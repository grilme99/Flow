local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local Flow = require(Packages.Flow)

type FlowNode = Flow.node

local NodeGuides = require(script.Parent.NodeGuides)

local e = React.createElement
local useState = React.useState

local EDGES = { "Top", "Right", "Bottom", "Left" }

export type Props = {
	flowNode: FlowNode,
	index: number?,
	parentNodeId: string?,
	selectedNodeId: string,
	onSelected: (nodeId: string) -> (),
}

local function Node(props: Props)
	local flowNode = props.flowNode
	local index = props.index
	local parentNodeId = props.parentNodeId
	local selectedNodeId = props.selectedNodeId
	local onSelected = props.onSelected

	local _isHovering, setIsHovering = useState(false)

	-- This is a really sub-optimal way to ID nodes, but it's easy so whatever :P
	local nodeId = if parentNodeId and index then `{parentNodeId}.{index}` else "1"
	local isSelected = selectedNodeId == nodeId

	local layout = flowNode:getComputedLayout()

	local isRoot = index == nil
	local buttonText = if isRoot then "root" else tostring(index)

	local children: any = {
		Border = e("UIStroke", {
			Thickness = if isSelected then 2 else 1,
			Color = if isSelected then Color3.fromHex("#68cfbb") else Color3.new(0, 0, 0),
			Transparency = if isSelected then 0 else 0.9,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
		}),
	}

	for i = 1, flowNode:getChildCount() do
		local childNode = flowNode:getChild(i)
		if childNode then
			children[`Child{i}`] = e(Node, {
				flowNode = childNode,
				index = i,
				parentNodeId = nodeId,
				selectedNodeId = selectedNodeId,
				onSelected = onSelected,
			})
		end
	end

	if isSelected then
		-- Padding
		do
			local guides = {}
			for _, edge in EDGES do
				local padding = flowNode:getComputedPadding(Flow.Edge[edge])
				guides[string.lower(edge)] = { thickness = padding, text = tostring(padding) }
			end

			children.PaddingGuides = e(NodeGuides, {
				renderOutside = false,
				color = Color3.fromHex("#F3F8EB"),
				guides = guides,
			})
		end

		-- Margin
		do
			local guides = {}
			for _, edge in EDGES do
				local margin = flowNode:getComputedMargin(Flow.Edge[edge])
				guides[string.lower(edge)] = { thickness = margin, text = tostring(margin) }
			end

			children.MarginGuides = e(NodeGuides, {
				renderOutside = true,
				color = Color3.fromHex("#F8EBE9"),
				guides = guides,
			})
		end
	end

	return e("Frame", {
		Position = UDim2.fromOffset(layout.left, layout.top),
		Size = UDim2.fromOffset(layout.width, layout.height),
		BackgroundTransparency = 1,
		ZIndex = if isSelected then 10000 else index,
	}, {
		VisibleNode = e("TextButton", {
			Size = UDim2.fromScale(1, 1),
			-- BackgroundColor3 = if isHovering then Color3.fromHex("#F3FFF9") else Color3.new(1, 1, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = if isRoot then 0 else 0.2,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			Text = buttonText,
			Font = Enum.Font.SourceSansLight,
			TextColor3 = Color3.fromRGB(48, 56, 69),
			TextSize = 24,
			ZIndex = 2,

			[React.Event.Activated] = function()
				onSelected(nodeId)
			end,
			[React.Event.MouseEnter] = function()
				setIsHovering(true)
			end,
			[React.Event.MouseLeave] = function()
				setIsHovering(false)
			end,
		}, children),
	})
end

return Node
