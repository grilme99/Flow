local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local e = React.createElement

local function Inspector()
	return e("Frame", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -20, 0.5, 0),
		Size = UDim2.new(0, 260, 0.8, 0),
		BackgroundColor3 = Color3.new(1, 1, 1),
	}, {
		Corner = e("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),
		Border = e("UIStroke", {
			Thickness = 1,
			Color = Color3.new(0, 0, 0),
			Transparency = 0.9,
		}),
	})
end

return Inspector
