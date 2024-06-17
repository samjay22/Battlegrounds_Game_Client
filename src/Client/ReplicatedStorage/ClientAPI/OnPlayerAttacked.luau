--!strict
local RunService : RunService = shared:Inject("RunService")
local KnockbackService = shared:Inject("KnockbackService")

local queue = {}
RunService.Heartbeat:Connect(function()
    if queue[1] then
        local data = table.remove(queue, 1)
        data:Start()
    end
end)

return {
    PlayerHit = function(data : any)
        warn(`PlayerHit: {data}`)
        table.insert(queue, data)
        return data
    end,

    PlayerDied = function(data : any)
        warn(`PlayerDied: {data}`)
        return data
    end
}