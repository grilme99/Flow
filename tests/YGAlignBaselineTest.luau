-- upstream: https://github.com/dead/typeflex/blob/422cb26/tests/Facebook.Yoga/YGAlignBaselineTest.js

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/javascript/tests/Facebook.Yoga/YGAlignBaselineTest.js

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
    print("align_baseline_parent_using_child_in_column_as_reference")

    local config = Flow.Config.new()

    local root = Flow.Node.new(config)
    root:setFlexDirection(Flow.FlexDirection.Row)
    root:setWidth(1000)
    root:setHeight(1000)
    root:setAlignItems(Flow.Align.Baseline)

    local root_child0 = Flow.Node.new(config)
    root_child0:setFlexDirection(Flow.FlexDirection.Column)
    root_child0:setWidth(500)
    root_child0:setHeight(600)
    root:insertChild(root_child0, 1)

    local root_child1 = Flow.Node.new(config)
    root_child1:setFlexDirection(Flow.FlexDirection.Column)
    root_child1:setWidth(500)
    root_child1:setHeight(800)
    root:insertChild(root_child1, 2)

    local root_child1_child0 = Flow.Node.new(config)
    root_child1_child0:setFlexDirection(Flow.FlexDirection.Column)
    root_child1_child0:setWidth(500)
    root_child1_child0:setHeight(300)
    root_child1:insertChild(root_child1_child0, 1)

    local root_child1_child1 = Flow.Node.new(config)
    root_child1_child1:setFlexDirection(Flow.FlexDirection.Column)
    root_child1_child1:setWidth(500)
    root_child1_child1:setHeight(400)
    root_child1_child1:setIsReferenceBaseline(true)
    root_child1:insertChild(root_child1_child1, 2)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    assert(
        0 == root_child0:getComputedLeft(),
        "0 == root_child0:getComputedLeft() (" .. root_child0:getComputedLeft() .. ")"
    )
    assert(
        100 == root_child0:getComputedTop(),
        "100 == root_child0:getComputedTop() (" .. root_child0:getComputedTop() .. ")"
    )

    assert(
        500 == root_child1:getComputedLeft(),
        "500 == root_child1:getComputedLeft() (" .. root_child1:getComputedLeft() .. ")"
    )
    assert(
        0 == root_child1:getComputedTop(),
        "0 == root_child1:getComputedTop() (" .. root_child1:getComputedTop() .. ")"
    )

    assert(
        0 == root_child1_child0:getComputedLeft(),
        "0 == root_child1_child0:getComputedLeft() (" .. root_child1_child0:getComputedLeft() .. ")"
    )
    assert(
        0 == root_child1_child0:getComputedTop(),
        "0 == root_child1_child0:getComputedTop() (" .. root_child1_child0:getComputedTop() .. ")"
    )

    assert(
        0 == root_child1_child1:getComputedLeft(),
        "0 == root_child1_child1:getComputedLeft() (" .. root_child1_child1:getComputedLeft() .. ")"
    )
    assert(
        300 == root_child1_child1:getComputedTop(),
        "300 == root_child1_child1:getComputedTop() (" .. root_child1_child1:getComputedTop() .. ")"
    )
end

do
    print("align_baseline_parent_using_child_in_row_as_reference")

    local config = Flow.Config.new()

    local root = Flow.Node.new(config)
    root:setFlexDirection(Flow.FlexDirection.Row)
    root:setWidth(1000)
    root:setHeight(1000)
    root:setAlignItems(Flow.Align.Baseline)

    local root_child0 = Flow.Node.new(config)
    root_child0:setFlexDirection(Flow.FlexDirection.Column)
    root_child0:setWidth(500)
    root_child0:setHeight(600)
    root:insertChild(root_child0, 1)

    local root_child1 = Flow.Node.new(config)
    root_child1:setFlexDirection(Flow.FlexDirection.Row)
    root_child1:setWidth(500)
    root_child1:setHeight(800)
    root:insertChild(root_child1, 2)

    local root_child1_child0 = Flow.Node.new(config)
    root_child1_child0:setFlexDirection(Flow.FlexDirection.Column)
    root_child1_child0:setWidth(500)
    root_child1_child0:setHeight(500)
    root_child1:insertChild(root_child1_child0, 1)

    local root_child1_child1 = Flow.Node.new(config)
    root_child1_child1:setFlexDirection(Flow.FlexDirection.Column)
    root_child1_child1:setWidth(500)
    root_child1_child1:setHeight(400)
    root_child1_child1:setIsReferenceBaseline(true)
    root_child1:insertChild(root_child1_child1, 2)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    assert(
        0 == root_child0:getComputedLeft(),
        "0 == root_child0:getComputedLeft() (" .. root_child0:getComputedLeft() .. ")"
    )
    assert(
        0 == root_child0:getComputedTop(),
        "0 == root_child0:getComputedTop() (" .. root_child0:getComputedTop() .. ")"
    )

    assert(
        500 == root_child1:getComputedLeft(),
        "500 == root_child1:getComputedLeft() (" .. root_child1:getComputedLeft() .. ")"
    )
    assert(
        200 == root_child1:getComputedTop(),
        "200 == root_child1:getComputedTop() (" .. root_child1:getComputedTop() .. ")"
    )

    assert(
        0 == root_child1_child0:getComputedLeft(),
        "0 == root_child1_child0:getComputedLeft() (" .. root_child1_child0:getComputedLeft() .. ")"
    )
    assert(
        0 == root_child1_child0:getComputedTop(),
        "0 == root_child1_child0:getComputedTop() (" .. root_child1_child0:getComputedTop() .. ")"
    )

    assert(
        500 == root_child1_child1:getComputedLeft(),
        "500 == root_child1_child1:getComputedLeft() (" .. root_child1_child1:getComputedLeft() .. ")"
    )
    assert(
        0 == root_child1_child1:getComputedTop(),
        "0 == root_child1_child1:getComputedTop() (" .. root_child1_child1:getComputedTop() .. ")"
    )
end

return nil
