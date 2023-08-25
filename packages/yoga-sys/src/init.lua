-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/yoga.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/Yoga.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/Yoga.cpp

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

local exports = {}

local rootWorkspace = script.Parent
local LuauPolyfill = require(rootWorkspace.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Number = LuauPolyfill.Number
local String = LuauPolyfill.String

type Array<T> = LuauPolyfill.Array<T>

local enumsModule = require(script.enums)
local YGUnit = enumsModule.YGUnit
export type YGUnit = enumsModule.YGUnit
local YGEdge = enumsModule.YGEdge
export type YGEdge = enumsModule.YGEdge
local YGNodeType = enumsModule.YGNodeType
export type YGNodeType = enumsModule.YGNodeType
local YGFlexDirection = enumsModule.YGFlexDirection
export type YGFlexDirection = enumsModule.YGFlexDirection
local YGAlign = enumsModule.YGAlign
export type YGAlign = enumsModule.YGAlign
local YGMeasureMode = enumsModule.YGMeasureMode
export type YGMeasureMode = enumsModule.YGMeasureMode
local YGLogLevel = enumsModule.YGLogLevel
export type YGLogLevel = enumsModule.YGLogLevel
local YGDirection = enumsModule.YGDirection
export type YGDirection = enumsModule.YGDirection
local YGJustify = enumsModule.YGJustify
export type YGJustify = enumsModule.YGJustify
local YGPositionType = enumsModule.YGPositionType
export type YGPositionType = enumsModule.YGPositionType
local YGWrap = enumsModule.YGWrap
export type YGWrap = enumsModule.YGWrap
local YGOverflow = enumsModule.YGOverflow
export type YGOverflow = enumsModule.YGOverflow
local YGDisplay = enumsModule.YGDisplay
export type YGDisplay = enumsModule.YGDisplay
local YGDimension = enumsModule.YGDimension
export type YGDimension = enumsModule.YGDimension
export type YGPrintOptions = enumsModule.YGPrintOptions
local YGExperimentalFeature = enumsModule.YGExperimentalFeature
export type YGExperimentalFeature = enumsModule.YGExperimentalFeature
local YGMeasureModeCount = enumsModule.YGMeasureModeCount

exports.YGEnum = enumsModule

local Types = require(script.types)
export type YGNode = Types.YGNode
export type YGConfig = Types.YGConfig
export type YGLayout = Types.YGLayout
export type YGStyle = Types.YGStyle
export type YGFloatOptional = Types.YGFloatOptional
export type YGValue = Types.YGValue
export type YGCachedMeasurement = Types.YGCachedMeasurement

export type YGSize = Types.YGSize
export type YGPrintFunc = Types.YGPrintFunc
export type YGMeasureFunc = Types.YGMeasureFunc
export type YGBaselineFunc = Types.YGBaselineFunc
export type YGDirtiedFunc = Types.YGDirtiedFunc
export type YGLogger = Types.YGLogger
export type YGCloneNodeFunc = Types.YGCloneNodeFunc
export type YGNodeCleanupFunc = Types.YGNodeCleanupFunc

local YGFloatOptional = require(script.ygfloatoptional)

local ygvalueModule = require(script.ygvalue)
local YGUndefined = ygvalueModule.YGUndefined
local YGValue = ygvalueModule.YGValue
local YGValueUndefined = ygvalueModule.YGValueUndefined

local utilsModule = require(script.utils)
local YGFloatIsUndefined = utilsModule.YGFloatIsUndefined
local YGFloatSanitize = utilsModule.YGFloatSanitize
local YGFlexDirectionIsColumn = utilsModule.YGFlexDirectionIsColumn
local YGResolveValue = utilsModule.YGResolveValue
local YGFlexDirectionIsRow = utilsModule.YGFlexDirectionIsRow
local YGFloatMax = utilsModule.YGFloatMax
local YGResolveFlexDirection = utilsModule.YGResolveFlexDirection
local YGFloatOptionalMax = utilsModule.YGFloatOptionalMax
local YGFlexDirectionCross = utilsModule.YGFlexDirectionCross
local YGFloatMin = utilsModule.YGFloatMin
local YGCollectFlexItemsRowValues = utilsModule.YGCollectFlexItemsRowValues
-- deviation: can't perform arithmetic operation on nil
local safeAdd = utilsModule.safeAdd
local safeSub = utilsModule.safeSub
local safeMul = utilsModule.safeMul

export type YGCollectFlexItemsRowValues = utilsModule.YGCollectFlexItemsRowValues
local YGFloatsEqual = utilsModule.YGFloatsEqual

local internalModule = require(script.internal)
local kDefaultFlexGrow = internalModule.kDefaultFlexGrow
local kWebDefaultFlexShrink = internalModule.kWebDefaultFlexShrink
local kDefaultFlexShrink = internalModule.kDefaultFlexShrink
local pos = internalModule.pos
local trailing = internalModule.trailing
local leading = internalModule.leading
local dim = internalModule.dim
local YG_MAX_CACHED_RESULT_COUNT = internalModule.YG_MAX_CACHED_RESULT_COUNT

local logModule_ = require(script.log)
local yogaAssertionsModule = require(script.yoga_assertions).resolve()
local logModule = logModule_.resolve({
    yogaAssertionsModule = yogaAssertionsModule,
})
local Log = logModule.Log
export type Log = logModule_.Log

local eventModule = require(script.event)
local EventType = eventModule.EventType
export type EventType = eventModule.EventType
local LayoutData = eventModule.LayoutData
export type LayoutData = eventModule.LayoutData
local LayoutPassReason = eventModule.LayoutPassReason
export type LayoutPassReason = eventModule.LayoutPassReason
local LayoutType = eventModule.LayoutType
export type LayoutType = eventModule.LayoutType
local YGEvent = eventModule.YGEvent
export type YGEvent = eventModule.YGEvent

local YGAssertWithNode = yogaAssertionsModule.YGAssertWithNode
local YGAssertWithConfig = yogaAssertionsModule.YGAssertWithConfig

local yogaUtilsModule = require(script.yoga_utils).resolve({
    yogaAssertionsModule = yogaAssertionsModule,
})
local YGNodeGetChildCount = yogaUtilsModule.YGNodeGetChildCount
exports.YGNodeGetChildCount = YGNodeGetChildCount
local YGNodeGetChild = yogaUtilsModule.YGNodeGetChild
exports.YGNodeGetChild = YGNodeGetChild

local YGNodeDeepClone = yogaUtilsModule.YGNodeDeepClone
exports.YGNodeDeepClone = YGNodeDeepClone
local YGConfigFreeRecursive = yogaUtilsModule.YGConfigFreeRecursive
exports.YGConfigFreeRecursive = YGConfigFreeRecursive
local YGNodeFreeRecursive = yogaUtilsModule.YGNodeFreeRecursive
exports.YGNodeFreeRecursive = YGNodeFreeRecursive
local YGDefaultLog = yogaUtilsModule.YGDefaultLog
exports.YGDefaultLog = YGDefaultLog

local YGSize = {}
YGSize.__index = YGSize

function YGSize.new()
    local self = setmetatable({}, YGSize)
    return self
end
exports.YGSize = YGSize

-- deviation: hoisted function signatures are needed for the linter
local YGLayoutNodeInternal: (
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    ownerDirection: YGDirection,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number,
    performLayout: boolean,
    reason: LayoutPassReason,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
) -> boolean
local YGConfigIsExperimentalFeatureEnabled: (config: YGConfig, feature: YGExperimentalFeature) -> boolean

-- deviation: formatToString and YGDefaultLog moved to yoga_utils to avoid circular dependencies

-- deviation: YGFloatIsUndefined has been moved to utils.lua to eliminate
-- a problematic circular dependency.

local function YGComputedEdgeValue(edges: Array<YGValue>, edge: YGEdge, defaultValue: YGValue): YGValue
    if edges[edge].unit ~= YGUnit.Undefined then
        return edges[edge]
    end

    if (edge == YGEdge.Top or edge == YGEdge.Bottom) and edges[YGEdge.Vertical].unit ~= YGUnit.Undefined then
        return edges[YGEdge.Vertical]
    end

    if
        (edge == YGEdge.Left or edge == YGEdge.Right or edge == YGEdge.Start or edge == YGEdge.End)
        and edges[YGEdge.Horizontal].unit ~= YGUnit.Undefined
    then
        return edges[YGEdge.Horizontal]
    end

    if edges[YGEdge.All].unit ~= YGUnit.Undefined then
        return edges[YGEdge.All]
    end

    if edge == YGEdge.Start or edge == YGEdge.End then
        return YGValueUndefined()
    end

    return defaultValue
end
exports.YGComputedEdgeValue = YGComputedEdgeValue

-- deviation: use 'any' in-place of 'unknown' type
local function YGNodeGetContext(node: YGNode?): any
    -- deviation: need nil check to satisfy analyze
    if node ~= nil then
        return node:getContext()
    end
    return nil
end
exports.YGNodeGetContext = YGNodeGetContext

-- deviation: use 'any' in-place of 'unknown' type
local function YGNodeSetContext(node: YGNode, context: any): ()
    return node:setContext(context)
end
exports.YGNodeSetContext = YGNodeSetContext

local function YGNodeSetMeasureFunc(node: YGNode, measureFunc: YGMeasureFunc?): ()
    node:setMeasureFunc(measureFunc :: YGMeasureFunc)
end
exports.YGNodeSetMeasureFunc = YGNodeSetMeasureFunc

local function YGNodeSetBaselineFunc(node: YGNode, baselineFunc: YGBaselineFunc): ()
    node:setBaseLineFunc(baselineFunc)
end
exports.YGNodeSetBaselineFunc = YGNodeSetBaselineFunc

local function YGNodeGetDirtiedFunc(node: YGNode): YGDirtiedFunc
    return node:getDirtied()
end
exports.YGNodeGetDirtiedFunc = YGNodeGetDirtiedFunc

local function YGNodeSetDirtiedFunc(node: YGNode, dirtiedFunc: YGDirtiedFunc): ()
    node:setDirtiedFunc(dirtiedFunc)
end
exports.YGNodeSetDirtiedFunc = YGNodeSetDirtiedFunc

local function YGNodeSetPrintFunc(node: YGNode, printFunc: YGPrintFunc): ()
    node:setPrintFunc(printFunc)
end
exports.YGNodeSetPrintFunc = YGNodeSetPrintFunc

local function YGNodeGetHasNewLayout(node: YGNode): boolean
    return node:getHasNewLayout()
end
exports.YGNodeGetHasNewLayout = YGNodeGetHasNewLayout

local function YGNodeSetHasNewLayout(node: YGNode, hasNewLayout: boolean): ()
    node:setHasNewLayout(hasNewLayout)
end
exports.YGNodeSetHasNewLayout = YGNodeSetHasNewLayout

local function YGNodeGetNodeType(node: YGNode): YGNodeType
    return node:getNodeType()
end
exports.YGNodeGetNodeType = YGNodeGetNodeType

local function YGNodeSetNodeType(node: YGNode, nodeType: YGNodeType): ()
    node:setNodeType(nodeType)
end
exports.YGNodeSetNodeType = YGNodeSetNodeType

local function YGNodeIsDirty(node: YGNode): boolean
    return node:isDirty()
end
exports.YGNodeIsDirty = YGNodeIsDirty

local function YGNodeLayoutGetDidUseLegacyFlag(node: YGNode): boolean
    return node:didUseLegacyFlag()
end
exports.YGNodeLayoutGetDidUseLegacyFlag = YGNodeLayoutGetDidUseLegacyFlag

local function YGNodeMarkDirtyAndPropogateToDescendants(node: YGNode): ()
    node:markDirtyAndPropogateDownwards()
end
exports.YGNodeMarkDirtyAndPropogateToDescendants = YGNodeMarkDirtyAndPropogateToDescendants

-- deviation START: split into `yoga_utils.lua` file
exports.YGDefaultLog = yogaUtilsModule.YGDefaultLog
exports.YGNodeNewWithConfig = yogaUtilsModule.YGNodeNewWithConfig
exports.YGConfigGetDefault = yogaUtilsModule.YGConfigGetDefault
exports.YGNodeNew = yogaUtilsModule.YGNodeNew
exports.YGNodeClone = yogaUtilsModule.YGNodeClone
exports.YGConfigClone = yogaUtilsModule.YGConfigClone
exports.YGNodeDeepClone = yogaUtilsModule.YGNodeDeepClone
exports.YGNodeFree = yogaUtilsModule.YGNodeFree
exports.YGConfigFreeRecursive = yogaUtilsModule.YGConfigFreeRecursive
exports.YGNodeFreeRecursiveWithCleanupFunc = yogaUtilsModule.YGNodeFreeRecursiveWithCleanupFunc
exports.YGNodeFreeRecursive = yogaUtilsModule.YGNodeFreeRecursive
exports.YGNodeReset = yogaUtilsModule.YGNodeReset
exports.YGConfigGetInstanceCount = yogaUtilsModule.YGConfigGetInstanceCount
exports.YGConfigNew = yogaUtilsModule.YGConfigNew
exports.YGConfigFree = yogaUtilsModule.YGConfigFree
exports.YGConfigCopy = yogaUtilsModule.YGConfigCopy
exports.YGNodeSetIsReferenceBaseline = yogaUtilsModule.YGNodeSetIsReferenceBaseline
exports.YGNodeIsReferenceBaseline = yogaUtilsModule.YGNodeIsReferenceBaseline
exports.YGNodeInsertChild = yogaUtilsModule.YGNodeInsertChild
exports.YGNodeRemoveChild = yogaUtilsModule.YGNodeRemoveChild
exports.YGNodeRemoveAllChildren = yogaUtilsModule.YGNodeRemoveAllChildren
exports.YGNodeSetChildrenInternal = yogaUtilsModule.YGNodeSetChildrenInternal
exports.YGNodeSetChildren = yogaUtilsModule.YGNodeSetChildren
exports.YGNodeGetChild = yogaUtilsModule.YGNodeGetChild
exports.YGNodeGetChildCount = yogaUtilsModule.YGNodeGetChildCount
exports.YGNodeGetOwner = yogaUtilsModule.YGNodeGetOwner
exports.YGNodeGetParent = yogaUtilsModule.YGNodeGetParent
exports.YGNodeMarkDirty = yogaUtilsModule.YGNodeMarkDirty
-- deviation END

local function YGNodeCopyStyle(dstNode: YGNode, srcNode: YGNode): ()
    if not dstNode:getStyle():isEqual(srcNode:getStyle()) then
        dstNode:setStyle(srcNode:getStyle())
        dstNode:markDirtyAndPropogate()
    end
end
exports.YGNodeCopyStyle = YGNodeCopyStyle

local function YGNodeStyleGetFlexGrow(node: YGNode): number
    return if node:getStyle().flexGrow:isUndefined() then kDefaultFlexGrow else node:getStyle().flexGrow:unwrap()
end
exports.YGNodeStyleGetFlexGrow = YGNodeStyleGetFlexGrow

local function YGNodeStyleGetFlexShrink(node: YGNode): number
    return if node:getStyle().flexShrink:isUndefined()
        then if node:getConfig().useWebDefaults then kWebDefaultFlexShrink else kDefaultFlexShrink
        else node:getStyle().flexShrink:getValue()
end
exports.YGNodeStyleGetFlexShrink = YGNodeStyleGetFlexShrink

-- deviation START: macros are defined here upstream but Lua has a limit of 200
-- locals per scope, so we split them out into their own file.
local yogaMacrosModule = require(script.yoga_macros)
exports.YGNodeStyleSetDirection = yogaMacrosModule.YGNodeStyleSetDirection
exports.YGNodeStyleGetDirection = yogaMacrosModule.YGNodeStyleGetDirection
exports.YGNodeStyleSetFlexDirection = yogaMacrosModule.YGNodeStyleSetFlexDirection
exports.YGNodeStyleGetFlexDirection = yogaMacrosModule.YGNodeStyleGetFlexDirection
exports.YGNodeStyleSetJustifyContent = yogaMacrosModule.YGNodeStyleSetJustifyContent
exports.YGNodeStyleGetJustifyContent = yogaMacrosModule.YGNodeStyleGetJustifyContent
exports.YGNodeStyleSetAlignContent = yogaMacrosModule.YGNodeStyleSetAlignContent
exports.YGNodeStyleGetAlignContent = yogaMacrosModule.YGNodeStyleGetAlignContent
exports.YGNodeStyleSetAlignItems = yogaMacrosModule.YGNodeStyleSetAlignItems
exports.YGNodeStyleGetAlignItems = yogaMacrosModule.YGNodeStyleGetAlignItems
exports.YGNodeStyleSetAlignSelf = yogaMacrosModule.YGNodeStyleSetAlignSelf
exports.YGNodeStyleGetAlignSelf = yogaMacrosModule.YGNodeStyleGetAlignSelf
exports.YGNodeStyleSetPositionType = yogaMacrosModule.YGNodeStyleSetPositionType
exports.YGNodeStyleGetPositionType = yogaMacrosModule.YGNodeStyleGetPositionType
exports.YGNodeStyleSetFlexWrap = yogaMacrosModule.YGNodeStyleSetFlexWrap
exports.YGNodeStyleGetFlexWrap = yogaMacrosModule.YGNodeStyleGetFlexWrap
exports.YGNodeStyleSetOverflow = yogaMacrosModule.YGNodeStyleSetOverflow
exports.YGNodeStyleGetOverflow = yogaMacrosModule.YGNodeStyleGetOverflow
exports.YGNodeStyleSetDisplay = yogaMacrosModule.YGNodeStyleSetDisplay
exports.YGNodeStyleGetDisplay = yogaMacrosModule.YGNodeStyleGetDisplay
exports.YGNodeStyleSetPosition = yogaMacrosModule.YGNodeStyleSetPosition
exports.YGNodeStyleSetPositionPercent = yogaMacrosModule.YGNodeStyleSetPositionPercent
exports.YGNodeStyleGetPosition = yogaMacrosModule.YGNodeStyleGetPosition
exports.YGNodeStyleSetMargin = yogaMacrosModule.YGNodeStyleSetMargin
exports.YGNodeStyleSetMarginPercent = yogaMacrosModule.YGNodeStyleSetMarginPercent
exports.YGNodeStyleGetMargin = yogaMacrosModule.YGNodeStyleGetMargin
exports.YGNodeStyleSetPadding = yogaMacrosModule.YGNodeStyleSetPadding
exports.YGNodeStyleSetPaddingPercent = yogaMacrosModule.YGNodeStyleSetPaddingPercent
exports.YGNodeStyleGetPadding = yogaMacrosModule.YGNodeStyleGetPadding
exports.YGNodeStyleSetMarginAuto = yogaMacrosModule.YGNodeStyleSetMarginAuto
exports.YGNodeStyleSetWidth = yogaMacrosModule.YGNodeStyleSetWidth
exports.YGNodeStyleSetWidthPercent = yogaMacrosModule.YGNodeStyleSetWidthPercent
exports.YGNodeStyleSetWidthAuto = yogaMacrosModule.YGNodeStyleSetWidthAuto
exports.YGNodeStyleGetWidth = yogaMacrosModule.YGNodeStyleGetWidth
exports.YGNodeStyleSetHeight = yogaMacrosModule.YGNodeStyleSetHeight
exports.YGNodeStyleSetHeightPercent = yogaMacrosModule.YGNodeStyleSetHeightPercent
exports.YGNodeStyleSetHeightAuto = yogaMacrosModule.YGNodeStyleSetHeightAuto
exports.YGNodeStyleGetHeight = yogaMacrosModule.YGNodeStyleGetHeight
exports.YGNodeStyleSetMinWidth = yogaMacrosModule.YGNodeStyleSetMinWidth
exports.YGNodeStyleSetMinWidthPercent = yogaMacrosModule.YGNodeStyleSetMinWidthPercent
exports.YGNodeStyleGetMinWidth = yogaMacrosModule.YGNodeStyleGetMinWidth
exports.YGNodeStyleSetMinHeight = yogaMacrosModule.YGNodeStyleSetMinHeight
exports.YGNodeStyleSetMinHeightPercent = yogaMacrosModule.YGNodeStyleSetMinHeightPercent
exports.YGNodeStyleGetMinHeight = yogaMacrosModule.YGNodeStyleGetMinHeight
exports.YGNodeStyleSetMaxWidth = yogaMacrosModule.YGNodeStyleSetMaxWidth
exports.YGNodeStyleSetMaxWidthPercent = yogaMacrosModule.YGNodeStyleSetMaxWidthPercent
exports.YGNodeStyleGetMaxWidth = yogaMacrosModule.YGNodeStyleGetMaxWidth
exports.YGNodeStyleSetMaxHeight = yogaMacrosModule.YGNodeStyleSetMaxHeight
exports.YGNodeStyleSetMaxHeightPercent = yogaMacrosModule.YGNodeStyleSetMaxHeightPercent
exports.YGNodeStyleGetMaxHeight = yogaMacrosModule.YGNodeStyleGetMaxHeight
exports.YGNodeLayoutGetLeft = yogaMacrosModule.YGNodeLayoutGetLeft
exports.YGNodeLayoutGetTop = yogaMacrosModule.YGNodeLayoutGetTop
exports.YGNodeLayoutGetRight = yogaMacrosModule.YGNodeLayoutGetRight
exports.YGNodeLayoutGetBottom = yogaMacrosModule.YGNodeLayoutGetBottom
exports.YGNodeLayoutGetWidth = yogaMacrosModule.YGNodeLayoutGetWidth
exports.YGNodeLayoutGetHeight = yogaMacrosModule.YGNodeLayoutGetHeight
exports.YGNodeLayoutGetDirection = yogaMacrosModule.YGNodeLayoutGetDirection
exports.YGNodeLayoutGetHadOverflow = yogaMacrosModule.YGNodeLayoutGetHadOverflow
exports.YGNodeLayoutGetMargin = yogaMacrosModule.YGNodeLayoutGetMargin
exports.YGNodeLayoutGetBorder = yogaMacrosModule.YGNodeLayoutGetBorder
exports.YGNodeLayoutGetPadding = yogaMacrosModule.YGNodeLayoutGetPadding
-- deviation END

local function YGNodeStyleSetFlex(node: YGNode, flex: number): ()
    if node:getStyle().flex:isDiffValue(flex) then
        local style: YGStyle = node:getStyle()
        if YGFloatIsUndefined(flex) then
            style.flex = YGFloatOptional.new()
        else
            style.flex = YGFloatOptional.new(flex)
        end
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlex = YGNodeStyleSetFlex

local function YGNodeStyleGetFlex(node: YGNode): number
    return if node:getStyle().flex:isUndefined() then YGUndefined else node:getStyle().flex:getValue()
end
exports.YGNodeStyleGetFlex = YGNodeStyleGetFlex

local function YGNodeStyleSetFlexGrow(node: YGNode, flexGrow: number): ()
    if node:getStyle().flexGrow:isDiffValue(flexGrow) then
        local style: YGStyle = node:getStyle()
        if YGFloatIsUndefined(flexGrow) then
            style.flexGrow = YGFloatOptional.new()
        else
            style.flexGrow = YGFloatOptional.new(flexGrow)
        end
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlexGrow = YGNodeStyleSetFlexGrow

local function YGNodeStyleSetFlexShrink(node: YGNode, flexShrink: number): ()
    if node:getStyle().flexShrink:isDiffValue(flexShrink) then
        local style: YGStyle = node:getStyle()
        if YGFloatIsUndefined(flexShrink) then
            style.flexShrink = YGFloatOptional.new()
        else
            style.flexShrink = YGFloatOptional.new(flexShrink)
        end
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlexShrink = YGNodeStyleSetFlexShrink

local function YGNodeStyleGetFlexBasis(node: YGNode): YGValue
    local flexBasis: YGValue = node:getStyle().flexBasis
    if flexBasis.unit == YGUnit.Undefined or flexBasis.unit == YGUnit.Auto then
        flexBasis.value = YGUndefined
    end
    return flexBasis
end
exports.YGNodeStyleGetFlexBasis = YGNodeStyleGetFlexBasis

local function YGNodeStyleSetFlexBasis(node: YGNode, flexBasis: number): ()
	-- stylua: ignore
	local value: YGValue = YGValue.new(
		YGFloatSanitize(flexBasis),
		if YGFloatIsUndefined(flexBasis) then YGUnit.Undefined else YGUnit.Point
	)

    if
        (node:getStyle().flexBasis.value ~= value.value and value.unit ~= YGUnit.Undefined)
        or node:getStyle().flexBasis.unit ~= value.unit
    then
        local style: YGStyle = node:getStyle()
        style.flexBasis = value
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlexBasis = YGNodeStyleSetFlexBasis

local function YGNodeStyleSetFlexBasisPercent(node: YGNode, flexBasisPercent: number): ()
    if node:getStyle().flexBasis.value ~= flexBasisPercent or node:getStyle().flexBasis.unit ~= YGUnit.Percent then
        local style: YGStyle = node:getStyle()
        style.flexBasis.value = YGFloatSanitize(flexBasisPercent)
        style.flexBasis.unit = if YGFloatIsUndefined(flexBasisPercent) then YGUnit.Auto else YGUnit.Percent
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlexBasisPercent = YGNodeStyleSetFlexBasisPercent

local function YGNodeStyleSetFlexBasisAuto(node: YGNode): ()
    if node:getStyle().flexBasis.unit ~= YGUnit.Auto then
        local style: YGStyle = node:getStyle()
        style.flexBasis.value = 0
        style.flexBasis.unit = YGUnit.Auto
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetFlexBasisAuto = YGNodeStyleSetFlexBasisAuto

local function YGNodeStyleSetBorder(node: YGNode, edge: YGEdge, border: number): ()
	-- stylua: ignore
	local value: YGValue = YGValue.new(
		YGFloatSanitize(border),
		if YGFloatIsUndefined(border) then YGUnit.Undefined else YGUnit.Point
	)

    if
        (node:getStyle().border[edge].value ~= value.value and value.unit ~= YGUnit.Undefined)
        or node:getStyle().border[edge].unit ~= value.unit
    then
        local style: YGStyle = node:getStyle()
        style.border[edge] = value
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetBorder = YGNodeStyleSetBorder

local function YGNodeStyleGetBorder(node: YGNode, edge: YGEdge): number
    if node:getStyle().border[edge].unit == YGUnit.Undefined or node:getStyle().border[edge].unit == YGUnit.Auto then
        return YGUndefined
    end
    return node:getStyle().border[edge].value
end
exports.YGNodeStyleGetBorder = YGNodeStyleGetBorder

local function YGNodeStyleGetAspectRatio(node: YGNode): number
    local op: YGFloatOptional = node:getStyle().aspectRatio
    return if op:isUndefined() then YGUndefined else op:getValue()
end
exports.YGNodeStyleGetAspectRatio = YGNodeStyleGetAspectRatio

local function YGNodeStyleSetAspectRatio(node: YGNode, aspectRatio: number): ()
    if node:getStyle().aspectRatio:isDiffValue(aspectRatio) then
        local style: YGStyle = node:getStyle()
        style.aspectRatio = YGFloatOptional.new(aspectRatio)
        node:setStyle(style)
        node:markDirtyAndPropogate()
    end
end
exports.YGNodeStyleSetAspectRatio = YGNodeStyleSetAspectRatio

local function YGNodeLayoutGetDidLegacyStretchFlagAffectLayout(node: YGNode): boolean
    return node:getLayout().doesLegacyStretchFlagAffectsLayout
end
exports.YGNodeLayoutGetDidLegacyStretchFlagAffectLayout = YGNodeLayoutGetDidLegacyStretchFlagAffectLayout

local gCurrentGenerationCount = 0

local function YGNodePrintInternal(_node: YGNode, _options: YGPrintOptions): ()
    -- local str: string = YGNodeToString(str, node, options, 0)
    -- YGLog(node, YGLogLevel.Debug, str)
end
exports.YGNodePrintInternal = YGNodePrintInternal

local function YGNodePrint(node: YGNode, options: YGPrintOptions): ()
    YGNodePrintInternal(node, options)
end
exports.YGNodePrint = YGNodePrint

local function YGNodePaddingAndBorderForAxis(node: YGNode, axis: YGFlexDirection, widthSize: number): number
    return node:getLeadingPaddingAndBorder(axis, widthSize)
        :add(node:getTrailingPaddingAndBorder(axis, widthSize))
        :unwrap()
end
exports.YGNodePaddingAndBorderForAxis = YGNodePaddingAndBorderForAxis

local function YGNodeAlignItem(node: YGNode, child: YGNode): YGAlign
	-- stylua: ignore
	local align: YGAlign =
		if child:getStyle().alignSelf == YGAlign.Auto then node:getStyle().alignItems else child:getStyle().alignSelf
    if align == YGAlign.Baseline and YGFlexDirectionIsColumn(node:getStyle().flexDirection) then
        return YGAlign.FlexStart
    end
    return align
end
exports.YGNodeAlignItem = YGNodeAlignItem

local function YGBaseline(node: YGNode, layoutContext: any): number
    if node:hasBaselineFunc() then
        YGEvent.publish(node, EventType.NodeBaselineStart)
        local baseline: number = node:baseline(
            node:getLayout().measuredDimensions[YGDimension.Width],
            node:getLayout().measuredDimensions[YGDimension.Height],
            layoutContext
        )
        YGEvent.publish(node, EventType.NodeBaselineEnd)
        YGAssertWithNode(node, not (YGFloatIsUndefined(baseline)), "Expect custom baseline function to not return NaN")
        return baseline
    end

    local baselineChild: YGNode = nil
    local childCount = YGNodeGetChildCount(node)
    local i = 1
    while i <= childCount do
        local child: YGNode = YGNodeGetChild(node, i) :: YGNode
        if child:getLineIndex() > 1 then
            break
        end

        if child:getStyle().positionType == YGPositionType.Absolute then
            i += 1
            continue
        end

        if YGNodeAlignItem(node, child) == YGAlign.Baseline or child:isReferenceBaseline() then
            baselineChild = child
            break
        end

        if baselineChild == nil then
            baselineChild = child
        end

        i += 1
    end

    if baselineChild == nil then
        return node:getLayout().measuredDimensions[YGDimension.Height]
    end

    local baseline: number = YGBaseline(baselineChild, layoutContext)
    return baseline + baselineChild:getLayout().position[YGEdge.Top]
end
exports.YGBaseline = YGBaseline

local function YGIsBaselineLayout(node: YGNode): boolean
    if YGFlexDirectionIsColumn(node:getStyle().flexDirection) then
        return false
    end
    if node:getStyle().alignItems == YGAlign.Baseline then
        return true
    end
    local childCount: number = YGNodeGetChildCount(node)
    local i = 1
    while i <= childCount do
        local child: YGNode = YGNodeGetChild(node, i) :: YGNode
        if
            child:getStyle().positionType ~= YGPositionType.Absolute
            and child:getStyle().alignSelf == YGAlign.Baseline
        then
            return true
        end
        i += 1
    end
    return false
end
exports.YGIsBaselineLayout = YGIsBaselineLayout

local function YGNodeDimWithMargin(node: YGNode, axis: YGFlexDirection, widthSize: number): number
    return node:getLayout().measuredDimensions[dim[axis]]
        + node:getLeadingMargin(axis, widthSize):add(node:getTrailingMargin(axis, widthSize)):unwrap()
end
exports.YGNodeDimWithMargin = YGNodeDimWithMargin

local function YGNodeIsStyleDimDefined(node: YGNode, axis: YGFlexDirection, ownerSize: number): boolean
    local isUndefined: boolean = YGFloatIsUndefined(node:getResolvedDimension(dim[axis]).value)
    return not (
        node:getResolvedDimension(dim[axis]).unit == YGUnit.Auto
        or node:getResolvedDimension(dim[axis]).unit == YGUnit.Undefined
        or node:getResolvedDimension(dim[axis]).unit == YGUnit.Point and not isUndefined and node:getResolvedDimension(
            dim[axis]
        ).value < 0.0
        or node:getResolvedDimension(dim[axis]).unit == YGUnit.Percent
            and not isUndefined
            and (node:getResolvedDimension(dim[axis]).value < 0.0 or YGFloatIsUndefined(ownerSize))
    )
end
exports.YGNodeIsStyleDimDefined = YGNodeIsStyleDimDefined

local function YGNodeIsLayoutDimDefined(node: YGNode, axis: YGFlexDirection): boolean
    local value: number = node:getLayout().measuredDimensions[dim[axis]]
    return not (YGFloatIsUndefined(value)) and value >= 0.0
end
exports.YGNodeIsLayoutDimDefined = YGNodeIsLayoutDimDefined

local function YGNodeBoundAxisWithinMinAndMax(
    node: YGNode,
    axis: YGFlexDirection,
    value: YGFloatOptional,
    axisSize: number
): YGFloatOptional
    local min: YGFloatOptional
    local max: YGFloatOptional

    if YGFlexDirectionIsColumn(axis) then
        min = YGResolveValue(node:getStyle().minDimensions[YGDimension.Height], axisSize)
        max = YGResolveValue(node:getStyle().maxDimensions[YGDimension.Height], axisSize)
    elseif YGFlexDirectionIsRow(axis) then
        min = YGResolveValue(node:getStyle().minDimensions[YGDimension.Width], axisSize)
        max = YGResolveValue(node:getStyle().maxDimensions[YGDimension.Width], axisSize)
    end

    if max:isBiggerEqual(YGFloatOptional.new(0)) and value:isBigger(max) then
        return max
    end

    if min:isBiggerEqual(YGFloatOptional.new(0)) and value:isSmaller(min) then
        return min
    end

    return value
end
exports.YGNodeBoundAxisWithinMinAndMax = YGNodeBoundAxisWithinMinAndMax

local function YGNodeBoundAxis(
    node: YGNode,
    axis: YGFlexDirection,
    value: number,
    axisSize: number,
    widthSize: number
): number
    return YGFloatMax(
        YGNodeBoundAxisWithinMinAndMax(node, axis, YGFloatOptional.new(value), axisSize):unwrap(),
        YGNodePaddingAndBorderForAxis(node, axis, widthSize)
    )
end
exports.YGNodeBoundAxis = YGNodeBoundAxis

local function YGNodeSetChildTrailingPosition(node: YGNode, child: YGNode, axis: YGFlexDirection): ()
    local size: number = child:getLayout().measuredDimensions[dim[axis]]
    child:setLayoutPosition(
        node:getLayout().measuredDimensions[dim[axis]] - size - child:getLayout().position[pos[axis]],
        trailing[axis]
    )
end
exports.YGNodeSetChildTrailingPosition = YGNodeSetChildTrailingPosition

local function YGConstrainMaxSizeForMode(
    node: YGNode,
    axis: YGFlexDirection,
    ownerAxisSize: number,
    ownerWidth: number,
    mode: { value: YGMeasureMode },
    size: { value: number }
): ()
    local maxSize: YGFloatOptional = YGResolveValue(node:getStyle().maxDimensions[dim[axis]], ownerAxisSize):add(
        node:getMarginForAxis(axis, ownerWidth)
    )

    if mode.value == YGMeasureMode.Exactly or mode.value == YGMeasureMode.AtMost then
        size.value = if maxSize:isUndefined() or size.value < maxSize:getValue() then size.value else maxSize:getValue()
    elseif mode.value == YGMeasureMode.Undefined then
        if not (maxSize:isUndefined()) then
            mode.value = YGMeasureMode.AtMost
            size.value = maxSize:getValue()
        end
    end
end
exports.YGConstrainMaxSizeForMode = YGConstrainMaxSizeForMode

local function YGNodeComputeFlexBasisForChild(
    node: YGNode,
    child: YGNode,
    width: number,
    widthMode: YGMeasureMode,
    height: number,
    ownerWidth: number,
    ownerHeight: number,
    heightMode: YGMeasureMode,
    direction: YGDirection,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): ()
    local mainAxis: YGFlexDirection = YGResolveFlexDirection(node:getStyle().flexDirection, direction)
    local isMainAxisRow: boolean = YGFlexDirectionIsRow(mainAxis)
    local mainAxisSize: number = if isMainAxisRow then width else height
    local mainAxisownerSize: number = if isMainAxisRow then ownerWidth else ownerHeight

    local childWidth: number
    local childHeight: number
    local childWidthMeasureMode: YGMeasureMode
    local childHeightMeasureMode: YGMeasureMode
    local resolvedFlexBasis: YGFloatOptional = YGResolveValue(child:resolveFlexBasisPtr(), mainAxisownerSize)
    local isRowStyleDimDefined: boolean = YGNodeIsStyleDimDefined(child, YGFlexDirection.Row, ownerWidth)
    local isColumnStyleDimDefined: boolean = YGNodeIsStyleDimDefined(child, YGFlexDirection.Column, ownerHeight)

    if not (resolvedFlexBasis:isUndefined()) and not (YGFloatIsUndefined(mainAxisSize)) then
        if
            child:getLayout().computedFlexBasis:isUndefined()
            or YGConfigIsExperimentalFeatureEnabled(child:getConfig(), YGExperimentalFeature.WebFlexBasis)
                and child:getLayout().computedFlexBasisGeneration ~= generationCount
        then
            local paddingAndBorder: YGFloatOptional =
                YGFloatOptional.new(YGNodePaddingAndBorderForAxis(child, mainAxis, ownerWidth))
            child:setLayoutComputedFlexBasis(YGFloatOptionalMax(resolvedFlexBasis, paddingAndBorder))
        end
    elseif isMainAxisRow and isRowStyleDimDefined then
        local paddingAndBorder: YGFloatOptional =
            YGFloatOptional.new(YGNodePaddingAndBorderForAxis(child, YGFlexDirection.Row, ownerWidth))
        child:setLayoutComputedFlexBasis(
            YGFloatOptionalMax(
                YGResolveValue(child:getResolvedDimensions()[YGDimension.Width], ownerWidth),
                paddingAndBorder
            )
        )
    elseif not isMainAxisRow and isColumnStyleDimDefined then
        local paddingAndBorder: YGFloatOptional =
            YGFloatOptional.new(YGNodePaddingAndBorderForAxis(child, YGFlexDirection.Column, ownerWidth))
        child:setLayoutComputedFlexBasis(
            YGFloatOptionalMax(
                YGResolveValue(child:getResolvedDimensions()[YGDimension.Height], ownerHeight),
                paddingAndBorder
            )
        )
    else
        childWidth = YGUndefined
        childHeight = YGUndefined
        childWidthMeasureMode = YGMeasureMode.Undefined
        childHeightMeasureMode = YGMeasureMode.Undefined

        local marginRow = child:getMarginForAxis(YGFlexDirection.Row, ownerWidth):unwrap()
        local marginColumn = child:getMarginForAxis(YGFlexDirection.Column, ownerWidth):unwrap()

        if isRowStyleDimDefined then
            childWidth = YGResolveValue(child:getResolvedDimensions()[YGDimension.Width], ownerWidth):unwrap()
                + marginRow
            childWidthMeasureMode = YGMeasureMode.Exactly
        end

        if isColumnStyleDimDefined then
            childHeight = YGResolveValue(child:getResolvedDimensions()[YGDimension.Height], ownerHeight):unwrap()
                + marginColumn
            childHeightMeasureMode = YGMeasureMode.Exactly
        end

        if
            not isMainAxisRow and node:getStyle().overflow == YGOverflow.Scroll
            or node:getStyle().overflow ~= YGOverflow.Scroll
        then
            if YGFloatIsUndefined(childWidth) and not (YGFloatIsUndefined(width)) then
                childWidth = width
                childWidthMeasureMode = YGMeasureMode.AtMost
            end
        end

        if
            isMainAxisRow and node:getStyle().overflow == YGOverflow.Scroll
            or node:getStyle().overflow ~= YGOverflow.Scroll
        then
            if YGFloatIsUndefined(childHeight) and not (YGFloatIsUndefined(height)) then
                childHeight = height
                childHeightMeasureMode = YGMeasureMode.AtMost
            end
        end

        local childStyle = child:getStyle()

        if not (childStyle.aspectRatio:isUndefined()) then
            if not isMainAxisRow and childWidthMeasureMode == YGMeasureMode.Exactly then
                childHeight = marginColumn + (childWidth - marginRow) / childStyle.aspectRatio:unwrap()
                childHeightMeasureMode = YGMeasureMode.Exactly
            elseif isMainAxisRow and childHeightMeasureMode == YGMeasureMode.Exactly then
                childWidth = marginRow + (childHeight - marginColumn) * childStyle.aspectRatio:unwrap()
                childWidthMeasureMode = YGMeasureMode.Exactly
            end
        end

        local hasExactWidth: boolean = not (YGFloatIsUndefined(width)) and widthMode == YGMeasureMode.Exactly
        local childWidthStretch: boolean = YGNodeAlignItem(node, child) == YGAlign.Stretch
            and childWidthMeasureMode ~= YGMeasureMode.Exactly

        if not isMainAxisRow and not isRowStyleDimDefined and hasExactWidth and childWidthStretch then
            childWidth = width
            childWidthMeasureMode = YGMeasureMode.Exactly

            if not (childStyle.aspectRatio:isUndefined()) then
                childHeight = (childWidth - marginRow) / childStyle.aspectRatio:unwrap()
                childHeightMeasureMode = YGMeasureMode.Exactly
            end
        end

        local hasExactHeight: boolean = not (YGFloatIsUndefined(height)) and heightMode == YGMeasureMode.Exactly
        local childHeightStretch: boolean = YGNodeAlignItem(node, child) == YGAlign.Stretch
            and childHeightMeasureMode ~= YGMeasureMode.Exactly

        if isMainAxisRow and not isColumnStyleDimDefined and hasExactHeight and childHeightStretch then
            childHeight = height
            childHeightMeasureMode = YGMeasureMode.Exactly

            if not (childStyle.aspectRatio:isUndefined()) then
                childWidth = (childHeight - marginColumn) * childStyle.aspectRatio:unwrap()
                childWidthMeasureMode = YGMeasureMode.Exactly
            end
        end

        local childWidthMeasureModeRef = { value = childWidthMeasureMode }
        local childWidthRef = { value = childWidth }
        local childHeightMeasureModeRef = { value = childHeightMeasureMode }
        local childHeightRef = { value = childHeight }

        YGConstrainMaxSizeForMode(
            child,
            YGFlexDirection.Row,
            ownerWidth,
            ownerWidth,
            childWidthMeasureModeRef,
            childWidthRef
        )
        YGConstrainMaxSizeForMode(
            child,
            YGFlexDirection.Column,
            ownerHeight,
            ownerWidth,
            childHeightMeasureModeRef,
            childHeightRef
        )
        YGLayoutNodeInternal(
            child,
            childWidth,
            childHeight,
            direction,
            childWidthMeasureMode,
            childHeightMeasureMode,
            ownerWidth,
            ownerHeight,
            false,
            LayoutPassReason.kMeasureChild,
            config,
            layoutMarkerData,
            layoutContext,
            depth,
            generationCount
        )

        child:setLayoutComputedFlexBasis(
            YGFloatOptional.new(
                YGFloatMax(
                    child:getLayout().measuredDimensions[dim[mainAxis]],
                    YGNodePaddingAndBorderForAxis(child, mainAxis, ownerWidth)
                )
            )
        )
    end
    child:setLayoutComputedFlexBasisGeneration(generationCount)
end
exports.YGNodeComputeFlexBasisForChild = YGNodeComputeFlexBasisForChild

local function YGNodeAbsoluteLayoutChild(
    node: YGNode,
    child: YGNode,
    width: number,
    widthMode: YGMeasureMode,
    height: number,
    direction: YGDirection,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): ()
    local mainAxis: YGFlexDirection = YGResolveFlexDirection(node:getStyle().flexDirection, direction)
    local crossAxis: YGFlexDirection = YGFlexDirectionCross(mainAxis, direction)
    local isMainAxisRow: boolean = YGFlexDirectionIsRow(mainAxis)
    local childWidth: number = YGUndefined
    local childHeight: number = YGUndefined
    local childWidthMeasureMode: YGMeasureMode = YGMeasureMode.Undefined
    local childHeightMeasureMode: YGMeasureMode = YGMeasureMode.Undefined
    local marginRow = child:getMarginForAxis(YGFlexDirection.Row, width):unwrap()
    local marginColumn = child:getMarginForAxis(YGFlexDirection.Column, width):unwrap()

    if YGNodeIsStyleDimDefined(child, YGFlexDirection.Row, width) then
        childWidth = YGResolveValue(child:getResolvedDimensions()[YGDimension.Width], width):unwrap() + marginRow
    else
        if child:isLeadingPositionDefined(YGFlexDirection.Row) and child:isTrailingPosDefined(YGFlexDirection.Row) then
            childWidth = node:getLayout().measuredDimensions[YGDimension.Width]
                - node:getLeadingBorder(YGFlexDirection.Row)
                + node:getTrailingBorder(YGFlexDirection.Row)
                - child
                    :getLeadingPosition(YGFlexDirection.Row, width)
                    :add(child:getTrailingPosition(YGFlexDirection.Row, width))
                    :unwrap()
            childWidth = YGNodeBoundAxis(child, YGFlexDirection.Row, childWidth, width, width)
        end
    end

    if YGNodeIsStyleDimDefined(child, YGFlexDirection.Column, height) then
        childHeight = YGResolveValue(child:getResolvedDimensions()[YGDimension.Height], height):unwrap() + marginColumn
    else
        if
            child:isLeadingPositionDefined(YGFlexDirection.Column)
            and child:isTrailingPosDefined(YGFlexDirection.Column)
        then
            childHeight = node:getLayout().measuredDimensions[YGDimension.Height]
                - node:getLeadingBorder(YGFlexDirection.Column)
                + node:getTrailingBorder(YGFlexDirection.Column)
                - child
                    :getLeadingPosition(YGFlexDirection.Column, height)
                    :add(child:getTrailingPosition(YGFlexDirection.Column, height))
                    :unwrap()
            childHeight = YGNodeBoundAxis(child, YGFlexDirection.Column, childHeight, height, width)
        end
    end

    local childStyle = child:getStyle()

    if YGFloatIsUndefined(childWidth) ~= YGFloatIsUndefined(childHeight) then
        if not (childStyle.aspectRatio:isUndefined()) then
            if YGFloatIsUndefined(childWidth) then
                childWidth = marginRow + (childHeight - marginColumn) * childStyle.aspectRatio:unwrap()
            elseif YGFloatIsUndefined(childHeight) then
                childHeight = marginColumn + (childWidth - marginRow) / childStyle.aspectRatio:unwrap()
            end
        end
    end

    if YGFloatIsUndefined(childWidth) or YGFloatIsUndefined(childHeight) then
		-- stylua: ignore
		childWidthMeasureMode =
			if (YGFloatIsUndefined(childWidth)) then YGMeasureMode.Undefined else YGMeasureMode.Exactly
		-- stylua: ignore
		childHeightMeasureMode =
			if (YGFloatIsUndefined(childHeight)) then YGMeasureMode.Undefined else YGMeasureMode.Exactly

        if
            not isMainAxisRow
            and YGFloatIsUndefined(childWidth)
            and widthMode ~= YGMeasureMode.Undefined
            and not (YGFloatIsUndefined(width))
            and width > 0
        then
            childWidth = width
            childWidthMeasureMode = YGMeasureMode.AtMost
        end

        YGLayoutNodeInternal(
            child,
            childWidth,
            childHeight,
            direction,
            childWidthMeasureMode,
            childHeightMeasureMode,
            childWidth,
            childHeight,
            false,
            LayoutPassReason.kAbsMeasureChild,
            config,
            layoutMarkerData,
            layoutContext,
            depth,
            generationCount
        )

        childWidth = child:getLayout().measuredDimensions[YGDimension.Width]
            + child:getMarginForAxis(YGFlexDirection.Row, width):unwrap()
        childHeight = child:getLayout().measuredDimensions[YGDimension.Height]
            + child:getMarginForAxis(YGFlexDirection.Column, width):unwrap()
    end

    YGLayoutNodeInternal(
        child,
        childWidth,
        childHeight,
        direction,
        YGMeasureMode.Exactly,
        YGMeasureMode.Exactly,
        childWidth,
        childHeight,
        true,
        LayoutPassReason.kAbsLayout,
        config,
        layoutMarkerData,
        layoutContext,
        depth,
        generationCount
    )

    if child:isTrailingPosDefined(mainAxis) and not (child:isLeadingPositionDefined(mainAxis)) then
        child:setLayoutPosition(
            node:getLayout().measuredDimensions[dim[mainAxis]]
                - child:getLayout().measuredDimensions[dim[mainAxis]]
                - node:getTrailingBorder(mainAxis)
                - child:getTrailingMargin(mainAxis, width):unwrap()
                - child:getTrailingPosition(mainAxis, if isMainAxisRow then width else height):unwrap(),
            leading[mainAxis]
        )
    elseif not (child:isLeadingPositionDefined(mainAxis)) and node:getStyle().justifyContent == YGJustify.Center then
        child:setLayoutPosition(
            (node:getLayout().measuredDimensions[dim[mainAxis]] - child:getLayout().measuredDimensions[dim[mainAxis]])
                / 2.0,
            leading[mainAxis]
        )
    elseif not (child:isLeadingPositionDefined(mainAxis)) and node:getStyle().justifyContent == YGJustify.FlexEnd then
        child:setLayoutPosition(
            node:getLayout().measuredDimensions[dim[mainAxis]] - child:getLayout().measuredDimensions[dim[mainAxis]],
            leading[mainAxis]
        )
    end

    if child:isTrailingPosDefined(crossAxis) and not (child:isLeadingPositionDefined(crossAxis)) then
        child:setLayoutPosition(
            node:getLayout().measuredDimensions[dim[crossAxis]]
                - child:getLayout().measuredDimensions[dim[crossAxis]]
                - node:getTrailingBorder(crossAxis)
                - child:getTrailingMargin(crossAxis, width):unwrap()
                - child:getTrailingPosition(crossAxis, if isMainAxisRow then height else width):unwrap(),
            leading[crossAxis]
        )
    elseif not child:isLeadingPositionDefined(crossAxis) and YGNodeAlignItem(node, child) == YGAlign.Center then
        child:setLayoutPosition(
            (node:getLayout().measuredDimensions[dim[crossAxis]] - child:getLayout().measuredDimensions[dim[crossAxis]])
                / 2.0,
            leading[crossAxis]
        )
    elseif
        not child:isLeadingPositionDefined(crossAxis)
        and (YGNodeAlignItem(node, child) == YGAlign.FlexEnd) ~= (node:getStyle().flexWrap == YGWrap.WrapReverse)
    then
        child:setLayoutPosition(
            node:getLayout().measuredDimensions[dim[crossAxis]] - child:getLayout().measuredDimensions[dim[crossAxis]],
            leading[crossAxis]
        )
    end
end
exports.YGNodeAbsoluteLayoutChild = YGNodeAbsoluteLayoutChild

local function YGNodeWithMeasureFuncSetMeasuredDimensions(
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    reason: LayoutPassReason
): ()
    YGAssertWithNode(node, node:hasMeasureFunc(), "Expected node to have custom measure function")

    if widthMeasureMode == YGMeasureMode.Undefined then
        availableWidth = YGUndefined
    end

    if heightMeasureMode == YGMeasureMode.Undefined then
        availableHeight = YGUndefined
    end

    local padding = node:getLayout().padding
    local border = node:getLayout().border
    local paddingAndBorderAxisRow: number = padding[YGEdge.Left]
        + padding[YGEdge.Right]
        + border[YGEdge.Left]
        + border[YGEdge.Right]
    local paddingAndBorderAxisColumn: number = padding[YGEdge.Top]
        + padding[YGEdge.Bottom]
        + border[YGEdge.Top]
        + border[YGEdge.Bottom]
    local innerWidth: number = if (YGFloatIsUndefined(availableWidth))
        then availableWidth
        else YGFloatMax(0, availableWidth - paddingAndBorderAxisRow)
    local innerHeight: number = if (YGFloatIsUndefined(availableHeight))
        then availableHeight
        else YGFloatMax(0, availableHeight - paddingAndBorderAxisColumn)

    if widthMeasureMode == YGMeasureMode.Exactly and heightMeasureMode == YGMeasureMode.Exactly then
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(node, YGFlexDirection.Row, availableWidth, ownerWidth, ownerWidth),
            YGDimension.Width
        )
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(node, YGFlexDirection.Column, availableHeight, ownerHeight, ownerWidth),
            YGDimension.Height
        )
    else
        YGEvent.publish(node, EventType.MeasureCallbackStart)

        local measuredSize: YGSize =
            node:measure(innerWidth, widthMeasureMode, innerHeight, heightMeasureMode, layoutContext)
        layoutMarkerData.measureCallbacks += 1
        layoutMarkerData.measureCallbackReasonsCount[reason] += 1

        YGEvent.publish(node, EventType.MeasureCallbackEnd, {
            layoutContext = layoutContext,
            width = innerWidth,
            widthMeasureMode = widthMeasureMode,
            height = innerHeight,
            heightMeasureMode = heightMeasureMode,
            measuredWidth = measuredSize.width,
            measuredHeight = measuredSize.height,
            reason = reason,
        })

		-- stylua: ignore
		node:setLayoutMeasuredDimension(
			YGNodeBoundAxis(
				node,
				YGFlexDirection.Row,
				if widthMeasureMode == YGMeasureMode.Undefined or widthMeasureMode == YGMeasureMode.AtMost
					-- deviation: can't perform arithmetic operation on nil
					then safeAdd(measuredSize.width, paddingAndBorderAxisRow)
					else availableWidth,
				ownerWidth,
				ownerWidth
			),
			YGDimension.Width
		)
		-- stylua: ignore
		node:setLayoutMeasuredDimension(
			YGNodeBoundAxis(
				node,
				YGFlexDirection.Column,
				if heightMeasureMode == YGMeasureMode.Undefined or heightMeasureMode == YGMeasureMode.AtMost
					-- deviation: can't perform arithmetic operation on nil
					then safeAdd(measuredSize.height, paddingAndBorderAxisColumn)
					else availableHeight,
				ownerHeight,
				ownerWidth
			),
			YGDimension.Height
		)
    end
end
exports.YGNodeWithMeasureFuncSetMeasuredDimensions = YGNodeWithMeasureFuncSetMeasuredDimensions

local function YGNodeEmptyContainerSetMeasuredDimensions(
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number
): ()
    local padding = node:getLayout().padding
    local border = node:getLayout().border
    local width: number = availableWidth
    if widthMeasureMode == YGMeasureMode.Undefined or widthMeasureMode == YGMeasureMode.AtMost then
        width = padding[YGEdge.Left] + padding[YGEdge.Right] + border[YGEdge.Left] + border[YGEdge.Right]
    end

    node:setLayoutMeasuredDimension(
        YGNodeBoundAxis(node, YGFlexDirection.Row, width, ownerWidth, ownerWidth),
        YGDimension.Width
    )

    local height: number = availableHeight
    if heightMeasureMode == YGMeasureMode.Undefined or heightMeasureMode == YGMeasureMode.AtMost then
        height = padding[YGEdge.Top] + padding[YGEdge.Bottom] + border[YGEdge.Top] + border[YGEdge.Bottom]
    end

    node:setLayoutMeasuredDimension(
        YGNodeBoundAxis(node, YGFlexDirection.Column, height, ownerHeight, ownerWidth),
        YGDimension.Height
    )
end
exports.YGNodeEmptyContainerSetMeasuredDimensions = YGNodeEmptyContainerSetMeasuredDimensions

local function YGNodeFixedSizeSetMeasuredDimensions(
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number
): boolean
    if
        not (YGFloatIsUndefined(availableWidth))
            and widthMeasureMode == YGMeasureMode.AtMost
            and availableWidth <= 0.0
        or not (YGFloatIsUndefined(availableHeight)) and heightMeasureMode == YGMeasureMode.AtMost and availableHeight <= 0.0
        or widthMeasureMode == YGMeasureMode.Exactly and heightMeasureMode == YGMeasureMode.Exactly
    then
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(
                node,
                YGFlexDirection.Row,
                (
                    YGFloatIsUndefined(availableWidth)
                    or widthMeasureMode == YGMeasureMode.AtMost and availableWidth < 0.0
                )
                        and 0.0
                    or availableWidth,
                ownerWidth,
                ownerWidth
            ),
            YGDimension.Width
        )
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(
                node,
                YGFlexDirection.Column,
                (
                    YGFloatIsUndefined(availableHeight)
                    or heightMeasureMode == YGMeasureMode.AtMost and availableHeight < 0.0
                )
                        and 0.0
                    or availableHeight,
                ownerHeight,
                ownerWidth
            ),
            YGDimension.Height
        )
        return true
    end
    return false
end
exports.YGNodeFixedSizeSetMeasuredDimensions = YGNodeFixedSizeSetMeasuredDimensions

local function YGZeroOutLayoutRecursivly(node: YGNode, layoutContext: any): ()
    node:getLayout():clean()
    node:setLayoutDimension(0, 0)
    node:setLayoutDimension(0, 1)
    node:setHasNewLayout(true)
    node:iterChildrenAfterCloningIfNeeded(YGZeroOutLayoutRecursivly, layoutContext)
end
exports.YGZeroOutLayoutRecursivly = YGZeroOutLayoutRecursivly

local function YGNodeCalculateAvailableInnerDim(
    node: YGNode,
    dimension: YGDimension,
    availableDim: number,
    paddingAndBorder: number,
    ownerDim: number
): number
    local availableInnerDim: number = availableDim - paddingAndBorder

    if not (YGFloatIsUndefined(availableInnerDim)) then
        local minDimensionOptional: YGFloatOptional = YGResolveValue(node:getStyle().minDimensions[dimension], ownerDim)
        local minInnerDim: number = (minDimensionOptional:isUndefined()) and 0.0
            or minDimensionOptional:unwrap() - paddingAndBorder
        local maxDimensionOptional: YGFloatOptional = YGResolveValue(node:getStyle().maxDimensions[dimension], ownerDim)
        local maxInnerDim: number = if maxDimensionOptional:isUndefined()
            -- deviation: using MAX_SAFE_INTEGER instead of MAX_VALUE
            then Number.MAX_SAFE_INTEGER
            else maxDimensionOptional:unwrap() - paddingAndBorder

        availableInnerDim = YGFloatMax(YGFloatMin(availableInnerDim, maxInnerDim), minInnerDim)
    end

    return availableInnerDim
end
exports.YGNodeCalculateAvailableInnerDim = YGNodeCalculateAvailableInnerDim

local function YGNodeComputeFlexBasisForChildren(
    node: YGNode,
    availableInnerWidth: number,
    availableInnerHeight: number,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    direction: YGDirection,
    mainAxis: YGFlexDirection,
    config: YGConfig,
    performLayout: boolean,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): number
    local totalOuterFlexBasis = 0.0
    local singleFlexChild: YGNode? = nil
    local children: Array<YGNode> = node:getChildren()
    local measureModeMainDim: YGMeasureMode = if (YGFlexDirectionIsRow(mainAxis))
        then widthMeasureMode
        else heightMeasureMode

    if measureModeMainDim == YGMeasureMode.Exactly then
        for _, child in ipairs(children) do
            if child:isNodeFlexible() then
                if
                    singleFlexChild ~= nil
                    or YGFloatsEqual(child:resolveFlexGrow(), 0.0)
                    or YGFloatsEqual(child:resolveFlexShrink(), 0.0)
                then
                    -- There is already a flexible child, or this flexible child
                    -- doesn't have flexGrow and flexShrink, abort
                    singleFlexChild = nil
                    break
                else
                    singleFlexChild = child
                end
            end
        end
    end

    for _, child in ipairs(children) do
        child:resolveDimension()

        if child:getStyle().display == YGDisplay.None then
            YGZeroOutLayoutRecursivly(child, layoutContext)
            child:setHasNewLayout(true)
            child:setDirty(false)
            continue
        end

        if performLayout then
            -- Set the initial position (relative to the owner).
            local childDirection: YGDirection = child:resolveDirection(direction)
            local mainDim: number = if YGFlexDirectionIsRow(mainAxis) then availableInnerWidth else availableInnerHeight
			-- stylua: ignore
			local crossDim: number =
				if YGFlexDirectionIsRow(mainAxis) then availableInnerHeight else availableInnerWidth
            child:setPosition(childDirection, mainDim, crossDim, availableInnerWidth)
        end

        if child:getStyle().positionType == YGPositionType.Absolute then
            continue
        end

        if child == singleFlexChild then
            child:setLayoutComputedFlexBasisGeneration(generationCount)
            child:setLayoutComputedFlexBasis(YGFloatOptional.new(0))
        else
            YGNodeComputeFlexBasisForChild(
                node,
                child,
                availableInnerWidth,
                widthMeasureMode,
                availableInnerHeight,
                availableInnerWidth,
                availableInnerHeight,
                heightMeasureMode,
                direction,
                config,
                layoutMarkerData,
                layoutContext,
                depth,
                generationCount
            )
        end

        totalOuterFlexBasis += child:getLayout().computedFlexBasis:unwrap() + child
            :getMarginForAxis(mainAxis, availableInnerWidth)
            :unwrap()
    end

    return totalOuterFlexBasis
end
exports.YGNodeComputeFlexBasisForChildren = YGNodeComputeFlexBasisForChildren

local function YGCalculateCollectFlexItemsRowValues(
    node: YGNode,
    ownerDirection: YGDirection,
    mainAxisownerSize: number,
    availableInnerWidth: number,
    availableInnerMainDim: number,
    startOfLineIndex: number,
    lineCount: number
): YGCollectFlexItemsRowValues
    local flexAlgoRowMeasurement: YGCollectFlexItemsRowValues = YGCollectFlexItemsRowValues.new()
    local sizeConsumedOnCurrentLineIncludingMinConstraint = 0
    local mainAxis: YGFlexDirection =
        YGResolveFlexDirection(node:getStyle().flexDirection, node:resolveDirection(ownerDirection))
    local isNodeFlexWrap: boolean = node:getStyle().flexWrap ~= YGWrap.NoWrap
    local endOfLineIndex = startOfLineIndex

    while endOfLineIndex <= #node:getChildren() do
        local child: YGNode = node:getChild(endOfLineIndex)
        if child:getStyle().display == YGDisplay.None or child:getStyle().positionType == YGPositionType.Absolute then
            endOfLineIndex += 1
            continue
        end

        child:setLineIndex(lineCount + 1)

        local childMarginMainAxis: number = child:getMarginForAxis(mainAxis, availableInnerWidth):unwrap()
        local flexBasisWithMinAndMaxConstraints: number = YGNodeBoundAxisWithinMinAndMax(
            child,
            mainAxis,
            child:getLayout().computedFlexBasis,
            mainAxisownerSize
        ):unwrap()

        if
            sizeConsumedOnCurrentLineIncludingMinConstraint
                    + flexBasisWithMinAndMaxConstraints
                    + childMarginMainAxis
                > availableInnerMainDim
            and isNodeFlexWrap
            and flexAlgoRowMeasurement.itemsOnLine > 0
        then
            break
        end

        sizeConsumedOnCurrentLineIncludingMinConstraint += flexBasisWithMinAndMaxConstraints + childMarginMainAxis
        flexAlgoRowMeasurement.sizeConsumedOnCurrentLine += flexBasisWithMinAndMaxConstraints + childMarginMainAxis
        flexAlgoRowMeasurement.itemsOnLine += 1

        if child:isNodeFlexible() then
            flexAlgoRowMeasurement.totalFlexGrowFactors += child:resolveFlexGrow()
            flexAlgoRowMeasurement.totalFlexShrinkScaledFactors += -child:resolveFlexShrink() * child
                :getLayout().computedFlexBasis
                :unwrap()
        end

        table.insert(flexAlgoRowMeasurement.relativeChildren, child)
        endOfLineIndex += 1
    end

    if flexAlgoRowMeasurement.totalFlexGrowFactors > 0 and flexAlgoRowMeasurement.totalFlexGrowFactors < 1 then
        flexAlgoRowMeasurement.totalFlexGrowFactors = 1
    end
    if
        flexAlgoRowMeasurement.totalFlexShrinkScaledFactors > 0
        and flexAlgoRowMeasurement.totalFlexShrinkScaledFactors < 1
    then
        flexAlgoRowMeasurement.totalFlexShrinkScaledFactors = 1
    end

    flexAlgoRowMeasurement.endOfLineIndex = endOfLineIndex

    return flexAlgoRowMeasurement
end
exports.YGCalculateCollectFlexItemsRowValues = YGCalculateCollectFlexItemsRowValues

local function YGDistributeFreeSpaceSecondPass(
    collectedFlexItemsValues: YGCollectFlexItemsRowValues,
    node: YGNode,
    mainAxis: YGFlexDirection,
    crossAxis: YGFlexDirection,
    mainAxisownerSize: number,
    availableInnerMainDim: number,
    availableInnerCrossDim: number,
    availableInnerWidth: number,
    availableInnerHeight: number,
    flexBasisOverflows: boolean,
    measureModeCrossDim: YGMeasureMode,
    performLayout: boolean,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): number
    local childFlexBasis = 0
    local flexShrinkScaledFactor = 0
    local flexGrowFactor = 0
    local deltaFreeSpace = 0
    local isMainAxisRow: boolean = YGFlexDirectionIsRow(mainAxis)
    local isNodeFlexWrap: boolean = node:getStyle().flexWrap ~= YGWrap.NoWrap

    for _, currentRelativeChild in ipairs(collectedFlexItemsValues.relativeChildren) do
        childFlexBasis = YGNodeBoundAxisWithinMinAndMax(
            currentRelativeChild,
            mainAxis,
            currentRelativeChild:getLayout().computedFlexBasis,
            mainAxisownerSize
        ):unwrap()
        local updatedMainSize: number = childFlexBasis

        if
            not YGFloatIsUndefined(collectedFlexItemsValues.remainingFreeSpace)
            and collectedFlexItemsValues.remainingFreeSpace < 0
        then
            flexShrinkScaledFactor = -currentRelativeChild:resolveFlexShrink() * childFlexBasis -- Is this child able to shrink?

            if flexShrinkScaledFactor ~= 0 then
                local childSize: number

                if
                    not YGFloatIsUndefined(collectedFlexItemsValues.totalFlexShrinkScaledFactors)
                    and collectedFlexItemsValues.totalFlexShrinkScaledFactors == 0
                then
                    childSize = childFlexBasis + flexShrinkScaledFactor
                else
                    childSize = childFlexBasis
                        + collectedFlexItemsValues.remainingFreeSpace
                            / collectedFlexItemsValues.totalFlexShrinkScaledFactors
                            * flexShrinkScaledFactor
                end

                updatedMainSize = YGNodeBoundAxis(
                    currentRelativeChild,
                    mainAxis,
                    childSize,
                    availableInnerMainDim,
                    availableInnerWidth
                )
            end
        elseif
            not YGFloatIsUndefined(collectedFlexItemsValues.remainingFreeSpace)
            and collectedFlexItemsValues.remainingFreeSpace > 0
        then
            flexGrowFactor = currentRelativeChild:resolveFlexGrow() -- Is this child able to grow?

            if not YGFloatIsUndefined(flexGrowFactor) and flexGrowFactor ~= 0 then
                updatedMainSize = YGNodeBoundAxis(
                    currentRelativeChild,
                    mainAxis,
                    childFlexBasis
                        + collectedFlexItemsValues.remainingFreeSpace
                            / collectedFlexItemsValues.totalFlexGrowFactors
                            * flexGrowFactor,
                    availableInnerMainDim,
                    availableInnerWidth
                )
            end
        end

        deltaFreeSpace += updatedMainSize - childFlexBasis
        local marginMain: number = currentRelativeChild:getMarginForAxis(mainAxis, availableInnerWidth):unwrap()
        local marginCross: number = currentRelativeChild:getMarginForAxis(crossAxis, availableInnerWidth):unwrap()
        local childCrossSize: number
        local childMainSize: number = updatedMainSize + marginMain
        local childCrossMeasureMode: YGMeasureMode
        local childMainMeasureMode: YGMeasureMode = YGMeasureMode.Exactly
        local childStyle = currentRelativeChild:getStyle()

        if not childStyle.aspectRatio:isUndefined() then
			-- stylua: ignore
			childCrossSize =
				if isMainAxisRow then (childMainSize - marginMain) / childStyle.aspectRatio:unwrap() else (childMainSize - marginMain) * childStyle.aspectRatio:unwrap()
            childCrossMeasureMode = YGMeasureMode.Exactly
            childCrossSize += marginCross
        elseif
            not YGFloatIsUndefined(availableInnerCrossDim)
            and not YGNodeIsStyleDimDefined(currentRelativeChild, crossAxis, availableInnerCrossDim)
            and measureModeCrossDim == YGMeasureMode.Exactly
            and not (isNodeFlexWrap and flexBasisOverflows)
            and YGNodeAlignItem(node, currentRelativeChild) == YGAlign.Stretch
            and currentRelativeChild:marginLeadingValue(crossAxis).unit ~= YGUnit.Auto
            and currentRelativeChild:marginTrailingValue(crossAxis).unit ~= YGUnit.Auto
        then
            childCrossSize = availableInnerCrossDim
            childCrossMeasureMode = YGMeasureMode.Exactly
        elseif not YGNodeIsStyleDimDefined(currentRelativeChild, crossAxis, availableInnerCrossDim) then
            childCrossSize = availableInnerCrossDim
			-- stylua: ignore
			childCrossMeasureMode =
				if YGFloatIsUndefined(childCrossSize) then YGMeasureMode.Undefined else YGMeasureMode.AtMost
        else
            childCrossSize = YGResolveValue(
                currentRelativeChild:getResolvedDimension(dim[crossAxis]),
                availableInnerCrossDim
            ):unwrap() + marginCross
            local isLoosePercentageMeasurement: boolean = currentRelativeChild:getResolvedDimension(dim[crossAxis]).unit
                    == YGUnit.Percent
                and measureModeCrossDim ~= YGMeasureMode.Exactly
			-- stylua: ignore
			childCrossMeasureMode =
				if YGFloatIsUndefined(childCrossSize) or isLoosePercentageMeasurement then YGMeasureMode.Undefined else YGMeasureMode.Exactly
        end

        local childMainMeasureModeRef = { value = childMainMeasureMode }
        local childMainSizeRef = { value = childMainSize }
        local childCrossMeasureModeRef = { value = childCrossMeasureMode }
        local childCrossSizeRef = { value = childCrossSize }

        YGConstrainMaxSizeForMode(
            currentRelativeChild,
            mainAxis,
            availableInnerMainDim,
            availableInnerWidth,
            childMainMeasureModeRef,
            childMainSizeRef
        )
        YGConstrainMaxSizeForMode(
            currentRelativeChild,
            crossAxis,
            availableInnerCrossDim,
            availableInnerWidth,
            childCrossMeasureModeRef,
            childCrossSizeRef
        )

        local requiresStretchLayout: boolean = not YGNodeIsStyleDimDefined(
            currentRelativeChild,
            crossAxis,
            availableInnerCrossDim
        ) and YGNodeAlignItem(node, currentRelativeChild) == YGAlign.Stretch and currentRelativeChild:marginLeadingValue(
            crossAxis
        ).unit ~= YGUnit.Auto and currentRelativeChild:marginTrailingValue(crossAxis).unit ~= YGUnit.Auto
        local childWidth: number = if isMainAxisRow then childMainSize else childCrossSize
        local childHeight: number = if not isMainAxisRow then childMainSize else childCrossSize
		-- stylua: ignore
		local childWidthMeasureMode: YGMeasureMode =
			if isMainAxisRow then childMainMeasureMode else childCrossMeasureMode
		-- stylua: ignore
		local childHeightMeasureMode: YGMeasureMode =
			if not isMainAxisRow then childMainMeasureMode else childCrossMeasureMode
        local isLayoutPass: boolean = performLayout and not requiresStretchLayout -- Recursively call the layout algorithm for this child with the updated main size.

		-- stylua: ignore
		YGLayoutNodeInternal(
			currentRelativeChild,
			childWidth,
			childHeight,
			node:getLayout().direction,
			childWidthMeasureMode,
			childHeightMeasureMode,
			availableInnerWidth,
			availableInnerHeight,
			isLayoutPass,
			if isLayoutPass then LayoutPassReason.kFlexLayout else LayoutPassReason.kFlexMeasure,
			config,
			layoutMarkerData,
			layoutContext,
			depth,
			generationCount
		)
        node:setLayoutHadOverflow(node:getLayout().hadOverflow or currentRelativeChild:getLayout().hadOverflow)
    end

    return deltaFreeSpace
end
exports.YGDistributeFreeSpaceSecondPass = YGDistributeFreeSpaceSecondPass

local function YGDistributeFreeSpaceFirstPass(
    collectedFlexItemsValues: YGCollectFlexItemsRowValues,
    mainAxis: YGFlexDirection,
    mainAxisownerSize: number,
    availableInnerMainDim: number,
    availableInnerWidth: number
): ()
    local flexShrinkScaledFactor = 0
    local flexGrowFactor = 0
    local baseMainSize = 0
    local boundMainSize = 0
    local deltaFreeSpace = 0

    for _, currentRelativeChild in ipairs(collectedFlexItemsValues.relativeChildren) do
        local childFlexBasis: number = YGNodeBoundAxisWithinMinAndMax(
            currentRelativeChild,
            mainAxis,
            currentRelativeChild:getLayout().computedFlexBasis,
            mainAxisownerSize
        ):unwrap()

        if collectedFlexItemsValues.remainingFreeSpace < 0 then
            flexShrinkScaledFactor = -currentRelativeChild:resolveFlexShrink() * childFlexBasis -- Is this child able to shrink?

            if not YGFloatIsUndefined(flexShrinkScaledFactor) and flexShrinkScaledFactor ~= 0 then
                baseMainSize = childFlexBasis
                    + collectedFlexItemsValues.remainingFreeSpace
                        / collectedFlexItemsValues.totalFlexShrinkScaledFactors
                        * flexShrinkScaledFactor
                boundMainSize = YGNodeBoundAxis(
                    currentRelativeChild,
                    mainAxis,
                    baseMainSize,
                    availableInnerMainDim,
                    availableInnerWidth
                )

                if
                    not YGFloatIsUndefined(baseMainSize)
                    and not YGFloatIsUndefined(boundMainSize)
                    and baseMainSize ~= boundMainSize
                then
                    -- By excluding this item's size and flex factor from
                    -- remaining, this item's min/max constraints should also
                    -- trigger in the second pass resulting in the item's size
                    -- calculation being identical in the first and second
                    -- passes.
                    deltaFreeSpace += boundMainSize - childFlexBasis
                    collectedFlexItemsValues.totalFlexShrinkScaledFactors -= -currentRelativeChild:resolveFlexShrink() * currentRelativeChild
                        :getLayout().computedFlexBasis
                        :unwrap()
                end
            end
        elseif
            not YGFloatIsUndefined(collectedFlexItemsValues.remainingFreeSpace)
            and collectedFlexItemsValues.remainingFreeSpace > 0
        then
            flexGrowFactor = currentRelativeChild:resolveFlexGrow() -- Is this child able to grow?

            if not YGFloatIsUndefined(flexGrowFactor) and flexGrowFactor ~= 0 then
                baseMainSize = childFlexBasis
                    + collectedFlexItemsValues.remainingFreeSpace
                        / collectedFlexItemsValues.totalFlexGrowFactors
                        * flexGrowFactor
                boundMainSize = YGNodeBoundAxis(
                    currentRelativeChild,
                    mainAxis,
                    baseMainSize,
                    availableInnerMainDim,
                    availableInnerWidth
                )

                if
                    not YGFloatIsUndefined(baseMainSize)
                    and not YGFloatIsUndefined(boundMainSize)
                    and baseMainSize ~= boundMainSize
                then
                    -- By excluding this item's size and flex factor from
                    -- remaining, this item's min/max constraints should also
                    -- trigger in the second pass resulting in the item's size
                    -- calculation being identical in the first and second
                    -- passes.
                    deltaFreeSpace += boundMainSize - childFlexBasis
                    collectedFlexItemsValues.totalFlexGrowFactors -= flexGrowFactor
                end
            end
        end
    end

    collectedFlexItemsValues.remainingFreeSpace -= deltaFreeSpace
end
exports.YGDistributeFreeSpaceFirstPass = YGDistributeFreeSpaceFirstPass

local function YGResolveFlexibleLength(
    node: YGNode,
    collectedFlexItemsValues: YGCollectFlexItemsRowValues,
    mainAxis: YGFlexDirection,
    crossAxis: YGFlexDirection,
    mainAxisownerSize: number,
    availableInnerMainDim: number,
    availableInnerCrossDim: number,
    availableInnerWidth: number,
    availableInnerHeight: number,
    flexBasisOverflows: boolean,
    measureModeCrossDim: YGMeasureMode,
    performLayout: boolean,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): ()
    local originalFreeSpace: number = collectedFlexItemsValues.remainingFreeSpace

    YGDistributeFreeSpaceFirstPass(
        collectedFlexItemsValues,
        mainAxis,
        mainAxisownerSize,
        availableInnerMainDim,
        availableInnerWidth
    )

    local distributedFreeSpace: number = YGDistributeFreeSpaceSecondPass(
        collectedFlexItemsValues,
        node,
        mainAxis,
        crossAxis,
        mainAxisownerSize,
        availableInnerMainDim,
        availableInnerCrossDim,
        availableInnerWidth,
        availableInnerHeight,
        flexBasisOverflows,
        measureModeCrossDim,
        performLayout,
        config,
        layoutMarkerData,
        layoutContext,
        depth,
        generationCount
    )

    collectedFlexItemsValues.remainingFreeSpace = originalFreeSpace - distributedFreeSpace
end
exports.YGResolveFlexibleLength = YGResolveFlexibleLength

local function YGJustifyMainAxis(
    node: YGNode,
    collectedFlexItemsValues: YGCollectFlexItemsRowValues,
    startOfLineIndex: number,
    mainAxis: YGFlexDirection,
    crossAxis: YGFlexDirection,
    measureModeMainDim: YGMeasureMode,
    measureModeCrossDim: YGMeasureMode,
    mainAxisownerSize: number,
    ownerWidth: number,
    availableInnerMainDim: number,
    availableInnerCrossDim: number,
    availableInnerWidth: number,
    performLayout: boolean,
    layoutContext: any
): ()
    local style = node:getStyle()
    local leadingPaddingAndBorderMain: number = node:getLeadingPaddingAndBorder(mainAxis, ownerWidth):unwrap()
    local trailingPaddingAndBorderMain: number = node:getTrailingPaddingAndBorder(mainAxis, ownerWidth):unwrap()

    if measureModeMainDim == YGMeasureMode.AtMost and collectedFlexItemsValues.remainingFreeSpace > 0 then
        if
            not (style.minDimensions[dim[mainAxis]]:isUndefined())
            and not (YGResolveValue(style.minDimensions[dim[mainAxis]], mainAxisownerSize):isUndefined())
        then
            local minAvailableMainDim: number = YGResolveValue(style.minDimensions[dim[mainAxis]], mainAxisownerSize):unwrap()
                - leadingPaddingAndBorderMain
                - trailingPaddingAndBorderMain
            local occupiedSpaceByChildNodes: number = availableInnerMainDim
                - collectedFlexItemsValues.remainingFreeSpace
            collectedFlexItemsValues.remainingFreeSpace = YGFloatMax(0, minAvailableMainDim - occupiedSpaceByChildNodes)
        else
            collectedFlexItemsValues.remainingFreeSpace = 0
        end
    end

    local numberOfAutoMarginsOnCurrentLine = 0
    do
        local i: number = startOfLineIndex
        while i < collectedFlexItemsValues.endOfLineIndex do
            local child: YGNode = node:getChild(i)

            if child:getStyle().positionType ~= YGPositionType.Absolute then
                if child:marginLeadingValue(mainAxis).unit == YGUnit.Auto then
                    numberOfAutoMarginsOnCurrentLine += 1
                end
                if child:marginTrailingValue(mainAxis).unit == YGUnit.Auto then
                    numberOfAutoMarginsOnCurrentLine += 1
                end
            end

            i += 1
        end
    end

    local leadingMainDim = 0
    local betweenMainDim = 0
    local justifyContent: YGJustify = node:getStyle().justifyContent

    if numberOfAutoMarginsOnCurrentLine == 0 then
        if justifyContent == YGJustify.Center then
            leadingMainDim = collectedFlexItemsValues.remainingFreeSpace / 2
        elseif justifyContent == YGJustify.FlexEnd then
            leadingMainDim = collectedFlexItemsValues.remainingFreeSpace
        elseif justifyContent == YGJustify.SpaceBetween then
            if collectedFlexItemsValues.itemsOnLine > 1 then
                betweenMainDim = YGFloatMax(collectedFlexItemsValues.remainingFreeSpace, 0)
                    / (collectedFlexItemsValues.itemsOnLine - 1)
            else
                betweenMainDim = 0
            end
        elseif justifyContent == YGJustify.SpaceEvenly then
            -- Space is distributed evenly across all elements
            betweenMainDim = collectedFlexItemsValues.remainingFreeSpace / (collectedFlexItemsValues.itemsOnLine + 1)
            leadingMainDim = betweenMainDim
        elseif justifyContent == YGJustify.SpaceAround then
            -- Space on the edges is half of the space between elements
            betweenMainDim = collectedFlexItemsValues.remainingFreeSpace / collectedFlexItemsValues.itemsOnLine
            leadingMainDim = betweenMainDim / 2
        end
    end

    collectedFlexItemsValues.mainDim = leadingPaddingAndBorderMain + leadingMainDim
    collectedFlexItemsValues.crossDim = 0

    local maxAscentForCurrentLine = 0
    local maxDescentForCurrentLine = 0
    local isNodeBaselineLayout: boolean = YGIsBaselineLayout(node)

    do
        local i: number = startOfLineIndex
        while i < collectedFlexItemsValues.endOfLineIndex do
            local child: YGNode = node:getChild(i)
            local childStyle: YGStyle = child:getStyle()
            local childLayout: YGLayout = child:getLayout()

            if childStyle.display == YGDisplay.None then
                i += 1
                continue
            end

            if childStyle.positionType == YGPositionType.Absolute and child:isLeadingPositionDefined(mainAxis) then
                if performLayout then
                    child:setLayoutPosition(
                        child:getLeadingPosition(mainAxis, availableInnerMainDim):unwrap()
                            + node:getLeadingBorder(mainAxis)
                            + child:getLeadingMargin(mainAxis, availableInnerWidth):unwrap(),
                        pos[mainAxis]
                    )
                end
            else
                if childStyle.positionType ~= YGPositionType.Absolute then
                    if child:marginLeadingValue(mainAxis).unit == YGUnit.Auto then
                        collectedFlexItemsValues.mainDim += collectedFlexItemsValues.remainingFreeSpace / numberOfAutoMarginsOnCurrentLine
                    end

                    if performLayout then
                        child:setLayoutPosition(
                            childLayout.position[pos[mainAxis]] + collectedFlexItemsValues.mainDim,
                            pos[mainAxis]
                        )
                    end

                    if child:marginTrailingValue(mainAxis).unit == YGUnit.Auto then
                        collectedFlexItemsValues.mainDim += collectedFlexItemsValues.remainingFreeSpace / numberOfAutoMarginsOnCurrentLine
                    end

                    local canSkipFlex: boolean = not performLayout and measureModeCrossDim == YGMeasureMode.Exactly

                    if canSkipFlex then
                        collectedFlexItemsValues.mainDim += betweenMainDim + child
                            :getMarginForAxis(mainAxis, availableInnerWidth)
                            :unwrap() + childLayout.computedFlexBasis:unwrap()
                        collectedFlexItemsValues.crossDim = availableInnerCrossDim
                    else
                        collectedFlexItemsValues.mainDim += betweenMainDim + YGNodeDimWithMargin(
                            child,
                            mainAxis,
                            availableInnerWidth
                        )

                        if isNodeBaselineLayout then
                            local ascent: number = YGBaseline(child, layoutContext)
                                + child:getLeadingMargin(YGFlexDirection.Column, availableInnerWidth):unwrap()
                            local descent: number = child:getLayout().measuredDimensions[YGDimension.Height]
                                + child:getMarginForAxis(YGFlexDirection.Column, availableInnerWidth):unwrap()
                                - ascent

                            maxAscentForCurrentLine = YGFloatMax(maxAscentForCurrentLine, ascent)
                            maxDescentForCurrentLine = YGFloatMax(maxDescentForCurrentLine, descent)
                        else
                            collectedFlexItemsValues.crossDim = YGFloatMax(
                                collectedFlexItemsValues.crossDim,
                                YGNodeDimWithMargin(child, crossAxis, availableInnerWidth)
                            )
                        end
                    end
                elseif performLayout then
                    child:setLayoutPosition(
                        childLayout.position[pos[mainAxis]] + node:getLeadingBorder(mainAxis) + leadingMainDim,
                        pos[mainAxis]
                    )
                end
            end
            i += 1
        end
    end

    collectedFlexItemsValues.mainDim += trailingPaddingAndBorderMain

    if isNodeBaselineLayout then
        collectedFlexItemsValues.crossDim = maxAscentForCurrentLine + maxDescentForCurrentLine
    end
end
exports.YGJustifyMainAxis = YGJustifyMainAxis

local function YGNodelayoutImpl(
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    ownerDirection: YGDirection,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number,
    performLayout: boolean,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number,
    reason: LayoutPassReason
): ()
	-- stylua: ignore
	YGAssertWithNode(
		node,
		if (YGFloatIsUndefined(availableWidth)) then widthMeasureMode == YGMeasureMode.Undefined else true,
		"availableWidth is indefinite so widthMeasureMode must be YGMeasureMode.Undefined"
	)
	-- stylua: ignore
	YGAssertWithNode(
		node,
		if (YGFloatIsUndefined(availableHeight)) then heightMeasureMode == YGMeasureMode.Undefined else true,
		"availableHeight is indefinite so heightMeasureMode must be YGMeasureMode.Undefined"
	)

    if performLayout then
        layoutMarkerData.layouts += 1
    else
        layoutMarkerData.measures += 1
    end

    local direction: YGDirection = node:resolveDirection(ownerDirection)
    node:setLayoutDirection(direction)

    local flexRowDirection: YGFlexDirection = YGResolveFlexDirection(YGFlexDirection.Row, direction)
    local flexColumnDirection: YGFlexDirection = YGResolveFlexDirection(YGFlexDirection.Column, direction)
    local startEdge: YGEdge = if direction == YGDirection.LTR then YGEdge.Left else YGEdge.Right
    local endEdge: YGEdge = if direction == YGDirection.LTR then YGEdge.Right else YGEdge.Left

    local marginRowLeading: number = node:getLeadingMargin(flexRowDirection, ownerWidth):unwrap()
    node:setLayoutMargin(marginRowLeading, startEdge)

    local marginRowTrailing: number = node:getTrailingMargin(flexRowDirection, ownerWidth):unwrap()
    node:setLayoutMargin(marginRowTrailing, endEdge)

    local marginColumnLeading: number = node:getLeadingMargin(flexColumnDirection, ownerWidth):unwrap()
    node:setLayoutMargin(marginColumnLeading, YGEdge.Top)

    local marginColumnTrailing: number = node:getTrailingMargin(flexColumnDirection, ownerWidth):unwrap()
    node:setLayoutMargin(marginColumnTrailing, YGEdge.Bottom)

    local marginAxisRow: number = marginRowLeading + marginRowTrailing
    local marginAxisColumn: number = marginColumnLeading + marginColumnTrailing

    node:setLayoutBorder(node:getLeadingBorder(flexRowDirection), startEdge)
    node:setLayoutBorder(node:getTrailingBorder(flexRowDirection), endEdge)
    node:setLayoutBorder(node:getLeadingBorder(flexColumnDirection), YGEdge.Top)
    node:setLayoutBorder(node:getTrailingBorder(flexColumnDirection), YGEdge.Bottom)
    node:setLayoutPadding(node:getLeadingPadding(flexRowDirection, ownerWidth):unwrap(), startEdge)
    node:setLayoutPadding(node:getTrailingPadding(flexRowDirection, ownerWidth):unwrap(), endEdge)
    node:setLayoutPadding(node:getLeadingPadding(flexColumnDirection, ownerWidth):unwrap(), YGEdge.Top)
    node:setLayoutPadding(node:getTrailingPadding(flexColumnDirection, ownerWidth):unwrap(), YGEdge.Bottom)

    if node:hasMeasureFunc() then
        YGNodeWithMeasureFuncSetMeasuredDimensions(
            node,
            availableWidth,
            availableHeight,
            widthMeasureMode,
            heightMeasureMode,
            ownerWidth,
            ownerHeight,
            layoutMarkerData,
            layoutContext,
            reason
        )
        return
    end

    local childCount: number = YGNodeGetChildCount(node)
    if childCount == 0 then
        YGNodeEmptyContainerSetMeasuredDimensions(
            node,
            -- deviation: can't perform arithmetic operation on nil
            safeSub(availableWidth, marginAxisRow),
            safeSub(availableHeight, marginAxisColumn),
            widthMeasureMode,
            heightMeasureMode,
            ownerWidth,
            ownerHeight
        )
        return
    end

    if
        not performLayout
        and YGNodeFixedSizeSetMeasuredDimensions(
            node,
            -- deviation: can't perform arithmetic operation on nil
            safeSub(availableWidth, marginAxisRow),
            safeSub(availableHeight, marginAxisColumn),
            widthMeasureMode,
            heightMeasureMode,
            ownerWidth,
            ownerHeight
        )
    then
        return
    end

    node:cloneChildrenIfNeeded(layoutContext)
    node:setLayoutHadOverflow(false)

    local mainAxis: YGFlexDirection = YGResolveFlexDirection(node:getStyle().flexDirection, direction)
    local crossAxis: YGFlexDirection = YGFlexDirectionCross(mainAxis, direction)
    local isMainAxisRow: boolean = YGFlexDirectionIsRow(mainAxis)
    local isNodeFlexWrap: boolean = node:getStyle().flexWrap ~= YGWrap.NoWrap
    local mainAxisownerSize: number = if isMainAxisRow then ownerWidth else ownerHeight
    local crossAxisownerSize: number = if isMainAxisRow then ownerHeight else ownerWidth
    local paddingAndBorderAxisMain: number = YGNodePaddingAndBorderForAxis(node, mainAxis, ownerWidth)
    local leadingPaddingAndBorderCross: number = node:getLeadingPaddingAndBorder(crossAxis, ownerWidth):unwrap()
    local trailingPaddingAndBorderCross: number = node:getTrailingPaddingAndBorder(crossAxis, ownerWidth):unwrap()
    local paddingAndBorderAxisCross: number = leadingPaddingAndBorderCross + trailingPaddingAndBorderCross
    local measureModeMainDim: YGMeasureMode = if isMainAxisRow then widthMeasureMode else heightMeasureMode
    local measureModeCrossDim: YGMeasureMode = if isMainAxisRow then heightMeasureMode else widthMeasureMode
	-- stylua: ignore
	local paddingAndBorderAxisRow: number =
		if (isMainAxisRow) then paddingAndBorderAxisMain else paddingAndBorderAxisCross
	-- stylua: ignore
	local paddingAndBorderAxisColumn: number =
		if (isMainAxisRow) then paddingAndBorderAxisCross else paddingAndBorderAxisMain

    local availableInnerWidth: number = YGNodeCalculateAvailableInnerDim(
        node,
        YGDimension.Width,
        -- deviation: can't perform arithmetic operation on nil
        safeSub(availableWidth, marginAxisRow),
        paddingAndBorderAxisRow,
        ownerWidth
    )
    local availableInnerHeight: number = YGNodeCalculateAvailableInnerDim(
        node,
        YGDimension.Height,
        -- deviation: can't perform arithmetic operation on nil
        safeSub(availableHeight, marginAxisColumn),
        paddingAndBorderAxisColumn,
        ownerHeight
    )
    local availableInnerMainDim: number = if isMainAxisRow then availableInnerWidth else availableInnerHeight
    local availableInnerCrossDim: number = if isMainAxisRow then availableInnerHeight else availableInnerWidth
    local totalOuterFlexBasis: number = YGNodeComputeFlexBasisForChildren(
        node,
        availableInnerWidth,
        availableInnerHeight,
        widthMeasureMode,
        heightMeasureMode,
        direction,
        mainAxis,
        config,
        performLayout,
        layoutMarkerData,
        layoutContext,
        depth,
        generationCount
    )
    local flexBasisOverflows: boolean = if measureModeMainDim == YGMeasureMode.Undefined
        then false
        else totalOuterFlexBasis > availableInnerMainDim

    if isNodeFlexWrap and flexBasisOverflows and measureModeMainDim == YGMeasureMode.AtMost then
        measureModeMainDim = YGMeasureMode.Exactly
    end

    local startOfLineIndex = 1
    local endOfLineIndex = 1
    local lineCount = 0
    local totalLineCrossDim = 0
    local maxLineMainDim = 0
    local collectedFlexItemsValues: YGCollectFlexItemsRowValues
    while endOfLineIndex <= childCount do
        collectedFlexItemsValues = YGCalculateCollectFlexItemsRowValues(
            node,
            ownerDirection,
            mainAxisownerSize,
            availableInnerWidth,
            availableInnerMainDim,
            startOfLineIndex,
            lineCount
        )
        endOfLineIndex = collectedFlexItemsValues.endOfLineIndex
        local canSkipFlex: boolean = not performLayout and measureModeCrossDim == YGMeasureMode.Exactly
        local sizeBasedOnContent = false

        if measureModeMainDim ~= YGMeasureMode.Exactly then
            local minDimensions = node:getStyle().minDimensions
            local maxDimensions = node:getStyle().maxDimensions
            local minInnerWidth: number = YGResolveValue(minDimensions[YGDimension.Width], ownerWidth):unwrap()
                - paddingAndBorderAxisRow
            local maxInnerWidth: number = YGResolveValue(maxDimensions[YGDimension.Width], ownerWidth):unwrap()
                - paddingAndBorderAxisRow
            local minInnerHeight: number = YGResolveValue(minDimensions[YGDimension.Height], ownerHeight):unwrap()
                - paddingAndBorderAxisColumn
            local maxInnerHeight: number = YGResolveValue(maxDimensions[YGDimension.Height], ownerHeight):unwrap()
                - paddingAndBorderAxisColumn
            local minInnerMainDim: number = if isMainAxisRow then minInnerWidth else minInnerHeight
            local maxInnerMainDim: number = if isMainAxisRow then maxInnerWidth else maxInnerHeight

            if
                not YGFloatIsUndefined(minInnerMainDim)
                and collectedFlexItemsValues.sizeConsumedOnCurrentLine < minInnerMainDim
            then
                availableInnerMainDim = minInnerMainDim
            elseif
                not (YGFloatIsUndefined(maxInnerMainDim))
                and collectedFlexItemsValues.sizeConsumedOnCurrentLine > maxInnerMainDim
            then
                availableInnerMainDim = maxInnerMainDim
            else
                if
                    not node:getConfig().useLegacyStretchBehaviour
                    and (
                        YGFloatIsUndefined(collectedFlexItemsValues.totalFlexGrowFactors)
                            and collectedFlexItemsValues.totalFlexGrowFactors == 0
                        or YGFloatIsUndefined(node:resolveFlexGrow()) and node:resolveFlexGrow() == 0
                    )
                then
                    availableInnerMainDim = collectedFlexItemsValues.sizeConsumedOnCurrentLine
                end

                if node:getConfig().useLegacyStretchBehaviour then
                    node:setLayoutDidUseLegacyFlag(true)
                end

                sizeBasedOnContent = not node:getConfig().useLegacyStretchBehaviour
            end
        end

        if not sizeBasedOnContent and not YGFloatIsUndefined(availableInnerMainDim) then
            collectedFlexItemsValues.remainingFreeSpace = availableInnerMainDim
                - collectedFlexItemsValues.sizeConsumedOnCurrentLine
        elseif collectedFlexItemsValues.sizeConsumedOnCurrentLine < 0 then
            collectedFlexItemsValues.remainingFreeSpace = -collectedFlexItemsValues.sizeConsumedOnCurrentLine
        end

        if not canSkipFlex then
            YGResolveFlexibleLength(
                node,
                collectedFlexItemsValues,
                mainAxis,
                crossAxis,
                mainAxisownerSize,
                availableInnerMainDim,
                availableInnerCrossDim,
                availableInnerWidth,
                availableInnerHeight,
                flexBasisOverflows,
                measureModeCrossDim,
                performLayout,
                config,
                layoutMarkerData,
                layoutContext,
                depth,
                generationCount
            )
        end

        node:setLayoutHadOverflow(
            node:getLayout().hadOverflow and node:getLayout().hadOverflow
                or collectedFlexItemsValues.remainingFreeSpace < 0
        )
        YGJustifyMainAxis(
            node,
            collectedFlexItemsValues,
            startOfLineIndex,
            mainAxis,
            crossAxis,
            measureModeMainDim,
            measureModeCrossDim,
            mainAxisownerSize,
            ownerWidth,
            availableInnerMainDim,
            availableInnerCrossDim,
            availableInnerWidth,
            performLayout,
            layoutContext
        )

        local containerCrossAxis: number = availableInnerCrossDim

        if measureModeCrossDim == YGMeasureMode.Undefined or measureModeCrossDim == YGMeasureMode.AtMost then
            containerCrossAxis = YGNodeBoundAxis(
                node,
                crossAxis,
                collectedFlexItemsValues.crossDim + paddingAndBorderAxisCross,
                crossAxisownerSize,
                ownerWidth
            ) - paddingAndBorderAxisCross
        end

        if not isNodeFlexWrap and measureModeCrossDim == YGMeasureMode.Exactly then
            collectedFlexItemsValues.crossDim = availableInnerCrossDim
        end

        collectedFlexItemsValues.crossDim = YGNodeBoundAxis(
            node,
            crossAxis,
            collectedFlexItemsValues.crossDim + paddingAndBorderAxisCross,
            crossAxisownerSize,
            ownerWidth
        ) - paddingAndBorderAxisCross

        if performLayout then
            local i: number = startOfLineIndex
            while i < endOfLineIndex do
                local child: YGNode = node:getChild(i)
                if child:getStyle().display == YGDisplay.None then
                    i += 1
                    continue
                end

                if child:getStyle().positionType == YGPositionType.Absolute then
                    local isChildLeadingPosDefined: boolean = child:isLeadingPositionDefined(crossAxis)
                    if isChildLeadingPosDefined then
                        child:setLayoutPosition(
                            child:getLeadingPosition(crossAxis, availableInnerCrossDim):unwrap()
                                + node:getLeadingBorder(crossAxis)
                                + child:getLeadingMargin(crossAxis, availableInnerWidth):unwrap(),
                            pos[crossAxis]
                        )
                    end
                    if
                        not isChildLeadingPosDefined
                        or YGFloatIsUndefined(child:getLayout().position[pos[crossAxis]])
                    then
                        child:setLayoutPosition(
                            node:getLeadingBorder(crossAxis)
                                + child:getLeadingMargin(crossAxis, availableInnerWidth):unwrap(),
                            pos[crossAxis]
                        )
                    end
                else
                    local leadingCrossDim: number = leadingPaddingAndBorderCross
                    local alignItem: YGAlign = YGNodeAlignItem(node, child)
                    if
                        alignItem == YGAlign.Stretch
                        and child:marginLeadingValue(crossAxis).unit ~= YGUnit.Auto
                        and child:marginTrailingValue(crossAxis).unit ~= YGUnit.Auto
                    then
                        if not YGNodeIsStyleDimDefined(child, crossAxis, availableInnerCrossDim) then
                            local childMainSize: number = child:getLayout().measuredDimensions[dim[mainAxis]]
                            local childStyle = child:getStyle()
                            local childCrossSize: number = if not childStyle.aspectRatio:isUndefined()
                                then child:getMarginForAxis(crossAxis, availableInnerWidth):unwrap() + (if isMainAxisRow
                                    then childMainSize / childStyle.aspectRatio:unwrap()
                                    else childMainSize * childStyle.aspectRatio:unwrap())
                                else collectedFlexItemsValues.crossDim

                            childMainSize += child:getMarginForAxis(mainAxis, availableInnerWidth):unwrap()

                            local childMainMeasureMode: YGMeasureMode = YGMeasureMode.Exactly
                            local childCrossMeasureMode: YGMeasureMode = YGMeasureMode.Exactly
                            local childMainMeasureModeRef = { value = childMainMeasureMode }
                            local childMainSizeRef = { value = childMainSize }
                            local childCrossMeasureModeRef = { value = childCrossMeasureMode }
                            local childCrossSizeRef = { value = childCrossSize }

                            YGConstrainMaxSizeForMode(
                                child,
                                mainAxis,
                                availableInnerMainDim,
                                availableInnerWidth,
                                childMainMeasureModeRef,
                                childMainSizeRef
                            )
                            YGConstrainMaxSizeForMode(
                                child,
                                crossAxis,
                                availableInnerCrossDim,
                                availableInnerWidth,
                                childCrossMeasureModeRef,
                                childCrossSizeRef
                            )

                            local childWidth: number = if isMainAxisRow then childMainSize else childCrossSize
                            local childHeight: number = if not isMainAxisRow then childMainSize else childCrossSize
                            local alignContent = node:getStyle().alignContent
                            local crossAxisDoesNotGrow = alignContent ~= YGAlign.Stretch and isNodeFlexWrap
							-- stylua: ignore
							local childWidthMeasureMode: YGMeasureMode =
								if YGFloatIsUndefined(childWidth) or not Boolean.toJSBoolean(isMainAxisRow) and crossAxisDoesNotGrow
									then YGMeasureMode.Undefined
									else YGMeasureMode.Exactly
							-- stylua: ignore
							local childHeightMeasureMode: YGMeasureMode =
								if YGFloatIsUndefined(childHeight) or isMainAxisRow and crossAxisDoesNotGrow
									then YGMeasureMode.Undefined
									else YGMeasureMode.Exactly

                            YGLayoutNodeInternal(
                                child,
                                childWidth,
                                childHeight,
                                direction,
                                childWidthMeasureMode,
                                childHeightMeasureMode,
                                availableInnerWidth,
                                availableInnerHeight,
                                true,
                                LayoutPassReason.kStretch,
                                config,
                                layoutMarkerData,
                                layoutContext,
                                depth,
                                generationCount
                            )
                        end
                    else
                        local remainingCrossDim: number = containerCrossAxis
                            - YGNodeDimWithMargin(child, crossAxis, availableInnerWidth)
                        if
                            child:marginLeadingValue(crossAxis).unit == YGUnit.Auto
                            and child:marginTrailingValue(crossAxis).unit == YGUnit.Auto
                        then
                            leadingCrossDim += YGFloatMax(0.0, remainingCrossDim / 2)
                        -- selene: allow(empty_if)
                        elseif child:marginTrailingValue(crossAxis).unit == YGUnit.Auto then
                            -- No-Op
                        elseif child:marginLeadingValue(crossAxis).unit == YGUnit.Auto then
                            leadingCrossDim += YGFloatMax(0.0, remainingCrossDim)
                        -- selene: allow(empty_if)
                        elseif alignItem == YGAlign.FlexStart then
                            -- No-Op
                        elseif alignItem == YGAlign.Center then
                            leadingCrossDim += remainingCrossDim / 2
                        else
                            leadingCrossDim += remainingCrossDim
                        end
                    end
                    child:setLayoutPosition(
                        child:getLayout().position[pos[crossAxis]] + totalLineCrossDim + leadingCrossDim,
                        pos[crossAxis]
                    )
                end
                i += 1
            end
        end
        totalLineCrossDim += collectedFlexItemsValues.crossDim
        maxLineMainDim = YGFloatMax(maxLineMainDim, collectedFlexItemsValues.mainDim)
        lineCount += 1
        startOfLineIndex = endOfLineIndex
    end

    if performLayout and (isNodeFlexWrap or YGIsBaselineLayout(node)) then
        local crossDimLead = 0
        local currentLead: number = leadingPaddingAndBorderCross

        if not YGFloatIsUndefined(availableInnerCrossDim) then
            local remainingAlignContentDim: number = availableInnerCrossDim - totalLineCrossDim

            if node:getStyle().alignContent == YGAlign.FlexEnd then
                currentLead += remainingAlignContentDim
            elseif node:getStyle().alignContent == YGAlign.Center then
                currentLead += remainingAlignContentDim / 2
            elseif node:getStyle().alignContent == YGAlign.Stretch then
                if availableInnerCrossDim > totalLineCrossDim then
                    crossDimLead = remainingAlignContentDim / lineCount
                end
            elseif node:getStyle().alignContent == YGAlign.SpaceAround then
                if availableInnerCrossDim > totalLineCrossDim then
                    currentLead += remainingAlignContentDim / (2 * lineCount)
                    if lineCount > 1 then
                        crossDimLead = remainingAlignContentDim / lineCount
                    end
                else
                    currentLead += remainingAlignContentDim / 2
                end
            elseif node:getStyle().alignContent == YGAlign.SpaceBetween then
                if availableInnerCrossDim > totalLineCrossDim and lineCount > 1 then
                    crossDimLead = remainingAlignContentDim / (lineCount - 1)
                end
            end
        end

        local endIndex = 1
        local i = 1
        while i <= lineCount do
            local startIndex: number = endIndex
            local ii: number
            local lineHeight = 0
            local maxAscentForCurrentLine = 0
            local maxDescentForCurrentLine = 0

            ii = startIndex
            while ii <= childCount do
                local child: YGNode = node:getChild(ii)
                if child:getStyle().display == YGDisplay.None then
                    ii += 1
                    continue
                end

                if child:getStyle().positionType ~= YGPositionType.Absolute then
                    if child:getLineIndex() ~= i then
                        break
                    end

                    if YGNodeIsLayoutDimDefined(child, crossAxis) then
                        lineHeight = YGFloatMax(
                            lineHeight,
                            child:getLayout().measuredDimensions[dim[crossAxis]]
                                + child:getMarginForAxis(crossAxis, availableInnerWidth):unwrap()
                        )
                    end

                    if YGNodeAlignItem(node, child) == YGAlign.Baseline then
                        local ascent: number = YGBaseline(child, layoutContext)
                            + child:getLeadingMargin(YGFlexDirection.Column, availableInnerWidth):unwrap()
                        local descent: number = child:getLayout().measuredDimensions[YGDimension.Height]
                            + child:getMarginForAxis(YGFlexDirection.Column, availableInnerWidth):unwrap()
                            - ascent
                        maxAscentForCurrentLine = YGFloatMax(maxAscentForCurrentLine, ascent)
                        maxDescentForCurrentLine = YGFloatMax(maxDescentForCurrentLine, descent)
                        lineHeight = YGFloatMax(lineHeight, maxAscentForCurrentLine + maxDescentForCurrentLine)
                    end
                end

                ii += 1
            end

            endIndex = ii
            lineHeight += crossDimLead

            if performLayout then
                ii = startIndex
                while ii < endIndex do
                    local child: YGNode = node:getChild(ii)
                    if child:getStyle().display == YGDisplay.None then
                        ii += 1
                        continue
                    end

                    if child:getStyle().positionType ~= YGPositionType.Absolute then
                        local condition = YGNodeAlignItem(node, child)
                        if condition == YGAlign.FlexStart then
                            child:setLayoutPosition(
                                currentLead + child:getLeadingMargin(crossAxis, availableInnerWidth):unwrap(),
                                pos[crossAxis]
                            )
                        elseif condition == YGAlign.FlexEnd then
                            child:setLayoutPosition(
                                currentLead
                                    + lineHeight
                                    - child:getTrailingMargin(crossAxis, availableInnerWidth):unwrap()
                                    - child:getLayout().measuredDimensions[dim[crossAxis]],
                                pos[crossAxis]
                            )
                        elseif condition == YGAlign.Center then
                            local childHeight: number = child:getLayout().measuredDimensions[dim[crossAxis]]

                            child:setLayoutPosition(currentLead + (lineHeight - childHeight) / 2, pos[crossAxis])
                        elseif condition == YGAlign.Stretch then
                            child:setLayoutPosition(
                                currentLead + child:getLeadingMargin(crossAxis, availableInnerWidth):unwrap(),
                                pos[crossAxis]
                            )

                            -- Remeasure child with the line height as it as
                            -- been only measured with the owners height yet.
                            if not YGNodeIsStyleDimDefined(child, crossAxis, availableInnerCrossDim) then
                                local childWidth: number = if isMainAxisRow
                                    then child:getLayout().measuredDimensions[YGDimension.Width] + child
                                        :getMarginForAxis(mainAxis, availableInnerWidth)
                                        :unwrap()
                                    else lineHeight

                                local childHeight: number = if not isMainAxisRow
                                    then child:getLayout().measuredDimensions[YGDimension.Height] + child
                                        :getMarginForAxis(crossAxis, availableInnerWidth)
                                        :unwrap()
                                    else lineHeight

                                if
                                    not (
                                        YGFloatsEqual(
                                            childWidth,
                                            child:getLayout().measuredDimensions[YGDimension.Width]
                                        )
                                        and YGFloatsEqual(
                                            childHeight,
                                            child:getLayout().measuredDimensions[YGDimension.Height]
                                        )
                                    )
                                then
                                    YGLayoutNodeInternal(
                                        child,
                                        childWidth,
                                        childHeight,
                                        direction,
                                        YGMeasureMode.Exactly,
                                        YGMeasureMode.Exactly,
                                        availableInnerWidth,
                                        availableInnerHeight,
                                        true,
                                        LayoutPassReason.kMultilineStretch,
                                        config,
                                        layoutMarkerData,
                                        layoutContext,
                                        depth,
                                        generationCount
                                    )
                                end
                            end
                        elseif condition == YGAlign.Baseline then
                            child:setLayoutPosition(
                                currentLead
                                    + maxAscentForCurrentLine
                                    - YGBaseline(child, layoutContext)
                                    + child:getLeadingPosition(YGFlexDirection.Column, availableInnerCrossDim):unwrap(),
                                YGEdge.Top
                            )
                        end
                    end

                    ii += 1
                end
            end

            currentLead += lineHeight
            i += 1
        end
    end

    node:setLayoutMeasuredDimension(
        YGNodeBoundAxis(node, YGFlexDirection.Row, safeSub(availableWidth, marginAxisRow), ownerWidth, ownerWidth),
        YGDimension.Width
    )
    node:setLayoutMeasuredDimension(
        YGNodeBoundAxis(
            node,
            YGFlexDirection.Column,
            safeSub(availableHeight, marginAxisColumn),
            ownerHeight,
            ownerWidth
        ),
        YGDimension.Height
    )

    if
        measureModeMainDim == YGMeasureMode.Undefined
        or node:getStyle().overflow ~= YGOverflow.Scroll and measureModeMainDim == YGMeasureMode.AtMost
    then
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(node, mainAxis, maxLineMainDim, mainAxisownerSize, ownerWidth),
            dim[mainAxis]
        )
    elseif measureModeMainDim == YGMeasureMode.AtMost and node:getStyle().overflow == YGOverflow.Scroll then
        node:setLayoutMeasuredDimension(
            YGFloatMax(
                YGFloatMin(
                    availableInnerMainDim + paddingAndBorderAxisMain,
                    YGNodeBoundAxisWithinMinAndMax(
                        node,
                        mainAxis,
                        YGFloatOptional.new(maxLineMainDim),
                        mainAxisownerSize
                    ):unwrap()
                ),
                paddingAndBorderAxisMain
            ),
            dim[mainAxis]
        )
    end

    if
        measureModeCrossDim == YGMeasureMode.Undefined
        or node:getStyle().overflow ~= YGOverflow.Scroll and measureModeCrossDim == YGMeasureMode.AtMost
    then
        node:setLayoutMeasuredDimension(
            YGNodeBoundAxis(
                node,
                crossAxis,
                totalLineCrossDim + paddingAndBorderAxisCross,
                crossAxisownerSize,
                ownerWidth
            ),
            dim[crossAxis]
        )
    elseif measureModeCrossDim == YGMeasureMode.AtMost and node:getStyle().overflow == YGOverflow.Scroll then
        node:setLayoutMeasuredDimension(
            YGFloatMax(
                YGFloatMin(
                    availableInnerCrossDim + paddingAndBorderAxisCross,
                    YGNodeBoundAxisWithinMinAndMax(
                        node,
                        crossAxis,
                        YGFloatOptional.new(totalLineCrossDim + paddingAndBorderAxisCross),
                        crossAxisownerSize
                    ):unwrap()
                ),
                paddingAndBorderAxisCross
            ),
            dim[crossAxis]
        )
    end

    if performLayout and node:getStyle().flexWrap == YGWrap.WrapReverse then
        local i = 1
        while i <= childCount do
            local child: YGNode = YGNodeGetChild(node, i) :: YGNode
            if child:getStyle().positionType ~= YGPositionType.Absolute then
                child:setLayoutPosition(
                    node:getLayout().measuredDimensions[dim[crossAxis]]
                        - child:getLayout().position[pos[crossAxis]]
                        - child:getLayout().measuredDimensions[dim[crossAxis]],
                    pos[crossAxis]
                )
            end
            i += 1
        end
    end

    if performLayout then
        local children: Array<YGNode> = node:getChildren()
        do
            local i = 1
            while i <= #children do
                local child: YGNode = children[i]
                if
                    child:getStyle().display == YGDisplay.None
                    or child:getStyle().positionType ~= YGPositionType.Absolute
                then
                    i += 1
                    continue
                end

				-- stylua: ignore
				YGNodeAbsoluteLayoutChild(
					node,
					child,
					availableInnerWidth,
					if Boolean.toJSBoolean(isMainAxisRow) then measureModeMainDim else measureModeCrossDim,
					availableInnerHeight,
					direction,
					config,
					layoutMarkerData,
					layoutContext,
					depth,
					generationCount
				)

                i += 1
            end
        end

        local needsMainTrailingPos: boolean = mainAxis == YGFlexDirection.RowReverse
            or mainAxis == YGFlexDirection.ColumnReverse
        local needsCrossTrailingPos: boolean = crossAxis == YGFlexDirection.RowReverse
            or crossAxis == YGFlexDirection.ColumnReverse
        if needsMainTrailingPos or needsCrossTrailingPos then
            do
                local i = 1
                while i <= childCount do
                    local child: YGNode = node:getChild(i)
                    if child:getStyle().display == YGDisplay.None then
                        i += 1
                        continue
                    end

                    if needsMainTrailingPos then
                        YGNodeSetChildTrailingPosition(node, child, mainAxis)
                    end

                    if needsCrossTrailingPos then
                        YGNodeSetChildTrailingPosition(node, child, crossAxis)
                    end

                    i += 1
                end
            end
        end
    end
end
exports.YGNodelayoutImpl = YGNodelayoutImpl

local gPrintChanges = false
local gPrintSkips = false
local spacer = "                                                            "

local function YGSpacer(level: number): string
    local spacerLen: number = #spacer
    if level > spacerLen then
        return spacer
    else
        return String.substr(spacer, spacerLen - level)
    end
end
exports.YGSpacer = YGSpacer

local function YGMeasureModeName(mode: YGMeasureMode, performLayout: boolean): string
    local kMeasureModeNames: Array<string> = { "UNDEFINED", "EXACTLY", "AT_MOST" }
    local kLayoutModeNames: Array<string> = { "LAY_UNDEFINED", "LAY_EXACTLY", "LAY_AT_", "MOST" }

    if mode >= YGMeasureModeCount then
        return ""
    end

    return if Boolean.toJSBoolean(performLayout) then kLayoutModeNames[mode] else kMeasureModeNames[mode]
end
exports.YGMeasureModeName = YGMeasureModeName

local function YGMeasureModeSizeIsExactAndMatchesOldMeasuredSize(
    sizeMode: YGMeasureMode,
    size: number,
    lastComputedSize: number
): boolean
    return sizeMode == YGMeasureMode.Exactly and YGFloatsEqual(size, lastComputedSize)
end
exports.YGMeasureModeSizeIsExactAndMatchesOldMeasuredSize = YGMeasureModeSizeIsExactAndMatchesOldMeasuredSize

local function YGMeasureModeOldSizeIsUnspecifiedAndStillFits(
    sizeMode: YGMeasureMode,
    size: number,
    lastSizeMode: YGMeasureMode,
    lastComputedSize: number
): boolean
    return sizeMode == YGMeasureMode.AtMost
        and lastSizeMode == YGMeasureMode.Undefined
        and (size >= lastComputedSize or YGFloatsEqual(size, lastComputedSize))
end
exports.YGMeasureModeOldSizeIsUnspecifiedAndStillFits = YGMeasureModeOldSizeIsUnspecifiedAndStillFits

local function YGMeasureModeNewMeasureSizeIsStricterAndStillValid(
    sizeMode: YGMeasureMode,
    size: number,
    lastSizeMode: YGMeasureMode,
    lastSize: number,
    lastComputedSize: number
): boolean
    return lastSizeMode == YGMeasureMode.AtMost
        and sizeMode == YGMeasureMode.AtMost
        and not YGFloatIsUndefined(lastSize)
        and not YGFloatIsUndefined(size)
        and not YGFloatIsUndefined(lastComputedSize)
        and lastSize > size
        and (lastComputedSize <= size or YGFloatsEqual(size, lastComputedSize))
end
exports.YGMeasureModeNewMeasureSizeIsStricterAndStillValid = YGMeasureModeNewMeasureSizeIsStricterAndStillValid

local function YGRoundValueToPixelGrid(
    value: number,
    pointScaleFactor: number,
    forceCeil: boolean,
    forceFloor: boolean
): number
    local scaledValue: number = safeMul(value, pointScaleFactor)
    local fractial: number = scaledValue % 1.0
    if forceFloor or YGFloatsEqual(fractial, 0) then
        scaledValue = scaledValue - fractial
    elseif forceCeil or YGFloatsEqual(fractial, 1.0) then
        scaledValue = scaledValue - fractial + 1.0
    -- elseif forceCeil then
    --     scaledValue = scaledValue - fractial + 1.0
    -- elseif forceFloor then
    --     scaledValue = scaledValue - fractial
    else
        scaledValue = scaledValue
            - fractial
            + (not (YGFloatIsUndefined(fractial)) and (fractial > 0.5 or YGFloatsEqual(fractial, 0.5)) and 1.0 or 0.0)
    end

    return if YGFloatIsUndefined(scaledValue) or YGFloatIsUndefined(pointScaleFactor)
        then YGUndefined
        else scaledValue / pointScaleFactor
end
exports.YGRoundValueToPixelGrid = YGRoundValueToPixelGrid

local function YGNodeCanUseCachedMeasurement(
    widthMode: YGMeasureMode,
    width: number,
    heightMode: YGMeasureMode,
    height: number,
    lastWidthMode: YGMeasureMode,
    lastWidth: number,
    lastHeightMode: YGMeasureMode,
    lastHeight: number,
    lastComputedWidth: number,
    lastComputedHeight: number,
    marginRow: number,
    marginColumn: number,
    config: YGConfig
): boolean
    if
        not YGFloatIsUndefined(lastComputedHeight) and lastComputedHeight < 0
        or not YGFloatIsUndefined(lastComputedWidth) and lastComputedWidth < 0
    then
        return false
    end

    local useRoundedComparison: boolean = config ~= nil and config.pointScaleFactor ~= 0

    local effectiveWidth: number = if useRoundedComparison
        then YGRoundValueToPixelGrid(width, config.pointScaleFactor, false, false)
        else width
    local effectiveHeight: number = if useRoundedComparison
        then YGRoundValueToPixelGrid(height, config.pointScaleFactor, false, false)
        else height
    local effectiveLastWidth: number = if useRoundedComparison
        then YGRoundValueToPixelGrid(lastWidth, config.pointScaleFactor, false, false)
        else lastWidth
    local effectiveLastHeight: number = if useRoundedComparison
        then YGRoundValueToPixelGrid(lastHeight, config.pointScaleFactor, false, false)
        else lastHeight

    local hasSameWidthSpec: boolean = lastWidthMode == widthMode and YGFloatsEqual(effectiveLastWidth, effectiveWidth)
    local hasSameHeightSpec: boolean = lastHeightMode == heightMode
        and YGFloatsEqual(effectiveLastHeight, effectiveHeight)

    local widthIsCompatible: boolean = hasSameWidthSpec
        or YGMeasureModeSizeIsExactAndMatchesOldMeasuredSize(widthMode, width - marginRow, lastComputedWidth)
        or YGMeasureModeOldSizeIsUnspecifiedAndStillFits(widthMode, width - marginRow, lastWidthMode, lastComputedWidth)
        or YGMeasureModeNewMeasureSizeIsStricterAndStillValid(
            widthMode,
            width - marginRow,
            lastWidthMode,
            lastWidth,
            lastComputedWidth
        )

    local heightIsCompatible: boolean = hasSameHeightSpec
        or YGMeasureModeSizeIsExactAndMatchesOldMeasuredSize(heightMode, height - marginColumn, lastComputedHeight)
        or YGMeasureModeOldSizeIsUnspecifiedAndStillFits(
            heightMode,
            height - marginColumn,
            lastHeightMode,
            lastComputedHeight
        )
        or YGMeasureModeNewMeasureSizeIsStricterAndStillValid(
            heightMode,
            height - marginColumn,
            lastHeightMode,
            lastHeight,
            lastComputedHeight
        )

    return widthIsCompatible and heightIsCompatible
end
exports.YGNodeCanUseCachedMeasurement = YGNodeCanUseCachedMeasurement

-- deviation: local declaration hoisted
function YGLayoutNodeInternal(
    node: YGNode,
    availableWidth: number,
    availableHeight: number,
    ownerDirection: YGDirection,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    ownerWidth: number,
    ownerHeight: number,
    performLayout: boolean,
    reason: LayoutPassReason,
    config: YGConfig,
    layoutMarkerData: LayoutData,
    layoutContext: any,
    depth: number,
    generationCount: number
): boolean
    local layout: YGLayout = node:getLayout()

    depth += 1

    local needToVisitNode: boolean = (
        (node:isDirty() and layout.generationCount ~= generationCount)
        or layout.lastOwnerDirection ~= ownerDirection
    )

    if needToVisitNode then
        layout.nextCachedMeasurementsIndex = 1
        layout.cachedLayout.availableWidth = -1
        layout.cachedLayout.availableHeight = -1
        layout.cachedLayout.widthMeasureMode = YGMeasureMode.Undefined
        layout.cachedLayout.heightMeasureMode = YGMeasureMode.Undefined
        layout.cachedLayout.computedWidth = -1
        layout.cachedLayout.computedHeight = -1
    end

    local cachedResults: YGCachedMeasurement = nil

    if node:hasMeasureFunc() then
        local marginAxisRow: number = node:getMarginForAxis(YGFlexDirection.Row, ownerWidth):unwrap()
        local marginAxisColumn: number = node:getMarginForAxis(YGFlexDirection.Column, ownerWidth):unwrap()

        if
            YGNodeCanUseCachedMeasurement(
                widthMeasureMode,
                availableWidth,
                heightMeasureMode,
                availableHeight,
                layout.cachedLayout.widthMeasureMode,
                layout.cachedLayout.availableWidth,
                layout.cachedLayout.heightMeasureMode,
                layout.cachedLayout.availableHeight,
                layout.cachedLayout.computedWidth,
                layout.cachedLayout.computedHeight,
                marginAxisRow,
                marginAxisColumn,
                config
            )
        then
            cachedResults = layout.cachedLayout
        else
            local i = 1
            while i <= layout.nextCachedMeasurementsIndex do
                if
                    YGNodeCanUseCachedMeasurement(
                        widthMeasureMode,
                        availableWidth,
                        heightMeasureMode,
                        availableHeight,
                        layout.cachedMeasurements[i].widthMeasureMode,
                        layout.cachedMeasurements[i].availableWidth,
                        layout.cachedMeasurements[i].heightMeasureMode,
                        layout.cachedMeasurements[i].availableHeight,
                        layout.cachedMeasurements[i].computedWidth,
                        layout.cachedMeasurements[i].computedHeight,
                        marginAxisRow,
                        marginAxisColumn,
                        config
                    )
                then
                    cachedResults = layout.cachedMeasurements[i]
                    break
                end

                i += 1
            end
        end
    elseif performLayout then
        if
            YGFloatsEqual(layout.cachedLayout.availableWidth, availableWidth)
            and YGFloatsEqual(layout.cachedLayout.availableHeight, availableHeight)
            and layout.cachedLayout.widthMeasureMode == widthMeasureMode
            and layout.cachedLayout.heightMeasureMode == heightMeasureMode
        then
            cachedResults = layout.cachedLayout
        end
    else
        local i = 1
        while i <= layout.nextCachedMeasurementsIndex do
            if
                YGFloatsEqual(layout.cachedMeasurements[i].availableWidth, availableWidth)
                and YGFloatsEqual(layout.cachedMeasurements[i].availableHeight, availableHeight)
                and layout.cachedMeasurements[i].widthMeasureMode == widthMeasureMode
                and layout.cachedMeasurements[i].heightMeasureMode == heightMeasureMode
            then
                cachedResults = layout.cachedMeasurements[i]
                break
            end
            i += 1
        end
    end
    if not Boolean.toJSBoolean(needToVisitNode) and cachedResults ~= nil then
        layout.measuredDimensions[YGDimension.Width] = cachedResults.computedWidth
        layout.measuredDimensions[YGDimension.Height] = cachedResults.computedHeight

        if Boolean.toJSBoolean(performLayout) then
            layoutMarkerData.cachedLayouts += 1
        else
            layoutMarkerData.cachedMeasures += 1
        end

        if gPrintChanges and gPrintSkips then
            Log.log(node, YGLogLevel.Verbose, nil, "%s%d.{[skipped] ", YGSpacer(depth), depth)
            node:print(layoutContext)
            Log.log(
                node,
                YGLogLevel.Verbose,
                nil,
                "wm: %s, hm: %s, aw: %f ah: %f => d: (%f, %f) %s\n",
                YGMeasureModeName(widthMeasureMode, performLayout),
                YGMeasureModeName(heightMeasureMode, performLayout),
                availableWidth,
                availableHeight,
                cachedResults.computedWidth,
                cachedResults.computedHeight,
                reason
            )
        end
    else
        if gPrintChanges then
			-- stylua: ignore
			Log.log(
				node,
				YGLogLevel.Verbose,
				nil,
				"%s%d.{%s",
				YGSpacer(depth),
				depth,
				if needToVisitNode then "*" else ""
			)
            node:print(layoutContext)
            Log.log(
                node,
                YGLogLevel.Verbose,
                nil,
                "wm: %s, hm: %s, aw: %f ah: %f %s\n",
                YGMeasureModeName(widthMeasureMode, performLayout),
                YGMeasureModeName(heightMeasureMode, performLayout),
                availableWidth,
                availableHeight,
                reason
            )
        end

        YGNodelayoutImpl(
            node,
            availableWidth,
            availableHeight,
            ownerDirection,
            widthMeasureMode,
            heightMeasureMode,
            ownerWidth,
            ownerHeight,
            performLayout,
            config,
            layoutMarkerData,
            layoutContext,
            depth,
            generationCount,
            reason
        )

        if gPrintChanges then
			-- stylua: ignore
			Log.log(
				node,
				YGLogLevel.Verbose,
				nil,
				"%s%d.}%s",
				YGSpacer(depth),
				depth,
				if needToVisitNode then "*" else ""
			)
            node:print(layoutContext)
            Log.log(
                node,
                YGLogLevel.Verbose,
                nil,
                "wm: %s, hm: %s, d: (%f, %f) %s\n",
                YGMeasureModeName(widthMeasureMode, performLayout),
                YGMeasureModeName(heightMeasureMode, performLayout),
                layout.measuredDimensions[YGDimension.Width],
                layout.measuredDimensions[YGDimension.Height],
                reason
            )
        end
        layout.lastOwnerDirection = ownerDirection
        if cachedResults == nil then
            if layout.nextCachedMeasurementsIndex + 1 > layoutMarkerData.maxMeasureCache then
                layoutMarkerData.maxMeasureCache = layout.nextCachedMeasurementsIndex + 1
            end
            if layout.nextCachedMeasurementsIndex == YG_MAX_CACHED_RESULT_COUNT then
                if gPrintChanges then
                    Log.log(node, YGLogLevel.Verbose, nil, "Out of cache entries!\n")
                end
                layout.nextCachedMeasurementsIndex = 1
            end
            local newCacheEntry: YGCachedMeasurement
            if performLayout then
                newCacheEntry = layout.cachedLayout
            else
                newCacheEntry = layout.cachedMeasurements[layout.nextCachedMeasurementsIndex]
                layout.nextCachedMeasurementsIndex += 1
            end

            newCacheEntry.availableWidth = availableWidth
            newCacheEntry.availableHeight = availableHeight
            newCacheEntry.widthMeasureMode = widthMeasureMode
            newCacheEntry.heightMeasureMode = heightMeasureMode
            newCacheEntry.computedWidth = layout.measuredDimensions[YGDimension.Width]
            newCacheEntry.computedHeight = layout.measuredDimensions[YGDimension.Height]
        end
    end

    if performLayout then
        node:setLayoutDimension(node:getLayout().measuredDimensions[YGDimension.Width], YGDimension.Width)
        node:setLayoutDimension(node:getLayout().measuredDimensions[YGDimension.Height], YGDimension.Height)
        node:setHasNewLayout(true)
        node:setDirty(false)
    end

    layout.generationCount = generationCount

    local layoutType: LayoutType
    if performLayout then
        layoutType = if not needToVisitNode and cachedResults == layout.cachedLayout
            then LayoutType.kCachedLayout
            else LayoutType.kLayout
    else
        layoutType = if cachedResults ~= nil then LayoutType.kCachedMeasure else LayoutType.kMeasure
    end
    YGEvent.publish(node, EventType.NodeLayout, { layoutType = layoutType, layoutContext = layoutContext })

    return needToVisitNode or cachedResults == nil
end
exports.YGLayoutNodeInternal = YGLayoutNodeInternal

local function YGConfigSetPointScaleFactor(config: YGConfig, pixelsInPoint: number): ()
    YGAssertWithConfig(config, pixelsInPoint >= 0.0, "Scale factor should not be less than zero")

    if pixelsInPoint == 0.0 then
        config.pointScaleFactor = 0.0
    else
        config.pointScaleFactor = pixelsInPoint
    end
end
exports.YGConfigSetPointScaleFactor = YGConfigSetPointScaleFactor

local function fmodf(x: number, y: number)
    return x % y
end

local function YGRoundToPixelGrid(node: YGNode, pointScaleFactor: number, absoluteLeft: number, absoluteTop: number): ()
    if pointScaleFactor == 0.0 then
        return
    end

    local nodeLeft: number = node:getLayout().position[YGEdge.Left]
    local nodeTop: number = node:getLayout().position[YGEdge.Top]
    local nodeWidth: number = node:getLayout().dimensions[YGDimension.Width]
    local nodeHeight: number = node:getLayout().dimensions[YGDimension.Height]
    local absoluteNodeLeft: number = safeAdd(absoluteLeft, nodeLeft)
    local absoluteNodeTop: number = safeAdd(absoluteTop, nodeTop)
    local absoluteNodeRight: number = safeAdd(absoluteNodeLeft, nodeWidth)
    local absoluteNodeBottom: number = safeAdd(absoluteNodeTop, nodeHeight)
    local textRounding: boolean = node:getNodeType() == YGNodeType.Text

    node:setLayoutPosition(YGRoundValueToPixelGrid(nodeLeft, pointScaleFactor, false, textRounding), YGEdge.Left)
    node:setLayoutPosition(YGRoundValueToPixelGrid(nodeTop, pointScaleFactor, false, textRounding), YGEdge.Top)

    local hasFractionalWidth: boolean = not YGFloatsEqual(fmodf(safeMul(nodeWidth, pointScaleFactor), 1.0), 0)
        and not YGFloatsEqual(fmodf(nodeWidth * pointScaleFactor, 1.0), 1.0)
    local hasFractionalHeight: boolean = not YGFloatsEqual(fmodf(safeMul(nodeHeight, pointScaleFactor), 1.0), 0)
        and not YGFloatsEqual(fmodf(safeMul(nodeHeight, pointScaleFactor), 1.0), 1.0)

    node:setLayoutDimension(
        safeSub(
            YGRoundValueToPixelGrid(
                absoluteNodeRight,
                pointScaleFactor,
                textRounding and hasFractionalWidth,
                textRounding and not hasFractionalWidth
            ),
            YGRoundValueToPixelGrid(absoluteNodeLeft, pointScaleFactor, false, textRounding)
        ),
        YGDimension.Width
    )

    node:setLayoutDimension(
        safeSub(
            YGRoundValueToPixelGrid(
                absoluteNodeBottom,
                pointScaleFactor,
                textRounding and hasFractionalHeight,
                textRounding and not hasFractionalHeight
            ),
            YGRoundValueToPixelGrid(absoluteNodeTop, pointScaleFactor, false, textRounding)
        ),
        YGDimension.Height
    )

    local childCount: number = YGNodeGetChildCount(node)
    local i = 1
    while i <= childCount do
        YGRoundToPixelGrid(YGNodeGetChild(node, i) :: YGNode, pointScaleFactor, absoluteNodeLeft, absoluteNodeTop)
        i += 1
    end
end
exports.YGRoundToPixelGrid = YGRoundToPixelGrid

local function unsetUseLegacyFlagRecursively(node: YGNode): ()
    node:getConfig().useLegacyStretchBehaviour = false
    for _, child in ipairs(node:getChildren()) do
        unsetUseLegacyFlagRecursively(child)
    end
end

local function YGNodeCalculateLayoutWithContext(
    node: YGNode,
    ownerWidth: number,
    ownerHeight: number,
    ownerDirection: YGDirection,
    layoutContext: any
): ()
    YGEvent.publish(node, EventType.LayoutPassStart, { layoutContext = layoutContext })
    local markerData: LayoutData = LayoutData.new()
    gCurrentGenerationCount += 1
    node:resolveDimension()

    local width: number = YGUndefined
    local widthMeasureMode: YGMeasureMode = YGMeasureMode.Undefined
    local maxDimensions = node:getStyle().maxDimensions

    if YGNodeIsStyleDimDefined(node, YGFlexDirection.Row, ownerWidth) then
        width = YGResolveValue(node:getResolvedDimension(dim[YGFlexDirection.Row]), ownerWidth)
            :add(node:getMarginForAxis(YGFlexDirection.Row, ownerWidth))
            :unwrap()
        widthMeasureMode = YGMeasureMode.Exactly
    elseif not YGResolveValue(maxDimensions[YGDimension.Width], ownerWidth):isUndefined() then
        width = YGResolveValue(maxDimensions[YGDimension.Width], ownerWidth):unwrap()
        widthMeasureMode = YGMeasureMode.AtMost
    else
        width = ownerWidth
        widthMeasureMode = if YGFloatIsUndefined(width) then YGMeasureMode.Undefined else YGMeasureMode.Exactly
    end

    local height: number = YGUndefined
    local heightMeasureMode: YGMeasureMode = YGMeasureMode.Undefined

    if YGNodeIsStyleDimDefined(node, YGFlexDirection.Column, ownerHeight) then
        height = YGResolveValue(node:getResolvedDimension(dim[YGFlexDirection.Column]), ownerHeight)
            :add(node:getMarginForAxis(YGFlexDirection.Column, ownerWidth))
            :unwrap()
        heightMeasureMode = YGMeasureMode.Exactly
    elseif not YGResolveValue(maxDimensions[YGDimension.Height], ownerHeight):isUndefined() then
        height = YGResolveValue(maxDimensions[YGDimension.Height], ownerHeight):unwrap()
        heightMeasureMode = YGMeasureMode.AtMost
    else
        height = ownerHeight
        heightMeasureMode = if YGFloatIsUndefined(height) then YGMeasureMode.Undefined else YGMeasureMode.Exactly
    end

    if
        YGLayoutNodeInternal(
            node,
            width,
            height,
            ownerDirection,
            widthMeasureMode,
            heightMeasureMode,
            ownerWidth,
            ownerHeight,
            true,
            LayoutPassReason.kInitial,
            node:getConfig(),
            markerData,
            layoutContext,
            0,
            gCurrentGenerationCount
        )
    then
        node:setPosition(node:getLayout().direction, ownerWidth, ownerHeight, ownerWidth)
        YGRoundToPixelGrid(node, node:getConfig().pointScaleFactor, 0.0, 0.0)
    end

    YGEvent.publish(node, EventType.LayoutPassEnd, { layoutContext = layoutContext, layoutData = markerData })

    if node:getConfig().shouldDiffLayoutWithoutLegacyStretchBehaviour and node:didUseLegacyFlag() then
        local nodeWithoutLegacyFlag: YGNode = YGNodeDeepClone(node)
        nodeWithoutLegacyFlag:resolveDimension()
        nodeWithoutLegacyFlag:markDirtyAndPropogateDownwards()

        gCurrentGenerationCount += 1

        unsetUseLegacyFlagRecursively(nodeWithoutLegacyFlag)
        local layoutMarkerData: LayoutData = LayoutData.new()
        if

            YGLayoutNodeInternal(
                nodeWithoutLegacyFlag,
                width,
                height,
                ownerDirection,
                widthMeasureMode,
                heightMeasureMode,
                ownerWidth,
                ownerHeight,
                true,
                LayoutPassReason.kInitial,
                nodeWithoutLegacyFlag:getConfig(),
                layoutMarkerData,
                layoutContext,
                0,
                gCurrentGenerationCount
            )
        then
            nodeWithoutLegacyFlag:setPosition(
                nodeWithoutLegacyFlag:getLayout().direction,
                ownerWidth,
                ownerHeight,
                ownerWidth
            )
            YGRoundToPixelGrid(nodeWithoutLegacyFlag, nodeWithoutLegacyFlag:getConfig().pointScaleFactor, 0.0, 0.0)

            local neededLegacyStretchBehaviour = not nodeWithoutLegacyFlag:isLayoutTreeEqualToNode(node)
            node:setLayoutDoesLegacyFlagAffectsLayout(neededLegacyStretchBehaviour)
        end

        YGConfigFreeRecursive(nodeWithoutLegacyFlag)
        YGNodeFreeRecursive(nodeWithoutLegacyFlag)
    end
end
exports.YGNodeCalculateLayoutWithContext = YGNodeCalculateLayoutWithContext

local function YGNodeCalculateLayout(
    node: YGNode,
    ownerWidth: number,
    ownerHeight: number,
    ownerDirection: YGDirection
): ()
    YGNodeCalculateLayoutWithContext(node, ownerWidth, ownerHeight, ownerDirection, nil)
end
exports.YGNodeCalculateLayout = YGNodeCalculateLayout

local function YGConfigSetLogger(config: YGConfig, logger: YGLogger): ()
    if logger ~= nil then
        config.logger = logger
    else
        config.logger = YGDefaultLog
    end
end
exports.YGConfigSetLogger = YGConfigSetLogger

local function YGConfigSetShouldDiffLayoutWithoutLegacyStretchBehaviour(config: YGConfig, shouldDiffLayout: boolean): ()
    config.shouldDiffLayoutWithoutLegacyStretchBehaviour = shouldDiffLayout
end
exports.YGConfigSetShouldDiffLayoutWithoutLegacyStretchBehaviour =
    YGConfigSetShouldDiffLayoutWithoutLegacyStretchBehaviour

-- deviation: assertion functions have been moved to utils.lua to
-- eliminate circular dependencies and meet the 200 local quota.

local function YGConfigSetExperimentalFeatureEnabled(
    config: YGConfig,
    feature: YGExperimentalFeature,
    enabled: boolean
): ()
    config.experimentalFeatures[feature] = enabled
end
exports.YGConfigSetExperimentalFeatureEnabled = YGConfigSetExperimentalFeatureEnabled

-- deviation: local declaration hoisted
function YGConfigIsExperimentalFeatureEnabled(config: YGConfig, feature: YGExperimentalFeature): boolean
    return config.experimentalFeatures[feature]
end
exports.YGConfigIsExperimentalFeatureEnabled = YGConfigIsExperimentalFeatureEnabled

local function YGConfigSetUseWebDefaults(config: YGConfig, enabled: boolean): ()
    config.useWebDefaults = enabled
end
exports.YGConfigSetUseWebDefaults = YGConfigSetUseWebDefaults

local function YGConfigSetUseLegacyStretchBehaviour(config: YGConfig, useLegacyStretchBehaviour: boolean): ()
    config.useLegacyStretchBehaviour = useLegacyStretchBehaviour
end
exports.YGConfigSetUseLegacyStretchBehaviour = YGConfigSetUseLegacyStretchBehaviour

local function YGConfigGetUseWebDefaults(config: YGConfig): boolean
    return config.useWebDefaults
end
exports.YGConfigGetUseWebDefaults = YGConfigGetUseWebDefaults

local function YGConfigSetContext(config: YGConfig, context: any): ()
    config.context = context
end
exports.YGConfigSetContext = YGConfigSetContext

local function YGConfigGetContext(config: YGConfig): any
    return config.context
end
exports.YGConfigGetContext = YGConfigGetContext

local function YGConfigSetCloneNodeFunc(config: YGConfig, callback: YGCloneNodeFunc): ()
    config.cloneNodeCallback = callback
end
exports.YGConfigSetCloneNodeFunc = YGConfigSetCloneNodeFunc

local function YGTraverseChildrenPreOrder(children: Array<YGNode>, f: (node: YGNode) -> ()): ()
    local i = 1
    while i <= #children do
        local node: YGNode = children[i]
        f(node)
        YGTraverseChildrenPreOrder(node:getChildren(), f)
        i += 1
    end
end
exports.YGTraverseChildrenPreOrder = YGTraverseChildrenPreOrder

local function YGTraversePreOrder(node: YGNode, f: (node: YGNode) -> ()): ()
    if not Boolean.toJSBoolean(node) then
        return
    end
    f(node)
    YGTraverseChildrenPreOrder(node:getChildren(), f)
end
exports.YGTraversePreOrder = YGTraversePreOrder

return exports
