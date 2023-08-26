--!nonstrict

local TestsRoot = script.Parent.Parent

for _, v in TestsRoot.generated:GetChildren() do
    print("Testing:", v.Name, "\n")
    require(v)
    print("\n\n")
end

for _, v in TestsRoot:GetChildren() do
    if not v:IsA("ModuleScript") then
        continue
    end

    print("Testing:", v.Name, "\n")
    require(v)
    print("\n\n")
end
