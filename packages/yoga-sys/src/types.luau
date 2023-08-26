-- note: no upstream

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

-- note: Majority of types pulled here to help avoid cyclic dependencies

type Array<T> = { T }

local Enums = require(script.Parent.enums)
type YGFlexDirection = Enums.YGFlexDirection
type YGDirection = Enums.YGDirection
type YGNodeType = Enums.YGNodeType
type YGUnit = Enums.YGUnit
type YGEdge = Enums.YGEdge
type YGDimension = Enums.YGDimension
type YGPositionType = Enums.YGPositionType
type YGAlign = Enums.YGAlign
type YGMeasureMode = Enums.YGMeasureMode
type YGLogLevel = Enums.YGLogLevel
type YGJustify = Enums.YGJustify
type YGWrap = Enums.YGWrap
type YGOverflow = Enums.YGOverflow
type YGDisplay = Enums.YGDisplay

export type YGSize = { width: number, height: number }

-- deviation: contextFn cannot be optional.
export type YGPrintFunc = (node: YGNode, contextFn: any) -> ()

-- deviation: contextFn cannot be optional.
export type YGMeasureFunc = (
    node: YGNode,
    width: number,
    widthMode: YGMeasureMode,
    height: number,
    heightMode: YGMeasureMode,
    contextFn: any
) -> YGSize

export type YGBaselineFunc = (node: YGNode, width: number, height: number, contextFn: any) -> number
export type YGDirtiedFunc = (node: YGNode) -> ()
export type YGLogger = (config: YGConfig, node: YGNode, level: YGLogLevel, format: string, ...any) -> ()
export type YGCloneNodeFunc = (oldNode: YGNode, owner: YGNode, childIndex: number, cloneContext: any) -> YGNode
export type YGNodeCleanupFunc = (node: YGNode) -> ()

export type YGCachedMeasurement = {
    availableWidth: number,
    availableHeight: number,
    widthMeasureMode: YGMeasureMode,
    heightMeasureMode: YGMeasureMode,
    computedWidth: number,
    computedHeight: number,
}

export type YGFloatOptional = {
    value_: number,
    isUndefined_: boolean,
    new: (value: (number | YGFloatOptional)?) -> YGFloatOptional,
    unwrap: (self: YGFloatOptional) -> number,
    clone: (self: YGFloatOptional) -> YGFloatOptional,
    getValue: (self: YGFloatOptional) -> number,
    setValue: (self: YGFloatOptional, value: number) -> (),
    isUndefined: (self: YGFloatOptional) -> boolean,
    add: (self: YGFloatOptional, op: YGFloatOptional) -> YGFloatOptional,
    isBigger: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isSmaller: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isBiggerEqual: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isSmallerEqual: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isEqual: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isDiff: (self: YGFloatOptional, op: YGFloatOptional) -> boolean,
    isEqualValue: (self: YGFloatOptional, val: number) -> boolean,
    isDiffValue: (self: YGFloatOptional, val: number) -> boolean,
}

export type YGStyle = {
    direction: YGDirection,
    flexDirection: YGFlexDirection,
    justifyContent: YGJustify,
    alignContent: YGAlign,
    alignItems: YGAlign,
    alignSelf: YGAlign,
    positionType: YGPositionType,
    flexWrap: YGWrap,
    overflow: YGOverflow,
    display: YGDisplay,
    flex: YGFloatOptional,
    flexGrow: YGFloatOptional,
    flexShrink: YGFloatOptional,
    flexBasis: YGValue,
    margin: Array<YGValue>,
    position: Array<YGValue>,
    padding: Array<YGValue>,
    border: Array<YGValue>,
    dimensions: Array<YGValue>,
    minDimensions: Array<YGValue>,
    maxDimensions: Array<YGValue>,
    aspectRatio: YGFloatOptional,
    new: () -> YGStyle,
    isEqual: (self: YGStyle, style: YGStyle) -> boolean,
    isDiff: (self: YGStyle, style: YGStyle) -> boolean,
    clone: (self: YGStyle) -> YGStyle,
}

export type YGValue = {
    value: number,
    unit: YGUnit,
    new: (value: number, unit: YGUnit) -> YGValue,
    eq: (self: YGValue, value: YGValue) -> boolean,
    neq: (self: YGValue, value: YGValue) -> boolean,
    subtract: (self: YGValue, value: YGValue) -> YGValue,
    clone: (self: YGValue) -> YGValue,
    isUndefined: (self: YGValue) -> boolean,
}

export type YGConfig = {
    experimentalFeatures: Array<boolean>,
    useWebDefaults: boolean,
    useLegacyStretchBehaviour: boolean,
    shouldDiffLayoutWithoutLegacyStretchBehaviour: boolean,
    printTree: boolean,
    pointScaleFactor: number,
    logger: YGLogger,
    cloneNodeCallback: YGCloneNodeFunc,
    context: any,
    new: (logger: YGLogger) -> YGConfig,
    log: (
        self: YGConfig,
        config: YGConfig,
        node: YGNode,
        logLevel: YGLogLevel,
        logContext: any,
        format: string,
        ...any
    ) -> (),
    cloneNode: (self: YGConfig, node: YGNode, owner: YGNode, childIndex: number, cloneContext: any?) -> YGNode,
    setLogger: (self: YGConfig, logger: YGLogger?) -> (),
    setCloneNodeCallback: (self: YGConfig, cloneNode: YGCloneNodeFunc?) -> (),
}

export type YGLayout = {
    position: Array<number>,
    dimensions: Array<number>,
    margin: Array<number>,
    border: Array<number>,
    padding: Array<number>,
    direction: YGDirection,

    computedFlexBasisGeneration: number,
    computedFlexBasis: YGFloatOptional,
    hadOverflow: boolean,

    generationCount: number,
    lastOwnerDirection: YGDirection,

    nextCachedMeasurementsIndex: number,
    cachedMeasurements: Array<YGCachedMeasurement>,
    measuredDimensions: Array<number>,

    cachedLayout: YGCachedMeasurement,
    didUseLegacyFlag: boolean,
    doesLegacyStretchFlagAffectsLayout: boolean,

    new: () -> YGLayout,
    getDirection: (self: YGLayout) -> YGDirection,
    setDirection: (self: YGLayout, direction: YGDirection) -> (),
    getDidUseLegacyFlag: (self: YGLayout) -> boolean,
    setDidUseLegacyFlag: (self: YGLayout, val: boolean) -> (),
    getDoesLegacyStretchFlagAffectsLayout: (self: YGLayout) -> boolean,
    setDoesLegacyStretchFlagAffectsLayout: (self: YGLayout, val: boolean) -> (),
    getHadOverflow: (self: YGLayout) -> boolean,
    setHadOverflow: (self: YGLayout, hadOverflow: boolean) -> (),
    equal: (self: YGLayout, layout: YGLayout) -> boolean,
    diff: (self: YGLayout, layout: YGLayout) -> boolean,
    clean: (self: YGLayout) -> (),
    clone: (self: YGLayout) -> YGLayout,
}

export type IterChildrenCallback = (node: YGNode, cloneContext: any) -> ()

export type YGNode = {
    context_: any,
    print_: YGPrintFunc,
    hasNewLayout_: boolean,
    isReferenceBaseline_: boolean,
    nodeType_: YGNodeType,
    measure_: YGMeasureFunc,
    baseline_: YGBaselineFunc,
    dirtied_: YGDirtiedFunc,
    style_: YGStyle,
    layout_: YGLayout,
    lineIndex_: number,
    owner_: YGNode,
    children_: Array<YGNode>,
    config_: YGConfig?,
    isDirty_: boolean,
    resolvedDimensions_: Array<YGValue>,

    new: (
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
    ) -> YGNode,
    initialize: (
        self: YGNode,
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
    ) -> (),
    operatorAtrib: (self: YGNode, node: YGNode) -> YGNode,
    fromNode: (self: YGNode, node: YGNode) -> (),
    print: (self: YGNode, printContext: any?) -> (),
    computeEdgeValueForRow: (
        self: YGNode,
        edges: Array<YGValue>,
        rowEdge: YGEdge,
        edge: YGEdge,
        defaultValue: YGValue
    ) -> YGValue,
    computeEdgeValueForColumn: (self: YGNode, edges: Array<YGValue>, edge: YGEdge, defaultValue: YGValue) -> YGValue,
    measure: (
        self: YGNode,
        width: number,
        widthMode: YGMeasureMode,
        height: number,
        heightMode: YGMeasureMode,
        layoutContext: any?
    ) -> YGSize,
    baseline: (self: YGNode, width: number, height: number, layoutContext: any?) -> number,
    useWebDefaults: (self: YGNode) -> (),
    hasMeasureFunc: (self: YGNode) -> boolean,
    hasBaselineFunc: (self: YGNode) -> boolean,
    getContext: (self: YGNode) -> any,
    getHasNewLayout: (self: YGNode) -> boolean,
    getNodeType: (self: YGNode) -> YGNodeType,
    getDirtied: (self: YGNode) -> YGDirtiedFunc,
    getStyle: (self: YGNode) -> YGStyle,
    getLayout: (self: YGNode) -> YGLayout,
    getLineIndex: (self: YGNode) -> number,
    isReferenceBaseline: (self: YGNode) -> boolean,
    getOwner: (self: YGNode) -> YGNode,
    getParent: (self: YGNode) -> YGNode,
    getChildren: (self: YGNode) -> Array<YGNode>,
    getChildrenCount: (self: YGNode) -> number,
    getChild: (self: YGNode, index: number) -> YGNode,
    getConfig: (self: YGNode) -> YGConfig,
    isDirty: (self: YGNode) -> boolean,
    getResolvedDimensions: (self: YGNode) -> Array<YGValue>,
    getResolvedDimension: (self: YGNode, index: number) -> YGValue,
    getLeadingPosition: (self: YGNode, axis: YGFlexDirection, axisSize: number) -> YGFloatOptional,
    isLeadingPositionDefined: (self: YGNode, axis: YGFlexDirection) -> boolean,
    isTrailingPosDefined: (self: YGNode, axis: YGFlexDirection) -> boolean,
    getTrailingPosition: (self: YGNode, axis: YGFlexDirection, axisSize: number) -> YGFloatOptional,
    getLeadingMargin: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getTrailingMargin: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getLeadingBorder: (self: YGNode, axis: YGFlexDirection) -> number,
    getTrailingBorder: (self: YGNode, axis: YGFlexDirection) -> number,
    getLeadingPadding: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getTrailingPadding: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getLeadingPaddingAndBorder: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getTrailingPaddingAndBorder: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    getMarginForAxis: (self: YGNode, axis: YGFlexDirection, widthSize: number) -> YGFloatOptional,
    setContext: (self: YGNode, context: any) -> (),
    setPrintFunc: (self: YGNode, printFunc: YGPrintFunc) -> (),
    setHasNewLayout: (self: YGNode, hasNewLayout: boolean) -> (),
    setNodeType: (self: YGNode, nodeType: YGNodeType) -> (),
    setMeasureFunc: (self: YGNode, measureFunc: YGMeasureFunc) -> (),
    setBaseLineFunc: (self: YGNode, baseLineFunc: YGBaselineFunc) -> (),
    setDirtiedFunc: (self: YGNode, dirtiedFunc: YGDirtiedFunc) -> (),
    setStyle: (self: YGNode, style: YGStyle) -> (),
    setStyleFlexDirection: (self: YGNode, direction: YGFlexDirection) -> (),
    setStyleAlignContent: (self: YGNode, alignContent: YGAlign) -> (),
    setLayout: (self: YGNode, layout: YGLayout) -> (),
    setLineIndex: (self: YGNode, lineIndex: number) -> (),
    setIsReferenceBaseline: (self: YGNode, isReferenceBaseline: boolean) -> (),
    setOwner: (self: YGNode, owner: YGNode?) -> (),
    setChildren: (self: YGNode, children: Array<YGNode>) -> (),
    setConfig: (self: YGNode, config: YGConfig?) -> (),
    setDirty: (self: YGNode, isDirty: boolean) -> (),
    setLayoutLastOwnerDirection: (self: YGNode, direction: YGDirection) -> (),
    setLayoutComputedFlexBasis: (self: YGNode, computedFlexBasis: YGFloatOptional) -> (),
    setLayoutComputedFlexBasisGeneration: (self: YGNode, computedFlexBasisGeneration: number) -> (),
    setLayoutMeasuredDimension: (self: YGNode, measuredDimension: number, index: number) -> (),
    setLayoutHadOverflow: (self: YGNode, hadOverflow: boolean) -> (),
    setLayoutDimension: (self: YGNode, dimension: number, index: number) -> (),
    setLayoutDirection: (self: YGNode, direction: YGDirection) -> (),
    setLayoutMargin: (self: YGNode, margin: number, index: number) -> (),
    setLayoutBorder: (self: YGNode, border: number, index: number) -> (),
    setLayoutPadding: (self: YGNode, padding: number, index: number) -> (),
    setLayoutPosition: (self: YGNode, position: number, index: number) -> (),
    setPosition: (self: YGNode, direction: YGDirection, mainSize: number, crossSize: number, ownerWidth: number) -> (),
    setLayoutDoesLegacyFlagAffectsLayout: (self: YGNode, doesLegacyFlagAffectsLayout: boolean) -> (),
    setLayoutDidUseLegacyFlag: (self: YGNode, didUseLegacyFlag: boolean) -> (),
    markDirtyAndPropogateDownwards: (self: YGNode) -> (),
    marginLeadingValue: (self: YGNode, axis: YGFlexDirection) -> YGValue,
    marginTrailingValue: (self: YGNode, axis: YGFlexDirection) -> YGValue,
    resolveFlexBasisPtr: (self: YGNode) -> YGValue,
    resolveDimension: (self: YGNode) -> (),
    resolveDirection: (self: YGNode, ownerDirection: YGDirection) -> YGDirection,
    clearChildren: (self: YGNode) -> (),
    replaceChild: (self: YGNode, oldChild: YGNode, newChild: YGNode) -> (),
    replaceChildIndex: (self: YGNode, child: YGNode, index: number) -> (),
    insertChildIndex: (self: YGNode, child: YGNode, index: number) -> (),
    removeChild: (self: YGNode, child: YGNode) -> boolean,
    removeChildIndex: (self: YGNode, index: number) -> (),
    iterChildrenAfterCloningIfNeeded: (self: YGNode, callback: IterChildrenCallback, cloneContext: any) -> (),
    cloneChildrenIfNeeded: (self: YGNode, cloneContext: any?) -> (),
    markDirtyAndPropogate: (self: YGNode) -> (),
    resolveFlexGrow: (self: YGNode) -> number,
    resolveFlexShrink: (self: YGNode) -> number,
    isNodeFlexible: (self: YGNode) -> boolean,
    didUseLegacyFlag: (self: YGNode) -> boolean,
    isLayoutTreeEqualToNode: (self: YGNode, node: YGNode) -> boolean,
    reset: (self: YGNode) -> (),
}

return nil
