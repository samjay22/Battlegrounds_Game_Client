
local Services = {}
local ServiceContainer = {}
function ServiceContainer:Inject<T>(serviceName : string) : T
    return Services[serviceName] or game:FindService(serviceName) and game:GetService(serviceName) or error(`Service under name {serviceName} has not been registered!`)
end

function ServiceContainer:RegisterService(serviceName : string, service)
    Services[serviceName] = service
end

setmetatable(shared, {__index = ServiceContainer})
local globalHeap = {}
setmetatable(_G, {_index = globalHeap})


return ServiceContainer