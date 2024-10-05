--// Fully made by @sakupenny, comments are made by me too.

--// define locally so they can't be changed mid usage
local JerkOffSpeed = getgenv().JERK_OFF_SPEED
local KeepOnDeath = getgenv().KEEP_ON_DEATH

--// player defintion
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 1)
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1) or Character.PrimaryPart

--// check if not R6
if not Character:FindFirstChild("Torso") then
    warn("Must be R6")
    return
end

--// check if already executed
if getgenv().JerkOffExecuted then
    warn("Already executed")
    return
end

getgenv().JerkOffExecuted = true

--// the animations of the script
local MAIN_ANIMATIONS = {
    JERK_OFF = "rbxassetid://99198989",
    CLOSER_HANDS = "rbxassetid://168086975",
}

--// this is a boolean named "JerkingOff"🤯
local JerkingOff = false

--// making the tool in 
local JerkTool = Instance.new("Tool")
JerkTool.Name = "Jerk Off"
JerkTool.RequiresHandle = false
JerkTool.Parent = game:GetService("ReplicatedStorage")

--// on respawn
Player.CharacterAdded:Connect(function()
    --// redefine character on respawn
    Character = Player.Character
    Humanoid = Character:WaitForChild("Humanoid", 1)
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1) or Character.PrimaryPart

    --// tool give
    if KeepOnDeath then
        --// clones the tool from replicatedStorage
        local new_tool = JerkTool:Clone()
        new_tool.Parent = Player.Backpack
        
        --// set JerkingOff to true or false based on if it's equipped
        new_tool.Equipped:Connect(function()
            JerkingOff = true
        end)

        new_tool.Unequipped:Connect(function()
            JerkingOff = false
        end)
    end

    --// disable on death
    Humanoid.Died:Connect(function()
        JerkingOff = false
        if not KeepOnDeath then
            getgenv().JerkOffExecuted = false
        end
    end)
end)

--// give on execute
local new_tool = JerkTool:Clone()
new_tool.Parent = Player.Backpack

--// set JerkingOff to true or false based on if it's equipped
new_tool.Equipped:Connect(function()
    JerkingOff = true
end)

new_tool.Unequipped:Connect(function()
    JerkingOff = false
end)

--// disable on death
Humanoid.Died:Connect(function()
    JerkingOff = false
    if not KeepOnDeath then
        getgenv().JerkOffExecuted = false
    end
end)

--// main loop
local jerkoffTrack
local closerhandsTrack
local setToOriginalValues = true

game:GetService("RunService").RenderStepped:Connect(function()
    if not Humanoid then
        return --// exit if Humanoid is not defined
    end
    if JerkingOff then
        setToOriginalValues = true
        Humanoid.WalkSpeed = 0 --// set walk speed to 0 while jerking off
        Humanoid.JumpPower = 0 --// set jump power to 0 while jerking off

        --// check if jerkoffTrack is not playing
        if not jerkoffTrack then
            local anim = Instance.new("Animation")
            anim.AnimationId = MAIN_ANIMATIONS.JERK_OFF
            jerkoffTrack = Humanoid:LoadAnimation(anim)
            jerkoffTrack.Looped = true
            jerkoffTrack:Play()
            jerkoffTrack:AdjustSpeed(JerkOffSpeed)
        end
      
        --// check if closerhandsTrack is not playing
        if not closerhandsTrack then
            local anim = Instance.new("Animation")
            anim.AnimationId = MAIN_ANIMATIONS.CLOSER_HANDS
            closerhandsTrack = Humanoid:LoadAnimation(anim)
            closerhandsTrack:Play()
            closerhandsTrack:AdjustSpeed(JerkOffSpeed)
        end
    elseif setToOriginalValues then
        setToOriginalValues = false
        Humanoid.WalkSpeed = 16 --// reset walk speed
        Humanoid.JumpPower = 50 --// reset jump power
        --// stop animations if they are playing
        if jerkoffTrack then
            jerkoffTrack:Stop()
            jerkoffTrack = nil
        end
        if closerhandsTrack then
            closerhandsTrack:Stop()
            closerhandsTrack = nil
        end
    end
end)
