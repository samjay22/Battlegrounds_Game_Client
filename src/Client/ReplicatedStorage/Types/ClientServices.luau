--!strict 
--!optimize 2 



local CharacterEntity = require(game.ReplicatedStorage.Types.Character)

export type KockbackService<T> = {
    Impluse : (userEntity : CharacterEntity.CharacterEntity, targetEntity : CharacterEntity.CharacterEntity, KnockbackArgs : T) -> nil
}

return 0