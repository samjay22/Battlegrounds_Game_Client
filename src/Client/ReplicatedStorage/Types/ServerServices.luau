--!strict 
--!optimize 2 


--!strict 
--!optimize 2 



local CharacterEntityType = require(game.ReplicatedStorage.Types.Character)

export type KockbackService = {
    FireClientImpluse : (userPlayer : Player, targetEntity : CharacterEntityType.CharacterEntity, KnockbackArgs : any) -> nil
}

type CharacterService = {
    CreateCharacterEntity : (player: Player) -> (),
    GetCharacterEntity : (player: Player) -> CharacterEntityType.CharacterEntity?,
    Update : (dt: number) -> ()
}
return 0