-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/internal.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/Yoga-internal.h

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

type Array<T> = { T }

local Enums = require(PackageRoot.enums)
local YGMeasureMode = Enums.YGMeasureMode
type YGMeasureMode = Enums.YGMeasureMode
local YGEdge = Enums.YGEdge
type YGEdge = Enums.YGEdge
local YGDimension = Enums.YGDimension
type YGDimension = Enums.YGDimension

local Utils = require(PackageRoot.utils)
local YGFloatIsUndefined = Utils.YGFloatIsUndefined

local Types = require(PackageRoot.types)
type YGCachedMeasurement = Types.YGCachedMeasurement

local Internal = {}

local YGCachedMeasurement = {}
YGCachedMeasurement.__index = YGCachedMeasurement

function YGCachedMeasurement.new(): YGCachedMeasurement
    local self = setmetatable({}, YGCachedMeasurement)
    self.availableWidth = 0
    self.availableHeight = 0
    self.widthMeasureMode = YGMeasureMode.Undefined
    self.heightMeasureMode = YGMeasureMode.Undefined
    self.computedWidth = -1
    self.computedHeight = -1
    return (self :: any) :: YGCachedMeasurement
end

function YGCachedMeasurement:isEqual(measurement: YGCachedMeasurement): boolean
    local isEqual = self.widthMeasureMode == measurement.widthMeasureMode
        and self.heightMeasureMode == measurement.heightMeasureMode

    if not YGFloatIsUndefined(self.availableWidth) or not YGFloatIsUndefined(measurement.availableWidth) then
        isEqual = isEqual and self.availableWidth == measurement.availableWidth
    end

    if not YGFloatIsUndefined(self.availableHeight) or not YGFloatIsUndefined(measurement.availableHeight) then
        isEqual = isEqual and self.availableHeight == measurement.availableHeight
    end

    if not YGFloatIsUndefined(self.computedWidth) or not YGFloatIsUndefined(measurement.computedWidth) then
        isEqual = isEqual and self.computedWidth == measurement.computedWidth
    end

    if not YGFloatIsUndefined(self.computedHeight) or not YGFloatIsUndefined(measurement.computedHeight) then
        isEqual = isEqual and self.computedHeight == measurement.computedHeight
    end

    return isEqual
end

function YGCachedMeasurement:clone(): YGCachedMeasurement
    local newCached = YGCachedMeasurement.new()
    newCached.availableWidth = self.availableWidth
    newCached.availableHeight = self.availableHeight
    newCached.widthMeasureMode = self.widthMeasureMode
    newCached.heightMeasureMode = self.heightMeasureMode
    newCached.computedWidth = self.computedWidth
    newCached.computedHeight = self.computedHeight
    return newCached
end
Internal.YGCachedMeasurement = YGCachedMeasurement

local leading: Array<YGEdge> = {
    YGEdge.Top,
    YGEdge.Bottom,
    YGEdge.Left,
    YGEdge.Right,
}
Internal.leading = leading

local trailing: Array<YGEdge> = {
    YGEdge.Bottom,
    YGEdge.Top,
    YGEdge.Right,
    YGEdge.Left,
}
Internal.trailing = trailing

local pos: Array<YGEdge> = {
    YGEdge.Top,
    YGEdge.Bottom,
    YGEdge.Left,
    YGEdge.Right,
}
Internal.pos = pos

local dim: Array<YGDimension> = {
    YGDimension.Height,
    YGDimension.Height,
    YGDimension.Width,
    YGDimension.Width,
}
Internal.dim = dim

local YG_MAX_CACHED_RESULT_COUNT = 16
Internal.YG_MAX_CACHED_RESULT_COUNT = YG_MAX_CACHED_RESULT_COUNT

local kDefaultFlexGrow = 0.0
Internal.kDefaultFlexGrow = kDefaultFlexGrow

local kDefaultFlexShrink = 0.0
Internal.kDefaultFlexShrink = kDefaultFlexShrink

local kWebDefaultFlexShrink = 1.0
Internal.kWebDefaultFlexShrink = kWebDefaultFlexShrink

return Internal
