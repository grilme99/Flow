// based on: https://github.com/facebook/yoga/blob/v1.19.0/gentest/gentest.rb

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

const puppeteer = require("puppeteer");
const fs = require("fs");
const path = require("path");
const handlebars = require("handlebars");

(async () => {
  const browser = await puppeteer.launch({
    headless: "new",
    args: ["--force-device-scale-factor=1", "--window-position=0,0"],
  });

  const page = await browser.newPage();

  const templatePath = path.join(__dirname, "browser/test-template.hbs");
  const templateSource = fs.readFileSync(templatePath, "utf-8");
  const template = handlebars.compile(templateSource);

  const fixtureDir = path.join(__dirname, "fixtures");
  const fixtures = fs.readdirSync(fixtureDir);

  for (let file of fixtures) {
    const filePath = path.join(fixtureDir, file);
    const fixture = fs.readFileSync(filePath, "utf-8");
    const name = path.basename(file, ".html");
    console.log(`Generate ${name}`);

    const ltr_fixture = fixture
      .replace(/start/g, "left")
      .replace(/end/g, "right")
      .replace(/flex-left/g, "flex-start")
      .replace(/flex-right/g, "flex-end");

    const rtl_fixture = fixture
      .replace(/start/g, "right")
      .replace(/end/g, "left")
      .replace(/flex-right/g, "flex-start")
      .replace(/flex-left/g, "flex-end");

    const content = template({
      name: name,
      ltr_fixture: ltr_fixture,
      rtl_fixture: rtl_fixture,
      fixture: fixture,
    });

    const testFilePath = path.join(__dirname, "test.html");
    fs.writeFileSync(testFilePath, content);

    if (process.env.DEBUG) {
      fs.copyFileSync(testFilePath, `${name}.html`);
    }

    let logs = [];
    page.on("console", (msg) => {
      logs.push(msg.text());
    });

    await page.goto(`file://${testFilePath}`);
    const testFile = logs.join("");

    fs.writeFileSync(
      `../../tests/generated/${name}.test.luau`,
      testFile.replace("YogaTest", name)
    );
  }

  fs.unlinkSync(path.join(__dirname, "test.html"));
  await browser.close();
})();
