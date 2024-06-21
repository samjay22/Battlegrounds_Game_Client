--!strict 
--!optimize 2 

local KnockbackService = shared:Inject("KnockbackService")

return {
    PlayerHit = function(data : any)
        warn(`PlayerHit: {data}`)
        return data
    end,

    PlayerDied = function(data : any)
        warn(`PlayerDied: {data}`)
        return data
    end,

    Knockback = function(payload)
        warn(`PlayerKnockback: {payload}`)
        KnockbackService.Impulse(unpack(payload.data))
    end,
}