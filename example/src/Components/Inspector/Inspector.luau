local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)

local e = React.createElement

local function Inspector()
    return e(React.Fragment)
end

return Inspector
