--! strict
--! optimize 2

--[[
    @author: idkfr
    @desc: Creates an Accurate Knockback force using :ApplyImpulse.

    @methods: {
        Knockback.new(User: Model, Target: Model, Range: number, Height: number)
        -- Creates the Knockback Force.

        Knockback:Start()
        -- Starts / Impulses the Knockback Force.
        _______________________________________________________________

        Knockback:Impulse(User: Model, Target: Model, Range: number, Height: number, DelayTime: number?)
        -- Instantly Creates and Impulses a Force.
    }
--]]

local Knockback = {}
Knockback.__index = Knockback

-- Calculates the Total Mass in a Body.
function Knockback:CalculateTotalMass(Model : Model) : number
    assert(Model and Model:IsA("Model"), "Type (Model) is not a Model!");
    
    local TotMass = 0;

    for Index, BodyPart: Instance in pairs(Model:GetDescendants()) do
        if BodyPart:IsA("Part") then
            TotMass += BodyPart.AssemblyMass
        end;
    end;

    return TotMass;
end

-- Creates the Knockback Force.
function Knockback.new(User: Model, Target: Model, Range: number, Height: number)
    local self = setmetatable({
        _User = User,
        _Target = Target,
        _Range = Range,
        _Height = Height,
    }, Knockback);

    return self
end

-- Starts / Impulses the Knockback Force.
function Knockback:Start()
    local User = self._User;
    local Target = self._Target;

    local Range = self._Range;
    local Height = self._Height;

    local Mass = Knockback:CalculateTotalMass(Target);

    local LookDirection = User.PrimaryPart.CFrame.LookVector;
    local UpDirection = Vector3.new(0, Mass * Height, 0);

    --Target.PrimaryPart:SetNetworkOwner(nil);

    Target.PrimaryPart:ApplyImpulse(LookDirection * Mass * Range + UpDirection);

    task.delay(2.5, function()
        setmetatable(self, nil)
    end)
end

-- Instantly Creates and Impulses a Force.
function Knockback:Impulse(User: Model, Target: Model, Range: number, Height: number)
    if not User.PrimaryPart or not Target.PrimaryPart then return end
    
    local Mass = Knockback:CalculateTotalMass(Target);
    local LookDirection = User.PrimaryPart.CFrame.LookVector;
    local UpDirection = Vector3.new(0, Mass * Height, 0);

    --Target.PrimaryPart:SetNetworkOwner(nil);

    Target.PrimaryPart:ApplyImpulse(LookDirection * Mass * Range + UpDirection);
    
    task.delay(2.5, function()
        setmetatable(self, nil)
    end)
end

return Knockback