-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/log.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/log.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/log.cpp

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

local Enums = require(PackageRoot.enums)
type YGLogLevel = Enums.YGLogLevel

local Types = require(PackageRoot.types)
type YGNode = Types.YGNode
type YGConfig = Types.YGConfig

local ygConfigModule_ = require(PackageRoot.ygconfig)
local YGConfig
local YGNode
local YGConfigGetDefault

local exports = {}

local vlog: (config: YGConfig?, node: YGNode?, level: YGLogLevel, context: any, format: string, ...any) -> ()

local Log = {}
Log.__index = Log

export type Log = {}

function Log.new(): Log
    local self = setmetatable({}, Log)
    return (self :: any) :: Log
end

function Log.log(using: YGNode | YGConfig, level: YGLogLevel, context: any, format: string, ...: any): ()
    if instanceof(using, YGNode) then
        local node: YGNode = using :: YGNode
        vlog(if node == nil then (nil :: any) :: YGConfig? else node:getConfig(), node, level, context, format, ...)
    elseif instanceof(using, YGConfig) then
        local config: YGConfig = using :: YGConfig
        vlog(config, nil, level, context, format, ...)
    end
end
exports.Log = Log

-- deviation: config param can actually be nil
function vlog(config: YGConfig?, node: YGNode?, level: YGLogLevel, context: any, format: string, ...: any): ()
    local logConfig: YGConfig
    if config ~= nil then
        logConfig = config
    else
        logConfig = YGConfigGetDefault()
    end
    logConfig:log(logConfig, node :: YGNode, level, context, format, ...)
end
-- deviation END

-- note: Some imports are done dynamically to resolve cyclic dependency issues.
return {
    resolve = function(deps: any)
        local yogaUtilsModule = require(PackageRoot.yoga_utils).resolve({
            yogaAssertionsModule = deps.yogaAssertionsModule,
        })

        local ygConfigModule = ygConfigModule_.resolve({
            yogaUtilsModule = yogaUtilsModule,
        })
        YGConfig = ygConfigModule

        local ygNodeModule = require(PackageRoot.ygnode).resolve({
            yogaAssertionsModule = deps.yogaAssertionsModule,
            yogaUtilsModule = yogaUtilsModule,
        })

        YGConfigGetDefault = yogaUtilsModule.YGConfigGetDefault
        YGNode = ygNodeModule

        return exports
    end,
}
