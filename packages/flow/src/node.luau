--!optimize 2
--!strict

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error

local Yoga = require(Packages.YogaSys)

type YGAlign = Yoga.YGAlign
type YGDirtiedFunc = Yoga.YGDirtiedFunc
type YGDirection = Yoga.YGDirection
type YGDisplay = Yoga.YGDisplay
type YGEdge = Yoga.YGEdge
type YGFlexDirection = Yoga.YGFlexDirection
type YGJustify = Yoga.YGJustify
type YGNode = Yoga.YGNode
type YGOverflow = Yoga.YGOverflow
type YGPositionType = Yoga.YGPositionType
type YGValue = Yoga.YGValue
type YGWrap = Yoga.YGWrap

local YGNodeCalculateLayout = Yoga.YGNodeCalculateLayout
local YGNodeCopyStyle = Yoga.YGNodeCopyStyle
local YGNodeFree = Yoga.YGNodeFree
local YGNodeFreeRecursive = Yoga.YGNodeFreeRecursive
local YGNodeGetChild = Yoga.YGNodeGetChild
local YGNodeGetChildCount = Yoga.YGNodeGetChildCount
local YGNodeGetContext = Yoga.YGNodeGetContext
local YGNodeGetDirtiedFunc = Yoga.YGNodeGetDirtiedFunc
local YGNodeGetParent = Yoga.YGNodeGetParent
local YGNodeInsertChild = Yoga.YGNodeInsertChild
local YGNodeIsDirty = Yoga.YGNodeIsDirty
local YGNodeIsReferenceBaseline = Yoga.YGNodeIsReferenceBaseline
local YGNodeLayoutGetBorder = Yoga.YGNodeLayoutGetBorder
local YGNodeLayoutGetBottom = Yoga.YGNodeLayoutGetBottom
local YGNodeLayoutGetHeight = Yoga.YGNodeLayoutGetHeight
local YGNodeLayoutGetLeft = Yoga.YGNodeLayoutGetLeft
local YGNodeLayoutGetMargin = Yoga.YGNodeLayoutGetMargin
local YGNodeLayoutGetPadding = Yoga.YGNodeLayoutGetPadding
local YGNodeLayoutGetRight = Yoga.YGNodeLayoutGetRight
local YGNodeLayoutGetTop = Yoga.YGNodeLayoutGetTop
local YGNodeLayoutGetWidth = Yoga.YGNodeLayoutGetWidth
local YGNodeMarkDirty = Yoga.YGNodeMarkDirty
local YGNodeNew = Yoga.YGNodeNew
local YGNodeNewWithConfig = Yoga.YGNodeNewWithConfig
local YGNodeRemoveChild = Yoga.YGNodeRemoveChild
local YGNodeReset = Yoga.YGNodeReset
local YGNodeSetContext = Yoga.YGNodeSetContext
local YGNodeSetDirtiedFunc = Yoga.YGNodeSetDirtiedFunc
local YGNodeSetIsReferenceBaseline = Yoga.YGNodeSetIsReferenceBaseline
local YGNodeSetMeasureFunc = Yoga.YGNodeSetMeasureFunc
local YGNodeStyleGetAlignContent = Yoga.YGNodeStyleGetAlignContent
local YGNodeStyleGetAlignItems = Yoga.YGNodeStyleGetAlignItems
local YGNodeStyleGetAlignSelf = Yoga.YGNodeStyleGetAlignSelf
local YGNodeStyleGetAspectRatio = Yoga.YGNodeStyleGetAspectRatio
local YGNodeStyleGetBorder = Yoga.YGNodeStyleGetBorder
local YGNodeStyleGetDisplay = Yoga.YGNodeStyleGetDisplay
local YGNodeStyleGetFlexBasis = Yoga.YGNodeStyleGetFlexBasis
local YGNodeStyleGetFlexDirection = Yoga.YGNodeStyleGetFlexDirection
local YGNodeStyleGetFlexGrow = Yoga.YGNodeStyleGetFlexGrow
local YGNodeStyleGetFlexShrink = Yoga.YGNodeStyleGetFlexShrink
local YGNodeStyleGetFlexWrap = Yoga.YGNodeStyleGetFlexWrap
local YGNodeStyleGetHeight = Yoga.YGNodeStyleGetHeight
local YGNodeStyleGetJustifyContent = Yoga.YGNodeStyleGetJustifyContent
local YGNodeStyleGetMargin = Yoga.YGNodeStyleGetMargin
local YGNodeStyleGetMaxHeight = Yoga.YGNodeStyleGetMaxHeight
local YGNodeStyleGetMaxWidth = Yoga.YGNodeStyleGetMaxWidth
local YGNodeStyleGetMinHeight = Yoga.YGNodeStyleGetMinHeight
local YGNodeStyleGetMinWidth = Yoga.YGNodeStyleGetMinWidth
local YGNodeStyleGetOverflow = Yoga.YGNodeStyleGetOverflow
local YGNodeStyleGetPadding = Yoga.YGNodeStyleGetPadding
local YGNodeStyleGetPosition = Yoga.YGNodeStyleGetPosition
local YGNodeStyleGetPositionType = Yoga.YGNodeStyleGetPositionType
local YGNodeStyleGetWidth = Yoga.YGNodeStyleGetWidth
local YGNodeStyleSetAlignContent = Yoga.YGNodeStyleSetAlignContent
local YGNodeStyleSetAlignItems = Yoga.YGNodeStyleSetAlignItems
local YGNodeStyleSetAlignSelf = Yoga.YGNodeStyleSetAlignSelf
local YGNodeStyleSetAspectRatio = Yoga.YGNodeStyleSetAspectRatio
local YGNodeStyleSetBorder = Yoga.YGNodeStyleSetBorder
local YGNodeStyleSetDisplay = Yoga.YGNodeStyleSetDisplay
local YGNodeStyleSetFlex = Yoga.YGNodeStyleSetFlex
local YGNodeStyleSetFlexBasis = Yoga.YGNodeStyleSetFlexBasis
local YGNodeStyleSetFlexBasisAuto = Yoga.YGNodeStyleSetFlexBasisAuto
local YGNodeStyleSetFlexBasisPercent = Yoga.YGNodeStyleSetFlexBasisPercent
local YGNodeStyleSetFlexDirection = Yoga.YGNodeStyleSetFlexDirection
local YGNodeStyleSetFlexGrow = Yoga.YGNodeStyleSetFlexGrow
local YGNodeStyleSetFlexShrink = Yoga.YGNodeStyleSetFlexShrink
local YGNodeStyleSetFlexWrap = Yoga.YGNodeStyleSetFlexWrap
local YGNodeStyleSetHeight = Yoga.YGNodeStyleSetHeight
local YGNodeStyleSetHeightAuto = Yoga.YGNodeStyleSetHeightAuto
local YGNodeStyleSetHeightPercent = Yoga.YGNodeStyleSetHeightPercent
local YGNodeStyleSetJustifyContent = Yoga.YGNodeStyleSetJustifyContent
local YGNodeStyleSetMargin = Yoga.YGNodeStyleSetMargin
local YGNodeStyleSetMarginAuto = Yoga.YGNodeStyleSetMarginAuto
local YGNodeStyleSetMarginPercent = Yoga.YGNodeStyleSetMarginPercent
local YGNodeStyleSetMaxHeight = Yoga.YGNodeStyleSetMaxHeight
local YGNodeStyleSetMaxHeightPercent = Yoga.YGNodeStyleSetMaxHeightPercent
local YGNodeStyleSetMaxWidth = Yoga.YGNodeStyleSetMaxWidth
local YGNodeStyleSetMaxWidthPercent = Yoga.YGNodeStyleSetMaxWidthPercent
local YGNodeStyleSetMinHeight = Yoga.YGNodeStyleSetMinHeight
local YGNodeStyleSetMinHeightPercent = Yoga.YGNodeStyleSetMinHeightPercent
local YGNodeStyleSetMinWidth = Yoga.YGNodeStyleSetMinWidth
local YGNodeStyleSetMinWidthPercent = Yoga.YGNodeStyleSetMinWidthPercent
local YGNodeStyleSetOverflow = Yoga.YGNodeStyleSetOverflow
local YGNodeStyleSetPadding = Yoga.YGNodeStyleSetPadding
local YGNodeStyleSetPaddingPercent = Yoga.YGNodeStyleSetPaddingPercent
local YGNodeStyleSetPosition = Yoga.YGNodeStyleSetPosition
local YGNodeStyleSetPositionType = Yoga.YGNodeStyleSetPositionType
local YGNodeStyleSetPositionPercent = Yoga.YGNodeStyleSetPositionPercent
local YGNodeStyleSetWidth = Yoga.YGNodeStyleSetWidth
local YGNodeStyleSetWidthAuto = Yoga.YGNodeStyleSetWidthAuto
local YGNodeStyleSetWidthPercent = Yoga.YGNodeStyleSetWidthPercent

local Config = require(PackageRoot.config)
type Config = Config.Config

local Utils = require(PackageRoot.utils)
local FloatSanitize = Utils.FloatSanitize
type Layout = Utils.Layout
type Value = Utils.Value
local Value = Utils.Value

local function fromYGNode(node: YGNode): Node
    return YGNodeGetContext(node)
end

local function fromYGValue(val: YGValue): Value
    return Value.new(val.unit, val.value)
end

local Node = {}
Node.__index = Node

function Node.new(config: Config?)
    local self = setmetatable({}, Node)
    if config then
        self._node = YGNodeNewWithConfig(config._config)
    else
        self._node = YGNodeNew()
    end

    -- TODO Luau: For some reason, passing `self` without any type cast causes the LSP to stop giving analysis (but
    --  doesn't hang or crash).
    YGNodeSetContext(self._node, self :: any)
    return self
end

export type Node = typeof(Node.new(...))

function Node.calculateLayout(self: Node, width: number?, height: number?, direction: YGDirection?)
    YGNodeCalculateLayout(self._node, width :: number, height :: number, direction :: YGDirection)
end

function Node.copyStyle(self: Node, node: YGNode): ()
    YGNodeCopyStyle(self._node, node)
end

function Node.free(self: Node): ()
    YGNodeFree(self._node)
end

function Node.freeRecursive(self: Node): ()
    YGNodeFreeRecursive(self._node)
end

function Node.getAlignContent(self: Node): YGAlign
    return YGNodeStyleGetAlignContent(self._node)
end

function Node.getAlignItems(self: Node): YGAlign
    return YGNodeStyleGetAlignItems(self._node)
end

function Node.getAlignSelf(self: Node): YGAlign
    return YGNodeStyleGetAlignSelf(self._node)
end

function Node.getAspectRatio(self: Node): number
    return YGNodeStyleGetAspectRatio(self._node)
end

function Node.getBorder(self: Node, edge: YGEdge): number
    return YGNodeStyleGetBorder(self._node, edge)
end

function Node.getChild(self: Node, index: number): Node?
    local child = YGNodeGetChild(self._node, index)
    return if child then fromYGNode(child) else nil
end

function Node.getChildCount(self: Node): number
    return YGNodeGetChildCount(self._node)
end

function Node.getComputedBorder(self: Node, edge: YGEdge): number
    return YGNodeLayoutGetBorder(self._node, edge)
end

function Node.getComputedBottom(self: Node): number
    return YGNodeLayoutGetBottom(self._node)
end

function Node.getComputedHeight(self: Node): number
    return FloatSanitize(YGNodeLayoutGetHeight(self._node))
end

function Node.getComputedLayout(self: Node): Layout
    local layout = {}
    layout.left = YGNodeLayoutGetLeft(self._node)
    layout.right = YGNodeLayoutGetRight(self._node)
    layout.top = YGNodeLayoutGetTop(self._node)
    layout.bottom = YGNodeLayoutGetBottom(self._node)
    layout.width = YGNodeLayoutGetWidth(self._node)
    layout.height = YGNodeLayoutGetHeight(self._node)
    return layout
end

function Node.getComputedLeft(self: Node): number
    return FloatSanitize(YGNodeLayoutGetLeft(self._node))
end

function Node.getComputedMargin(self: Node, edge: YGEdge): number
    return FloatSanitize(YGNodeLayoutGetMargin(self._node, edge))
end

function Node.getComputedPadding(self: Node, edge: YGEdge): number
    return FloatSanitize(YGNodeLayoutGetPadding(self._node, edge))
end

function Node.getComputedRight(self: Node): number
    return FloatSanitize(YGNodeLayoutGetRight(self._node))
end

function Node.getComputedTop(self: Node): number
    return FloatSanitize(YGNodeLayoutGetTop(self._node))
end

function Node.getComputedWidth(self: Node): number
    return FloatSanitize(YGNodeLayoutGetWidth(self._node))
end

function Node.getDisplay(self: Node): YGDisplay
    return YGNodeStyleGetDisplay(self._node)
end

function Node.getFlexBasis(self: Node): Value
    return fromYGValue(YGNodeStyleGetFlexBasis(self._node))
end

function Node.getFlexDirection(self: Node): YGFlexDirection
    return YGNodeStyleGetFlexDirection(self._node)
end

function Node.getFlexGrow(self: Node): number
    return YGNodeStyleGetFlexGrow(self._node)
end

function Node.getFlexShrink(self: Node): number
    return YGNodeStyleGetFlexShrink(self._node)
end

function Node.getFlexWrap(self: Node): YGWrap
    return YGNodeStyleGetFlexWrap(self._node)
end

function Node.getHeight(self: Node): Value
    return fromYGValue(YGNodeStyleGetHeight(self._node))
end

function Node.getJustifyContent(self: Node): YGJustify
    return YGNodeStyleGetJustifyContent(self._node)
end

function Node.getMargin(self: Node, edge: YGEdge): Value
    return fromYGValue(YGNodeStyleGetMargin(self._node, edge))
end

function Node.getMaxHeight(self: Node): Value
    return fromYGValue(YGNodeStyleGetMaxHeight(self._node))
end

function Node.getMaxWidth(self: Node): Value
    return fromYGValue(YGNodeStyleGetMaxWidth(self._node))
end

function Node.getMinHeight(self: Node): Value
    return fromYGValue(YGNodeStyleGetMinHeight(self._node))
end

function Node.getMinWidth(self: Node): Value
    return fromYGValue(YGNodeStyleGetMinWidth(self._node))
end

function Node.getOverflow(self: Node): YGOverflow
    return YGNodeStyleGetOverflow(self._node)
end

function Node.getPadding(self: Node, edge: YGEdge): Value
    return fromYGValue(YGNodeStyleGetPadding(self._node, edge))
end

function Node.getParent(self: Node): Node?
    local parent: YGNode = YGNodeGetParent(self._node)
    if not Boolean.toJSBoolean(parent) then
        return nil
    end
    return fromYGNode(parent)
end

function Node.getPosition(self: Node, edge: YGEdge): Value
    return fromYGValue(YGNodeStyleGetPosition(self._node, edge))
end

function Node.getPositionType(self: Node): YGPositionType
    return YGNodeStyleGetPositionType(self._node)
end

function Node.getWidth(self: Node): Value
    return fromYGValue(YGNodeStyleGetWidth(self._node))
end

function Node.getDirtied(self: Node): YGDirtiedFunc
    return YGNodeGetDirtiedFunc(self._node)
end

function Node.insertChild(self: Node, child: Node, index: number): ()
    YGNodeInsertChild(self._node, child._node, index)
end

function Node.isDirty(self: Node): boolean
    return YGNodeIsDirty(self._node)
end

function Node.markDirty(self: Node): ()
    YGNodeMarkDirty(self._node)
end

function Node.removeChild(self: Node, child: Node): ()
    YGNodeRemoveChild(self._node, child._node)
end

function Node.reset(self: Node): ()
    YGNodeReset(self._node)
end

function Node.setAlignContent(self: Node, alignContent: YGAlign): ()
    YGNodeStyleSetAlignContent(self._node, alignContent)
end

function Node.setAlignItems(self: Node, alignItems: YGAlign): ()
    YGNodeStyleSetAlignItems(self._node, alignItems)
end

function Node.setAlignSelf(self: Node, alignSelf: YGAlign): ()
    YGNodeStyleSetAlignSelf(self._node, alignSelf)
end

function Node.setAspectRatio(self: Node, aspectRatio: number): ()
    YGNodeStyleSetAspectRatio(self._node, aspectRatio)
end

function Node.setBorder(self: Node, edge: YGEdge, borderWidth: number): ()
    YGNodeStyleSetBorder(self._node, edge, borderWidth)
end

function Node.setDisplay(self: Node, display: YGDisplay): ()
    YGNodeStyleSetDisplay(self._node, display)
end

function Node.setFlex(self: Node, flex: number): ()
    YGNodeStyleSetFlex(self._node, flex)
end

function Node.setFlexBasis(self: Node, flexBasis: number | string): ()
    if typeof(flexBasis) == "string" then
        if string.sub(flexBasis, #flexBasis, #flexBasis) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setFlexBasisPercent(tonumber(string.sub(flexBasis, 1, #flexBasis - 1)) :: number)
        else
            error(Error.new("Invalid input type"))
        end
    else
        YGNodeStyleSetFlexBasis(self._node, flexBasis :: number)
    end
end

function Node.setFlexBasisAuto(self: Node): ()
    YGNodeStyleSetFlexBasisAuto(self._node)
end

function Node.setFlexBasisPercent(self: Node, flexBasis: number): ()
    YGNodeStyleSetFlexBasisPercent(self._node, flexBasis)
end

function Node.setFlexDirection(self: Node, flexDirection: YGFlexDirection): ()
    YGNodeStyleSetFlexDirection(self._node, flexDirection)
end

function Node.setFlexGrow(self: Node, flexGrow: number): ()
    YGNodeStyleSetFlexGrow(self._node, flexGrow)
end

function Node.setFlexShrink(self: Node, flexShrink: number): ()
    YGNodeStyleSetFlexShrink(self._node, flexShrink)
end

function Node.setFlexWrap(self: Node, flexWrap: YGWrap): ()
    YGNodeStyleSetFlexWrap(self._node, flexWrap)
end

function Node.setHeight(self: Node, height: number | string): ()
    if typeof(height) == "string" then
        if height == "auto" then
            self:setHeightAuto()
        elseif string.sub(height, #height, #height) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setHeightPercent(tonumber(string.sub(height, 1, #height - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetHeight(self._node, height :: number)
    end
end

function Node.setHeightAuto(self: Node): ()
    YGNodeStyleSetHeightAuto(self._node)
end

function Node.setHeightPercent(self: Node, height: number): ()
    YGNodeStyleSetHeightPercent(self._node, height)
end

function Node.setJustifyContent(self: Node, justifyContent: YGJustify): ()
    YGNodeStyleSetJustifyContent(self._node, justifyContent)
end

function Node.setMargin(self: Node, edge: YGEdge, margin: number | string): ()
    if typeof(margin) == "string" then
        if margin == "auto" then
            self:setMarginAuto(edge)
        elseif string.sub(margin, #margin, #margin) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setMarginPercent(edge, tonumber(string.sub(margin, 1, #margin - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetMargin(self._node, edge, margin)
    end
end

function Node.setMarginAuto(self: Node, edge: YGEdge): ()
    YGNodeStyleSetMarginAuto(self._node, edge)
end

function Node.setMarginPercent(self: Node, edge: YGEdge, margin: number): ()
    YGNodeStyleSetMarginPercent(self._node, edge, margin)
end

function Node.setMaxHeight(self: Node, maxHeight: number | string): ()
    if typeof(maxHeight) == "string" then
        if string.sub(maxHeight, #maxHeight, #maxHeight) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setMaxHeightPercent(tonumber(string.sub(maxHeight, 1, #maxHeight - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetMaxHeight(self._node, maxHeight :: number)
    end
end

function Node.setMaxHeightPercent(self: Node, maxHeight: number): ()
    YGNodeStyleSetMaxHeightPercent(self._node, maxHeight)
end

function Node.setMaxWidth(self: Node, maxWidth: number | string): ()
    if typeof(maxWidth) == "string" then
        if string.sub(maxWidth, #maxWidth, #maxWidth) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setMaxWidthPercent(tonumber(string.sub(maxWidth, 1, #maxWidth - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetMaxWidth(self._node, maxWidth :: number)
    end
end

function Node.setMaxWidthPercent(self: Node, maxWidth: number): ()
    YGNodeStyleSetMaxWidthPercent(self._node, maxWidth)
end

function Node.setMeasureFunc(self: Node, measureFunc: any): ()
    if measureFunc == nil then
        self:unsetMeasureFunc()
    else
        YGNodeSetMeasureFunc(self._node, measureFunc)
    end
end

function Node.unsetMeasureFunc(self: Node): ()
    YGNodeSetMeasureFunc(self._node, nil)
end

function Node.setMinHeight(self: Node, minHeight: number | string): ()
    if typeof(minHeight) == "string" then
        if string.sub(minHeight, #minHeight, #minHeight) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setMinHeightPercent(tonumber(string.sub(minHeight, 1, #minHeight - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetMinHeight(self._node, minHeight :: number)
    end
end

function Node.setMinHeightPercent(self: Node, minHeight: number): ()
    YGNodeStyleSetMinHeightPercent(self._node, minHeight)
end

function Node.setMinWidth(self: Node, minWidth: number | string): ()
    if typeof(minWidth) == "string" then
        if string.sub(minWidth, #minWidth, #minWidth) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setMinWidthPercent(tonumber(string.sub(minWidth, 1, #minWidth - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetMinWidth(self._node, minWidth :: number)
    end
end

function Node.setMinWidthPercent(self: Node, minWidth: number): ()
    YGNodeStyleSetMinWidthPercent(self._node, minWidth)
end

function Node.setOverflow(self: Node, overflow: YGOverflow): ()
    YGNodeStyleSetOverflow(self._node, overflow)
end

function Node.setPadding(self: Node, edge: YGEdge, padding: number | string): ()
    if typeof(padding) == "string" then
        if string.sub(padding, #padding, #padding) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setPaddingPercent(edge, tonumber(string.sub(padding, 1, #padding - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetPadding(self._node, edge, padding :: number)
    end
end

function Node.setPaddingPercent(self: Node, edge: YGEdge, padding: number): ()
    YGNodeStyleSetPaddingPercent(self._node, edge, padding)
end

function Node.setPosition(self: Node, edge: YGEdge, position: number | string): ()
    if typeof(position) == "string" then
        if string.sub(position, #position, #position) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setPositionPercent(edge, tonumber(string.sub(position, 1, #position - 1)) :: any)
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetPosition(self._node, edge, position :: number)
    end
end

function Node.setPositionPercent(self: Node, edge: YGEdge, position: number): ()
    YGNodeStyleSetPositionPercent(self._node, edge, position)
end

function Node.setPositionType(self: Node, positionType: YGPositionType): ()
    YGNodeStyleSetPositionType(self._node, positionType)
end

function Node.setWidth(self: Node, width: number | string): ()
    if typeof(width) == "string" then
        if string.sub(width, #width, #width) == "%" then
            -- TODO: Should this be made into a runtime assertion? It's technically possible to pass a bad value.
            self:setWidthPercent(tonumber(string.sub(width, 1, #width - 1)) :: any)
        elseif width == "auto" then
            self:setWidthAuto()
        else
            error(Error.new("Invalid input type."))
        end
    else
        YGNodeStyleSetWidth(self._node, width :: number)
    end
end

function Node.setWidthAuto(self: Node): ()
    YGNodeStyleSetWidthAuto(self._node)
end

function Node.setWidthPercent(self: Node, width: number): ()
    YGNodeStyleSetWidthPercent(self._node, width)
end

function Node.setDirtiedFunc(self: Node, dirtiedFunc: YGDirtiedFunc): ()
    return YGNodeSetDirtiedFunc(self._node, dirtiedFunc)
end

function Node.unsetMeasureFun(self: Node): ()
    YGNodeSetMeasureFunc(self._node, nil)
end

function Node.isReferenceBaseline(self: Node): boolean
    return YGNodeIsReferenceBaseline(self._node)
end

function Node.setIsReferenceBaseline(self: Node, isReferenceBaseline: boolean): ()
    YGNodeSetIsReferenceBaseline(self._node, isReferenceBaseline)
end

return {
    new = Node.new,
}
