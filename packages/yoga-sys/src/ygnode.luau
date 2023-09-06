-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/ygnode.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGNode.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGNode.cpp

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

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local instanceof = LuauPolyfill.instanceof
local console = LuauPolyfill.console

local Types = require(PackageRoot.types)
type YGFloatOptional = Types.YGFloatOptional
type YGNode = Types.YGNode
type YGLayout = Types.YGLayout
type YGStyle = Types.YGStyle
type YGValue = Types.YGValue
type YGConfig = Types.YGConfig
type IterChildrenCallback = Types.IterChildrenCallback
type YGPrintFunc = Types.YGPrintFunc
type YGMeasureFunc = Types.YGMeasureFunc
type YGBaselineFunc = Types.YGBaselineFunc
type YGDirtiedFunc = Types.YGDirtiedFunc
type YGSize = Types.YGSize

local Enums = require(PackageRoot.enums)
local YGFlexDirection = Enums.YGFlexDirection
type YGFlexDirection = Enums.YGFlexDirection
local YGDirection = Enums.YGDirection
type YGDirection = Enums.YGDirection
local YGNodeType = Enums.YGNodeType
type YGNodeType = Enums.YGNodeType
local YGUnit = Enums.YGUnit
type YGUnit = Enums.YGUnit
local YGEdge = Enums.YGEdge
type YGEdge = Enums.YGEdge
local YGDimension = Enums.YGDimension
type YGDimension = Enums.YGDimension
local YGPositionType = Enums.YGPositionType
type YGPositionType = Enums.YGPositionType
local YGAlign = Enums.YGAlign
type YGAlign = Enums.YGAlign
type YGMeasureMode = Enums.YGMeasureMode

local YGFloatOptional = require(PackageRoot.ygfloatoptional)

local ygConfigModule_ = require(PackageRoot.ygconfig)
local YGConfig

local Utils = require(PackageRoot.utils)
local YGFlexDirectionIsRow = Utils.YGFlexDirectionIsRow
local YGResolveValue = Utils.YGResolveValue
local YGResolveValueMargin = Utils.YGResolveValueMargin
local YGFloatOptionalMax = Utils.YGFloatOptionalMax
local YGFloatMax = Utils.YGFloatMax
local YGFlexDirectionCross = Utils.YGFlexDirectionCross
local YGResolveFlexDirection = Utils.YGResolveFlexDirection
local YGValueEqual = Utils.YGValueEqual
local YGAssertWithNode: (node: YGNode, condition: boolean, message: string) -> ()

local YGLayout = require(PackageRoot.yglayout)
local YGStyle = require(PackageRoot.ygstyle)

local Internal = require(PackageRoot.internal)
local trailing = Internal.trailing
local leading = Internal.leading
local kDefaultFlexGrow = Internal.kDefaultFlexGrow
local kDefaultFlexShrink = Internal.kDefaultFlexShrink
local kWebDefaultFlexShrink = Internal.kWebDefaultFlexShrink

local ygvalueModule = require(PackageRoot.ygvalue)
local YGValueUndefined = ygvalueModule.YGValueUndefined
local YGValueZero = ygvalueModule.YGValueZero
local YGValueAuto = ygvalueModule.YGValueAuto

type Array<T> = { T }

local YGNode = {}
YGNode.__index = YGNode

-- deviation: having multiple constructor type signatures is not supported
function YGNode.new(
    contextOrNodeOrConfig_: (any | YGNode | YGConfig)?,
    print_: YGPrintFunc?,
    hasNewLayout: boolean?,
    isReferenceBaseline: boolean?,
    nodeType: YGNodeType?,
    measure: YGMeasureFunc?,
    baseline: YGBaselineFunc?,
    dirtied: YGDirtiedFunc?,
    style: YGStyle?,
    layout: YGLayout?,
    lineIndex: number?,
    owner: YGNode?,
    children: Array<YGNode>?,
    config: YGConfig?,
    isDirty: boolean?,
    resolvedDimensions: Array<YGValue | YGValue>?
): YGNode
    local self: YGNode = setmetatable({}, YGNode) :: any

    if hasNewLayout == nil then
        hasNewLayout = true
    end
    if isReferenceBaseline == nil then
        isReferenceBaseline = false
    end
    if nodeType == nil then
        nodeType = YGNodeType.Default
    end
    if style == nil then
        style = YGStyle.new()
    end
    if layout == nil then
        layout = YGLayout.new()
    end
    if lineIndex == nil then
        lineIndex = 1
    end
    if children == nil then
        children = {}
    end
    if isDirty == nil then
        isDirty = false
    end
    if resolvedDimensions == nil then
        resolvedDimensions = { YGValueUndefined(), YGValueUndefined() }
    end

    if instanceof(contextOrNodeOrConfig_, YGNode) then
        local contextOrNodeOrConfig = contextOrNodeOrConfig_ :: YGNode
        console.log("from node")
        self:fromNode(contextOrNodeOrConfig)
        return (self :: any) :: YGNode
    end

    self:initialize(
        print_,
        hasNewLayout,
        isReferenceBaseline,
        nodeType,
        measure,
        baseline,
        dirtied,
        style,
        layout,
        lineIndex,
        owner,
        children,
        config,
        isDirty,
        resolvedDimensions
    )

    if instanceof(contextOrNodeOrConfig_, YGConfig) then
        local contextOrNodeOrConfig = contextOrNodeOrConfig_ :: YGConfig
        self.config_ = contextOrNodeOrConfig
        self.context_ = nil
    else
        self.context_ = contextOrNodeOrConfig_
    end

    return self
end

function YGNode.initialize(
    self: YGNode,
    print_: YGPrintFunc?,
    hasNewLayout_: boolean?,
    isReferenceBaseline_: boolean?,
    nodeType_: YGNodeType?,
    measure_: YGMeasureFunc,
    baseline_: YGBaselineFunc,
    dirtied_: YGDirtiedFunc,
    style_: YGStyle?,
    layout_: YGLayout?,
    lineIndex_: number?,
    owner_: YGNode,
    children_: Array<YGNode>?,
    config_: YGConfig?,
    isDirty_: boolean?,
    resolvedDimensions_: Array<YGValue | YGValue>?
): ()
    local hasNewLayout = if hasNewLayout_ == nil then true else hasNewLayout_
    local isReferenceBaseline = if isReferenceBaseline_ == nil then true else isReferenceBaseline_
    local nodeType = if nodeType_ == nil then YGNodeType.Default else nodeType_
    local style = if style_ == nil then YGStyle.new() else style_
    local layout = if layout_ == nil then YGLayout.new() else layout_
    local lineIndex = if lineIndex_ == nil then 1 else lineIndex_
    local children = if children_ == nil then {} else children_
    local isDirty = if isDirty_ == nil then false else isDirty_
    local resolvedDimensions = if resolvedDimensions_ == nil then { YGValueUndefined(), YGValueUndefined() } else resolvedDimensions_

    self.print_ = print_
    self.hasNewLayout_ = hasNewLayout
    self.isReferenceBaseline_ = isReferenceBaseline
    self.nodeType_ = nodeType
    self.measure_ = measure_
    self.baseline_ = baseline_
    self.dirtied_ = dirtied_
    self.style_ = style
    self.layout_ = layout
    self.lineIndex_ = lineIndex
    self.owner_ = owner_
    self.children_ = children
    self.config_ = config_
    self.isDirty_ = isDirty
    self.resolvedDimensions_ = resolvedDimensions
    self.context_ = nil
end

function YGNode.relativePosition(self: YGNode, axis: YGFlexDirection, axisSize: number): YGFloatOptional
    if self:isLeadingPositionDefined(axis) then
        return self:getLeadingPosition(axis, axisSize)
    end

    local trailingPosition: YGFloatOptional = self:getTrailingPosition(axis, axisSize)
    if not trailingPosition:isUndefined() then
        trailingPosition:setValue(-1 * trailingPosition:getValue())
    end

    return trailingPosition
end

function YGNode.operatorAtrib(self: YGNode, node: YGNode): YGNode
    if node == self then
        return self
    end

    self:clearChildren()
    self:fromNode(node)

    return self
end

function YGNode.fromNode(self: YGNode, node: YGNode): ()
    self.context_ = node.context_
    self.print_ = node.print_
    self.hasNewLayout_ = node.hasNewLayout_
    self.isReferenceBaseline_ = node.isReferenceBaseline_
    self.nodeType_ = node.nodeType_
    self.measure_ = node.measure_
    self.baseline_ = node.baseline_
    self.dirtied_ = node.dirtied_

    self.style_ = node.style_
    -- this.style_ = node.style_.clone();

    self.layout_ = node.layout_
    -- this.layout_ = node.layout_.clone();

    self.lineIndex_ = node.lineIndex_
    self.owner_ = node.owner_
    self.children_ = node.children_
    -- let newChildren: Array<YGNode> = new Array(node.children_.length);
    -- for(let i = 0; i < node.children_.length; ++i) {
    --     newChildren[i] = node.children_[i]
    -- }
    -- this.children_ = newChildren;

    self.config_ = node.config_
    self.isDirty_ = node.isDirty_

    self.resolvedDimensions_ = node.resolvedDimensions_
    -- this.resolvedDimensions_ = [node.resolvedDimensions_[0].clone(), node.resolvedDimensions_[1].clone()];
end

function YGNode.print(self: YGNode, printContext: any?): ()
    local print_ = self.print_
    if print_ ~= nil then
        print_(self, printContext)
    end
end

function YGNode.computeEdgeValueForRow(
    self: YGNode,
    edges: Array<YGValue>,
    rowEdge: YGEdge,
    edge: YGEdge,
    defaultValue: YGValue
): YGValue
    if not edges[rowEdge]:isUndefined() then
        return edges[rowEdge]
    elseif not edges[edge]:isUndefined() then
        return edges[edge]
    elseif not edges[YGEdge.Horizontal]:isUndefined() then
        return edges[YGEdge.Horizontal]
    elseif not edges[YGEdge.All]:isUndefined() then
        return edges[YGEdge.All]
    else
        return defaultValue
    end
end

function YGNode.computeEdgeValueForColumn(self: YGNode, edges: Array<YGValue>, edge: YGEdge, defaultValue: YGValue): YGValue
    if not edges[edge]:isUndefined() then
        return edges[edge]
    elseif not edges[YGEdge.Vertical]:isUndefined() then
        return edges[YGEdge.Vertical]
    elseif not edges[YGEdge.All]:isUndefined() then
        return edges[YGEdge.All]
    else
        return defaultValue
    end
end

function YGNode.measure(
    self: YGNode,
    width: number,
    widthMode: YGMeasureMode,
    height: number,
    heightMode: YGMeasureMode,
    layoutContext: any?
): YGSize
    return self:measure_(width, widthMode, height, heightMode, layoutContext)
end

function YGNode.baseline(self: YGNode, width: number, height: number, layoutContext: any?): number
    return self:baseline_(width, height, layoutContext)
end

-- TODO: Move useWebDefaults to the node and not the config?
function YGNode.useWebDefaults(self: YGNode): ()
    assert(self.config_, "Cannot useWebDefaults without setting a config")
    self.config_.useWebDefaults = true
    self.style_.flexDirection = YGFlexDirection.Row
    self.style_.alignContent = YGAlign.Stretch
end

function YGNode.hasMeasureFunc(self: YGNode): boolean
    return self.measure_ ~= nil
end

function YGNode.hasBaselineFunc(self: YGNode): boolean
    return self.baseline_ ~= nil
end

function YGNode.getContext(self: YGNode): any
    return self.context_
end

function YGNode.getHasNewLayout(self: YGNode): boolean
    return self.hasNewLayout_
end

function YGNode.getNodeType(self: YGNode): YGNodeType
    return self.nodeType_
end

function YGNode.getDirtied(self: YGNode): YGDirtiedFunc
    return self.dirtied_
end

function YGNode.getStyle(self: YGNode): YGStyle
    return self.style_
end

function YGNode.getLayout(self: YGNode): YGLayout
    return self.layout_
end

function YGNode.getLineIndex(self: YGNode): number
    return self.lineIndex_
end

function YGNode.isReferenceBaseline(self: YGNode): boolean
    return self.isReferenceBaseline_
end

function YGNode.getOwner(self: YGNode): YGNode
    return self.owner_
end

function YGNode.getParent(self: YGNode): YGNode
    return self:getOwner()
end

function YGNode.getChildren(self: YGNode): Array<YGNode>
    return self.children_
end

function YGNode.getChildrenCount(self: YGNode): number
    return #self.children_
end

-- deviation: upstream Yoga and Typeflex expect 0 to be the index of the
-- first child when using this function, so add one as arrays start at 1 in Lua.
function YGNode.getChild(self: YGNode, index: number): YGNode
    return self.children_[index]
end

function YGNode.getConfig(self: YGNode): YGConfig?
    return self.config_
end

function YGNode.isDirty(self: YGNode): boolean
    return self.isDirty_
end

function YGNode.getResolvedDimensions(self: YGNode): Array<YGValue>
    return self.resolvedDimensions_
end

function YGNode.getResolvedDimension(self: YGNode, index: number): YGValue
    return self.resolvedDimensions_[index]
end

function YGNode.getLeadingPosition(self: YGNode, axis: YGFlexDirection, axisSize: number): YGFloatOptional
    local leadingPosition = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.position, leading[axis], YGValueZero())
    return YGResolveValue(leadingPosition, axisSize)
end

function YGNode.isLeadingPositionDefined(self: YGNode, axis: YGFlexDirection): boolean
    -- FIXME Luau: this annotation shouldn't be necessary
    local leadingPosition: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.Start, leading[axis], YGValueUndefined())
        else self:computeEdgeValueForColumn(self.style_.position, leading[axis], YGValueUndefined())
    return not leadingPosition:isUndefined()
end

function YGNode.isTrailingPosDefined(self: YGNode, axis: YGFlexDirection): boolean
    -- FIXME Luau: this annotation shouldn't be necessary
    local trailingPosition: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.End, trailing[axis], YGValueUndefined())
        else self:computeEdgeValueForColumn(self.style_.position, trailing[axis], YGValueUndefined())
    return not trailingPosition:isUndefined()
end

function YGNode.getTrailingPosition(self: YGNode, axis: YGFlexDirection, axisSize: number): YGFloatOptional
    local trailingPosition = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.position, trailing[axis], YGValueZero())
    return YGResolveValue(trailingPosition, axisSize)
end

function YGNode.getLeadingMargin(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local leadingMargin = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.margin, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.margin, leading[axis], YGValueZero())
    return YGResolveValueMargin(leadingMargin, widthSize)
end

function YGNode.getTrailingMargin(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local trailingMargin: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.margin, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.margin, trailing[axis], YGValueZero())
    return YGResolveValueMargin(trailingMargin, widthSize)
end

function YGNode.getLeadingBorder(self: YGNode, axis: YGFlexDirection): number
    local leadingBorder: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.border, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.border, leading[axis], YGValueZero())
    return YGFloatMax(leadingBorder.value, 0.0)
end

function YGNode.getTrailingBorder(self: YGNode, axis: YGFlexDirection): number
    local trailingBorder: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.border, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.border, trailing[axis], YGValueZero())
    return YGFloatMax(trailingBorder.value, 0.0)
end

function YGNode.getLeadingPadding(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local leadingPadding = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.padding, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.padding, leading[axis], YGValueZero())
    return YGFloatOptionalMax(YGResolveValue(leadingPadding, widthSize), YGFloatOptional.new(0.0))
end

function YGNode.getTrailingPadding(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local trailingPadding = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.padding, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.padding, trailing[axis], YGValueZero())
    return YGFloatOptionalMax(YGResolveValue(trailingPadding, widthSize), YGFloatOptional.new(0.0))
end

function YGNode.getLeadingPaddingAndBorder(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getLeadingPadding(axis, widthSize):add(YGFloatOptional.new(self:getLeadingBorder(axis)))
end

function YGNode.getTrailingPaddingAndBorder(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getTrailingPadding(axis, widthSize):add(YGFloatOptional.new(self:getTrailingBorder(axis)))
end

function YGNode.getMarginForAxis(self: YGNode, axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getLeadingMargin(axis, widthSize):add(self:getTrailingMargin(axis, widthSize))
end

function YGNode.setContext(self: YGNode, context: any): ()
    self.context_ = context
end

function YGNode.setPrintFunc(self: YGNode, printFunc: YGPrintFunc): ()
    self.print_ = printFunc
end

function YGNode.setHasNewLayout(self: YGNode, hasNewLayout: boolean): ()
    self.hasNewLayout_ = hasNewLayout
end

function YGNode.setNodeType(self: YGNode, nodeType: YGNodeType): ()
    self.nodeType_ = nodeType
end

--- deviation: Upstream uses method overloading with a union for callbacks
--- with and without context functions. TypeScript doesn't support method
--- overloading in classes the same way C++ does, so the context function is
--- made an optional parameter of YGMeasureFunc.
function YGNode.setMeasureFunc(self: YGNode, measureFunc: YGMeasureFunc): ()
    if measureFunc == nil then
        self:setNodeType(YGNodeType.Default)
    else
        -- YGAssertWithNode(this, this.children_.size() == 0, "Cannot set measure function: Nodes with measure functions cannot have children.");
        if #self.children_ ~= 0 then
            console.error("Cannot set measure function: Nodes with measure functions cannot have children.")
        end
        self:setNodeType(YGNodeType.Text)
    end

    self.measure_ = measureFunc
end

function YGNode.setBaseLineFunc(self: YGNode, baseLineFunc: YGBaselineFunc): ()
    self.baseline_ = baseLineFunc
end

function YGNode.setDirtiedFunc(self: YGNode, dirtiedFunc: YGDirtiedFunc): ()
    self.dirtied_ = dirtiedFunc
end

function YGNode.setStyle(self: YGNode, style: YGStyle): ()
    self.style_ = style
end

function YGNode.setStyleFlexDirection(self: YGNode, direction: YGFlexDirection): ()
    self.style_.flexDirection = direction
end

function YGNode.setStyleAlignContent(self: YGNode, alignContent: YGAlign): ()
    self.style_.alignContent = alignContent
end

function YGNode.setLayout(self: YGNode, layout: YGLayout): ()
    self.layout_ = layout
end

function YGNode.setLineIndex(self: YGNode, lineIndex: number): ()
    self.lineIndex_ = lineIndex
end

function YGNode.setIsReferenceBaseline(self: YGNode, isReferenceBaseline: boolean): ()
    self.isReferenceBaseline_ = isReferenceBaseline
end

function YGNode.setOwner(self: YGNode, owner: YGNode): ()
    self.owner_ = owner
end

function YGNode.setChildren(self: YGNode, children: Array<YGNode>): ()
    self.children_ = children
end

function YGNode.setConfig(self: YGNode, config: YGConfig?): ()
    self.config_ = config
end

function YGNode.setDirty(self: YGNode, isDirty: boolean): ()
    if isDirty == self.isDirty_ then
        return
    end
    self.isDirty_ = isDirty
    if isDirty and Boolean.toJSBoolean(self.dirtied_) then
        self:dirtied_()
    end
end

function YGNode.setLayoutLastOwnerDirection(self: YGNode, direction: YGDirection): ()
    self.layout_.lastOwnerDirection = direction
end

function YGNode.setLayoutComputedFlexBasis(self: YGNode, computedFlexBasis: YGFloatOptional): ()
    self.layout_.computedFlexBasis = computedFlexBasis
end

function YGNode.setLayoutComputedFlexBasisGeneration(self: YGNode, computedFlexBasisGeneration: number): ()
    self.layout_.computedFlexBasisGeneration = computedFlexBasisGeneration
end

function YGNode.setLayoutMeasuredDimension(self: YGNode, measuredDimension: number, index: number): ()
    self.layout_.measuredDimensions[index] = measuredDimension
end

function YGNode.setLayoutHadOverflow(self: YGNode, hadOverflow: boolean): ()
    self.layout_.hadOverflow = hadOverflow
end

function YGNode.setLayoutDimension(self: YGNode, dimension: number, index: number): ()
    self.layout_.dimensions[index] = dimension
end

function YGNode.setLayoutDirection(self: YGNode, direction: YGDirection): ()
    self.layout_.direction = direction
end

function YGNode.setLayoutMargin(self: YGNode, margin: number, index: number): ()
    self.layout_.margin[index] = margin
end

function YGNode.setLayoutBorder(self: YGNode, border: number, index: number): ()
    self.layout_.border[index] = border
end

function YGNode.setLayoutPadding(self: YGNode, padding: number, index: number): ()
    self.layout_.padding[index] = padding
end

function YGNode.setLayoutPosition(self: YGNode, position: number, index: number): ()
    self.layout_.position[index] = position
end

function YGNode.setPosition(self: YGNode, direction: YGDirection, mainSize: number, crossSize: number, ownerWidth: number): ()
    local directionRespectingRoot: YGDirection = if self.owner_ ~= nil then direction else YGDirection.LTR
    local mainAxis: YGFlexDirection = YGResolveFlexDirection(self.style_.flexDirection, directionRespectingRoot)
    local crossAxis: YGFlexDirection = YGFlexDirectionCross(mainAxis, directionRespectingRoot)
    local relativePositionMain: YGFloatOptional = self:relativePosition(mainAxis, mainSize)
    local relativePositionCross: YGFloatOptional = self:relativePosition(crossAxis, crossSize)

    self:setLayoutPosition(
        self:getLeadingMargin(mainAxis, ownerWidth):add(relativePositionMain):unwrap(),
        leading[mainAxis]
    )
    self:setLayoutPosition(
        self:getTrailingMargin(mainAxis, ownerWidth):add(relativePositionMain):unwrap(),
        trailing[mainAxis]
    )
    self:setLayoutPosition(
        self:getLeadingMargin(crossAxis, ownerWidth):add(relativePositionCross):unwrap(),
        leading[crossAxis]
    )
    self:setLayoutPosition(
        self:getTrailingMargin(crossAxis, ownerWidth):add(relativePositionCross):unwrap(),
        trailing[crossAxis]
    )
end

function YGNode.setLayoutDoesLegacyFlagAffectsLayout(self: YGNode, doesLegacyFlagAffectsLayout: boolean): ()
    self.layout_.doesLegacyStretchFlagAffectsLayout = doesLegacyFlagAffectsLayout
end

function YGNode.setLayoutDidUseLegacyFlag(self: YGNode, didUseLegacyFlag: boolean): ()
    self.layout_.didUseLegacyFlag = didUseLegacyFlag
end

function YGNode.markDirtyAndPropogateDownwards(self: YGNode): ()
    self.isDirty_ = true
    for i = 1, #self.children_ do
        self.children_[i]:markDirtyAndPropogateDownwards()
    end
end

function YGNode.marginLeadingValue(self: YGNode, axis: YGFlexDirection): YGValue
    if YGFlexDirectionIsRow(axis) and self.style_.margin[YGEdge.Start].unit ~= YGUnit.Undefined then
        return self.style_.margin[YGEdge.Start]
    else
        return self.style_.margin[leading[axis]]
    end
end

function YGNode.marginTrailingValue(self: YGNode, axis: YGFlexDirection): YGValue
    if YGFlexDirectionIsRow(axis) and self.style_.margin[YGEdge.End].unit ~= YGUnit.Undefined then
        return self.style_.margin[YGEdge.End]
    else
        return self.style_.margin[trailing[axis]]
    end
end

function YGNode.resolveFlexBasisPtr(self: YGNode): YGValue
    local flexBasis: YGValue = self.style_.flexBasis

    if flexBasis.unit ~= YGUnit.Auto and flexBasis.unit ~= YGUnit.Undefined then
        return flexBasis
    end

    if not self.style_.flex:isUndefined() and self.style_.flex:getValue() > 0.0 then
        if self.config_ and self.config_.useWebDefaults then
            return YGValueAuto()
        else
            return YGValueZero()
        end
    end

    return YGValueAuto()
end

function YGNode.resolveDimension(self: YGNode): ()
    local style: YGStyle = self:getStyle()
    for _, dim in ipairs({ YGDimension.Width, YGDimension.Height }) do
        if
            not style.maxDimensions[dim]:isUndefined()
            and YGValueEqual(style.maxDimensions[dim], style.minDimensions[dim])
        then
            self.resolvedDimensions_[dim] = style.maxDimensions[dim]
        else
            self.resolvedDimensions_[dim] = style.dimensions[dim]
        end
    end
end

function YGNode.resolveDirection(self: YGNode, ownerDirection: YGDirection): YGDirection
    if self.style_.direction == YGDirection.Inherit then
        if ownerDirection > YGDirection.Inherit then
            return ownerDirection
        else
            return YGDirection.LTR
        end
    else
        return self.style_.direction
    end
end

function YGNode.clearChildren(self: YGNode): ()
    while #self.children_ > 0 do
        table.remove(self.children_)
    end
end

function YGNode.replaceChild(self: YGNode, oldChild: YGNode, newChild: YGNode): ()
    local index = Array.indexOf(self.children_, oldChild)
    if index >= 1 then
        self.children_[index] = newChild
    end
end

function YGNode.replaceChildIndex(self: YGNode, child: YGNode, index: number): ()
    self.children_[index] = child
end

function YGNode.insertChildIndex(self: YGNode, child: YGNode, index: number): ()
    Array.splice(self.children_, index, 0, child)
end

function YGNode.removeChild(self: YGNode, child: YGNode): boolean
    local index = Array.indexOf(self.children_, child)
    if index >= 1 then
        Array.splice(self.children_, index, 1)
        return true
    end
    return false
end

function YGNode.removeChildIndex(self: YGNode, index: number): ()
    Array.splice(self.children_, index, 1)
end

function YGNode.iterChildrenAfterCloningIfNeeded(self: YGNode, callback: IterChildrenCallback, cloneContext: any): ()
    for i, child in ipairs(self.children_) do
        if self.config_ and child:getOwner() ~= self then
            child = self.config_:cloneNode(child, self, i, cloneContext)
            child:setOwner(self)
        end

        callback(child, cloneContext)
    end
end

function YGNode.cloneChildrenIfNeeded(self: YGNode, cloneContext: any?): ()
    self:iterChildrenAfterCloningIfNeeded(function(_node: YGNode, _cloneContext: any) end, cloneContext)
end

function YGNode.markDirtyAndPropogate(self: YGNode): ()
    if not self.isDirty_ then
        self:setDirty(true)
        self:setLayoutComputedFlexBasis(YGFloatOptional.new())

        if Boolean.toJSBoolean(self.owner_) then
            self.owner_:markDirtyAndPropogate()
        end
    end
end

function YGNode.resolveFlexGrow(self: YGNode): number
    if self.owner_ == nil then
        return 0.0
    end

    if not self.style_.flexGrow:isUndefined() then
        return self.style_.flexGrow:unwrap()
    end

    if not self.style_.flex:isUndefined() and self.style_.flex:unwrap() > 0.0 then
        return self.style_.flex:unwrap()
    end

    return kDefaultFlexGrow
end

function YGNode.resolveFlexShrink(self: YGNode): number
    if self.owner_ == nil then
        return 0.0
    end

    if not (self.style_.flexShrink:isUndefined()) then
        return self.style_.flexShrink:getValue()
    end

    if self.config_ and not self.config_.useWebDefaults and not self.style_.flex:isUndefined() and self.style_.flex:getValue() < 0.0 then
        return -self.style_.flex:getValue()
    end

    return if self.config_ and self.config_.useWebDefaults then kWebDefaultFlexShrink else kDefaultFlexShrink
end

function YGNode.isNodeFlexible(self: YGNode): boolean
    return self.style_.positionType ~= YGPositionType.Absolute
        and (self:resolveFlexGrow() ~= 0 or self:resolveFlexShrink() ~= 0)
end

function YGNode.didUseLegacyFlag(self: YGNode): boolean
    local didUseLegacyFlag: boolean = self.layout_.didUseLegacyFlag
    if didUseLegacyFlag then
        return true
    end

    for i = 1, #self.children_ do
        if self.children_[i]:getLayout().didUseLegacyFlag then
            didUseLegacyFlag = true
            break
        end
    end

    return didUseLegacyFlag
end

function YGNode.isLayoutTreeEqualToNode(self: YGNode, node: YGNode): boolean
    if #self.children_ ~= #node:getChildren() then
        return false
    end

    if self.layout_:diff(node:getLayout()) then
        return false
    end

    if #self.children_ == 0 then
        return true
    end

    local isLayoutTreeEqual = true
    for i = 1, #self.children_ do
        local otherNodeChildren: YGNode = node:getChild(i)
        isLayoutTreeEqual = self.children_[i]:isLayoutTreeEqualToNode(otherNodeChildren)

        if not isLayoutTreeEqual then
            return false
        end
    end

    return isLayoutTreeEqual
end

function YGNode.reset(self: YGNode): ()
    YGAssertWithNode(self, #self.children_ == 0, "Cannot reset a node which still has children attached")
    YGAssertWithNode(self, self.owner_ == nil, "Cannot reset a node still attached to a owner")

    self:clearChildren()

    -- TODO: Move useWebDefaults to the node and not the config?
    local config = self:getConfig()
    local webDefaults = config.useWebDefaults

    self:initialize()
    self:setConfig(config)

    if webDefaults then
        self:useWebDefaults()
    end
end

-- note: Some imports are done dynamically to resolve cyclic dependency issues.
return {
    resolve = function(deps)
        local yogaAssertionsModule = deps.yogaAssertionsModule
        YGAssertWithNode = yogaAssertionsModule.YGAssertWithNode

        local ygConfigModule = ygConfigModule_.resolve({
            yogaUtilsModule = deps.yogaUtilsModule,
        })
        YGConfig = ygConfigModule

        return YGNode
    end,
}
