-- upstream: https://github.com/dead/typeflex/blob/422cb26/tests/Facebook.Yoga/YGDirtiedTest.js

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/javascript/tests/Facebook.Yoga/YGDirtiedTest.js

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
    print("dirtied")

    local root = Flow.Node.new()
    root:setAlignItems(Flow.Align.FlexStart)
    root:setWidth(100)
    root:setHeight(100)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    local dirtied = 0
    root:setDirtiedFunc(function()
        dirtied += 1
    end)

    -- only nodes with a measure function can be marked dirty
    root:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)

    assert(0 == dirtied, "0 == dirtied")

    -- dirtied func MUST be called in case of explicit dirtying.
    root:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    -- dirtied func MUST be called ONCE.
    root:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    root:freeRecursive()
end

do
    print("dirtied_propagation")

    local root = Flow.Node.new()
    root:setAlignItems(Flow.Align.FlexStart)
    root:setWidth(100)
    root:setHeight(100)

    local root_child0 = Flow.Node.new()
    root_child0:setAlignItems(Flow.Align.FlexStart)
    root_child0:setWidth(50)
    root_child0:setHeight(20)
    root_child0:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)
    root:insertChild(root_child0, 1)

    local root_child1 = Flow.Node.new()
    root_child1:setAlignItems(Flow.Align.FlexStart)
    root_child1:setWidth(50)
    root_child1:setHeight(20)
    root:insertChild(root_child1, 1)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    local dirtied = 0
    root:setDirtiedFunc(function()
        dirtied += 1
    end)

    assert(0 == dirtied, "0 == dirtied")

    -- dirtied func MUST be called for the first time.
    root_child0:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    -- dirtied func must NOT be called for the second time.
    root_child0:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    root:freeRecursive()
end

do
    print("dirtied_hierarchy")

    local root = Flow.Node.new()
    root:setAlignItems(Flow.Align.FlexStart)
    root:setWidth(100)
    root:setHeight(100)

    local root_child0 = Flow.Node.new()
    root_child0:setAlignItems(Flow.Align.FlexStart)
    root_child0:setWidth(50)
    root_child0:setHeight(20)
    root_child0:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)
    root:insertChild(root_child0, 1)

    local root_child1 = Flow.Node.new()
    root_child1:setAlignItems(Flow.Align.FlexStart)
    root_child1:setWidth(50)
    root_child1:setHeight(20)
    root_child0:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)
    root:insertChild(root_child1, 1)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    local dirtied = 0
    root_child0:setDirtiedFunc(function()
        dirtied += 1
    end)

    assert(0 == dirtied, "0 == dirtied")

    -- dirtied func must NOT be called for descendants.
    -- NOTE: nodes without a measure function cannot be marked dirty manually,
    -- but nodes with a measure function can not have children.
    -- Update the width to dirty the node instead.
    root:setWidth(110)
    assert(0 == dirtied, "0 == dirtied")

    -- dirtied func MUST be called in case of explicit dirtying.
    root_child0:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    root:freeRecursive()
end

do
    print("dirtied_reset")

    local root = Flow.Node.new()
    root:setAlignItems(Flow.Align.FlexStart)
    root:setWidth(100)
    root:setHeight(100)
    root:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)

    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    local dirtied = 0
    root:setDirtiedFunc(function()
        dirtied += 1
    end)

    assert(0 == dirtied, "0 == dirtied")

    -- dirtied func MUST be called in case of explicit dirtying.
    root:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    -- recalculate so the root is no longer dirty
    root:calculateLayout(nil, nil, Flow.Direction.LTR)

    root:reset()
    root:setAlignItems(Flow.Align.FlexStart)
    root:setWidth(100)
    root:setHeight(100)
    root:setMeasureFunc(function()
        return { width = 0, height = 0 }
    end)

    root:markDirty()

    -- dirtied func must NOT be called after reset.
    root:markDirty()
    assert(1 == dirtied, "1 == dirtied")

    root:freeRecursive()
end

return nil
