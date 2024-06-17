--!strict
local Services = {}

for i, module in next, script:GetChildren() do
    if module:IsA("ModuleScript") then
        for name, value in next, require(module) do
            Services[name] = value
        end
    end
end


local ServiceContainer = {}
function ServiceContainer:Inject<T>(serviceName : string) : T
    return Services[serviceName] or game:FindService(serviceName) and game:GetService(serviceName) or error(`Service under name {serviceName} has not been registered!`)
end

setmetatable(shared, {__index = ServiceContainer})

local globalHeap = {}
setmetatable(_G, {_index = globalHeap})