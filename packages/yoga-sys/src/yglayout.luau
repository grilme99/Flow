-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/yglayout.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGLayout.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGLayout.cpp

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

local YGFloatOptional = require(PackageRoot.ygfloatoptional)

local Internal = require(PackageRoot.internal)
local YGCachedMeasurement = Internal.YGCachedMeasurement

local Utils = require(PackageRoot.utils)
local YGFloatArrayEqual = Utils.YGFloatArrayEqual
local YGFloatIsUndefined = Utils.YGFloatIsUndefined

local Types = require(PackageRoot.types)
type YGLayout = Types.YGLayout
type YGFloatOptional = Types.YGFloatOptional
type YGCachedMeasurement = Types.YGCachedMeasurement

local function kYGDefaultDimensionValues(): Array<number?>
    -- CHECK: this will return empty array. If the code requires the array to have length of 2 it might not work
    return { nil, nil }
end

local YG_MAX_CACHED_RESULT_COUNT = 16

local function buildCache(c: number): Array<YGCachedMeasurement>
    local ret: Array<YGCachedMeasurement> = {}
    for _ = 1, c do
        table.insert(ret, YGCachedMeasurement.new())
    end
    return ret
end

type Array<T> = { T }

local YGLayout = {}
YGLayout.__index = YGLayout

function YGLayout.new(): YGLayout
    local self = setmetatable({}, YGLayout)

    self.dimensions = kYGDefaultDimensionValues()
    self.direction = YGDirection.Inherit
    self.computedFlexBasisGeneration = 0
    self.computedFlexBasis = YGFloatOptional.new()
    self.hadOverflow = false
    self.generationCount = 0
    self.lastOwnerDirection = YGDirection.Inherit
    self.nextCachedMeasurementsIndex = 1
    self.measuredDimensions = kYGDefaultDimensionValues()
    self.cachedLayout = YGCachedMeasurement.new()
    self.didUseLegacyFlag = false
    self.doesLegacyStretchFlagAffectsLayout = false
    self.position = { nil, nil, nil, nil }
    self.margin = { nil, nil, nil, nil, nil, nil }
    self.border = { nil, nil, nil, nil, nil, nil }
    self.padding = { nil, nil, nil, nil, nil, nil }
    self.cachedMeasurements = buildCache(YG_MAX_CACHED_RESULT_COUNT)

    return (self :: any) :: YGLayout
end

function YGLayout:getDirection(): YGDirection
    return self.direction
end

function YGLayout:setDirection(direction: YGDirection): ()
    self.direction = direction
end

function YGLayout:getDidUseLegacyFlag(): boolean
    return self.didUseLegacyFlag
end

function YGLayout:setDidUseLegacyFlag(val: boolean): ()
    self.didUseLegacyFlag = val
end

function YGLayout:getDoesLegacyStretchFlagAffectsLayout(): boolean
    return self.doesLegacyStretchFlagAffectsLayout
end

function YGLayout:setDoesLegacyStretchFlagAffectsLayout(val: boolean): ()
    self.doesLegacyStretchFlagAffectsLayout = val
end

function YGLayout:getHadOverflow(): boolean
    return self.hadOverflow
end

function YGLayout:setHadOverflow(hadOverflow: boolean): ()
    self.hadOverflow = hadOverflow
end

function YGLayout:equal(layout: YGLayout): boolean
    local isEqual: boolean = YGFloatArrayEqual(self.position, layout.position)
        and YGFloatArrayEqual(self.dimensions, layout.dimensions)
        and YGFloatArrayEqual(self.margin, layout.margin)
        and YGFloatArrayEqual(self.border, layout.border)
        and YGFloatArrayEqual(self.padding, layout.padding)
        and self.direction == layout.direction
        and self.hadOverflow == layout.hadOverflow
        and self.lastOwnerDirection == layout.lastOwnerDirection
        and self.nextCachedMeasurementsIndex == layout.nextCachedMeasurementsIndex
        and self.cachedLayout == layout.cachedLayout
        and self.computedFlexBasis == layout.computedFlexBasis

    local i = 1
    while i <= YG_MAX_CACHED_RESULT_COUNT and isEqual do
        isEqual = isEqual and self.cachedMeasurements[i] == layout.cachedMeasurements[i]
        i += 1
    end

    if not YGFloatIsUndefined(self.measuredDimensions[1]) or not YGFloatIsUndefined(layout.measuredDimensions[1]) then
        isEqual = isEqual and self.measuredDimensions[1] == layout.measuredDimensions[1]
    end

    if not YGFloatIsUndefined(self.measuredDimensions[2]) or not YGFloatIsUndefined(layout.measuredDimensions[2]) then
        isEqual = isEqual and self.measuredDimensions[2] == layout.measuredDimensions[2]
    end

    return isEqual
end

function YGLayout:diff(layout: YGLayout): boolean
    return not self:equal(layout)
end

function YGLayout:clean(): ()
    self.dimensions = kYGDefaultDimensionValues()
    self.direction = YGDirection.Inherit
    self.computedFlexBasisGeneration = 0
    self.computedFlexBasis = YGFloatOptional.new()
    self.hadOverflow = false
    self.generationCount = 0
    self.lastOwnerDirection = YGDirection.RTL
    self.nextCachedMeasurementsIndex = 1
    self.measuredDimensions = kYGDefaultDimensionValues()
    self.cachedLayout = YGCachedMeasurement.new()
    self.didUseLegacyFlag = false
    self.doesLegacyStretchFlagAffectsLayout = false
    self.position = { nil, nil, nil, nil }
    self.margin = { nil, nil, nil, nil, nil, nil }
    self.border = { nil, nil, nil, nil, nil, nil }
    self.padding = { nil, nil, nil, nil, nil, nil }
    self.cachedMeasurements = buildCache(YG_MAX_CACHED_RESULT_COUNT)
end

function YGLayout:clone(): YGLayout
    local newLayout = YGLayout.new()

    newLayout.dimensions = {
        self.dimensions[1],
        self.dimensions[2],
    }
    newLayout.direction = self.direction
    newLayout.computedFlexBasisGeneration = self.computedFlexBasisGeneration
    newLayout.computedFlexBasis = self.computedFlexBasis:clone()
    newLayout.hadOverflow = self.hadOverflow
    newLayout.generationCount = self.generationCount
    newLayout.lastOwnerDirection = self.lastOwnerDirection
    newLayout.nextCachedMeasurementsIndex = self.nextCachedMeasurementsIndex
    newLayout.measuredDimensions = { self.measuredDimensions[1], self.measuredDimensions[2] }
    newLayout.cachedLayout = self.cachedLayout:clone()
    newLayout.didUseLegacyFlag = self.didUseLegacyFlag
    newLayout.doesLegacyStretchFlagAffectsLayout = self.doesLegacyStretchFlagAffectsLayout
    newLayout.position = {
        self.position[1],
        self.position[2],
        self.position[3],
        self.position[4],
    }
    newLayout.margin = {
        self.margin[1],
        self.margin[2],
        self.margin[3],
        self.margin[4],
        self.margin[5],
        self.margin[6],
    }
    newLayout.border = {
        self.border[1],
        self.border[2],
        self.border[3],
        self.border[4],
        self.border[5],
        self.border[6],
    }
    newLayout.padding = {
        self.padding[1],
        self.padding[2],
        self.padding[3],
        self.padding[4],
        self.padding[5],
        self.padding[6],
    }
    newLayout.cachedMeasurements = buildCache(YG_MAX_CACHED_RESULT_COUNT)

    return newLayout
end

return YGLayout
