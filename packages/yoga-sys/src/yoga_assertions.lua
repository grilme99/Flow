-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/yoga.ts

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

-- Note: This module is extracted out of `init.lua` (originally `yoga.ts`) to avoid Luau's maximum local limit.
-- For performance reasons, everything in `init.lua` must be defined as a local, so we quickly run into the limit.

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean

local Types = require(PackageRoot.types)
type YGConfig = Types.YGConfig
type YGNode = Types.YGNode

local Enums = require(PackageRoot.enums)
local YGLogLevel = Enums.YGLogLevel

local ygNodeModule_ = require(PackageRoot.ygnode)
local YGNode

type FIX_ANALYZE = any
local Log: FIX_ANALYZE

local Utils = require(PackageRoot.utils)
local throwLogicalErrorWithMessage = Utils.throwLogicalErrorWithMessage

-- deviation: assertion functions have been moved from yoga.lua to
-- eliminate circular dependencies and meet the 200 local quota.

local YogaAssertions = {}

local function YGAssert(condition: boolean, message: string): ()
    if not condition then
        Log.log(YGNode.new(nil), YGLogLevel.Fatal, nil, "%s\n", message)
        throwLogicalErrorWithMessage(message)
    end
end
YogaAssertions.YGAssert = YGAssert

-- deviation: type predicates are not supported
local function YGAssertWithNode(node: YGNode, condition: boolean, message: string): ()
    if not Boolean.toJSBoolean(condition) then
        Log.log(node, YGLogLevel.Fatal, nil, "%s\n", message)
        throwLogicalErrorWithMessage(message)
    end
end
YogaAssertions.YGAssertWithNode = YGAssertWithNode

local function YGAssertWithConfig(config: YGConfig, condition: boolean, message: string): ()
    if not Boolean.toJSBoolean(condition) then
        Log.log(config, YGLogLevel.Fatal, nil, "%s\n", message)
        throwLogicalErrorWithMessage(message)
    end
end
YogaAssertions.YGAssertWithConfig = YGAssertWithConfig

-- note: Some imports are done dynamically to resolve cyclic dependency issues.
return {
    resolve = function()
        local logModule = require(script.Parent.log).resolve({
            yogaAssertionsModule = YogaAssertions,
        })
        Log = logModule.Log

        local yogaUtilsModule = require(script.Parent.yoga_utils).resolve({
            yogaAssertionsModule = YogaAssertions,
        })

        local ygNodeModule = ygNodeModule_.resolve({
            yogaAssertionsModule = YogaAssertions,
            yogaUtilsModule = yogaUtilsModule,
        })
        YGNode = ygNodeModule.YGNode

        return YogaAssertions
    end,
}
