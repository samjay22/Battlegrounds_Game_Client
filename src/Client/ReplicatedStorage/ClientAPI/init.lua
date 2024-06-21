--!strict 
--!optimize 2 


local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)

local ClientAPI = {}
local Delegates = {}
local _RequestQueue = {}

for _, module in ipairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        for name, value in pairs(require(module)) do
            if Delegates[name] then
                warn("Duplicate API name: " .. name)
                continue
            end
            
            Delegates[name] = value
        end
    end
end

local NetworkTypes = require(game.ReplicatedStorage.ClientNetwork.Types)
function ClientAPI.ProcessRequest(endpoint : string, payload : NetworkTypes.ResponsePayload)
   if Delegates[endpoint] then
       table.insert(_RequestQueue, {Delegates[endpoint], payload})
   end 
end

GlobalUpdateService.AddGlobalUpdate(function(dt : number)
    local requestData = table.remove(_RequestQueue)
    if requestData == nil then
        return
    end
    
    requestData[1](requestData[2])
end)

return ClientAPI