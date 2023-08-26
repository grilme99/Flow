-- upstream: https://github.com/dead/typeflex/blob/422cb26/tests/Facebook.Yoga/YGMeasureTest.js

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/javascript/tests/Facebook.Yoga/YGMeasureTest.js

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

--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Flow = require(Packages.Flow)

local MeasureCount = require(script.Parent.tools.MeasureCounter)
local getMeasureCounter = MeasureCount.getMeasureCounter

do
    print("dont_measure_single_grow_shrink_child")

    local root = Flow.Node.new()
    root:setWidth(100)
    root:setHeight(100)

    local measureCounter = getMeasureCounter(nil, 100, 100)

    local root_child0 = Flow.Node.new()
    root_child0:setMeasureFunc(measureCounter.inc)
    root_child0:setFlexGrow(1)
    root_child0:setFlexShrink(1)
    root:insertChild(root_child0, 1)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    assert(0 == measureCounter.get(), "0 == measureCounter.get()")

    root:freeRecursive()
end

return nil
