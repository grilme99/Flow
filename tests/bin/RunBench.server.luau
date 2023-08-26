-- upstream: https://github.com/dead/typeflex/blob/422cb26f998cde2b7f9251e26f6cab63d50f76c9/tests/run-bench.js

--[[
	MIT License

Copyright (c) Facebook, Inc. and its affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

--!optimize 2
--!strict

-- Delay before running any benchmarks so there is less overhead from the test session just starting
task.wait(2)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local LuauPolyfill = require(Packages.LuauPolyfill)
local Map = LuauPolyfill.Map
local console = LuauPolyfill.console

-- Print benchmark results in format supported by github-benchmark-action
local BENCHMARKJS_OUTPUT = false

local WARMUP_ITERATIONS = 3
local BENCHMARK_ITERATIONS = 10
local testResults = Map.new()

local testFiles = {
    require(script.Parent.Parent.Benchmarks.YGBenchmark),
}

for _, file in ipairs(testFiles) do
    local function YGBENCHMARK(name: string, fn: () -> ())
        local testEntry = testResults:get(name)
        if testEntry == nil then
            testEntry = Map.new()
            testResults:set(name, testEntry)
        end

        for _i = 1, WARMUP_ITERATIONS do
            fn()
        end

        -- deviation: use high-precision Luau API and convert to ms
        local start = os.clock() * 1000

        for _i = 1, BENCHMARK_ITERATIONS do
            fn()
        end

        -- deviation: use high-precision Luau API and convert to ms
        local end_ = os.clock() * 1000

        testEntry:set("roblox", (end_ - start) / BENCHMARK_ITERATIONS)

        task.wait()
    end

    file.run(YGBENCHMARK)
end

console.log("Note: these tests are independents; there is no time relation to be expected between them")

for _, ref in ipairs(testResults:entries()) do
    local name, results = table.unpack(ref, 1, 2)

    console.log("")

    local min = math.min(math.huge, table.unpack(results:values()))

    console.log(name)

    for _, ref_ in ipairs(results:entries()) do
        local type_, result = table.unpack(ref_)

        console.log("  - %s: %4.4fms (%s%%)", type_, result, math.round((result / min) * 10000) / 100)

        -- deviation: print benchmark results in format supported by github-benchmark-action
        if BENCHMARKJS_OUTPUT then
            console.log(
                "%s x %4.4f %s ±%1.0f%% (%d runs sampled)(roblox version %s)",
                name,
                result,
                "ms/op",
                0,
                BENCHMARK_ITERATIONS,
                -- TODO Selene: remove when version is part of roblox standard library
                -- selene: allow(undefined_variable)
                version()
            )
        end
    end
end
