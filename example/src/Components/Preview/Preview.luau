local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local e = React.createElement

local function Preview()
    return e(React.Fragment)
end

return Preview
