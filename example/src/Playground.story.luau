local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local Components = script.Parent.Components
local Playground = require(Components.Playground)

local e = React.createElement

return function(container)
	local root = ReactRoblox.createRoot(Instance.new("Folder"))
	root:render(ReactRoblox.createPortal(e(Playground, {}), container))

	return function()
        root:unmount()
    end
end
