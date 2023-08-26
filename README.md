<!-- Allow this file to not have a first line heading -->
<!-- markdownlint-disable-file MD041 no-emphasis-as-heading -->

<!-- inline html -->
<!-- markdownlint-disable-file MD033 -->

<div align="center">

# `🌊 Flow`

**Flexbox layouting for Roblox and Lua**

</div>

## About

Flow is a Flexbox layout engine with the goal of performance and spec conformance. If it's in the Flexbox spec, Flow
wants to support it. We're based on Meta's [Yoga](https://github.com/facebook/yoga), see
[Acknowledgements](#acknowledgements) for more details.

## Testing

### Adding Tests

Many of Flows's tests are automatically generated, using HTML fixtures describing node structure. These are rendered in
Chrome to generate an expected layout result for the tree. New fixtures can be added to `gentest/fixtures`.

```html
<div id="my_test" style="width: 100px; height: 100px; align-items: center;">
  <div style="width: 50px; height: 50px;"></div>
</div>
```

To generate new tests from added fixtures:

1. Run `npm install` in the `gentest` directory to install dependencies of the test generator.
2. Run `node index.js` in the `gentest` directory.

### Running Tests

Roblox Studio is currently required to run Flow's unit test suite. See [this issue](https://github.com/grilme99/Flow/issues/3)
for more details.

To test in Roblox Studio:

1. Install packages with `just install-packages`.
2. Build the project with `rojo build --output Flow.rbxl`. This uses the default project file, which is made for tests.
3. Open the Roblox file and enable or disable the `RunBench` or `RunTests` scripts depending on which you want to do.
4. Run the game and the results will be printed to the output.

## Benchmarks

TODO: Add benchmarks here

## Acknowledgements

Flow is hand-translated from [Typeflex](https://github.com/dead/typeflex), which itself is a Typescript port of Yoga.
Some of Flow's internals are also based on (licensed) work done by [Roblox](https://www.roblox.com/) internally to
investigate Flexbox in Lua.

As time goes on, it's likely Flow will deviate from Typeflex and align more closely with upstream Yoga. See
[this issue](https://github.com/grilme99/Flow/issues/2) for more details.
