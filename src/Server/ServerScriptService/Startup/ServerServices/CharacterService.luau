--!strict 
--!optimize 2 


local CharacterEntityType = require(game.ReplicatedStorage.Types.Character)

local Service = {}
local _ActiveEntitys = {}
local function GetPlayerCharacter(player : Player) : Model
    return player.Character or player.CharacterAdded:Wait() and player.Character :: any
end

function Service.CreateCharacterEntity(player : Player)
    local charactEntity : CharacterEntityType.CharacterEntity = {
        Id = player.UserId,
        Player = player,
        MoveSet = "Default",
        CurrentCharacterModel = GetPlayerCharacter(player),
        CurrentPlayTime = 0,
    }

    table.insert(_ActiveEntitys, charactEntity)
end

function Service.GetCharacterEntity(player : Player) : CharacterEntityType.CharacterEntity?
    for _, entity in ipairs(_ActiveEntitys) do
        if entity.Id == player.UserId then
            return entity
        end
    end
    
    return nil
end

function Service.Update(dt : number)
    for _, entity in ipairs(_ActiveEntitys) do
        if not entity.Player.Parent then
            table.remove(_ActiveEntitys, _)
            break
        end

        entity.CurrentPlayTime += dt

        --Reset character
        if not entity.CurrentCharacterModel then
            entity.CurrentCharacterModel = GetPlayerCharacter(entity.Player)
        end
    end
end

return Service
