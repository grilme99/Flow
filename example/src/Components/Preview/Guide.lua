local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local e = React.createElement

export type Props = {
	edge: "top" | "right" | "bottom" | "left",
	renderOutside: boolean,
	thickness: number,
	text: string,
	color: Color3,
}

local function Guide(props: Props)
	local edge = props.edge
	local renderOutside = props.renderOutside
	local thickness = props.thickness
	local text = props.text
	local color = props.color

	local isHorizontal = edge == "top" or edge == "bottom"

	local anchorPoint: Vector2
	if isHorizontal then
		anchorPoint = Vector2.new(0.5, if edge == "top" then 0 else 1)
	else
		anchorPoint = Vector2.new(if edge == "left" then 1 else 0, 0.5)
	end

	local position: UDim2
	if isHorizontal then
		if renderOutside then
			position = UDim2.fromScale(0.5, if edge == "top" then 1 else 0)
		else
			position = UDim2.fromScale(0.5, if edge == "top" then 0 else 1)
		end
	else
		if renderOutside then
			position = UDim2.fromScale(if edge == "left" then 0 else 1, 0.5)
		else
			position = UDim2.fromScale(if edge == "left" then 1 else 0, 0.5)
		end
	end

	local size = if isHorizontal then UDim2.new(1, 0, 0, thickness) else UDim2.new(0, thickness, 1, 0)

	return e("TextLabel", {
		AnchorPoint = anchorPoint,
		Position = position,
		Size = size,
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Text = text,
		Font = Enum.Font.SourceSansLight,
		TextColor3 = Color3.fromRGB(48, 56, 69),
		TextSize = 14,
	})
end

return React.memo(Guide)
