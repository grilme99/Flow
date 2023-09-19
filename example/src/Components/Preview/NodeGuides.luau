local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array

local Guide = require(script.Parent.Guide)

local e = React.createElement

type Guide = {
	thickness: number,
	text: number,
}

export type Props = {
	renderOutside: boolean,
	color: Color3,
	guides: {
		top: Guide?,
		right: Guide?,
		bottom: Guide?,
		left: Guide?,
	},
}

local function NodeGuides(props: Props)
	local renderOutside = props.renderOutside
	local color = props.color
	local guides = props.guides

	local children = {}
	local count = 0

	for name, guideData: Guide in pairs(guides) do
		if guideData.thickness == 0 then
			continue
		end

		count += 1
		children[name] = e(Guide, {
			edge = name,
			renderOutside = renderOutside,
			thickness = guideData.thickness,
			text = guideData.text,
			color = color,
		})
	end

	if count == 0 then
		return nil :: any
	end

	return e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, children :: any)
end

return React.memo(NodeGuides)
