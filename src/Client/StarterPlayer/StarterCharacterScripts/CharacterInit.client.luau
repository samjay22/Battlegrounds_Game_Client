--!strict

local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")
Humanoid.BreakJointsOnDeath = false

local function OnHumanoidDied()
	for _, Part in ipairs(Character:GetChildren()) do
		if Part:IsA("BasePart") then
			local Motor6D = Part:FindFirstChildWhichIsA("Motor6D")
			if Motor6D then
				if Part.Name ~= "Head" then
					local BallSocket = Instance.new("BallSocketConstraint")
					local Attachment1 = Instance.new("Attachment")
					local Attachment2 = Instance.new("Attachment")
					Attachment1.CFrame = Motor6D.C0
					Attachment2.CFrame = Motor6D.C1
					Attachment1.Parent = Motor6D.Part0
					Attachment2.Parent = Motor6D.Part1
					BallSocket.Attachment0 = Attachment1
					BallSocket.Attachment1 = Attachment2
					BallSocket.Parent = Motor6D.Parent
					Motor6D:Destroy()
				elseif Part.Name == "Head" then
					local WeldConstraint = Instance.new("WeldConstraint")
					WeldConstraint.Part0 = Motor6D.Part0
					WeldConstraint.Part1 = Motor6D.Part1
					WeldConstraint.Parent = Motor6D.Parent
				end
			end
		end
	end
end

Humanoid.Died:Once(OnHumanoidDied)