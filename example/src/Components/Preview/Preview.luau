local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local Flow = require(Packages.Flow)

local Node = require(script.Parent.Node)

type FlowNode = Flow.node

local e = React.createElement

export type Props = {
	rootNode: FlowNode,
    selectedNodeId: string,
	onSelected: (nodeId: string) -> (),
}

local function Preview(props: Props)
	local rootNode = props.rootNode
    local selectedNodeId = props.selectedNodeId
    local onSelected = props.onSelected

	local width = rootNode:getComputedWidth()
	local height = rootNode:getComputedHeight()

	return e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, -140, 0.5, 0),
		Size = UDim2.fromOffset(width, height),
		BackgroundTransparency = 1,
	}, {
		RootNode = e(Node, {
			flowNode = rootNode,
            selectedNodeId = selectedNodeId,
            onSelected = onSelected,
		}),
	})
end

return Preview
