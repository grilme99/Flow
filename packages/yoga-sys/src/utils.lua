-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/utils.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/Utils.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/Utils.cpp

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
local Error = LuauPolyfill.Error
local Number = LuauPolyfill.Number

local Enums = require(PackageRoot.enums)
local YGUnit = Enums.YGUnit
type YGUnit = Enums.YGUnit
local YGFlexDirection = Enums.YGFlexDirection
type YGFlexDirection = Enums.YGFlexDirection
local YGDirection = Enums.YGDirection
type YGDirection = Enums.YGDirection

local YGFloatOptional = require(PackageRoot.ygfloatoptional)

local Types = require(PackageRoot.types)
type YGFloatOptional = Types.YGFloatOptional
type YGNode = Types.YGNode
type YGConfig = Types.YGConfig
type YGValue = Types.YGValue

type Array<T> = { T }

local Utils = {}

-- deviation START: can't perform arithmetic operation on nil
local function safeAdd(a: number?, b: number?): number
    if typeof(a) == "number" and typeof(b) == "number" then
        return a + b
    end
    return 0 / 0
end
Utils.safeAdd = safeAdd

local function safeSub(a: number?, b: number?): number
    if typeof(a) == "number" and typeof(b) == "number" then
        return a - b
    end
    return 0 / 0
end
Utils.safeSub = safeSub

local function safeMul(a: number?, b: number?): number
    if typeof(a) == "number" and typeof(b) == "number" then
        return a * b
    end
    return 0 / 0
end
Utils.safeMul = safeMul
-- deviation END

-- deviation: hoisted function signatures are needed for the linter
local YGFlexDirectionIsColumn: (flexDirection: YGFlexDirection) -> boolean
local YGResolveFlexDirection: (flexDirection: YGFlexDirection, direction: YGDirection) -> YGFlexDirection

export type YGCollectFlexItemsRowValues = {
    itemsOnLine: number,
    sizeConsumedOnCurrentLine: number,
    totalFlexGrowFactors: number,
    totalFlexShrinkScaledFactors: number,
    endOfLineIndex: number,
    relativeChildren: Array<YGNode>,
    remainingFreeSpace: number,
    mainDim: number,
    crossDim: number,
    new: () -> YGCollectFlexItemsRowValues,
}
local YGCollectFlexItemsRowValues = {}
YGCollectFlexItemsRowValues.__index = YGCollectFlexItemsRowValues

function YGCollectFlexItemsRowValues.new(): YGCollectFlexItemsRowValues
    local self = setmetatable({}, YGCollectFlexItemsRowValues)
    self.itemsOnLine = 0
    self.sizeConsumedOnCurrentLine = 0
    self.totalFlexGrowFactors = 0
    self.totalFlexShrinkScaledFactors = 0
    self.endOfLineIndex = 1
    self.relativeChildren = {}
    self.remainingFreeSpace = 0
    self.mainDim = 0
    self.crossDim = 0
    return (self :: any) :: YGCollectFlexItemsRowValues
end
Utils.YGCollectFlexItemsRowValues = YGCollectFlexItemsRowValues

-- deviation: remove redundant if-statement and moved from yoga.lua to
-- eliminate a problematic circular dependency.
local function YGFloatIsUndefined(value: number): boolean
    return value == nil or Number.isNaN(value)
    -- return value >= 10E8 || value <= -10E8;
end
Utils.YGFloatIsUndefined = YGFloatIsUndefined

local function YGValueEqual(a: YGValue, b: YGValue): boolean
    if a.unit ~= b.unit then
        return false
    end

    if a.unit == YGUnit.Undefined or (YGFloatIsUndefined(a.value) and YGFloatIsUndefined(b.value)) then
        return true
    end

    return math.abs(a.value - b.value) < 0.0001
end
Utils.YGValueEqual = YGValueEqual

local function YGFloatsEqual(a: number, b: number): boolean
    if not YGFloatIsUndefined(a) and not YGFloatIsUndefined(b) then
        return math.abs(a - b) < 0.0001
    end
    return YGFloatIsUndefined(a) and YGFloatIsUndefined(b)
end
Utils.YGFloatsEqual = YGFloatsEqual

local function YGFloatMax(a: number, b: number): number
    if not YGFloatIsUndefined(a) and not YGFloatIsUndefined(b) then
        return math.max(a, b)
    end

    if YGFloatIsUndefined(a) then
        return b
    else
        return a
    end
end
Utils.YGFloatMax = YGFloatMax

local function YGFloatOptionalMax(op1: YGFloatOptional, op2: YGFloatOptional): YGFloatOptional
    if not op1:isUndefined() and not op2:isUndefined() then
        if op1:getValue() > op2:getValue() then
            return op1
        else
            return op2
        end
    end

    if op1:isUndefined() then
        return op2
    else
        return op1
    end
end
Utils.YGFloatOptionalMax = YGFloatOptionalMax

local function YGFloatMin(a: number, b: number): number
    if not YGFloatIsUndefined(a) and not YGFloatIsUndefined(b) then
        return math.min(a, b)
    end

    if YGFloatIsUndefined(a) then
        return b
    else
        return a
    end
end
Utils.YGFloatMin = YGFloatMin

local function YGFloatArrayEqual(val1: Array<number>, val2: Array<number>): boolean
    local areEqual = true

    local i = 1
    while i <= #val1 and areEqual do
        areEqual = YGFloatsEqual(val1[i], val2[i])
        i += 1
    end

    return areEqual
end
Utils.YGFloatArrayEqual = YGFloatArrayEqual

local function YGValueArrayEqual(val1: Array<YGValue>, val2: Array<YGValue>): boolean
    local areEqual = true

    local i = 1
    while i <= #val1 and areEqual do
        areEqual = YGValueEqual(val1[i], val2[i])
        i += 1
    end

    return areEqual
end
Utils.YGValueArrayEqual = YGValueArrayEqual

local function YGFloatSanitize(val: number): number
    if YGFloatIsUndefined(val) then
        return 0
    else
        return val
    end
end
Utils.YGFloatSanitize = YGFloatSanitize

local function YGFlexDirectionCross(flexDirection: YGFlexDirection, direction: YGDirection): YGFlexDirection
    if YGFlexDirectionIsColumn(flexDirection) then
        return YGResolveFlexDirection(YGFlexDirection.Row, direction)
    else
        return YGFlexDirection.Column
    end
end
Utils.YGFlexDirectionCross = YGFlexDirectionCross

local function YGFlexDirectionIsRow(flexDirection: YGFlexDirection): boolean
    return flexDirection == YGFlexDirection.Row or flexDirection == YGFlexDirection.RowReverse
end
Utils.YGFlexDirectionIsRow = YGFlexDirectionIsRow

local function YGResolveValue(value: YGValue, ownerSize: number): YGFloatOptional
    if value.unit == YGUnit.Point then
        return YGFloatOptional.new(value.value)
    elseif value.unit == YGUnit.Percent then
        return YGFloatOptional.new(safeMul(safeMul(value.value, ownerSize), 0.01))
    end

    return YGFloatOptional.new()
end
Utils.YGResolveValue = YGResolveValue

-- deviation: local declaration hoisted
function YGFlexDirectionIsColumn(flexDirection: YGFlexDirection): boolean
    return flexDirection == YGFlexDirection.Column or flexDirection == YGFlexDirection.ColumnReverse
end
Utils.YGFlexDirectionIsColumn = YGFlexDirectionIsColumn

-- deviation: local declaration hoisted
function YGResolveFlexDirection(flexDirection: YGFlexDirection, direction: YGDirection): YGFlexDirection
    if direction == YGDirection.RTL then
        if flexDirection == YGFlexDirection.Row then
            return YGFlexDirection.RowReverse
        elseif flexDirection == YGFlexDirection.RowReverse then
            return YGFlexDirection.Row
        end
    end
    return flexDirection
end
Utils.YGResolveFlexDirection = YGResolveFlexDirection

local function YGResolveValueMargin(value: YGValue, ownerSize: number): YGFloatOptional
    if value.unit == YGUnit.Auto then
        return YGFloatOptional.new(0)
    else
        return YGResolveValue(value, ownerSize)
    end
end
Utils.YGResolveValueMargin = YGResolveValueMargin

local function throwLogicalErrorWithMessage(message: string): ()
    error(Error.new(message))
end
Utils.throwLogicalErrorWithMessage = throwLogicalErrorWithMessage

local function cloneYGValueArray(array: Array<YGValue>): Array<YGValue>
    local ret = {}
    for i = 1, #array do
        ret[i] = array[i]:clone()
    end
    return ret
end
Utils.cloneYGValueArray = cloneYGValueArray

return Utils
