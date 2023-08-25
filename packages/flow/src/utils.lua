--!optimize 2
--!strict

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Number = LuauPolyfill.Number

local YogaSys = require(Packages.YogaSys)
local YGUnit = YogaSys.YGEnum.YGUnit
type YGUnit = YogaSys.YGUnit

local Utils = {}

function Utils.FloatIsUndefined(value: number): boolean
    return value == nil or Number.isNaN(value)
end

function Utils.FloatSanitize(val: number): number
    if Utils.FloatIsUndefined(val) then
        return 0
    else
        return val
    end
end

export type Layout = {
    left: number,
    right: number,
    bottom: number,
    top: number,
    width: number,
    height: number,
}

export type Size = {
    width: number,
    height: number,
}

Utils.Size = table.freeze({
    new = function(width: number?, height: number?): Size
        if width then
            return {
                width = width,
                height = height or 0,
            }
        else
            return {
                width = 0,
                height = 0,
            }
        end
    end,
})

export type Value = {
    unit: YGUnit,
    value: number,
}

Utils.Value = table.freeze({
    new = function(unit: YGUnit?, value: number?)
        if unit then
            return {
                unit = unit,
                value = value or 0,
            }
        else
            return {
                unit = YGUnit.Undefined,
                value = 0,
            }
        end
    end,
})

return Utils
