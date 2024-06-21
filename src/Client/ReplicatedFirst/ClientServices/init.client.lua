--!strict 
--!optimize 2 



local ServiceContainer = require(game.ReplicatedStorage.Utility.ServiceContainer)

for i, module in next, script:GetChildren() do
    if module:IsA("ModuleScript") then
        for name, value in next, require(module) do
            ServiceContainer:RegisterService(module.Name, value)
        end
    end
end

