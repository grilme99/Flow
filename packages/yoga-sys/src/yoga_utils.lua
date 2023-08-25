-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/yoga.ts

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

-- Note: This module is extracted out of `init.lua` (originally `yoga.ts`) to avoid Luau's maximum local limit.
-- For performance reasons, everything in `init.lua` must be defined as a local, so we quickly run into the limit.

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console

local Types = require(PackageRoot.types)
type YGNode = Types.YGNode
type YGConfig = Types.YGConfig
type YGLayout = Types.YGLayout
type YGNodeCleanupFunc = Types.YGNodeCleanupFunc

local Enums = require(PackageRoot.enums)
local YGLogLevel = Enums.YGLogLevel
type YGLogLevel = Enums.YGLogLevel
type YGMeasureMode = Enums.YGMeasureMode

local ygNodeModule_ = require(PackageRoot.ygnode)
local YGNode: any

local ygConfigModule_ = require(PackageRoot.ygconfig)
local YGConfig

local YGLayout = require(PackageRoot.yglayout)

local Event = require(PackageRoot.event)
local EventType = Event.EventType
local YGEvent = Event.YGEvent

local YGAssertWithNode

-- deviation: hoisted function signatures are needed for the linter
local YGNodeFreeRecursive: (root: YGNode) -> ()
local YGConfigNew: () -> YGConfig
local YGNodeRemoveChild: (owner: YGNode, excludedChild: YGNode) -> ()
local YGNodeGetChild: (node: YGNode, index: number) -> YGNode?
local YGNodeGetChildCount: (node: YGNode) -> number

type Array<T> = { T }

local exports = {}

local function formatToString(format: string, args: Array<any>)
    local ret: string = format

    for _, arg in ipairs(args[1][1]) do
        -- deviation: replace regex of /%[d|s|f]/ with gsub call
        ret = ret:gsub("%S+", { ["%d"] = arg, ["%s"] = arg, ["%f"] = arg }, 1)
    end

    return ret
end

local function YGDefaultLog(_config: YGConfig, _node: YGNode, level: YGLogLevel, format: string, ...: Array<any>): ()
    if level == YGLogLevel.Error or level == YGLogLevel.Fatal then
        return console.error(formatToString(format, ...))
    else
        return console.log(formatToString(format, ...))
    end
end
exports.YGDefaultLog = YGDefaultLog

local gConfigInstanceCount = 0

local function YGNodeNewWithConfig(config: YGConfig): YGNode
    local node: YGNode = YGNode.new(config)
    YGEvent.publish(node, EventType.NodeAllocation, { config = config })
    return node
end
exports.YGNodeNewWithConfig = YGNodeNewWithConfig

local function YGConfigGetDefault(): YGConfig
    return YGConfigNew()
end
exports.YGConfigGetDefault = YGConfigGetDefault

local function YGNodeNew(): YGNode
    return YGNodeNewWithConfig(YGConfigGetDefault())
end
exports.YGNodeNew = YGNodeNew

local function YGNodeClone(oldNode: YGNode): YGNode
    local node: YGNode = YGNode.new(oldNode)
    YGEvent.publish(node, EventType.NodeAllocation, { config = node:getConfig() })
    node:setOwner(nil)
    return node
end
exports.YGNodeClone = YGNodeClone

local function YGConfigClone(oldConfig: YGConfig): YGConfig
    local config: YGConfig = YGConfig.new(oldConfig.logger)
    gConfigInstanceCount += 1
    return config
end
exports.YGConfigClone = YGConfigClone

local function YGNodeDeepClone(oldNode: YGNode): YGNode
    local config = YGConfigClone(oldNode:getConfig())
    local node = YGNode.new(oldNode)
    node:setConfig(config)
    node:setOwner(nil)
    YGEvent.publish(node, EventType.NodeAllocation, { config = node:getConfig() })

    local vec: Array<YGNode> = {}
    local childNode: YGNode = nil
    for _, item in ipairs(oldNode:getChildren()) do
        childNode = YGNodeDeepClone(item)
        childNode:setOwner(node)
        table.insert(vec, childNode)
    end
    node:setChildren(vec)

    return node
end
exports.YGNodeDeepClone = YGNodeDeepClone

local function YGNodeFree(node: YGNode): ()
    local owner: YGNode = node:getOwner()
    if owner ~= nil then
        owner:removeChild(node)
        node:setOwner(nil)
    end

    local childCount: number = YGNodeGetChildCount(node)
    local i = 1
    while i <= childCount do
        local child: YGNode = YGNodeGetChild(node, i) :: any
        child:setOwner(nil)
        i += 1
    end

    node:clearChildren()
    YGEvent.publish(node, EventType.NodeDeallocation, { config = node:getConfig() })
end
exports.YGNodeFree = YGNodeFree

local function YGConfigFreeRecursive(root: YGNode): ()
    if root:getConfig() ~= nil then
        gConfigInstanceCount -= 1
        root:setConfig(nil)
    end

    for _, child in ipairs(root:getChildren()) do
        YGConfigFreeRecursive(child)
    end
end
exports.YGConfigFreeRecursive = YGConfigFreeRecursive

local function YGNodeFreeRecursiveWithCleanupFunc(root: YGNode, cleanup: YGNodeCleanupFunc?): ()
    local skipped = 0
    while YGNodeGetChildCount(root) > skipped do
        local child: YGNode = YGNodeGetChild(root, skipped + 1) :: any
        if child:getOwner() ~= root then
            -- Don't free shared nodes that we don't own.
            skipped += 1
        else
            YGNodeRemoveChild(root, child)
            YGNodeFreeRecursive(child)
        end
    end
    if cleanup ~= nil then
        cleanup(root)
    end
    YGNodeFree(root)
end
exports.YGNodeFreeRecursiveWithCleanupFunc = YGNodeFreeRecursiveWithCleanupFunc

-- deviation: local declaration hoisted
function YGNodeFreeRecursive(root: YGNode): ()
    return YGNodeFreeRecursiveWithCleanupFunc(root, nil)
end
exports.YGNodeFreeRecursive = YGNodeFreeRecursive

local function YGNodeReset(node: YGNode): ()
    return node:reset()
end
exports.YGNodeReset = YGNodeReset

local function YGConfigGetInstanceCount(): number
    return gConfigInstanceCount
end
exports.YGConfigGetInstanceCount = YGConfigGetInstanceCount

-- deviation: local declaration hoisted
function YGConfigNew(): YGConfig
    local config: YGConfig = YGConfig.new(YGDefaultLog)
    gConfigInstanceCount += 1
    return config
end
exports.YGConfigNew = YGConfigNew

local function YGConfigFree(_config: YGConfig): ()
    gConfigInstanceCount -= 1
end
exports.YGConfigFree = YGConfigFree

local function YGConfigCopy(dest: YGConfig, src: YGConfig): ()
    Object.assign(dest, src)
end
exports.YGConfigCopy = YGConfigCopy

local function YGNodeSetIsReferenceBaseline(node: YGNode, isReferenceBaseline: boolean): ()
    if node:isReferenceBaseline() ~= isReferenceBaseline then
        node:setIsReferenceBaseline(isReferenceBaseline)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeSetIsReferenceBaseline = YGNodeSetIsReferenceBaseline

local function YGNodeIsReferenceBaseline(node: YGNode): boolean
    return node:isReferenceBaseline()
end
exports.YGNodeIsReferenceBaseline = YGNodeIsReferenceBaseline

local function YGNodeInsertChild(owner: YGNode, child: YGNode, index: number): ()
    YGAssertWithNode(owner, child:getOwner() == nil, "Child already has a owner, it must be removed first.")
    YGAssertWithNode(
        owner,
        not owner:hasMeasureFunc(),
        "Cannot add child: Nodes with measure functions cannot have children."
    )
    owner:insertChildIndex(child, index)
    child:setOwner(owner)
    owner:markDirtyAndPropogate()
end
exports.YGNodeInsertChild = YGNodeInsertChild

-- deviation: local declaration hoisted
function YGNodeRemoveChild(owner: YGNode, excludedChild: YGNode): ()
    if YGNodeGetChildCount(owner) == 0 then
        -- This is an empty set. Nothing to remove.
        return
    end

    -- Children may be shared between parents, which is indicated by not having
    -- an owner. We only want to reset the child completely if it is owned
    -- exclusively by one node.
    local childOwner = excludedChild:getOwner()
    if owner:removeChild(excludedChild) then
        if owner == childOwner then
            excludedChild:setLayout(YGLayout.new()) -- layout is no longer valid
            excludedChild:setOwner(nil)
        end
        owner:markDirtyAndPropogate()
    end
end
exports.YGNodeRemoveChild = YGNodeRemoveChild

local function YGNodeRemoveAllChildren(owner: YGNode): ()
    local childCount = YGNodeGetChildCount(owner)
    if childCount == 0 then
        return
    end

    local firstChild: YGNode = YGNodeGetChild(owner, 1) :: any
    if firstChild:getOwner() == owner then
        local i = 1
        while i <= childCount do
            local oldChild: YGNode = YGNodeGetChild(owner, i) :: any
            oldChild:setLayout(YGLayout.new()) -- YGNode.new():getLayout()
            oldChild:setOwner(nil)
            i += 1
        end

        owner:clearChildren()
        owner:markDirtyAndPropogate()
        return
    end

    owner:setChildren({})
    owner:markDirtyAndPropogate()
end
exports.YGNodeRemoveAllChildren = YGNodeRemoveAllChildren

local function YGNodeSetChildrenInternal(owner: YGNode, children: Array<YGNode>): ()
    if not Boolean.toJSBoolean(owner) then
        return
    end

    local ownerChildren: Array<YGNode> = owner:getChildren()
    if #children == 0 then
        if #ownerChildren > 0 then
            local i = 1
            while i <= #ownerChildren do
                local child: YGNode = ownerChildren[i]
                child:setLayout(YGLayout.new())
                child:setOwner(nil)
                i += 1
            end

            owner:setChildren({})
            owner:markDirtyAndPropogate()
        end
    else
        if #ownerChildren > 0 then
            local i = 1
            while i <= #ownerChildren do
                local oldChild: YGNode = ownerChildren[i]
                if Array.indexOf(children, oldChild) < 0 then
                    oldChild:setLayout(YGLayout.new())
                    oldChild:setOwner(nil)
                end
                i += 1
            end
        end

        owner:setChildren(children)
        local i = 1
        while i <= #children do
            children[i]:setOwner(owner)
            i += 1
        end

        owner:markDirtyAndPropogate()
    end
end
exports.YGNodeSetChildrenInternal = YGNodeSetChildrenInternal

local function YGNodeSetChildren(owner: YGNode, children: Array<YGNode>): ()
    YGNodeSetChildrenInternal(owner, children)
end
exports.YGNodeSetChildren = YGNodeSetChildren

-- deviation: local declaration hoisted
-- deviation: can return nil
function YGNodeGetChild(node: YGNode, index: number): YGNode?
    local children = node:getChildren()
    if index <= #children then
        return children[index]
    end
    return nil
end
exports.YGNodeGetChild = YGNodeGetChild

-- deviation: local declaration hoisted
function YGNodeGetChildCount(node: YGNode): number
    return node:getChildrenCount()
end
exports.YGNodeGetChildCount = YGNodeGetChildCount

local function YGNodeGetOwner(node: YGNode): YGNode
    return node:getOwner()
end
exports.YGNodeGetOwner = YGNodeGetOwner

local function YGNodeGetParent(node: YGNode): YGNode
    return node:getOwner()
end
exports.YGNodeGetParent = YGNodeGetParent

local function YGNodeMarkDirty(node: YGNode): ()
    YGAssertWithNode(
        node,
        node:hasMeasureFunc(),
        "Only leaf nodes with custom measure functions should manually mark themselves as dirty"
    )
    node:markDirtyAndPropogate()
end
exports.YGNodeMarkDirty = YGNodeMarkDirty

-- note: Some imports are done dynamically to resolve cyclic dependency issues.
return {
    resolve = function(deps: any)
        local yogaAssertionsModule = deps.yogaAssertionsModule
        YGAssertWithNode = yogaAssertionsModule.YGAssertWithNode

        local ygConfigModule = ygConfigModule_.resolve({
            yogaUtilsModule = exports,
        })
        YGConfig = ygConfigModule

        local ygNodeModule = ygNodeModule_.resolve({
            yogaAssertionsModule = yogaAssertionsModule,
            yogaUtilsModule = exports,
        })
        YGNode = ygNodeModule

        return exports
    end,
}
