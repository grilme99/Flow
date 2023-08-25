-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/enums.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGEnums.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGEnums.cpp

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

local Enums = {}

local YGAlignCount = 8
Enums.YGAlignCount = YGAlignCount

local YGAlign = table.freeze({
    Auto = 1,
    FlexStart = 2,
    Center = 3,
    FlexEnd = 4,
    Stretch = 5,
    Baseline = 6,
    SpaceBetween = 7,
    SpaceAround = 8,
})
export type YGAlign = number
Enums.YGAlign = YGAlign

local function YGAlignToString(value: YGAlign): string
    if value == YGAlign.Auto then
        return "auto"
    elseif value == YGAlign.FlexStart then
        return "flex-start"
    elseif value == YGAlign.Center then
        return "center"
    elseif value == YGAlign.FlexEnd then
        return "flex-end"
    elseif value == YGAlign.Stretch then
        return "stretch"
    elseif value == YGAlign.Baseline then
        return "baseline"
    elseif value == YGAlign.SpaceBetween then
        return "space-between"
    elseif value == YGAlign.SpaceAround then
        return "space-around"
    end

    return "unknown"
end
Enums.YGAlignToString = YGAlignToString

local YGDimensionCount = 2
Enums.YGDimensionCount = YGDimensionCount

local YGDimension = table.freeze({
    Width = 1,
    Height = 2,
})
export type YGDimension = number
Enums.YGDimension = YGDimension

local function YGDimensionToString(value: YGDimension): string
    if value == YGDimension.Width then
        return "width"
    elseif value == YGDimension.Height then
        return "height"
    end

    return "unknown"
end
Enums.YGDimensionToString = YGDimensionToString

local YGDirection = table.freeze({
    Inherit = 1,
    LTR = 2,
    RTL = 3,
})
export type YGDirection = number
Enums.YGDirection = YGDirection

local function YGDirectionToString(value: YGDirection): string
    if value == YGDirection.Inherit then
        return "inherit"
    elseif value == YGDirection.LTR then
        return "ltr"
    elseif value == YGDirection.RTL then
        return "rtl"
    end

    return "unknown"
end
Enums.YGDirectionToString = YGDirectionToString

local YGDisplayCount = 2
Enums.YGDisplayCount = YGDisplayCount

local YGDisplay = table.freeze({
    Flex = 1,
    None = 2,
})
export type YGDisplay = number
Enums.YGDisplay = YGDisplay

local function YGDisplayToString(value: YGDisplay): string
    if value == YGDisplay.Flex then
        return "flex"
    elseif value == YGDisplay.None then
        return "none"
    end

    return "unknown"
end
Enums.YGDisplayToString = YGDisplayToString

local YGEdgeCount = 9
Enums.YGEdgeCount = YGEdgeCount

local YGEdge = table.freeze({
    Left = 1,
    Top = 2,
    Right = 3,
    Bottom = 4,
    Start = 5,
    End = 6,
    Horizontal = 7,
    Vertical = 8,
    All = 9,
})
export type YGEdge = number
Enums.YGEdge = YGEdge

local function YGEdgeToString(value: YGEdge): string
    if value == YGEdge.Left then
        return "left"
    elseif value == YGEdge.Top then
        return "top"
    elseif value == YGEdge.Right then
        return "right"
    elseif value == YGEdge.Bottom then
        return "bottom"
    elseif value == YGEdge.Start then
        return "start"
    elseif value == YGEdge.End then
        return "end"
    elseif value == YGEdge.Horizontal then
        return "horizontal"
    elseif value == YGEdge.Vertical then
        return "vertical"
    elseif value == YGEdge.All then
        return "all"
    end

    return "unknown"
end
Enums.YGEdgeToString = YGEdgeToString

local YGExperimentalFeatureCount = 1
Enums.YGExperimentalFeatureCount = YGExperimentalFeatureCount

local YGExperimentalFeature = table.freeze({
    WebFlexBasis = 1,
})
export type YGExperimentalFeature = number
Enums.YGExperimentalFeature = YGExperimentalFeature

local function YGExperimentalFeatureToString(value: YGExperimentalFeature): string
    if value == YGExperimentalFeature.WebFlexBasis then
        return "web-flex-basis"
    end

    return "unknown"
end
Enums.YGExperimentalFeatureToString = YGExperimentalFeatureToString

local YGFlexDirectionCount = 4
Enums.YGFlexDirectionCount = YGFlexDirectionCount

local YGFlexDirection = table.freeze({
    Column = 1,
    ColumnReverse = 2,
    Row = 3,
    RowReverse = 4,
})
export type YGFlexDirection = number
Enums.YGFlexDirection = YGFlexDirection

local function YGFlexDirectionToString(value: YGFlexDirection): string
    if value == YGFlexDirection.Column then
        return "column"
    elseif value == YGFlexDirection.ColumnReverse then
        return "column-reverse"
    elseif value == YGFlexDirection.Row then
        return "row"
    elseif value == YGFlexDirection.RowReverse then
        return "row-reverse"
    end

    return "unknown"
end
Enums.YGFlexDirectionToString = YGFlexDirectionToString

local YGJustifyCount = 6
Enums.YGJustifyCount = YGJustifyCount

local YGJustify = table.freeze({
    FlexStart = 1,
    Center = 2,
    FlexEnd = 3,
    SpaceBetween = 4,
    SpaceAround = 5,
    SpaceEvenly = 6,
})
export type YGJustify = number
Enums.YGJustify = YGJustify

local function YGJustifyToString(value: YGJustify): string
    if value == YGJustify.FlexStart then
        return "flex-start"
    elseif value == YGJustify.Center then
        return "center"
    elseif value == YGJustify.FlexEnd then
        return "flex-end"
    elseif value == YGJustify.SpaceBetween then
        return "space-between"
    elseif value == YGJustify.SpaceAround then
        return "space-around"
    elseif value == YGJustify.SpaceEvenly then
        return "space-evenly"
    end

    return "unknown"
end
Enums.YGJustifyToString = YGJustifyToString

local YGLogLevelCount = 6
Enums.YGLogLevelCount = YGLogLevelCount

local YGLogLevel = table.freeze({
    Error = 1,
    Warn = 2,
    Info = 3,
    Debug = 4,
    Verbose = 5,
    Fatal = 6,
})
export type YGLogLevel = number
Enums.YGLogLevel = YGLogLevel

local function YGLogLevelToString(value: YGLogLevel): string
    if value == YGLogLevel.Error then
        return "error"
    elseif value == YGLogLevel.Warn then
        return "warn"
    elseif value == YGLogLevel.Info then
        return "info"
    elseif value == YGLogLevel.Debug then
        return "debug"
    elseif value == YGLogLevel.Verbose then
        return "verbose"
    elseif value == YGLogLevel.Fatal then
        return "fatal"
    end

    return "unknown"
end
Enums.YGLogLevelToString = YGLogLevelToString

local YGMeasureModeCount = 3
Enums.YGMeasureModeCount = YGMeasureModeCount

local YGMeasureMode = table.freeze({
    Undefined = 1,
    Exactly = 2,
    AtMost = 3,
})
export type YGMeasureMode = number
Enums.YGMeasureMode = YGMeasureMode

local function YGMeasureModeToString(value: YGMeasureMode): string
    if value == YGMeasureMode.Undefined then
        return "undefined"
    elseif value == YGMeasureMode.Exactly then
        return "exactly"
    elseif value == YGMeasureMode.AtMost then
        return "at-most"
    end

    return "unknown"
end
Enums.YGMeasureModeToString = YGMeasureModeToString

local YGNodeTypeCount = 2
Enums.YGNodeTypeCount = YGNodeTypeCount

local YGNodeType = table.freeze({
    Default = 1,
    Text = 2,
})
export type YGNodeType = number
Enums.YGNodeType = YGNodeType

local function YGNodeTypeToString(value: YGNodeType): string
    if value == YGNodeType.Default then
        return "default"
    elseif value == YGNodeType.Text then
        return "text"
    end

    return "unknown"
end
Enums.YGNodeTypeToString = YGNodeTypeToString

local YGOverflowCount = 3
Enums.YGOverflowCount = YGOverflowCount

local YGOverflow = table.freeze({
    Visible = 1,
    Hidden = 2,
    Scroll = 3,
})
export type YGOverflow = number
Enums.YGOverflow = YGOverflow

local function YGOverflowToString(value: YGOverflow): string
    if value == YGOverflow.Visible then
        return "visible"
    elseif value == YGOverflow.Hidden then
        return "hidden"
    elseif value == YGOverflow.Scroll then
        return "scroll"
    end

    return "unknown"
end
Enums.YGOverflowToString = YGOverflowToString

local YGPositionTypeCount = 2
Enums.YGPositionTypeCount = YGPositionTypeCount

local YGPositionType = table.freeze({
    Static = 1,
    Relative = 2,
    Absolute = 3,
})
export type YGPositionType = number
Enums.YGPositionType = YGPositionType

local function YGPositionTypeToString(value: YGPositionType): string
    if value == YGPositionType.Static then
        return "static"
    elseif value == YGPositionType.Relative then
        return "relative"
    elseif value == YGPositionType.Absolute then
        return "absolute"
    end

    return "unknown"
end
Enums.YGPositionTypeToString = YGPositionTypeToString

local YGPrintOptionsCount = 3
Enums.YGPrintOptionsCount = YGPrintOptionsCount

local YGPrintOptions = table.freeze({
    Layout = 1,
    Style = 2,
    Children = 4,
})
export type YGPrintOptions = number
Enums.YGPrintOptions = YGPrintOptions

local function YGPrintOptionsToString(value: YGPrintOptions): string
    if value == YGPrintOptions.Layout then
        return "layout"
    elseif value == YGPrintOptions.Style then
        return "style"
    elseif value == YGPrintOptions.Children then
        return "children"
    end

    return "unknown"
end
Enums.YGPrintOptionsToString = YGPrintOptionsToString

local YGUnitCount = 4
Enums.YGUnitCount = YGUnitCount

local YGUnit = table.freeze({
    Undefined = 1,
    Point = 2,
    Percent = 3,
    Auto = 4,
})
export type YGUnit = number
Enums.YGUnit = YGUnit

local function YGUnitToString(value: YGUnit): string
    if value == YGUnit.Undefined then
        return "undefined"
    elseif value == YGUnit.Point then
        return "point"
    elseif value == YGUnit.Percent then
        return "percent"
    elseif value == YGUnit.Auto then
        return "auto"
    end

    return "unknown"
end
Enums.YGUnitToString = YGUnitToString

local YGWrapCount = 3
Enums.YGWrapCount = YGWrapCount

local YGWrap = table.freeze({
    NoWrap = 1,
    Wrap = 2,
    WrapReverse = 3,
})
export type YGWrap = number
Enums.YGWrap = YGWrap

local function YGWrapToString(value: YGWrap): string
    if value == YGWrap.NoWrap then
        return "no-wrap"
    elseif value == YGWrap.Wrap then
        return "wrap"
    elseif value == YGWrap.WrapReverse then
        return "wrap-reverse"
    end

    return "unknown"
end
Enums.YGWrapToString = YGWrapToString

return Enums
