--!strict 
--!optimize 2 



export type CharacterEntity = {
    --We can store any data here. Ideally, we can use player.userId
    Id : string | number,
    MoveSet : string,
    CurrentCharacterModel : Model,
    CurrentPlayTime : number,
    Player : Player,
}

return 0