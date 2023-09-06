-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/ygvalue.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGValue.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGValue.cpp

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
local YGUnit = Enums.YGUnit
type YGUnit = Enums.YGUnit

local Types = require(PackageRoot.types)
type YGValue = Types.YGValue

local exports = {}

-- deviation: hoist things referenced prior to definition
local YGValue = {}

local YGUndefined: number = nil
exports.YGUndefined = YGUndefined

local function YGValueZero(): YGValue
    return YGValue.new(0, YGUnit.Point)
end
exports.YGValueZero = YGValueZero

local function YGValueUndefined(): YGValue
    return YGValue.new(YGUndefined, YGUnit.Undefined)
end
exports.YGValueUndefined = YGValueUndefined

local function YGValueAuto(): YGValue
    return YGValue.new(YGUndefined, YGUnit.Auto)
end
exports.YGValueAuto = YGValueAuto
YGValue.__index = YGValue

function YGValue.new(value: number, unit: YGUnit): YGValue
    local self = setmetatable({}, YGValue)
    self.value = value
    self.unit = unit
    return (self :: any) :: YGValue
end

function YGValue.eq(self: YGValue, value: YGValue): boolean
    local lhs = self
    local rhs = value

    if lhs.unit ~= rhs.unit then
        return false
    end

    if lhs.unit == YGUnit.Undefined or lhs.unit == YGUnit.Auto then
        return true
    elseif lhs.unit == YGUnit.Point or lhs.unit == YGUnit.Percent then
        return lhs.value == rhs.value
    end

    return false
end

function YGValue.neq(self: YGValue, value: YGValue): boolean
    return not self:eq(value)
end

function YGValue.subtract(self: YGValue, value: YGValue): YGValue
    return YGValue.new(-value.value, value.unit)
end

function YGValue.clone(self: YGValue): YGValue
    return YGValue.new(self.value, self.unit)
end

-- deviation: upstream this is only provided in CompactValue.
function YGValue.isUndefined(self: YGValue): boolean
    return self.unit == YGUnit.Undefined
end
exports.YGValue = YGValue

return exports
