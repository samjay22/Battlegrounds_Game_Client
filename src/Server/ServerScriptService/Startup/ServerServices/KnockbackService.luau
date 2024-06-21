--!strict 
--!optimize 2 


local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local CharacterService : ServerServiceTypes.CharacterService = shared.Inject("CharacterService")
local Service = {}

function Service.ApplyKockback(attacker : Player, target : Player, args : any)

    local attackerEntity = CharacterService.GetCharacterEntity(attacker)
    local targetEntity = CharacterService.GetCharacterEntity(target)

    if not attackerEntity or not targetEntity then
        return warn(`Invalid kockback args: {args} from {attacker} to {target}`)
    end

    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireAllClients("Knockback", {data = {attackerEntity, targetEntity, args}})
end

return Service