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

function YGNode:relativePosition(axis: YGFlexDirection, axisSize: number): YGFloatOptional
    if self:isLeadingPositionDefined(axis) then
        return self:getLeadingPosition(axis, axisSize)
    end

    local trailingPosition: YGFloatOptional = self:getTrailingPosition(axis, axisSize)
    if not trailingPosition:isUndefined() then
        trailingPosition:setValue(-1 * trailingPosition:getValue())
    end

    return trailingPosition
end

-- deviation: having multiple constructor type signatures is not supported
function YGNode.new(
    contextOrNodeOrConfig: (any | YGNode | YGConfig)?,
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
    local self = setmetatable({}, YGNode)

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

    if instanceof(contextOrNodeOrConfig, YGNode) then
        console.log("from node")
        self:fromNode(contextOrNodeOrConfig :: YGNode)
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

    if instanceof(contextOrNodeOrConfig, YGConfig) then
        self.config_ = contextOrNodeOrConfig
        self.context_ = (nil :: any) :: typeof(contextOrNodeOrConfig)
    else
        self.context_ = contextOrNodeOrConfig
    end

    return (self :: any) :: YGNode
end

function YGNode:initialize(
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
): ()
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

    self.print_ = print_
    self.hasNewLayout_ = hasNewLayout
    self.isReferenceBaseline_ = isReferenceBaseline
    self.nodeType_ = nodeType
    self.measure_ = measure
    self.baseline_ = baseline
    self.dirtied_ = dirtied
    self.style_ = style
    self.layout_ = layout
    self.lineIndex_ = lineIndex
    self.owner_ = owner
    self.children_ = children
    self.config_ = config
    self.isDirty_ = isDirty
    self.resolvedDimensions_ = resolvedDimensions
    self.context_ = nil
end

function YGNode:operatorAtrib(node: YGNode): YGNode
    if node == self then
        return self
    end

    self:clearChildren()
    self:fromNode(node)

    return self
end

function YGNode:fromNode(node: YGNode): ()
    print(node)

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

function YGNode:print(printContext: any?): ()
    if self.print_ ~= nil then
        self:print_(self, printContext)
    end
end

function YGNode:computeEdgeValueForRow(
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

function YGNode:computeEdgeValueForColumn(edges: Array<YGValue>, edge: YGEdge, defaultValue: YGValue): YGValue
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

function YGNode:measure(
    width: number,
    widthMode: YGMeasureMode,
    height: number,
    heightMode: YGMeasureMode,
    layoutContext: any?
): YGSize
    return self:measure_(width, widthMode, height, heightMode, layoutContext)
end

function YGNode:baseline(width: number, height: number, layoutContext: any?): number
    return self:baseline_(width, height, layoutContext)
end

-- TODO: Move useWebDefaults to the node and not the config?
function YGNode:useWebDefaults(): ()
    self.config_.useWebDefaults = true
    self.style_.flexDirection = YGFlexDirection.Row
    self.style_.alignContent = YGAlign.Stretch
end

function YGNode:hasMeasureFunc(): boolean
    return self.measure_ ~= nil
end

function YGNode:hasBaselineFunc(): boolean
    return self.baseline_ ~= nil
end

function YGNode:getContext(): any
    return self.context_
end

function YGNode:getHasNewLayout(): boolean
    return self.hasNewLayout_
end

function YGNode:getNodeType(): YGNodeType
    return self.nodeType_
end

function YGNode:getDirtied(): YGDirtiedFunc
    return self.dirtied_
end

function YGNode:getStyle(): YGStyle
    return self.style_
end

function YGNode:getLayout(): YGLayout
    return self.layout_
end

function YGNode:getLineIndex(): number
    return self.lineIndex_
end

function YGNode:isReferenceBaseline(): boolean
    return self.isReferenceBaseline_
end

function YGNode:getOwner(): YGNode
    return self.owner_
end

function YGNode:getParent(): YGNode
    return self:getOwner()
end

function YGNode:getChildren(): Array<YGNode>
    return self.children_
end

function YGNode:getChildrenCount(): number
    return #self.children_
end

-- deviation: upstream Yoga and Typeflex expect 0 to be the index of the
-- first child when using this function, so add one as arrays start at 1 in Lua.
function YGNode:getChild(index: number): YGNode
    return self.children_[index]
end

function YGNode:getConfig(): YGConfig
    return self.config_
end

function YGNode:isDirty(): boolean
    return self.isDirty_
end

function YGNode:getResolvedDimensions(): Array<YGValue>
    return self.resolvedDimensions_
end

function YGNode:getResolvedDimension(index: number): YGValue
    return self.resolvedDimensions_[index]
end

function YGNode:getLeadingPosition(axis: YGFlexDirection, axisSize: number): YGFloatOptional
    local leadingPosition = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.position, leading[axis], YGValueZero())
    return YGResolveValue(leadingPosition, axisSize)
end

function YGNode:isLeadingPositionDefined(axis: YGFlexDirection): boolean
    -- FIXME Luau: this annotation shouldn't be necessary
    local leadingPosition: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.Start, leading[axis], YGValueUndefined())
        else self:computeEdgeValueForColumn(self.style_.position, leading[axis], YGValueUndefined())
    return not leadingPosition:isUndefined()
end

function YGNode:isTrailingPosDefined(axis: YGFlexDirection): boolean
    -- FIXME Luau: this annotation shouldn't be necessary
    local trailingPosition: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.End, trailing[axis], YGValueUndefined())
        else self:computeEdgeValueForColumn(self.style_.position, trailing[axis], YGValueUndefined())
    return not trailingPosition:isUndefined()
end

function YGNode:getTrailingPosition(axis: YGFlexDirection, axisSize: number): YGFloatOptional
    local trailingPosition = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.position, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.position, trailing[axis], YGValueZero())
    return YGResolveValue(trailingPosition, axisSize)
end

function YGNode:getLeadingMargin(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local leadingMargin = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.margin, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.margin, leading[axis], YGValueZero())
    return YGResolveValueMargin(leadingMargin, widthSize)
end

function YGNode:getTrailingMargin(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local trailingMargin: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.margin, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.margin, trailing[axis], YGValueZero())
    return YGResolveValueMargin(trailingMargin, widthSize)
end

function YGNode:getLeadingBorder(axis: YGFlexDirection): number
    local leadingBorder: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.border, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.border, leading[axis], YGValueZero())
    return YGFloatMax(leadingBorder.value, 0.0)
end

function YGNode:getTrailingBorder(axis: YGFlexDirection): number
    local trailingBorder: YGValue = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.border, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.border, trailing[axis], YGValueZero())
    return YGFloatMax(trailingBorder.value, 0.0)
end

function YGNode:getLeadingPadding(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local leadingPadding = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.padding, YGEdge.Start, leading[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.padding, leading[axis], YGValueZero())
    return YGFloatOptionalMax(YGResolveValue(leadingPadding, widthSize), YGFloatOptional.new(0.0))
end

function YGNode:getTrailingPadding(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    local trailingPadding = if YGFlexDirectionIsRow(axis)
        then self:computeEdgeValueForRow(self.style_.padding, YGEdge.End, trailing[axis], YGValueZero())
        else self:computeEdgeValueForColumn(self.style_.padding, trailing[axis], YGValueZero())
    return YGFloatOptionalMax(YGResolveValue(trailingPadding, widthSize), YGFloatOptional.new(0.0))
end

function YGNode:getLeadingPaddingAndBorder(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getLeadingPadding(axis, widthSize):add(YGFloatOptional.new(self:getLeadingBorder(axis)))
end

function YGNode:getTrailingPaddingAndBorder(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getTrailingPadding(axis, widthSize):add(YGFloatOptional.new(self:getTrailingBorder(axis)))
end

function YGNode:getMarginForAxis(axis: YGFlexDirection, widthSize: number): YGFloatOptional
    return self:getLeadingMargin(axis, widthSize):add(self:getTrailingMargin(axis, widthSize))
end

function YGNode:setContext(context: any): ()
    self.context_ = context
end

function YGNode:setPrintFunc(printFunc: YGPrintFunc): ()
    self.print_ = printFunc
end

function YGNode:setHasNewLayout(hasNewLayout: boolean): ()
    self.hasNewLayout_ = hasNewLayout
end

function YGNode:setNodeType(nodeType: YGNodeType): ()
    self.nodeType_ = nodeType
end

--[[*
 * deviation: Upstream uses method overloading with a union for callbacks
 * with and without context functions. TypeScript doesn't support method
 * overloading in classes the same way C++ does, so the context function is
 * made an optional parameter of YGMeasureFunc.
]]
function YGNode:setMeasureFunc(measureFunc: YGMeasureFunc): ()
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

function YGNode:setBaseLineFunc(baseLineFunc: YGBaselineFunc): ()
    self.baseline_ = baseLineFunc
end

function YGNode:setDirtiedFunc(dirtiedFunc: YGDirtiedFunc): ()
    self.dirtied_ = dirtiedFunc
end

function YGNode:setStyle(style: YGStyle): ()
    self.style_ = style
end

function YGNode:setStyleFlexDirection(direction: YGFlexDirection): ()
    self.style_.flexDirection = direction
end

function YGNode:setStyleAlignContent(alignContent: YGAlign): ()
    self.style_.alignContent = alignContent
end

function YGNode:setLayout(layout: YGLayout): ()
    self.layout_ = layout
end

function YGNode:setLineIndex(lineIndex: number): ()
    self.lineIndex_ = lineIndex
end

function YGNode:setIsReferenceBaseline(isReferenceBaseline: boolean): ()
    self.isReferenceBaseline_ = isReferenceBaseline
end

function YGNode:setOwner(owner: YGNode): ()
    self.owner_ = owner
end

function YGNode:setChildren(children: Array<YGNode>): ()
    self.children_ = children
end

function YGNode:setConfig(config: YGConfig?): ()
    self.config_ = config
end

function YGNode:setDirty(isDirty: boolean): ()
    if isDirty == self.isDirty_ then
        return
    end
    self.isDirty_ = isDirty
    if isDirty and Boolean.toJSBoolean(self.dirtied_) then
        self:dirtied_(self)
    end
end

function YGNode:setLayoutLastOwnerDirection(direction: YGDirection): ()
    self.layout_.lastOwnerDirection = direction
end

function YGNode:setLayoutComputedFlexBasis(computedFlexBasis: YGFloatOptional): ()
    self.layout_.computedFlexBasis = computedFlexBasis
end

function YGNode:setLayoutComputedFlexBasisGeneration(computedFlexBasisGeneration: number): ()
    self.layout_.computedFlexBasisGeneration = computedFlexBasisGeneration
end

function YGNode:setLayoutMeasuredDimension(measuredDimension: number, index: number): ()
    self.layout_.measuredDimensions[index] = measuredDimension
end

function YGNode:setLayoutHadOverflow(hadOverflow: boolean): ()
    self.layout_.hadOverflow = hadOverflow
end

function YGNode:setLayoutDimension(dimension: number, index: number): ()
    self.layout_.dimensions[index] = dimension
end

function YGNode:setLayoutDirection(direction: YGDirection): ()
    self.layout_.direction = direction
end

function YGNode:setLayoutMargin(margin: number, index: number): ()
    self.layout_.margin[index] = margin
end

function YGNode:setLayoutBorder(border: number, index: number): ()
    self.layout_.border[index] = border
end

function YGNode:setLayoutPadding(padding: number, index: number): ()
    self.layout_.padding[index] = padding
end

function YGNode:setLayoutPosition(position: number, index: number): ()
    self.layout_.position[index] = position
end

function YGNode:setPosition(direction: YGDirection, mainSize: number, crossSize: number, ownerWidth: number): ()
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

function YGNode:setLayoutDoesLegacyFlagAffectsLayout(doesLegacyFlagAffectsLayout: boolean): ()
    self.layout_.doesLegacyStretchFlagAffectsLayout = doesLegacyFlagAffectsLayout
end

function YGNode:setLayoutDidUseLegacyFlag(didUseLegacyFlag: boolean): ()
    self.layout_.didUseLegacyFlag = didUseLegacyFlag
end

function YGNode:markDirtyAndPropogateDownwards(): ()
    self.isDirty_ = true
    for i = 1, #self.children_ do
        self.children_[i]:markDirtyAndPropogateDownwards()
    end
end

function YGNode:marginLeadingValue(axis: YGFlexDirection): YGValue
    if YGFlexDirectionIsRow(axis) and self.style_.margin[YGEdge.Start].unit ~= YGUnit.Undefined then
        return self.style_.margin[YGEdge.Start]
    else
        return self.style_.margin[leading[axis]]
    end
end

function YGNode:marginTrailingValue(axis: YGFlexDirection): YGValue
    if YGFlexDirectionIsRow(axis) and self.style_.margin[YGEdge.End].unit ~= YGUnit.Undefined then
        return self.style_.margin[YGEdge.End]
    else
        return self.style_.margin[trailing[axis]]
    end
end

function YGNode:resolveFlexBasisPtr(): YGValue
    local flexBasis: YGValue = self.style_.flexBasis

    if flexBasis.unit ~= YGUnit.Auto and flexBasis.unit ~= YGUnit.Undefined then
        return flexBasis
    end

    if not self.style_.flex:isUndefined() and self.style_.flex:getValue() > 0.0 then
        if self.config_.useWebDefaults then
            return YGValueAuto()
        else
            return YGValueZero()
        end
    end

    return YGValueAuto()
end

function YGNode:resolveDimension(): ()
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

function YGNode:resolveDirection(ownerDirection: YGDirection): YGDirection
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

function YGNode:clearChildren(): ()
    while #self.children_ > 0 do
        table.remove(self.children_)
    end
end

function YGNode:replaceChild(oldChild: YGNode, newChild: YGNode): ()
    local index = Array.indexOf(self.children_, oldChild)
    if index >= 1 then
        self.children_[index] = newChild
    end
end

function YGNode:replaceChildIndex(child: YGNode, index: number): ()
    self.children_[index] = child
end

function YGNode:insertChildIndex(child: YGNode, index: number): ()
    Array.splice(self.children_, index, 0, child)
end

function YGNode:removeChild(child: YGNode): boolean
    local index = Array.indexOf(self.children_, child)
    if index >= 1 then
        Array.splice(self.children_, index, 1)
        return true
    end
    return false
end

function YGNode:removeChildIndex(index: number): ()
    Array.splice(self.children_, index, 1)
end

function YGNode:iterChildrenAfterCloningIfNeeded(callback: IterChildrenCallback, cloneContext: any): ()
    for i, child in ipairs(self.children_) do
        if child:getOwner() ~= self then
            child = self.config_:cloneNode(child, self, i, cloneContext)
            child:setOwner(self)
        end

        callback(child, cloneContext)
    end
end

function YGNode:cloneChildrenIfNeeded(cloneContext: any?): ()
    self:iterChildrenAfterCloningIfNeeded(function(_node: YGNode, _cloneContext: any) end, cloneContext)
end

function YGNode:markDirtyAndPropogate(): ()
    if not self.isDirty_ then
        self:setDirty(true)
        self:setLayoutComputedFlexBasis(YGFloatOptional.new())

        if Boolean.toJSBoolean(self.owner_) then
            self.owner_:markDirtyAndPropogate()
        end
    end
end

function YGNode:resolveFlexGrow(): number
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

function YGNode:resolveFlexShrink(): number
    if self.owner_ == nil then
        return 0.0
    end

    if not (self.style_.flexShrink:isUndefined()) then
        return self.style_.flexShrink:getValue()
    end

    if not self.config_.useWebDefaults and not self.style_.flex:isUndefined() and self.style_.flex:getValue() < 0.0 then
        return -self.style_.flex:getValue()
    end

    return if self.config_.useWebDefaults then kWebDefaultFlexShrink else kDefaultFlexShrink
end

function YGNode:isNodeFlexible(): boolean
    return self.style_.positionType ~= YGPositionType.Absolute
        and (self:resolveFlexGrow() ~= 0 or self:resolveFlexShrink() ~= 0)
end

function YGNode:didUseLegacyFlag(): boolean
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

function YGNode:isLayoutTreeEqualToNode(node: YGNode): boolean
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

function YGNode:reset(): ()
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
