-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/ygconfig.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGConfig.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/YGConfig.cpp

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
type YGLogLevel = Enums.YGLogLevel

local Types = require(PackageRoot.types)
type YGConfig = Types.YGConfig
type YGNode = Types.YGNode
type YGLogger = Types.YGLogger
type YGCloneNodeFunc = Types.YGCloneNodeFunc

local YGNodeClone

local function kYGDefaultExperimentalFeatures(): Array<boolean>
    return { false, false, false }
end

type Array<T> = { T }

local YGConfig = {}
YGConfig.__index = YGConfig

function YGConfig.new(logger: YGLogger): YGConfig
    local self = setmetatable({}, YGConfig)

    self.cloneNodeCallback = nil
    self.experimentalFeatures = kYGDefaultExperimentalFeatures()
    self.useWebDefaults = false
    self.useLegacyStretchBehaviour = false
    self.shouldDiffLayoutWithoutLegacyStretchBehaviour = false
    self.printTree = false
    self.pointScaleFactor = 1.0
    self.logger = logger
    self.context = nil

    return (self :: any) :: YGConfig
end

function YGConfig:log(
    config: YGConfig,
    node: YGNode,
    logLevel: YGLogLevel,
    logContext: any,
    format: string,
    ...: any
): ()
    self.logger(config, node, logLevel, logContext, format, ...)
end

function YGConfig:cloneNode(node: YGNode, owner: YGNode, childIndex: number, cloneContext: any?): YGNode
    local clone: YGNode = nil
    if self.cloneNodeCallback ~= nil then
        clone = self.cloneNodeCallback(node, owner, childIndex, cloneContext)
    end
    if clone == nil then
        clone = YGNodeClone(node)
    end
    return clone
end

function YGConfig:setLogger(logger: YGLogger?): ()
    self.logger = logger
end

function YGConfig:setCloneNodeCallback(cloneNode: YGCloneNodeFunc?): ()
    self.cloneNodeCallback = cloneNode
end

-- note: Some imports are done dynamically to resolve cyclic dependency issues.
return {
    resolve = function(deps)
        YGNodeClone = deps.yogaUtilsModule.YGNodeClone

        return YGConfig
    end,
}
