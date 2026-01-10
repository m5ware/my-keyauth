local SYC = {
    Modules = {
        UI = {}
    }
}

if not getgenv().SYC then
    getgenv().SYC = SYC
end

getgenv().playerService = game:GetService("Players")
getgenv().coreguiService = game:GetService("CoreGui")
getgenv().tweenService = game:GetService("TweenService")
getgenv().inputService = game:GetService("UserInputService")
getgenv().rsService = game:GetService("RunService")
getgenv().textService = game:GetService("TextService")
getgenv().httpService = game:GetService("HttpService")

local LocalPlayer = playerService.LocalPlayer

local Color3FromRGB = Color3.fromRGB
local Vector2New = Vector2.new
local UDim2New = UDim2.new
local InstanceNew = Instance.new
local TaskWait = task.wait

local ModuleHandler = (function()
    local ModuleHandler = {}
    
    function ModuleHandler:include(ModuleName)
        if not SYC then return end
        if not SYC.Modules then return end
    
        if not type(ModuleName) == "string" then return end
    
        local Modules = SYC.Modules
        return Modules[ModuleName]
    end
    
    getgenv().include = function (modname) return ModuleHandler:include(modname) end 
    return ModuleHandler
end)()

do
    do
        function SYC.Modules.UI:GetTextBoundary(Text, Font, Size, Resolution)
            local Bounds = textService:GetTextSize(Text, Size, Font, Resolution or Vector2New(1920, 1080))
            return Bounds.X, Bounds.Y
        end
    end
end

local UserInterface = (function()
    local UserInterface = {
        Instances = {},
        Popup = nil,
        KeybindsListObjects = {},
        KeybindList = nil,
    
        Flags = {},
        ConfigFlags = {}
    }
    
    getgenv().theme = {
        accent = Color3FromRGB(168, 157, 159)
    }
    
    getgenv().theme_event = Instance.new('BindableEvent')
    
    getgenv().UI = UserInterface.Instances
    local UIModule = include "UI"
    
    local dragging, dragInput, dragStart, startPos, dragObject
    
    local FlagCount = 0
    function UserInterface:GetNextFlag()
        FlagCount = FlagCount + 1
        return tostring(FlagCount)
    end
    
    function UserInterface:Create(OptionsLaughtOutLouds)
        local Configuration = {
            Tabs = {},
            Title = OptionsLaughtOutLouds.title or 'syndicate<font color="rgb(129, 127, 127)">.club</font>'
        }

        local Texts = {
            "59d4",
        }

        local function ChangeText(Object, NewText)
            tweenService:Create(Object, TweenInfo.new(0.2), {TextTransparency = 0.5}):Play()
            Object.Text = NewText
            TaskWait(0.1)

            tweenService:Create(Object, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        end
        
        UI["1"] = InstanceNew("ScreenGui", coreguiService)
        UI["1"]["Name"] = [[syndicate.club]]
        UI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Global

        UI["2"] = InstanceNew("Frame", UI["1"])
        UI["2"]["BorderSizePixel"] = 0
        UI["2"]["BackgroundColor3"] = Color3FromRGB(24, 24, 24)
        UI["2"]["Size"] = UDim2New(0, 562, 0, 459)
        UI["2"]["Position"] = UDim2New(0, 527, 0, 168)
        UI["2"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["2"]["Name"] = [[BackgroundFrame]]
        
        UI["3"] = InstanceNew("UICorner", UI["2"])
        UI["3"]["Name"] = [[BackgroundCorner]]
        
        UI["4"] = InstanceNew("UIStroke", UI["2"])
        UI["4"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
        UI["4"]["Name"] = [[BackgroundStroke]]
        UI["4"]["Thickness"] = 2
        UI["4"]["Color"] = Color3FromRGB(31, 33, 31)
        
        UI["5"] = InstanceNew("TextLabel", UI["2"])
        UI["5"]["TextStrokeTransparency"] = 0
        UI["5"]["BorderSizePixel"] = 0
        UI["5"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["5"]["TextSize"] = 16
        UI["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        UI["5"]["TextColor3"] = Color3FromRGB(255, 255, 255)
        UI["5"]["BackgroundTransparency"] = 1
        UI["5"]["Size"] = UDim2New(0, 81, 0, 20)
        UI["5"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["5"]["Text"] = Configuration.Title
        UI["5"]["Name"] = [[MainTitle]]
        UI["5"]["Position"] = UDim2New(0, 15, 0, 12)
        UI["5"]["RichText"] = true
        UI["5"]["TextXAlignment"] = Enum.TextXAlignment.Left

        UI["6"] = InstanceNew("Frame", UI["2"])
        UI["6"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["6"]["Size"] = UDim2New(0, 1, 0, 16)
        UI["6"]["Position"] = UDim2New(0, 98, 0, 14)
        UI["6"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["6"]["Name"] = [[BackgroundAccent]]

        UI["7"] = InstanceNew("Frame", UI["2"])
        UI["7"]["BorderSizePixel"] = 0
        UI["7"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["7"]["Size"] = UDim2New(0, 456, 0, 16)
        UI["7"]["Position"] = UDim2New(0, 105, 0, 14)
        UI["7"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["7"]["Name"] = [[TabsList]]
        UI["7"]["BackgroundTransparency"] = 1

        UI["9"] = InstanceNew("UIListLayout", UI["7"])
        UI["9"]["Padding"] = UDim.new(0, 5)
        UI["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder
        UI["9"]["Name"] = [[TabsListLayout]]
        UI["9"]["FillDirection"] = Enum.FillDirection.Horizontal

        UI["a"] = InstanceNew("TextLabel", UI["2"])
        UI["a"]["TextWrapped"] = false
        UI["a"]["TextStrokeTransparency"] = 0
        UI["a"]["BorderSizePixel"] = 0
        UI["a"]["TextXAlignment"] = Enum.TextXAlignment.Right
        UI["a"]["TextScaled"] = false
        UI["a"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["a"]["TextSize"] = 16
        UI["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        UI["a"]["TextColor3"] = Color3FromRGB(255, 255, 255)
        UI["a"]["BackgroundTransparency"] = 1
        UI["a"]["Size"] = UDim2New(0, 452, 0, 19)
        UI["a"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["a"]["Text"] = [[powered by astro.space]]
        UI["a"]["Name"] = [[CreditTitle]]
        UI["a"]["Position"] = UDim2New(0, 96, 0, 428)

        UI["b"] = InstanceNew("Frame", UI["2"])
        UI["b"]["BorderSizePixel"] = 0
        UI["b"]["BackgroundColor3"] = Color3FromRGB(17, 17, 17)
        UI["b"]["Size"] = UDim2New(0, 533, 0, 378)
        UI["b"]["Position"] = UDim2New(0.027, 0,0.095, 0)
        UI["b"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["b"]["Name"] = [[MainFrame]]

        local MainFrameShadow1 = Instance.new("Frame")
        local MF_SHADOW1 = Instance.new("UIGradient")
        
        MainFrameShadow1.Name = "MainFrameShadow1"
        MainFrameShadow1.Parent = UI["b"]
        MainFrameShadow1.ZIndex = 2
        MainFrameShadow1.Size = UDim2.new(1, 0, 0.039682541, 0)
        MainFrameShadow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MainFrameShadow1.Position = UDim2.new(0, 0, 0.960317433, 0)
        MainFrameShadow1.BorderSizePixel = 0
        MainFrameShadow1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        
        MF_SHADOW1.Name = "MF_SHADOW1"
        MF_SHADOW1.Parent = MainFrameShadow1
        MF_SHADOW1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.004552352242171764, 0.11475414037704468), NumberSequenceKeypoint.new(0.030349012464284897, 0.3606557846069336), NumberSequenceKeypoint.new(0.6358118057250977, 1), NumberSequenceKeypoint.new(0.9998999834060669, 1), NumberSequenceKeypoint.new(1, 0)})
        MF_SHADOW1.Rotation = -90

        local MainFrameShadow2 = Instance.new("Frame")
        local MF_SHADOW2 = Instance.new("UIGradient")
        
        MainFrameShadow2.Name = "MainFrameShadow2"
        MainFrameShadow2.Parent = UI["b"]
        MainFrameShadow2.ZIndex = 2
        MainFrameShadow2.Size = UDim2.new(1, 0, 0.0399999991, 0)
        MainFrameShadow2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MainFrameShadow2.BorderSizePixel = 0
        MainFrameShadow2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        
        MF_SHADOW2.Name = "MF_SHADOW2"
        MF_SHADOW2.Parent = MainFrameShadow2
        MF_SHADOW2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.004552352242171764, 0.11475414037704468), NumberSequenceKeypoint.new(0.030349012464284897, 0.3606557846069336), NumberSequenceKeypoint.new(0.6358118057250977, 1), NumberSequenceKeypoint.new(0.9998999834060669, 1), NumberSequenceKeypoint.new(1, 0)})
        MF_SHADOW2.Rotation = 90

        UI["c"] = InstanceNew("UICorner", UI["b"])
        UI["c"]["Name"] = [[MainFrameCorner]]

        UI["d"] = InstanceNew("UIStroke", UI["b"])
        UI["d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
        UI["d"]["Name"] = [[MainFrameStroke]]
        UI["d"]["Color"] = Color3FromRGB(29, 29, 29)

        UI["e"] = InstanceNew("Folder", UI["2"])
        UI["e"]["Name"] = [[Sections]]

        local Shadow1 = Instance.new("ImageLabel")

        Shadow1.Name = "Shadow1"
        Shadow1.Parent = UI["2"]
        Shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow1.ZIndex = 0
        Shadow1.Size = UDim2.new(1.7, 0,2.843, 0)
        Shadow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.Rotation = 90
        Shadow1.BackgroundTransparency = 1
        Shadow1.Position = UDim2.new(0.468, 0,0.495, 0)
        Shadow1.BorderSizePixel = 0
        Shadow1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shadow1.ImageColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.ScaleType = Enum.ScaleType.Tile
        Shadow1.Image = "rbxassetid://8992230677"
        Shadow1.SliceCenter = Rect.new(Vector2.new(0, 0), Vector2.new(99, 99))

        local text_coroutine = coroutine.create(function ()
            while TaskWait() do
                for i = 1, #Texts do
                    TaskWait(2)
                    ChangeText(UI["a"], Texts[i])
                end
            end
        end)
        coroutine.resume(text_coroutine)

        function Configuration:Tab( Tab_Name )
            if not type(Tab_Name) == "string" then return end

            local TabConfiguration = { Sections = {} }

            local X = UIModule:GetTextBoundary(Tab_Name, Enum.Font.SourceSans, 16)
            UI["8"] = InstanceNew("TextButton", UI["7"])
            UI["8"]["TextStrokeTransparency"] = 0
            UI["8"]["BorderSizePixel"] = 0
            UI["8"]["TextSize"] = 16
            UI["8"]["TextColor3"] = Color3FromRGB(137, 137, 139)
            UI["8"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            UI["8"]["Size"] = UDim2New(0, X, 1, 0)
            UI["8"]["BackgroundTransparency"] = 1
            UI["8"]["Name"] = [[TabButton]]
            UI["8"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
            UI["8"]["Text"] = Tab_Name

            UI["f"] = InstanceNew("Frame", UI["e"])
            UI["f"]["Active"] = true
            UI["f"]["BorderSizePixel"] = 0
            UI["f"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            UI["f"]["Name"] = [[MainSectionFrame]]
            UI["f"]["Position"] = UDim2New(0.028, 0,0.142, 0)
            UI["f"]["Size"] = UDim2New(0, 530, 0, 378)
            UI["f"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
            UI["f"]["BackgroundTransparency"] = 1
            UI["f"]["Position"] = UDim2New(0.027, 0, 0.095, 0)

            local MSFrame = UI["f"]

            local leftblah = InstanceNew("ScrollingFrame", UI["f"])
            leftblah["Active"] = true
            leftblah["BorderSizePixel"] = 0
            leftblah["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            leftblah["Name"] = [[Left]]
            leftblah["ScrollBarImageTransparency"] = 0
            leftblah["Size"] = UDim2New(0, 265, 1, 0)
            leftblah["ScrollBarImageColor3"] = Color3FromRGB(0, 255, 255)
            leftblah["BorderColor3"] = Color3FromRGB(0, 0, 0)
            leftblah["ScrollBarThickness"] = 3
            leftblah["BackgroundTransparency"] = 1
            leftblah.AutomaticCanvasSize = Enum.AutomaticSize.Y
            leftblah["Position"] = UDim2New(0, 0, 0, 0)
            leftblah.BottomImage = ""
            leftblah.TopImage = ""

            theme_event.Event:Connect(function ()
                leftblah.ScrollBarImageColor3 = theme.scroll
            end)

            UI["11"] = InstanceNew("UIPadding", leftblah)
            UI["11"]["PaddingTop"] = UDim.new(0, 18)
            UI["11"]["Name"] = [[LeftColumnPadding]]
            UI["11"]["PaddingLeft"] = UDim.new(0, 7)

            local rightblahInstance = InstanceNew("ScrollingFrame", UI["f"])
            rightblahInstance["Active"] = true
            rightblahInstance["BorderSizePixel"] = 0
            rightblahInstance["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            rightblahInstance["Name"] = [[Right]]
            rightblahInstance["ScrollBarImageTransparency"] = 0
            rightblahInstance["Size"] = UDim2New(0, 265, 1, 0)
            rightblahInstance["ScrollBarImageColor3"] = Color3FromRGB(0, 255, 255)
            rightblahInstance["BorderColor3"] = Color3FromRGB(0, 0, 0)
            rightblahInstance["ScrollBarThickness"] = 3
            rightblahInstance["BackgroundTransparency"] = 1
            rightblahInstance.AutomaticCanvasSize = Enum.AutomaticSize.Y
            rightblahInstance["Position"] = UDim2New(0, 265, 0, 0)
            rightblahInstance.BottomImage = ""
            rightblahInstance.TopImage = ""

            theme_event.Event:Connect(function ()
                rightblahInstance.ScrollBarImageColor3 = theme.scroll
            end)

            UI["20"] = InstanceNew("UIPadding", rightblahInstance)
            UI["20"]["PaddingTop"] = UDim.new(0, 18)
            UI["20"]["PaddingRight"] = UDim.new(0, 7)
            UI["20"]["PaddingLeft"] = UDim.new(0, 6)
            UI["20"]["Name"] = [[RightColumnPadding]]

            UI["LISTLAYOUT_LEFT"] = InstanceNew("UIListLayout")
            UI["LISTLAYOUT_LEFT"].Name = "LeftColumnList"
            UI["LISTLAYOUT_LEFT"].Parent = leftblah
            UI["LISTLAYOUT_LEFT"].SortOrder = Enum.SortOrder.LayoutOrder
            UI["LISTLAYOUT_LEFT"].Padding = UDim.new(0, 19)

            UI["LISTLAYOUT_RIGHT"] = InstanceNew("UIListLayout")
            UI["LISTLAYOUT_RIGHT"].Name = "RightColumnList"
            UI["LISTLAYOUT_RIGHT"].Parent = rightblahInstance
            UI["LISTLAYOUT_RIGHT"].SortOrder = Enum.SortOrder.LayoutOrder
            UI["LISTLAYOUT_RIGHT"].Padding = UDim.new(0, 19)

            local localization = UI['LISTLAYOUT_LEFT']
            local localization2 = UI["LISTLAYOUT_RIGHT"]

            localization.Changed:Connect(function ()
                leftblah.CanvasSize = UDim2New(0, 0, 0, 100 + localization.AbsoluteContentSize.Y)
            end)

            localization2.Changed:Connect(function ()
                rightblahInstance.CanvasSize = UDim2New(0, 0, 0, 100 + localization2.AbsoluteContentSize.Y)
            end)

            TabConfiguration.Button = UI["8"]
            TabConfiguration.MainSectionFrame = MSFrame
            TabConfiguration.Left = leftblah
            TabConfiguration.Right = rightblahInstance

            function TabConfiguration:Select()
                for i, v in next, UI["e"]:GetChildren() do
                    if v:IsA("UIListLayout") then return end
                    v.Visible = false
                end
                for i, v in next, UI["7"]:GetChildren() do
                    if v:IsA("TextButton") then
                        v.TextColor3 = Color3FromRGB(137, 137, 139)
                    end
                end
                TabConfiguration.Button.TextColor3 = Color3FromRGB(255,255,255)
                TabConfiguration.MainSectionFrame.Visible = true
            end
            
            TabConfiguration.Button.MouseButton1Click:Connect(function ()
                TabConfiguration:Select()
            end)

            function TabConfiguration:Section( Section_Name, Side )
                if not type(Section_Name) == "string" then return end
                if not type(Side) == "string" then return end

                local SectionSide = Side == "right" and TabConfiguration.Right or TabConfiguration.Left
                local Options = {}

                local MainFrameThingy = InstanceNew("Frame", SectionSide)
                MainFrameThingy["BorderSizePixel"] = 0
                MainFrameThingy["BackgroundColor3"] = Color3FromRGB(28, 28, 28)
                MainFrameThingy["Size"] = UDim2New(0, 247, 0, 20)
                MainFrameThingy["Position"] = UDim2New(0, 6, 0, 0)
                MainFrameThingy["BorderColor3"] = Color3FromRGB(0, 0, 0)
                MainFrameThingy["Name"] = [[Column]]

                local MFSTROKE = InstanceNew("UIStroke", MainFrameThingy)
                MFSTROKE["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                MFSTROKE["Name"] = [[ColumnStroke]]
                MFSTROKE["Color"] = Color3FromRGB(37, 37, 37)

                local uicornerthingyy = InstanceNew("UICorner", MainFrameThingy)
                uicornerthingyy["Name"] = [[ColumnCorner]]

                local titlethinggyy = InstanceNew("TextLabel", MainFrameThingy)
                titlethinggyy["TextStrokeTransparency"] = 0
                titlethinggyy["BorderSizePixel"] = 0
                titlethinggyy["TextXAlignment"] = Enum.TextXAlignment.Left
                titlethinggyy["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                titlethinggyy["TextSize"] = 14
                titlethinggyy["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                titlethinggyy["TextColor3"] = Color3FromRGB(255, 255, 255)
                titlethinggyy["BackgroundTransparency"] = 1
                titlethinggyy["Size"] = UDim2New(0, 229, 0, -4)
                titlethinggyy["BorderColor3"] = Color3FromRGB(0, 0, 0)
                titlethinggyy["Text"] = Section_Name
                titlethinggyy["Name"] = [[ColumnTitle]]
                titlethinggyy["Position"] = UDim2New(0, 8, 0, 0)

                local uilistlayoutthingy = InstanceNew("UIListLayout", MainFrameThingy)
                uilistlayoutthingy["Padding"] = UDim.new(0, 13)
                uilistlayoutthingy["SortOrder"] = Enum.SortOrder.LayoutOrder
                uilistlayoutthingy["Name"] = [[ColumnListLayout]]

                local paddingthingy = InstanceNew("UIPadding", MainFrameThingy)
                paddingthingy["Name"] = [[ColumnPadding]]
                paddingthingy["PaddingLeft"] = UDim.new(0, 9)

                local SectionColumnComponents = InstanceNew("Frame", MainFrameThingy)
                SectionColumnComponents["BorderSizePixel"] = 0
                SectionColumnComponents["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                SectionColumnComponents["Size"] = UDim2New(0, 229, 0, 0)
                SectionColumnComponents["Position"] = UDim2New(0, 0, 0, 13)
                SectionColumnComponents["BorderColor3"] = Color3FromRGB(0, 0, 0)
                SectionColumnComponents["Name"] = tostring(math.random(10000,16384))
                SectionColumnComponents["BackgroundTransparency"] = 1

                local aujodnousnd = InstanceNew("UIListLayout", SectionColumnComponents)
                aujodnousnd["Padding"] = UDim.new(0, 4)
                aujodnousnd["SortOrder"] = Enum.SortOrder.LayoutOrder
                aujodnousnd["Name"] = [[ColumnComponentsList]]

                local function increaseYSize(sizeY, Custom)
                    SectionColumnComponents["Size"] += UDim2New(0, 0, 0, sizeY)
                    MainFrameThingy.Size = UDim2New(0, 247, 0, 22 + aujodnousnd.AbsoluteContentSize.Y)
                end

                do
                    do
                        function Options:BoneSelector(Configuration)
                            local BoneSelectorOptions = {
                                Type = Configuration.type or "R15",
                                Callback = Configuration.callback or function() end,
                                Default = Configuration.default or nil,
                                Flag = UserInterface:GetNextFlag(),
                                Multi = Configuration.multi or false
                            }
                        
                            local BoneSelector = {
                                FValues = {},
                                FValue = BoneSelectorOptions.Multi and {} or "",
                            }
                        
                            local BoneSelectorHolder = InstanceNew("Frame")
                            local BSHStroke = InstanceNew("UIStroke")
                            local BSHCorner = InstanceNew("UICorner")
                            local R15 = InstanceNew("Frame")
                            local Head = Instance.new("TextButton")
                            local HumanoidRootPart = Instance.new("TextButton")
                            local LeftHand = Instance.new("TextButton")
                            local LeftLowerArm = Instance.new("TextButton")
                            local LowerTorso = Instance.new("TextButton")
                            local LeftUpperArm = Instance.new("TextButton")
                            local RightHand = Instance.new("TextButton")
                            local RightUpperArm = Instance.new("TextButton")
                            local RightLowerArm = Instance.new("TextButton")
                            local UpperTorso = Instance.new("TextButton")
                            local LeftUpperLeg = Instance.new("TextButton")
                            local LeftLowerLeg = Instance.new("TextButton")
                            local LeftFoot = Instance.new("TextButton")
                            local RightFoot = Instance.new("TextButton")
                            local RightUpperLeg = Instance.new("TextButton")
                            local RightLowerLeg = Instance.new("TextButton")
                            local R6 = InstanceNew("Frame")
                            local Head_2 = InstanceNew("TextButton")
                            local LeftArm_2 = InstanceNew("TextButton")
                            local RightArm_2 = InstanceNew("TextButton")
                            local RightLeg_2 = InstanceNew("TextButton")
                            local LeftLeg_2 = InstanceNew("TextButton")
                            local Torso_3 = InstanceNew("TextButton")
                            local HumanoidRootPart_2 = InstanceNew("TextButton")
                            
                            BoneSelectorHolder.Name = "BoneSelectorHolder"
                            BoneSelectorHolder.Parent = SectionColumnComponents
                            BoneSelectorHolder.Size = UDim2.new(1, 0, 0, 316)
                            BoneSelectorHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            BoneSelectorHolder.Position = UDim2.new(0, 0, -1.17375305e-06, 0)
                            BoneSelectorHolder.BorderSizePixel = 0
                            BoneSelectorHolder.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
                            
                            BSHStroke.Name = "BSHStroke"
                            BSHStroke.Parent = BoneSelectorHolder
                            BSHStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            BSHStroke.Color = Color3.fromRGB(36, 36, 36)
                            
                            BSHCorner.Name = "BSHCorner"
                            BSHCorner.Parent = BoneSelectorHolder
                            
                            R15.Name = "R15"
                            R15.Parent = BoneSelectorHolder
                            R15.Size = UDim2.new(0, 217, 0, 308)
                            R15.Visible = true
                            R15.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            R15.BackgroundTransparency = 1
                            R15.Position = UDim2.new(0.0262008738, 0, 0.0187500007, 0)
                            R15.BorderSizePixel = 0
                            R15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            
                            Head.Name = "Head"
                            Head.Parent = R15
                            Head.Size = UDim2.new(0, 60, 0, 68)
                            Head.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Head.Position = UDim2.new(0.358999997, 0, 0.0579999983, 0)
                            Head.BorderSizePixel = 2
                            Head.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Head.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Head.Text = ""
                            Head.TextSize = 14
                            Head.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            HumanoidRootPart.Name = "HumanoidRootPart"
                            HumanoidRootPart.Parent = R15
                            HumanoidRootPart.ZIndex = 2
                            HumanoidRootPart.Size = UDim2.new(0, 22, 0, 25)
                            HumanoidRootPart.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            HumanoidRootPart.Position = UDim2.new(0.446557671, 0, 0.402155876, 0)
                            HumanoidRootPart.BorderSizePixel = 2
                            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            HumanoidRootPart.TextColor3 = Color3.fromRGB(0, 0, 0)
                            HumanoidRootPart.Text = ""
                            HumanoidRootPart.TextSize = 14
                            HumanoidRootPart.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftHand.Name = "LeftHand"
                            LeftHand.Parent = R15
                            LeftHand.Size = UDim2.new(0, 53, 0, 20)
                            LeftHand.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftHand.Position = UDim2.new(0.0778940767, 0, 0.548259795, 0)
                            LeftHand.BorderSizePixel = 2
                            LeftHand.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftHand.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftHand.Text = ""
                            LeftHand.TextSize = 14
                            LeftHand.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftLowerArm.Name = "LeftLowerArm"
                            LeftLowerArm.Parent = R15
                            LeftLowerArm.Size = UDim2.new(0, 53, 0, 44)
                            LeftLowerArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLowerArm.Position = UDim2.new(0.0778940767, 0, 0.405238956, 0)
                            LeftLowerArm.BorderSizePixel = 2
                            LeftLowerArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLowerArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLowerArm.Text = ""
                            LeftLowerArm.TextSize = 14
                            LeftLowerArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LowerTorso.Name = "LowerTorso"
                            LowerTorso.Parent = R15
                            LowerTorso.Size = UDim2.new(0, 76, 0, 20)
                            LowerTorso.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LowerTorso.Position = UDim2.new(0.32213372, 0, 0.54809612, 0)
                            LowerTorso.BorderSizePixel = 2
                            LowerTorso.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LowerTorso.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LowerTorso.Text = ""
                            LowerTorso.TextSize = 14
                            LowerTorso.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftUpperArm.Name = "LeftUpperArm"
                            LeftUpperArm.Parent = R15
                            LeftUpperArm.Size = UDim2.new(0, 53, 0, 38)
                            LeftUpperArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftUpperArm.Position = UDim2.new(0.0778940767, 0, 0.278615594, 0)
                            LeftUpperArm.BorderSizePixel = 2
                            LeftUpperArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftUpperArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftUpperArm.Text = ""
                            LeftUpperArm.TextSize = 14
                            LeftUpperArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightHand.Name = "RightHand"
                            RightHand.Parent = R15
                            RightHand.Size = UDim2.new(0, 49, 0, 19)
                            RightHand.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightHand.Position = UDim2.new(0.672364116, 0, 0.548259795, 0)
                            RightHand.BorderSizePixel = 2
                            RightHand.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightHand.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightHand.Text = ""
                            RightHand.TextSize = 14
                            RightHand.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightUpperArm.Name = "RightUpperArm"
                            RightUpperArm.Parent = R15
                            RightUpperArm.Size = UDim2.new(0, 53, 0, 38)
                            RightUpperArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightUpperArm.Position = UDim2.new(0.672364116, 0, 0.278615594, 0)
                            RightUpperArm.BorderSizePixel = 2
                            RightUpperArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightUpperArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightUpperArm.Text = ""
                            RightUpperArm.TextSize = 14
                            RightUpperArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightLowerArm.Name = "RightLowerArm"
                            RightLowerArm.Parent = R15
                            RightLowerArm.Size = UDim2.new(0, 53, 0, 44)
                            RightLowerArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLowerArm.Position = UDim2.new(0.672364116, 0, 0.405238956, 0)
                            RightLowerArm.BorderSizePixel = 2
                            RightLowerArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLowerArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLowerArm.Text = ""
                            RightLowerArm.TextSize = 14
                            RightLowerArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            UpperTorso.Name = "UpperTorso"
                            UpperTorso.Parent = R15
                            UpperTorso.Size = UDim2.new(0, 76, 0, 82)
                            UpperTorso.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            UpperTorso.Position = UDim2.new(0.32213372, 0, 0.279000014, 0)
                            UpperTorso.BorderSizePixel = 2
                            UpperTorso.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            UpperTorso.TextColor3 = Color3.fromRGB(0, 0, 0)
                            UpperTorso.Text = ""
                            UpperTorso.TextSize = 14
                            UpperTorso.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftUpperLeg.Name = "LeftUpperLeg"
                            LeftUpperLeg.Parent = R15
                            LeftUpperLeg.Size = UDim2.new(0, 38, 0, 62)
                            LeftUpperLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftUpperLeg.Position = UDim2.new(0.32213372, 0, 0.613031149, 0)
                            LeftUpperLeg.BorderSizePixel = 2
                            LeftUpperLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftUpperLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftUpperLeg.Text = ""
                            LeftUpperLeg.TextSize = 14
                            LeftUpperLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftLowerLeg.Name = "LeftLowerLeg"
                            LeftLowerLeg.Parent = R15
                            LeftLowerLeg.Size = UDim2.new(0, 38, 0, 32)
                            LeftLowerLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLowerLeg.Position = UDim2.new(0.32213372, 0, 0.814329863, 0)
                            LeftLowerLeg.BorderSizePixel = 2
                            LeftLowerLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLowerLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLowerLeg.Text = ""
                            LeftLowerLeg.TextSize = 14
                            LeftLowerLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftFoot.Name = "LeftFoot"
                            LeftFoot.Parent = R15
                            LeftFoot.Size = UDim2.new(0, 38, 0, 9)
                            LeftFoot.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftFoot.Position = UDim2.new(0.32213372, 0, 0.918225944, 0)
                            LeftFoot.BorderSizePixel = 2
                            LeftFoot.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftFoot.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftFoot.Text = ""
                            LeftFoot.TextSize = 14
                            LeftFoot.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightFoot.Name = "RightFoot"
                            RightFoot.Parent = R15
                            RightFoot.Size = UDim2.new(0, 38, 0, 9)
                            RightFoot.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightFoot.Position = UDim2.new(0.497248918, 0, 0.918225944, 0)
                            RightFoot.BorderSizePixel = 2
                            RightFoot.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightFoot.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightFoot.Text = ""
                            RightFoot.TextSize = 14
                            RightFoot.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightUpperLeg.Name = "RightUpperLeg"
                            RightUpperLeg.Parent = R15
                            RightUpperLeg.Size = UDim2.new(0, 38, 0, 62)
                            RightUpperLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightUpperLeg.Position = UDim2.new(0.497248918, 0, 0.613031149, 0)
                            RightUpperLeg.BorderSizePixel = 2
                            RightUpperLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightUpperLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightUpperLeg.Text = ""
                            RightUpperLeg.TextSize = 14
                            RightUpperLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightLowerLeg.Name = "RightLowerLeg"
                            RightLowerLeg.Parent = R15
                            RightLowerLeg.Size = UDim2.new(0, 38, 0, 32)
                            RightLowerLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLowerLeg.Position = UDim2.new(0.497248918, 0, 0.814329863, 0)
                            RightLowerLeg.BorderSizePixel = 2
                            RightLowerLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLowerLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLowerLeg.Text = ""
                            RightLowerLeg.TextSize = 14
                            RightLowerLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            R6.Name = "R6"
                            R6.Parent = BoneSelectorHolder
                            R6.Size = UDim2.new(0, 217, 0, 308)
                            R6.Visible = false
                            R6.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            R6.BackgroundTransparency = 1
                            R6.Position = UDim2.new(0.0262008738, 0, 0.0187500007, 0)
                            R6.BorderSizePixel = 0
                            R6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            
                            Head_2.Name = "Head"
                            Head_2.Parent = R6
                            Head_2.Size = UDim2.new(0, 76, 0, 68)
                            Head_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Head_2.Position = UDim2.new(0.322580636, 0, 0.058441557, 0)
                            Head_2.BorderSizePixel = 2
                            Head_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Head_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Head_2.Text = ""
                            Head_2.TextSize = 14
                            Head_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            LeftArm_2.Name = "Left Arm"
                            LeftArm_2.Parent = R6
                            LeftArm_2.Size = UDim2.new(0, 53, 0, 103)
                            LeftArm_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftArm_2.Position = UDim2.new(0.0783410147, 0, 0.27922079, 0)
                            LeftArm_2.BorderSizePixel = 2
                            LeftArm_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftArm_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftArm_2.Text = ""
                            LeftArm_2.TextSize = 14
                            LeftArm_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            RightArm_2.Name = "Right Arm"
                            RightArm_2.Parent = R6
                            RightArm_2.Size = UDim2.new(0, 53, 0, 103)
                            RightArm_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightArm_2.Position = UDim2.new(0.672811031, 0, 0.27922079, 0)
                            RightArm_2.BorderSizePixel = 2
                            RightArm_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightArm_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightArm_2.Text = ""
                            RightArm_2.TextSize = 14
                            RightArm_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            RightLeg_2.Name = "Right Leg"
                            RightLeg_2.Parent = R6
                            RightLeg_2.Size = UDim2.new(0, 38, 0, 103)
                            RightLeg_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLeg_2.Position = UDim2.new(0.497695863, 0, 0.613636374, 0)
                            RightLeg_2.BorderSizePixel = 2
                            RightLeg_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLeg_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLeg_2.Text = ""
                            RightLeg_2.TextSize = 14
                            RightLeg_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            LeftLeg_2.Name = "Left Leg"
                            LeftLeg_2.Parent = R6
                            LeftLeg_2.Size = UDim2.new(0, 38, 0, 103)
                            LeftLeg_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLeg_2.Position = UDim2.new(0.322580636, 0, 0.613636374, 0)
                            LeftLeg_2.BorderSizePixel = 2
                            LeftLeg_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLeg_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLeg_2.Text = ""
                            LeftLeg_2.TextSize = 14
                            LeftLeg_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            Torso_3.Name = "Torso"
                            Torso_3.Parent = R6
                            Torso_3.Size = UDim2.new(0, 76, 0, 103)
                            Torso_3.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Torso_3.Position = UDim2.new(0.322580636, 0, 0.27922079, 0)
                            Torso_3.BorderSizePixel = 2
                            Torso_3.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Torso_3.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Torso_3.Text = ""
                            Torso_3.TextSize = 14
                            Torso_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            HumanoidRootPart_2.Name = "HumanoidRootPart"
                            HumanoidRootPart_2.Parent = R6
                            HumanoidRootPart_2.Size = UDim2.new(0, 31, 0, 30)
                            HumanoidRootPart_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            HumanoidRootPart_2.Position = UDim2.new(0.42396313, 0, 0.373376638, 0)
                            HumanoidRootPart_2.BorderSizePixel = 2
                            HumanoidRootPart_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            HumanoidRootPart_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            HumanoidRootPart_2.Text = ""
                            HumanoidRootPart_2.TextSize = 14
                            HumanoidRootPart_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            local function R15_function()
                                for _, bodypart in pairs(R15:GetChildren()) do
                                    bodypart.AutoButtonColor = false
                        
                                    local name = bodypart.Name
                                    
                                    local self_conn = nil
                                    local function ButtonClick()
                                        tweenService:Create(bodypart, TweenInfo.new(0.2), { BackgroundColor3 = theme.accent }):Play()
                                        BoneSelector["FValues"][name].Selected = true
                        
                                        if not self_conn then
                                            self_conn = theme_event.Event:Connect(function ()
                                                if BoneSelector["FValues"][name].Selected then
                                                    bodypart.BackgroundColor3 = theme.accent
                                                end
                                            end)
                                        end
                                    end
                        
                                    local function ButtonUnClick()
                                        tweenService:Create(bodypart, TweenInfo.new(0.2), { BackgroundColor3 = Color3FromRGB(27, 27, 27) }):Play()
                                        BoneSelector["FValues"][name].Selected = false
                        
                                        if self_conn then
                                            self_conn:Disconnect(); self_conn = nil
                                        end
                                    end
                        
                                    bodypart.MouseButton1Click:Connect(function ()
                                        BoneSelectorOptions:Set(name)
                                    end)
                        
                                    BoneSelector["FValues"][name] = {
                                        Click = ButtonClick,
                                        UnClick = ButtonUnClick,
                                        Selected = false,
                                    }
                                end
                            end
                        
                            local function R6_FUNCTION()
                                for _, bodypart in pairs(R6:GetChildren()) do
                                    local name = bodypart.Name
                        
                                    local self_conn = nil
                                    local function ButtonClick()
                                        bodypart.BackgroundColor3 = theme.accent
                                        BoneSelector["FValues"][name].Selected = true
                        
                                        if not self_conn then
                                            self_conn = theme_event.Event:Connect(function ()
                                                if BoneSelector["FValues"][name].Selected then
                                                    bodypart.BackgroundColor3 = theme.accent
                                                end
                                            end)
                                        end
                                    end
                        
                                    local function ButtonUnClick()
                                        bodypart.BackgroundColor3 = Color3FromRGB(27, 27, 27)
                                        BoneSelector["FValues"][name].Selected = false
                        
                                        if self_conn then
                                            self_conn:Disconnect(); self_conn = nil
                                        end
                                    end
                        
                                    bodypart.MouseButton1Click:Connect(function ()
                                        BoneSelectorOptions:Set(name)
                                    end)
                        
                                    BoneSelector["FValues"][name] = {
                                        Click = ButtonClick,
                                        UnClick = ButtonUnClick,
                                        Selected = false,
                                    }
                                end
                            end
                        
                            R15_function()
                        
                            function BoneSelectorOptions:Update()
                                for _, v in pairs(BoneSelector.FValues) do
                                    if BoneSelector.FValue == _ then
                                        v.Click()
                                    else
                                        v.UnClick()
                                    end
                                end
                        
                                return BoneSelector
                            end
                        
                            function BoneSelectorOptions:Set(value)
                                if BoneSelectorOptions.Multi then
                                    if type(value) == "table" then
                                        BoneSelectorOptions:Refresh()
                            
                                        for _,v in pairs(value) do
                                            if not table.find(BoneSelector.FValue, _) then
                                                BoneSelectorOptions:Set(v)
                                            end
                                        end
                            
                                        local RemovedButtons = {}
                            
                                        for _,v in pairs(BoneSelector.FValue) do
                                            if not table.find(value, _) then
                                                RemovedButtons[#RemovedButtons + 1] = v
                                            end
                                        end
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function(value)  end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                            
                                        return
                                    end
                            
                                    local Index = table.find(BoneSelector.FValue, value)
                            
                                    if Index then
                                        table.remove(BoneSelector.FValue, Index)
                            
                                        BoneSelector.FValues[value].UnClick()
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                    else
                                        BoneSelector.FValue[#BoneSelector.FValue + 1] = value
                            
                                        BoneSelector.FValues[value].Click()
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                    end
                                else
                                    BoneSelector.FValue = value
                        
                                    for _, v in pairs(BoneSelector.FValues) do
                                        v.UnClick()
                                    end
                                    BoneSelector["FValues"][BoneSelector.FValue].Click()
                        
                                    pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                    UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                    UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                end 
                            end
                        
                            function BoneSelectorOptions:GetValues()
                                return BoneSelector.FValue
                            end
                        
                            function BoneSelectorOptions:Refresh()
                                for i, v in next, BoneSelector.FValues do
                                    if v.UnClick then
                                        v.UnClick()
                                    end
                                end
                            end
                        
                            function BoneSelectorOptions:SetMulti(bool)
                                if BoneSelectorOptions.Multi == bool then return end
                                self:Refresh()
                                BoneSelectorOptions.Multi = bool
                                BoneSelector.FValue = bool and {} or ""
                            end
                        
                            UserInterface.ConfigFlags[BoneSelectorOptions.Flag] = function(state) BoneSelectorOptions:Set(state) end
                            increaseYSize(308)
                            return BoneSelectorOptions
                        end
                    end
                end

                return Options
            end

            if #Configuration.Tabs > 0 then
                Configuration.Tabs[1]:Select()
            end

            table.insert(Configuration.Tabs, #Configuration.Tabs + 1, TabConfiguration)
            return TabConfiguration
        end

        local function isMouseInFrame()
            local framePosition = UI["b"].AbsolutePosition
            local frameSize = UI["b"].AbsoluteSize

            local player = playerService.LocalPlayer
            local mouse = player:GetMouse()
            
            local mouseX, mouseY = mouse.X, mouseY
            
            if mouseX >= framePosition.X and mouseX <= framePosition.X + frameSize.X and
               mouseY >= framePosition.Y and mouseY <= framePosition.Y + frameSize.Y then
                return true
            else
                return false
            end
        end

        UI["2"].InputBegan:Connect(function (input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not isMouseInFrame() then
                dragObject = UI["2"]
                dragging = true
                dragStart = input.Position
                startPos = dragObject.Position
            end
        end)
        UI["2"].InputEnded:Connect(function (input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        UI["2"].InputChanged:Connect(function (input)
            if dragging and input.UserInputType.Name == "MouseMovement" then
                dragInput = input
            end
        end)

        inputService.InputChanged:Connect(function (input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
                dragObject:TweenPosition(UDim2New(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quad", .15, true)
            end
        end)

        do
            do
                inputService.InputBegan:Connect(function(input, gameproc)
                    if gameproc then return end
                
                    if input.KeyCode == Enum.KeyCode.RightShift then
                        UI["2"].Visible = not UI["2"].Visible
                    end
                end)
            end
        end

        return Configuration
    end
    
    return UserInterface
end)()

local Interface = UserInterface:Create{title = 'm5ware<font color="rgb(255, 182, 193)">.cc</font>',}

local tab1 = Interface:Tab("Tab 1")
local section1 = tab1:Section("Section 1", "left")
local section2 = tab1:Section("Section 2", "right")

local tab2 = Interface:Tab("Tab 2")
local section3 = tab2:Section("Section 3", "left")
local section4 = tab2:Section("Section 4", "right")

local tab3 = Interface:Tab("Tab 3")
local section5 = tab3:Section("Section 5", "left")
local section6 = tab3:Section("Bone/S", "right")

section6:BoneSelector({multi = false, default = "Head"})
