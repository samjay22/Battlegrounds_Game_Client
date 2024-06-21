--!strict 
--!optimize 2 





--[[
    @author: idkfr
    @desc: Creates an Accurate Knockback force using :ApplyImpulse.

    @methods: {
        Knockback.new(User: Model, Target: Model, Range: number, Height: number)
        -- Creates the Knockback Force.

        Knockback:Impulse(User: Model, Target: Model, Range: number, Height: number, DelayTime: number?)
        -- Instantly Creates and Impulses a Force.
    }
--]]

local CharacterEntity = require(game.ReplicatedStorage.Types.Character)

local Knockback = {}

-- Calculates the Total Mass in a Body.
function Knockback.CalculateTotalMass(Model : Model) : number
    assert(Model and Model:IsA("Model"), "Type (Model) is not a Model!");
    
    local TotMass = 0;

    for Index, BodyPart: Instance in pairs(Model:GetDescendants()) do
        if BodyPart:IsA("Part") then
            TotMass += BodyPart.AssemblyMass
        end;
    end;

    return TotMass;
end
-- Starts / Impulses the Knockback Force.
function Knockback.Impulse(characterEntity : CharacterEntity.CharacterEntity, targetEntity : CharacterEntity.CharacterEntity, AdditionalArgs)
    local User = characterEntity.CurrentCharacterModel;
    local Target = targetEntity.CurrentCharacterModel;

    local Range = AdditionalArgs.Range or 10;
    local Height = AdditionalArgs.Height or 10;

    local Mass = Knockback.CalculateTotalMass(Target);

    if not User.PrimaryPart then return warn(`{User.Name} has no PrimaryPart`) end
    local LookDirection = User.PrimaryPart.CFrame.LookVector;
    local UpDirection = Vector3.new(0, Mass * Height, 0);

    --Target.PrimaryPart:SetNetworkOwner(nil);
    if not Target.PrimaryPart then return warn(`{Target.Name} has no PrimaryPart`) end
    Target.PrimaryPart:ApplyImpulse(LookDirection * Mass * Range + UpDirection);
end

return Knockback