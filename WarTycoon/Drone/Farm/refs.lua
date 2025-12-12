-- M5WARE Team Bypass & Immortality Loader | War Tycoon 2025
-- Теперь запускается ТОЛЬКО по кнопке ON в GUI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

local TARGET_TEAM = "Alpha"
local hasTeleported = false
local scriptActivated = false  -- Флаг активации

-- ================== ВСЁ НИЖЕ БУДЕТ РАБОТАТЬ ТОЛЬКО ПОСЛЕ НАЖАТИЯ КНОПКИ ==================

local function enableImmortality(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum.WalkSpeed = 50
        hum.JumpPower = 100
        hum.HealthChanged:Connect(function(h)
            if h < math.huge then hum.Health = math.huge end
        end
    end
end

local function forceToTargetTeam()
    for _, team in pairs(game:GetService("Teams"):GetTeams()) do
        if string.lower(team.Name) == string.lower(TARGET_TEAM) then
            if player.Team ~= team then
                player.Team = team
            end
            return true
        end
    end
    return false
end

local function removeBaseSelectionElements()
    pcall(function()
        local paths = {
            "UI.Container.Overlay.StartMenu.MainMenu.Options.ChooseBase",
            "UI.Container.Screen.BaseSelect",
            "UI.Container.Screen.MissileUI.Frame.Body.Main.Container.BaseSelector"
        }
        for _, path in ipairs(paths) do
            local obj = player.PlayerGui
            for part in path:gmatch("[^%.]+") do
                if obj then obj = obj:FindFirstChild(part) end
            end
            if obj then obj:Destroy() end
        end
    end)
end

local function loadDefaultRobloxTab()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
        game:GetService("StarterGui"):SetCore("ChatActive", true)
    end)
end

-- Полноценный лоадер с белыми точками (как у тебя был)
local function showM5WareLoader()
    -- (твой оригинальный код лоадера полностью сохранён)
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999
    gui.Parent = pgui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(2,0,2,0)
    bg.Position = UDim2.new(-0.5,0,-0.5,0)
    bg.BackgroundColor3 = Color3.fromRGB(10,10,25)
    bg.BackgroundTransparency = 1
    bg.Parent = gui

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20,10,50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70,25,100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,30))
    }
    grad.Rotation = 45
    grad.Parent = bg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0,800,0,200)
    title.Position = UDim2.new(0.5,-400,0.4,-100)
    title.AnchorPoint = Vector2.new(0.5, 0.5)
    title.BackgroundTransparency = 1
    title.Text = ""
    title.TextColor3 = Color3.fromRGB(255,200,50)
    title.TextTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 130
    title.TextStrokeTransparency = 0.3
    title.TextStrokeColor3 = Color3.fromRGB(200,100,0)
    title.Parent = bg

    local bug = Instance.new("TextLabel")
    bug.Size = UDim2.new(0,1000,0,80)
    bug.Position = UDim2.new(0.5,-500,0.55,0)
    bug.AnchorPoint = Vector2.new(0.5, 0.5)
    bug.BackgroundTransparency = 1
    bug.Text = ""
    bug.TextColor3 = Color3.fromRGB(255,50,50)
    bug.TextTransparency = 1
    bug.Font = Enum.Font.GothamBold
    bug.TextSize = 52
    bug.Parent = bg

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(0,700,0,60)
    sub.Position = UDim2.new(0.5,-350,0.65,0)
    sub.AnchorPoint = Vector2.new(0.5, 0.5)
    sub.BackgroundTransparency = 1
    sub.Text = "by pavel & forward & BlueNexus"
    sub.TextColor3 = Color3.fromRGB(180,230,255)
    sub.TextTransparency = 1
    sub.Font = Enum.Font.GothamBold
    sub.TextSize = 38
    sub.Parent = bg

    local particles = Instance.new("Frame")
    particles.Size = UDim2.new(1,0,1,0)
    particles.BackgroundTransparency = 1
    particles.Parent = bg

    local dots = {}
    local camSize = workspace.CurrentCamera.ViewportSize

    for i = 1, 120 do
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, math.random(3,8), 0, math.random(3,8))
        dot.BackgroundColor3 = Color3.new(1,1,1)
        dot.BorderSizePixel = 0
        dot.BackgroundTransparency = 1
        dot.Position = UDim2.new(0, math.random(-50, camSize.X+50), 0, math.random(-100, -20))
        dot.Parent = particles

        local speed = math.random(300, 700)
        local angle = math.random(-20, 20)

        table.insert(dots, {obj = dot, speed = speed, angle = angle})
    end

    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        for _, d in dots do
            local pos = d.obj.Position
            local newY = pos.Y.Offset + d.speed * dt
            local newX = pos.X.Offset + d.angle * dt * 50

            if newY > camSize.Y + 50 then
                newY = -50
                newX = math.random(-50, camSize.X + 50)
            end

            d.obj.Position = UDim2.new(0, newX, 0, newY)
        end
    end)

    TweenService:Create(bg, TweenInfo.new(0.9), {BackgroundTransparency = 0}):Play()
    task.wait(0.7)
    for _, d in dots do
        TweenService:Create(d.obj, TweenInfo.new(1), {BackgroundTransparency = 0.4}):Play()
    end

    for _, letter in {"M","5","W","A","R","E"} do
        title.Text ..= letter
        TweenService:Create(title, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
        task.wait(0.22)
    end

    task.wait(0.3)
    local txt = "itss bug godmode wait for fix"
    for i = 1, #txt do
        bug.Text = txt:sub(1,i)
        TweenService:Create(bug, TweenInfo.new(0.06), {TextTransparency = 0}):Play()
        task.wait(0.06)
    end

    TweenService:Create(sub, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
    task.wait(1.8)

    return gui, bg, title, bug, sub, dots, conn
end

local function hideM5WareLoader(gui, bg, title, bug, sub, dots, conn)
    TweenService:Create(title, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(bug, TweenInfo.new(1), {TextTransparency = 1}):Play()
    TweenService:Create(sub, TweenInfo.new(1), {TextTransparency = 1}):Play()
    for _, d in dots do
        TweenService:Create(d.obj, TweenInfo.new(1.2), {BackgroundTransparency = 1}):Play()
    end
    task.wait(1)
    TweenService:Create(bg, TweenInfo.new(1.4), {BackgroundTransparency = 1}):Play()
    task.wait(1.5)
    if conn then conn:Disconnect() end
    if gui then gui:Destroy() end
end

-- Основной запуск чита
local function activateCheat()
    if scriptActivated then return end
    scriptActivated = true

    local loaderGui, bg, title, bug, sub, dots, conn = showM5WareLoader()

    hasTeleported = false
    forceToTargetTeam()

    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    pcall(function() game:GetService("Chat").LoadDefaultChat = true end)

    if player.Character then player.Character:BreakJoints() end

    local character = player.CharacterAdded:Wait()
    task.wait(2)
    enableImmortality(character)
    removeBaseSelectionElements()
    loadDefaultRobloxTab()

    if not hasTeleported then
        local hrp = character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(0, 100, 0)
        hasTeleported = true
    end

    task.wait(0.5)
    local camera = workspace.CurrentCamera
    camera.CameraType = Enum.CameraType.Custom
    camera.CameraSubject = character.Humanoid
    local hrp = character:WaitForChild("HumanoidRootPart")
    camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 5, 10), hrp.Position)

    task.wait(1)
    hideM5WareLoader(loaderGui, bg, title, bug, sub, dots, conn)

    -- Постоянный контроль команды
    task.spawn(function()
        while scriptActivated do
            task.wait(3)
            forceToTargetTeam()
        end
    end)
end

-- ================== GUI С КНОПКОЙ ON ==================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "M5WARE_Menu"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999999
screenGui.Parent = pgui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 220)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 40))
}
gradient.Rotation = 90
gradient.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 70)
title.BackgroundTransparency = 1
title.Text = "M5WARE"
title.TextColor3 = Color3.fromRGB(255, 200, 80)
title.Font = Enum.Font.GothamBlack
title.TextSize = 56
title.Parent = mainFrame

local onButton = Instance.new("TextButton")
onButton.Size = UDim2.new(0, 260, 0, 90)
onButton.Position = UDim2.new(0.5, -130, 1, -120)
onButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
onButton.Text = "ON"
onButton.TextColor3 = Color3.new(1, 1, 1)
onButton.Font = Enum.Font.GothamBlack
onButton.TextSize = 64
onButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 14)
btnCorner.Parent = onButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255, 120, 120)
btnStroke.Thickness = 3
btnStroke.Parent = onButton

-- Эффект нажатия и запуск чита
onButton.MouseButton1Click:Connect(function()
    onButton.Text = "ACTIVATED"
    onButton.BackgroundColor3 = Color3.fromRGB(70, 255, 70)
    btnStroke.Color = Color3.fromRGB(100, 255, 100)
    task.wait(0.5)
    screenGui:Destroy()  -- Убираем меню после активации
    activateCheat()
end)

-- Пульсация кнопки (красиво)
task.spawn(function()
    while screenGui.Parent do
        TweenService:Create(onButton, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Size = UDim2.new(0, 280, 0, 96)
        }):Play()
        task.wait(2.4)
    end
end)
