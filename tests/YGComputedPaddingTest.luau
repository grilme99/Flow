-- upstream: https://github.com/dead/typeflex/blob/422cb26/tests/Facebook.Yoga/YGComputedPaddingTest.js

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/javascript/tests/Facebook.Yoga/YGComputedPaddingTest.js

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

do
    print("padding_start")

    local root = Flow.Node.new()
    root:setWidth(100)
    root:setHeight(100)
    root:setPadding(Flow.Edge.Start, "10%")

    root:calculateLayout(100, 100, Flow.Direction.LTR)

    assert(10 == root:getComputedPadding(Flow.Edge.Left), "10 == root:getComputedPadding(Flow.Edge.Left)")
    assert(0 == root:getComputedPadding(Flow.Edge.Right), "0 == root:getComputedPadding(Flow.Edge.Right)")

    root:calculateLayout(100, 100, Flow.Direction.RTL)

    assert(0 == root:getComputedPadding(Flow.Edge.Left), "0 == root:getComputedPadding(Flow.Edge.Left)")
    assert(10 == root:getComputedPadding(Flow.Edge.Right), "10 == root:getComputedPadding(Flow.Edge.Right)")
end

return nil
