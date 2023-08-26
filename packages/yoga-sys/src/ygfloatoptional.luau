-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/ygfloatoptional.ts

-- upstream: upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGFloatOptional.h

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
local instanceof = LuauPolyfill.instanceof
local Number = LuauPolyfill.Number

local Types = require(PackageRoot.types)
type YGFloatOptional = Types.YGFloatOptional

-- deviation: inline to avoid circular deps
local function YGFloatIsUndefined(value: number?): boolean
    return value == nil or Number.isNaN(value)
    -- return value >= 10E8 || value <= -10E8;
end

local YGFloatOptional = {}
YGFloatOptional.__index = YGFloatOptional

function YGFloatOptional.new(value_: (number | YGFloatOptional)?): YGFloatOptional
    local self = setmetatable({}, YGFloatOptional)
    if instanceof(value_, YGFloatOptional) then
        local value = value_ :: YGFloatOptional
        self.value_ = value:getValue()
        self.isUndefined_ = value:isUndefined()
        return (self :: any) :: YGFloatOptional
    end

    local value = value_ :: number?
    if YGFloatIsUndefined(value) then
        self.value_ = 0
        self.isUndefined_ = true
    else
        self.value_ = value :: number
        self.isUndefined_ = false
    end
    return (self :: any) :: YGFloatOptional
end

function YGFloatOptional:unwrap(): number
    if not self.isUndefined_ then
        return self.value_
    else
        return 0 / 0
    end
end

function YGFloatOptional:clone(): YGFloatOptional
    return YGFloatOptional.new((function()
        if self.isUndefined_ then
            return nil
        else
            return self.value_
        end
    end)())
end

function YGFloatOptional:getValue(): number
    if self.isUndefined_ then
        error("Tried to get value of an undefined YGFloatOptional")
    end
    return self.value_
end

function YGFloatOptional:setValue(value: number): ()
    self.value_ = value
    self.isUndefined_ = false
end

function YGFloatOptional:isUndefined(): boolean
    return self.isUndefined_
end

function YGFloatOptional:add(op: YGFloatOptional): YGFloatOptional
    if not self.isUndefined_ and not op:isUndefined() then
        return YGFloatOptional.new(self.value_ + op:getValue())
    end
    return YGFloatOptional.new()
end

function YGFloatOptional:isBigger(op: YGFloatOptional): boolean
    if self.isUndefined_ or op:isUndefined() then
        return false
    end
    return self.value_ > op:getValue()
end

function YGFloatOptional:isSmaller(op: YGFloatOptional): boolean
    if self.isUndefined_ or op:isUndefined() then
        return false
    end
    return self.value_ < op:getValue()
end

function YGFloatOptional:isBiggerEqual(op: YGFloatOptional): boolean
    return self:isEqual(op) or self:isBigger(op)
end

function YGFloatOptional:isSmallerEqual(op: YGFloatOptional): boolean
    return self:isEqual(op) or self:isSmaller(op)
end

function YGFloatOptional:isEqual(op: YGFloatOptional): boolean
    if self.isUndefined_ == op:isUndefined() then
        return self.isUndefined_ or self.value_ == op:getValue()
    end
    return false
end

function YGFloatOptional:isDiff(op: YGFloatOptional): boolean
    return not self:isEqual(op)
end

function YGFloatOptional:isEqualValue(val: number): boolean
    if YGFloatIsUndefined(val) == self.isUndefined_ then
        return self.isUndefined_ or val == self.value_
    end
    return false
end

function YGFloatOptional:isDiffValue(val: number): boolean
    return not self:isEqualValue(val)
end

return YGFloatOptional
