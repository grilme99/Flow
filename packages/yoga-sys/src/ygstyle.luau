-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/ygstyle.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGStyle.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGStyle.cpp

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

local Enums = require(PackageRoot.enums)
local YGDirection = Enums.YGDirection
type YGDirection = Enums.YGDirection
local YGFlexDirection = Enums.YGFlexDirection
type YGFlexDirection = Enums.YGFlexDirection
local YGPositionType = Enums.YGPositionType
type YGPositionType = Enums.YGPositionType
local YGJustify = Enums.YGJustify
type YGJustify = Enums.YGJustify
local YGAlign = Enums.YGAlign
type YGAlign = Enums.YGAlign
local YGWrap = Enums.YGWrap
type YGWrap = Enums.YGWrap
local YGOverflow = Enums.YGOverflow
type YGOverflow = Enums.YGOverflow
local YGDisplay = Enums.YGDisplay
type YGDisplay = Enums.YGDisplay
local YGUnit = Enums.YGUnit
type YGUnit = Enums.YGUnit

local Utils = require(PackageRoot.utils)
local YGValueEqual = Utils.YGValueEqual
local YGValueArrayEqual = Utils.YGValueArrayEqual
local cloneYGValueArray = Utils.cloneYGValueArray

local ygValueModule = require(PackageRoot.ygvalue)
local YGValue = ygValueModule.YGValue
local YGFloatOptional = require(PackageRoot.ygfloatoptional)

local Types = require(PackageRoot.types)
type YGStyle = Types.YGStyle
type YGValue = Types.YGValue
type YGFloatOptional = Types.YGFloatOptional

local kYGValueUndefined: () -> YGValue = function()
    return YGValue.new(0, YGUnit.Undefined)
end

local kYGValueAuto: () -> YGValue = function()
    return YGValue.new(0, YGUnit.Auto)
end

local kYGDefaultEdgeValuesUnit: () -> Array<YGValue> = function()
    return {
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
        kYGValueUndefined(),
    }
end

local kYGDefaultDimensionValuesAutoUnit: () -> Array<YGValue> = function()
    return { kYGValueAuto(), kYGValueAuto() }
end

local kYGDefaultDimensionValuesUnit: () -> Array<YGValue> = function()
    return { kYGValueUndefined(), kYGValueUndefined() }
end

type Array<T> = { T }

local YGStyle = {}
YGStyle.__index = YGStyle

function YGStyle.new(): YGStyle
    local self = setmetatable({}, YGStyle)

    self.direction = YGDirection.Inherit
    self.flexDirection = YGFlexDirection.Column
    self.justifyContent = YGJustify.FlexStart
    self.alignContent = YGAlign.FlexStart
    self.alignItems = YGAlign.Stretch
    self.alignSelf = YGAlign.Auto
    self.positionType = YGPositionType.Relative
    self.flexWrap = YGWrap.NoWrap
    self.overflow = YGOverflow.Visible
    self.display = YGDisplay.Flex
    self.flex = YGFloatOptional.new()
    self.flexGrow = YGFloatOptional.new()
    self.flexShrink = YGFloatOptional.new()
    self.flexBasis = kYGValueAuto()
    self.margin = kYGDefaultEdgeValuesUnit()
    self.position = kYGDefaultEdgeValuesUnit()
    self.padding = kYGDefaultEdgeValuesUnit()
    self.border = kYGDefaultEdgeValuesUnit()
    self.dimensions = kYGDefaultDimensionValuesAutoUnit()
    self.minDimensions = kYGDefaultDimensionValuesUnit()
    self.maxDimensions = kYGDefaultDimensionValuesUnit()
    self.aspectRatio = YGFloatOptional.new()

    return (self :: any) :: YGStyle
end

function YGStyle:isEqual(style: YGStyle): boolean
    local areNonFloatValuesEqual: boolean = self.direction == style.direction
        and self.flexDirection == style.flexDirection
        and self.justifyContent == style.justifyContent
        and self.alignContent == style.alignContent
        and self.alignitems == style.alignItems
        and self.alignSelf == style.alignSelf
        and self.positionType == style.positionType
        and self.flexWrap == style.flexWrap
        and self.overflow == style.overflow
        and self.display == style.display
        and YGValueEqual(self.flexBasis, style.flexBasis)
        and YGValueArrayEqual(self.margin, style.margin)
        and YGValueArrayEqual(self.position, style.position)
        and YGValueArrayEqual(self.padding, style.padding)
        and YGValueArrayEqual(self.border, style.border)
        and YGValueArrayEqual(self.dimensions, style.dimensions)
        and YGValueArrayEqual(self.minDimensions, style.minDimensions)
        and YGValueArrayEqual(self.maxDimensions, style.maxDimensions)

    areNonFloatValuesEqual = areNonFloatValuesEqual and self.flex:isUndefined() == style.flex:isUndefined()
    if areNonFloatValuesEqual and not self.flex:isUndefined() and not style.flex:isUndefined() then
        areNonFloatValuesEqual = areNonFloatValuesEqual and self.flex:getValue() == style.flex:getValue()
    end

    areNonFloatValuesEqual = areNonFloatValuesEqual and self.flexGrow:isUndefined() == style.flexGrow:isUndefined()
    if areNonFloatValuesEqual and not self.flexGrow:isUndefined() then
        areNonFloatValuesEqual = areNonFloatValuesEqual and self.flexGrow:getValue() == style.flexGrow:getValue()
    end

    areNonFloatValuesEqual = areNonFloatValuesEqual and self.flexShrink:isUndefined() == style.flexShrink:isUndefined()
    if areNonFloatValuesEqual and not style.flexShrink:isUndefined() then
        areNonFloatValuesEqual = areNonFloatValuesEqual and self.flexShrink:getValue() == style.flexShrink:getValue()
    end

    if not (self.aspectRatio:isUndefined() and style.aspectRatio:isUndefined()) then
        areNonFloatValuesEqual = areNonFloatValuesEqual and self.aspectRatio:getValue() == style.aspectRatio:getValue()
    end

    return areNonFloatValuesEqual
end

function YGStyle:isDiff(style: YGStyle): boolean
    return not self:isEqual(style)
end

function YGStyle:clone(): YGStyle
    local newStyle: YGStyle = YGStyle.new()

    newStyle.direction = self.direction
    newStyle.flexDirection = self.flexDirection
    newStyle.justifyContent = self.justifyContent
    newStyle.alignContent = self.alignContent
    newStyle.alignItems = self.alignItems
    newStyle.alignSelf = self.alignSelf
    newStyle.positionType = self.positionType
    newStyle.flexWrap = self.flexWrap
    newStyle.overflow = self.overflow
    newStyle.display = self.display
    newStyle.flex = self.flex:clone()
    newStyle.flexGrow = self.flexGrow:clone()
    newStyle.flexShrink = self.flexShrink:clone()
    newStyle.flexBasis = self.flexBasis:clone()
    newStyle.margin = cloneYGValueArray(self.margin)
    newStyle.position = cloneYGValueArray(self.position)
    newStyle.padding = cloneYGValueArray(self.padding)
    newStyle.border = cloneYGValueArray(self.border)
    newStyle.dimensions = { self.dimensions[1]:clone(), self.dimensions[2]:clone() }
    newStyle.minDimensions = { self.minDimensions[1]:clone(), self.minDimensions[2]:clone() }
    newStyle.maxDimensions = { self.maxDimensions[1]:clone(), self.maxDimensions[2]:clone() }
    newStyle.aspectRatio = self.aspectRatio:clone()

    return newStyle
end

return YGStyle
