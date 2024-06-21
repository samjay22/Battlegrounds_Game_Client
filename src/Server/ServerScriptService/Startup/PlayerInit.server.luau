--!strict 
--!optimize 2 


local ServerServiceTypes = require(game.ReplicatedStorage.Types.ServerServices)
local Players : Players = shared.Inject("Players")
local CharacterService : ServerServiceTypes.CharacterService = shared.Inject("CharacterService")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if not ServerServiceTypes.GetCharacterEntity(player) then
            CharacterService.CreateCharacterEntity(player)
        end
    end)
end)