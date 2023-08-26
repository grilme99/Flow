local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local Components = script.Parent:WaitForChild("Components")
local Playground = require(Components.Playground)

local e = React.createElement

local function App()
	return e("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
	}, {
		Playground = e(Playground, {}),
	})
end

local root = ReactRoblox.createRoot(Instance.new("Folder"))
root:render(ReactRoblox.createPortal(e(App), Players.LocalPlayer.PlayerGui))
