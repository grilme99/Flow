-- upstream: https://github.com/dead/typeflex/blob/422cb26f998cde2b7f9251e26f6cab63d50f76c9/tests/Benchmarks/YGBenchmark.js

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

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Flow = require(Packages.Flow)

local TestsRoot = script.Parent.Parent
local MeasureCounter = require(TestsRoot.tools.MeasureCounter)
local getMeasureCounter = MeasureCounter.getMeasureCounter

local function run(YGBENCHMARK: (name: string, fn: () -> ()) -> ())
    local ITERATIONS = 2000

    YGBENCHMARK("Stack with flex", function()
        local root = Flow.Node.new()
        root:setWidth(100)
        root:setHeight(100)

        local measureCounter = getMeasureCounter()

        for _ = 1, ITERATIONS do
            local child = Flow.Node.new()
            child:setMeasureFunc(measureCounter.inc)
            child:setFlex(1)
            root:insertChild(child, 1)
        end

        root:calculateLayout(nil, nil, Flow.Direction.LTR)
        root:freeRecursive()
    end)

    YGBENCHMARK("Align stretch in undefined axis", function()
        local root = Flow.Node.new()

        local measureCounter = getMeasureCounter()

        for _ = 1, ITERATIONS do
            local child = Flow.Node.new()
            child:setMeasureFunc(measureCounter.inc)
            child:setHeight(20)
            root:insertChild(child, 1)
        end

        root:calculateLayout(nil, nil, Flow.Direction.LTR)
        root:freeRecursive()
    end)

    YGBENCHMARK("Nested flex", function()
        local root = Flow.Node.new()

        local measureCounter = getMeasureCounter()

        local iterations = math.pow(ITERATIONS, 1 / 2)

        for _ = 1, iterations do
            local child = Flow.Node.new()
            child:setFlex(1)
            root:insertChild(child, 1)

            for _ = 1, iterations do
                local grandChild = Flow.Node.new()
                grandChild:setMeasureFunc(measureCounter.inc)
                grandChild:setFlex(1)
                child:insertChild(grandChild, 1)
            end
        end

        root:calculateLayout(nil, nil, Flow.Direction.LTR)
        root:freeRecursive()
    end)

    YGBENCHMARK("Huge nested layout", function()
        local root = Flow.Node.new()

        local iterations = math.pow(ITERATIONS, 1 / 4)

        for _ = 1, iterations do
            local child = Flow.Node.new()
            child:setFlexGrow(1)
            child:setWidth(10)
            child:setHeight(10)
            root:insertChild(child, 1)

            for _ = 1, iterations do
                local grandChild = Flow.Node.new()
                grandChild:setFlexDirection(Flow.FlexDirection.Row)
                grandChild:setFlexGrow(1)
                grandChild:setWidth(10)
                grandChild:setHeight(10)
                child:insertChild(grandChild, 1)

                for _ = 1, iterations do
                    local grandGrandChild = Flow.Node.new()
                    grandGrandChild:setFlexGrow(1)
                    grandGrandChild:setWidth(10)
                    grandGrandChild:setHeight(10)
                    grandChild:insertChild(grandGrandChild, 1)

                    for _ = 1, iterations do
                        local grandGrandGrandChild = Flow.Node.new()
                        grandGrandGrandChild:setFlexDirection(Flow.FlexDirection.Row)
                        grandGrandGrandChild:setFlexGrow(1)
                        grandGrandGrandChild:setWidth(10)
                        grandGrandGrandChild:setHeight(10)
                        grandGrandChild:insertChild(grandGrandGrandChild, 1)
                    end
                end
            end
        end

        root:calculateLayout(nil, nil, Flow.Direction.LTR)
        root:freeRecursive()
    end)
end

return {
    run = run,
}
