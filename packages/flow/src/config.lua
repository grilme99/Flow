--!optimize 2
--!strict

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local Yoga = require(Packages.YogaSys)
type YGExperimentalFeature = Yoga.YGExperimentalFeature
local YGConfigNew = Yoga.YGConfigNew
local YGConfigFree = Yoga.YGConfigFree
local YGConfigSetExperimentalFeatureEnabled = Yoga.YGConfigSetExperimentalFeatureEnabled
local YGConfigIsExperimentalFeatureEnabled = Yoga.YGConfigIsExperimentalFeatureEnabled
local YGConfigSetPointScaleFactor = Yoga.YGConfigSetPointScaleFactor

local Config = {}
Config.__index = Config

function Config.new()
    local self = setmetatable({}, Config)
    self._config = YGConfigNew()
    return self
end

export type Config = typeof(Config.new(...))

function Config.free(self: Config)
    YGConfigFree(self._config)
end

function Config.setExperimentalFeatureEnabled(self: Config, feature: YGExperimentalFeature, enabled: boolean)
    YGConfigSetExperimentalFeatureEnabled(self._config, feature, enabled)
end

function Config.isExperimentalFeatureEnabled(self: Config, feature: YGExperimentalFeature): boolean
    return YGConfigIsExperimentalFeatureEnabled(self._config, feature)
end

function Config.setPointScaleFactor(self: Config, pixelsInPoint: number)
    YGConfigSetPointScaleFactor(self._config, pixelsInPoint)
end

return {
    new = Config.new,
}
