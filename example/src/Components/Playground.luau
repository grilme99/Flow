local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local Components = script.Parent
local Inspector = require(Components.Inspector.Inspector)
local Preview = require(Components.Preview.Preview)

local e = React.createElement

local function Playground()
	return e(React.Fragment, {}, {
		Inspector = e(Inspector, {}),
		Preview = e(Preview, {}),
	})
end

return Playground
