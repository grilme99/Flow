local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local Flow = require(Packages.Flow)

local Components = script.Parent
local Inspector = require(Components.Inspector.Inspector)
local Preview = require(Components.Preview.Preview)

local Config = Flow.Config
local Direction = Flow.Direction
local FlexDirection = Flow.FlexDirection
local Edge = Flow.Edge
local Node = Flow.Node

local e = React.createElement
local useMemo = React.useMemo
local useState = React.useState

local function createDefaultTree()
	local config = Config.new()

	local rootNode = Node.new(config)
	rootNode:setWidth(500)
	rootNode:setHeight(300)
	rootNode:setFlexDirection(FlexDirection.Row)
	rootNode:setPadding(Edge.All, 20)
	rootNode:setFlexWrap(Flow.Wrap.Wrap)

	local function createChildNode(index: number, bigger: boolean)
		local childNode = Node.new(config)
		childNode:setWidth(100)
		childNode:setHeight(100)

		if bigger then
			childNode:setFlexGrow(1)
			childNode:setMargin(Edge.Horizontal, 20)
		end

		rootNode:insertChild(childNode, index)
	end

	createChildNode(1, false)
	createChildNode(2, true)
	createChildNode(3, false)

	-- createChildNode(4, false)
	-- createChildNode(5, false)
	-- createChildNode(6, false)

	return rootNode
end

local function Playground()
	local rootNode = useMemo(createDefaultTree)
	rootNode:calculateLayout(nil, nil, Direction.LTR)

	local selectedNodeId, setSelectedNodeId = useState("1")

	return e("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Active = false,
		Modal = true,
		Text = "",

		[React.Event.MouseButton1Down] = function()
			setSelectedNodeId("")
		end
	}, {
		Inspector = e(Inspector, {}),
		Preview = e(Preview, {
			rootNode = rootNode,
			selectedNodeId = selectedNodeId,
			onSelected = function(nodeId)
				setSelectedNodeId(nodeId)
			end,
		}),
	})
end

return Playground
