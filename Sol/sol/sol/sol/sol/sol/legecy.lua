local Fluent = loadstring(game:HttpGet(
    "https://github.com/StyearX/Fluent-Modded/releases/download/Fluent/FluentLite"
))()

Fluent:RegisterCustomTheme("One reddit User say :dont kill yourself", {
    Accent              = Color3.fromRGB(96, 205, 255),
    AcrylicMain         = Color3.fromRGB(20, 20, 30),
    AcrylicBorder       = Color3.fromRGB(50, 50, 70),
    AcrylicGradient     = ColorSequence.new(Color3.fromRGB(20, 20, 30), Color3.fromRGB(10, 10, 20)),
    AcrylicNoise        = 0.8,
    TitleBarLine        = Color3.fromRGB(50, 50, 70),
    Tab                 = Color3.fromRGB(30, 30, 45),
    Element             = Color3.fromRGB(25, 25, 38),
    ElementBorder       = Color3.fromRGB(50, 50, 70),
    InElementBorder     = Color3.fromRGB(60, 60, 85),
    ElementTransparency = 0.85,
    ToggleSlider        = Color3.fromRGB(40, 40, 60),
    ToggleToggled       = Color3.fromRGB(96, 205, 255),
    SliderRail          = Color3.fromRGB(40, 40, 60),
    DropdownFrame       = Color3.fromRGB(20, 20, 32),
    DropdownHolder      = Color3.fromRGB(15, 15, 25),
    DropdownBorder      = Color3.fromRGB(50, 50, 70),
    DropdownOption      = Color3.fromRGB(28, 28, 42),
    Keybind             = Color3.fromRGB(28, 28, 42),
    Input               = Color3.fromRGB(18, 18, 28),
    InputFocused        = Color3.fromRGB(12, 12, 20),
    InputIndicator      = Color3.fromRGB(60, 60, 90),
    InputIndicatorFocus = Color3.fromRGB(96, 205, 255),
    Dialog              = Color3.fromRGB(15, 15, 25),
    DialogHolder        = Color3.fromRGB(12, 12, 20),
    DialogHolderLine    = Color3.fromRGB(40, 40, 60),
    DialogButton        = Color3.fromRGB(22, 22, 35),
    DialogButtonBorder  = Color3.fromRGB(50, 50, 70),
    DialogBorder        = Color3.fromRGB(50, 50, 70),
    DialogInput         = Color3.fromRGB(18, 18, 28),
    DialogInputLine     = Color3.fromRGB(60, 60, 90),
    Text                = Color3.fromRGB(240, 240, 255),
    SubText             = Color3.fromRGB(140, 140, 175),
    Hover               = Color3.fromRGB(35, 35, 55),
    HoverChange         = 0.04,
    ShineEnabled        = true,
    StrokeShine         = false,
    StrokeDark          = Color3.fromRGB(40, 40, 60),
    IconColor           = Color3.fromRGB(96, 205, 255),
    IconSize            = 18,
    Background          = nil,
    BackgroundTransparency = 0,
    ThemeAccentColors   = { Color3.fromRGB(96, 205, 255) },
})

if _G.SolasmotaryXIsAlreadyRunning then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script is already running!",
        Text = ""
    })
    return
end

_G.SolasmotaryXIsAlreadyRunning = true

local function getPlayerLevel()
    local player = game:GetService("Players").LocalPlayer
    local lv = player:GetAttribute("Level") or player:GetAttribute("level")
        or player:GetAttribute("LVL") or player:GetAttribute("PlayerLevel")
    if lv then return tostring(lv) end
    local ls = player:FindFirstChild("leaderstats")
    if ls then
        local node = ls:FindFirstChild("Level") or ls:FindFirstChild("level")
            or ls:FindFirstChild("LVL") or ls:FindFirstChild("XP")
        if node then return tostring(node.Value) end
    end
    return "?"
end

local Window = Fluent:CreateWindow({
    Title              = "SolasmotaryX | Legacy Version",
    SubTitle           = "Evade │ Mobile",
    TabWidth           = 160,
    Size               = UDim2.fromOffset(490, 490),
    Acrylic            = true,
    Theme              = "Deep Violet",
    MinimizeKey        = Enum.KeyCode.LeftControl,
    Search             = true,
    UserInfoTop        = true,
    UserInfoTitle      = "Welcome ",
    UserInfoSubtitle   = "Your level is " .. getPlayerLevel(),
    UserInfoColor      = Color3.fromRGB(96, 205, 255),
})

local Tabs = {
    Main     = Window:AddTab({ Title = "| Main",           Icon = "rbxassetid://7733960981"  }),
    Combat   = Window:AddTab({ Title = "| Combat",         Icon = "rbxassetid://10734975692" }),
    Movement = Window:AddTab({ Title = "| Movement & Misc", Icon = "rbxassetid://7734068321"  }),
    Visual   = Window:AddTab({ Title = "| Visual",         Icon = "rbxassetid://10709819149" }),
    Settings = Window:AddTab({ Title = "| Settings",       Icon = "rbxassetid://7734052335"  }),
}

local Options = Fluent.Options


local Workspace          = game:GetService("Workspace")
local RunService         = game:GetService("RunService")
local Players            = game:GetService("Players")
local Lighting           = game:GetService("Lighting")
local StarterGui         = game:GetService("StarterGui")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local Camera             = Workspace.CurrentCamera
local LocalPlayer        = Players.LocalPlayer
local UserInputService   = game:GetService("UserInputService")
local TweenService       = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local CAS                = game:GetService("ContextActionService")


local function GetAutoDuration()
    local dt = RunService.RenderStepped:Wait()
    local fps = 1 / dt
    local duration = 60 / math.clamp(fps, 5, 60)
    return math.clamp(duration, 1, 6)
end

local Duration = GetAutoDuration()


local toggleGui = Instance.new("ScreenGui")
toggleGui.Name            = "OpenUi"
toggleGui.Parent          = LocalPlayer.PlayerGui
toggleGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
toggleGui.ResetOnSpawn    = false

local mainBtn = Instance.new("TextButton")
mainBtn.Name                   = "OpenButton"
mainBtn.Parent                 = toggleGui
mainBtn.BackgroundColor3       = Color3.fromRGB(35, 35, 35)
mainBtn.BackgroundTransparency = 1
mainBtn.Position               = UDim2.new(0.101969875, 0, 0.110441767, 0)
mainBtn.Size                   = UDim2.new(0, 64, 0, 42)
mainBtn.Text                   = ""
mainBtn.Visible                = true
Instance.new("UICorner", mainBtn)

local SizeBackMulti = 0.3

local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Name                   = "RotatingBackground"
backgroundImage.Parent                 = mainBtn
backgroundImage.Size                   = UDim2.new(1.5 + SizeBackMulti, 0, 1.5 + SizeBackMulti, 0)
backgroundImage.Position               = UDim2.new(0.5, 0, 0.5, 0)
backgroundImage.AnchorPoint            = Vector2.new(0.5, 0.5)
backgroundImage.BackgroundTransparency = 1
backgroundImage.Image                  = "rbxassetid://92062295706713"
backgroundImage.SizeConstraint         = Enum.SizeConstraint.RelativeXX
backgroundImage.ZIndex                 = 0

local frontImage = Instance.new("ImageLabel")
frontImage.Name                   = "StaticIcon"
frontImage.Parent                 = mainBtn
frontImage.Size                   = UDim2.fromOffset(55, 55)
frontImage.Position               = UDim2.new(0.5, 0, 0.5, 0)
frontImage.AnchorPoint            = Vector2.new(0.5, 0.5)
frontImage.BackgroundTransparency = 1
frontImage.Image                  = "rbxassetid://126113649238951"
frontImage.ZIndex                 = 1
Instance.new("UICorner", frontImage).CornerRadius = UDim.new(0.2, 0)

local rotation = 0
local rotSpeed = 90
local lastTime = tick()

task.spawn(function()
    while true do
        local now   = tick()
        local delta = now - lastTime
        lastTime    = now
        rotation    = (rotation + rotSpeed * delta) % 360
        backgroundImage.Rotation = rotation
        task.wait()
    end
end)

local function MakeDraggable(topbar, obj, locked)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    local holding, holdTime, moveCancelThreshold   = false, 1.0, 6
    local holdToken = 0

    obj:SetAttribute("Locked", locked or false)

    local function Update(input)
        if obj:GetAttribute("Locked") then return end
        local delta = input.Position - dragStart
        obj.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    local function ToggleLock()
        local newState = not obj:GetAttribute("Locked")
        obj:SetAttribute("Locked", newState)
        Fluent:Notify({
            Title    = newState and "Button Locked" or "Button Unlocked",
            Content  = newState and "This button is now locked in place." or "This button can now be moved.",
            Duration = 2,
        })
    end

    topbar.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then return end
        dragging  = not obj:GetAttribute("Locked")
        holding   = true
        dragStart = input.Position
        startPos  = obj.Position
        holdToken += 1
        local token = holdToken
        task.delay(holdTime, function()
            if holding and token == holdToken then ToggleLock() end
        end)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                holding  = false
            end
        end)
    end)

    topbar.InputChanged:Connect(function(input)
        if not dragStart then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            if (input.Position - dragStart).Magnitude > moveCancelThreshold then
                holding = false
            end
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then Update(input) end
    end)
end

MakeDraggable(mainBtn, mainBtn, false)

local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent  = game:GetService("SoundService")
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

mainBtn.MouseButton1Click:Connect(function()
    local sounds = { "7127123605", "137566474343039", "438666542" }
    playSound(sounds[math.random(#sounds)])
    Window:Minimize()

    local function smoothSpeed(target, dur)
        local start = rotSpeed
        local steps = 30
        for i = 1, steps do
            rotSpeed = start + (target - start) * (i / steps)
            task.wait(dur / steps)
        end
        rotSpeed = target
    end

    smoothSpeed(360, 0.4)
    task.wait(0.5)
    smoothSpeed(180, 0.4)
    task.wait(0.3)
    smoothSpeed(90, 0.4)
end)


local Stats = game:GetService("Stats")

local fpsCounter = Instance.new("ScreenGui")
fpsCounter.Name = "FPSCounter"
fpsCounter.Parent = game.CoreGui
fpsCounter.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
fpsCounter.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = fpsCounter
frame.Size = UDim2.new(0, 180, 0, 80)
frame.Position = UDim2.new(0, 300, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.7

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = getgenv().ButtonGradients.Background
gradient.Parent = frame

task.spawn(function()
    while task.wait(0.03) do
        gradient.Rotation = (gradient.Rotation + 1) % 360
        gradient.Color = getgenv().ButtonGradients.Background
    end
end)

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = frame

local gradientstroke = Instance.new("UIGradient")
gradientstroke.Color = getgenv().ButtonGradients.Stroke
gradientstroke.Parent = uiStroke

task.spawn(function()
    while frame.Parent do
        gradientstroke.Rotation = (gradientstroke.Rotation + 0.5) % 360
        gradientstroke.Color = getgenv().ButtonGradients.Stroke
        task.wait()
    end
end)

local label = Instance.new("TextLabel")
label.Parent = frame
label.Size = UDim2.new(1, -10, 1, -10)
label.Position = UDim2.new(0, 5, 0, 5)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBlack
label.TextSize = 12
label.TextWrapped = true
label.TextXAlignment = Enum.TextXAlignment.Center
label.TextYAlignment = Enum.TextYAlignment.Center
label.Text = "FPS: 0 | Ping: 0 ms\nClient Timer: 0h 0m 0s"

if typeof(MakeDraggable) == "function" then
    MakeDraggable(frame, frame, false)
end

local function GetPing()
    local n = Stats:FindFirstChild("Network")
    if not n then return 0 end
    local s = n:FindFirstChild("ServerStatsItem")
    if not s then return 0 end
    local p = s:FindFirstChild("Data Ping")
    if not p then return 0 end
    return math.floor(p:GetValue())
end

local startTime = tick()
local lastUpdateTime = startTime
local frameCount = 0
local previousText = ""

RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    local dt = now - lastUpdateTime

    if dt >= 1 then
        local fps = math.round(frameCount / dt)
        local elapsed = now - startTime
        local h = math.floor(elapsed / 3600)
        local m = math.floor((elapsed % 3600) / 60)
        local s = math.floor(elapsed % 60)
        local ping = GetPing()

        local text = string.format(
            "FPS: %d | Ping: %d ms\nClient Timer: %dh %dm %ds",
            fps, ping, h, m, s
        )

        if text ~= previousText then
            label.Text = text
            previousText = text
        end

        lastUpdateTime = now
        frameCount = 0
    end
end)


if not require then
    return LocalPlayer:Kick("UNC RESTRICTION MISSING: require(path) | PLEASE TRY OTHER EXECUTORS")
else
    print("Supported require()")
end

if not firetouchinterest then
    return LocalPlayer:Kick("UNC RESTRICTION MISSING: firetouchinterest() | PLEASE TRY OTHER EXECUTORS")
else
    print("Supported firetouchinterest()")
end

if not setfpscap or setfpscap(500) then
    return LocalPlayer:Kick("UNC RESTRICTION MISSING: setfpscap() | PLEASE TRY OTHER EXECUTORS")
else
    print("Supported setfpscap()")
end

if game.Players then
    print("Advance Api")
else
    print("Common Api")
end


function CreateBillboardESP(Name, Part, Color, TextSize)
    if not Part or Part:FindFirstChild(Name) then return nil end

    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel    = Instance.new("TextLabel")
    local TextStroke   = Instance.new("UIStroke")

    BillboardGui.Parent          = Part
    BillboardGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
    BillboardGui.Name            = Name
    BillboardGui.AlwaysOnTop     = true
    BillboardGui.LightInfluence  = 1
    BillboardGui.Size            = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset     = Vector3.new(0, 2.5, 0)
    BillboardGui.MaxDistance     = 1000

    TextLabel.Parent              = BillboardGui
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size                = UDim2.new(1, 0, 1, 0)
    TextLabel.TextScaled          = false
    TextLabel.Font                = Enum.Font.SourceSans
    TextLabel.TextSize            = TextSize or 14
    TextLabel.TextColor3          = Color or Color3.fromRGB(255, 255, 255)

    TextStroke.Parent    = TextLabel
    TextStroke.Thickness = 1
    TextStroke.Color     = Color3.new(0, 0, 0)

    return BillboardGui
end

function UpdateBillboardESP(Name, Part, NameText, Color, TextSize, PartPosition)
    if not Part then return false end

    local esp = Part:FindFirstChild(Name)
    if esp and esp:FindFirstChildOfClass("TextLabel") then
        local label = esp:FindFirstChildOfClass("TextLabel")

        if Color    then label.TextColor3 = Color    end
        if TextSize then label.TextSize   = TextSize end

        if PartPosition then
            local Pos
            if typeof(PartPosition) == "Instance" and PartPosition:IsA("BasePart") then
                Pos = PartPosition.Position
            elseif typeof(PartPosition) == "Vector3" then
                Pos = PartPosition
            end

            if Pos then
                local distance = math.floor((Pos - Part.Position).Magnitude)
                local name = NameText or Part.Parent and Part.Parent.Name or Part.Name
                label.Text = string.format("%s - [ %d M ]", name, distance)
            end
        else
            local name = NameText or Part.Parent and Part.Parent.Name or Part.Name
            label.Text = name
        end
        return true
    end
    return false
end

function DestroyBillboardESP(Name, Part)
    if not Part then return false end
    local esp = Part:FindFirstChild(Name)
    if esp then
        esp:Destroy()
        return true
    end
    return false
end

function CreateTracerESP(tracerTable, part, thickness, color)
    local tracer = Drawing.new("Line")
    tracer.Thickness   = thickness or 2
    tracer.Color       = color or Color3.fromRGB(255, 255, 255)
    tracer.Transparency = 1
    tracer.Visible     = false
    tracerTable[part]  = tracer
    return tracer
end

function UpdateTracerESP(tracerTable, part, color)
    local tracer = tracerTable[part]
    if not tracer then return end

    if typeof(part) ~= "Instance" then
        tracerTable[part] = nil
        return
    end

    if not part.Parent or not part:IsDescendantOf(workspace) then
        tracer.Visible = false
        DestroyTracerESP(tracerTable, part)
        return
    end

    local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
    if onScreen then
        if color then tracer.Color = color end
        tracer.From    = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
        tracer.To      = Vector2.new(screenPos.X, screenPos.Y)
        tracer.Visible = true
    else
        tracer.Visible = false
    end
end

function DestroyTracerESP(tracerTable, part)
    if typeof(part) ~= "Instance" then
        tracerTable[part] = nil
        return
    end
    local tracer = tracerTable[part]
    if tracer then
        if tracer.Remove then tracer:Remove() end
        tracerTable[part] = nil
    end
end

function CreateHighlightESP(Name, Part, HighlightColor, OutlineColor, ShowHighlight)
    if not Part then return false end

    local Highlight = Instance.new("Highlight")
    Highlight.Name             = Name
    Highlight.FillColor        = HighlightColor or Color3.fromRGB(255, 255, 255)
    Highlight.OutlineColor     = OutlineColor   or Color3.fromRGB(0, 0, 0)

    if ShowHighlight then
        Highlight.FillTransparency = 0
    else
        Highlight.FillTransparency = 1
    end

    Highlight.OutlineTransparency = 0
    Highlight.Parent              = Part

    return true
end

function UpdateHighlightESP(Name, Part, HighlightColor, OutlineColor, ShowHighlight)
    local Highlight = Part and Part:FindFirstChild(Name)
    if not Highlight or not Highlight:IsA("Highlight") then return false end

    if HighlightColor then Highlight.FillColor    = HighlightColor end
    if OutlineColor   then Highlight.OutlineColor = OutlineColor   end

    if ShowHighlight ~= nil then
        Highlight.FillTransparency = ShowHighlight and 0 or 0.5
    end

    return true
end

function DestroyHighlightESP(Name, Part)
    local Highlight = Part and Part:FindFirstChild(Name)
    if Highlight and Highlight:IsA("Highlight") then
        Highlight:Destroy()
        return true
    end
    return false
end


local DFunctions = {}
local DConfiguration = {
    ESP = {
        Players  = false,
        Nextbots  = false,
        Tickets   = false,
        Objective = false,
    },

    Tracers = {
        Players  = false,
        Nextbots  = false,
        Tickets   = false,
        Objective = false,
    },

    Highlight = {
        Players    = false,
        Nextbots   = false,
        Tickets    = false,
        Objective  = false,
        OutlineOnly = false,
    },

    Boxes = {
        Players  = false,
        Nextbots  = false,
        Tickets   = false,
        Objective = false,
    },

    Removals = {
        CameraShake   = false,
        InvisibleWalls = false,
        DamageParts   = false,
    },

    Main = {
        AntiAFK      = true,
        AutoRespawn  = false,
        RespawnType  = "Spawnpoint",
        AutoWhistle  = false,
        ShowTimer    = false,
        Fly          = false,
        FlySpeed     = 20,
        Noclip       = false,
        Cola = {
            Count         = 0,
            SpeedEnabled  = false,
            SpeedAmount   = 10,
            SpeedDuration = 5,
        },
    },

    Combat = {
        AntiNextbot      = false,
        AntiNextbotRange = 15,
        AntiNextbotType  = "Spawn",
    },

    Misc = {
        PlayerAdjustment = {
            Default = {
                Speed             = 1500,
                JumpHeight        = 3,
                AirStrafe         = 182,
                GroundAcceleration = 1,
            },

            Update = {
                Speed             = 1500,
                JumpHeight        = 3,
                AirStrafe         = 182,
                GroundAcceleration = 1,
            },

            Saved = {
                Speed             = 1500,
                JumpHeight        = 3,
                AirStrafe         = 182,
                GroundAcceleration = 1,
            },

            Tick = {
                Speed             = 0,
                JumpHeight        = 0,
                AirStrafe         = 0,
                GroundAcceleration = 0,
            },

            Debounce = {
                Speed             = false,
                JumpHeight        = false,
                AirStrafe         = false,
                GroundAcceleration = false,
            },
        },

        Humanoids = {
            WalkspeedCF        = false,
            OriginalJumpHeight = false,
            CF                 = 5,
            JP                 = 20,
        },

        Utilities = {
            GetCurrentSpeed = 0,

            BounceModification = {
                Enabled      = false,
                DefaultBounce = 80,
                EmoteBounce  = 120,
            },

            LagSwitch = {
                MSDelay = 200,
                Mode    = "Normal",
            },
        },

        GameAutomation = {
            Macro = {
                SelectedPrimary = 1,
                FloatingButton  = false,
                Keybind         = false,
            },
        },

        MovementModification = {
            EmoteModification = {
                AggressiveEmoteDash = {
                    Enabled      = false,
                    Type         = "Blatant",
                    Speed        = 3000,
                    Acceleration = -2,
                },

                ModifyEmote = {
                    Enabled   = true,
                    TurnSpeed = 0.5,
                },
            },

            Gravity = {
                FloatingButton = false,
                Keybind        = false,
                Value          = 10,
            },

            BHOP = {
                Enabled          = false,
                FloatingButton   = false,
                AutoAcceleration = false,
                MaxSpeed         = 70,
                JumpButton       = false,
                HipHeight1       = 0,
                HipHeight2       = 0,
                Type             = "Acceleration",
                JumpType         = "Simulated",
                Acceleration     = -0.1,
                lastTick         = 0.01,
            },
        },

        AntiLags = {
            Low      = false,
            Moderate = false,
            High     = false,
        },
    },

    Visual = {
        OriginalCosmetics = {
            Cosmetics1 = "",
            Cosmetics2 = "",
            Cosmetics3 = "",
            Cosmetics4 = "",
        },

        ModifyCosmetics = {
            Cosmetics1 = "",
            Cosmetics2 = "",
            Cosmetics3 = "",
            Cosmetics4 = "",
        },

        OriginalEmotes = {
            Emote1 = "",
            Emote2 = "",
            Emote3 = "",
            Emote4 = "",
            Emote5 = "",
            Emote6 = "",
        },

        ModifyEmotes = {
            Emote1 = "",
            Emote2 = "",
            Emote3 = "",
            Emote4 = "",
            Emote5 = "",
            Emote6 = "",
        },
    },

    Settings = {
        GuiScale = {
            Respawn        = 0,
            AutoCarry      = 0,
            InstantRevive  = 0,
            AutoEmoteDash  = 0,
            MacroButton1   = 0,
            MacroButton2   = 0,
            Crouch         = 0,
            Gravity        = 0,
            AutoJump       = 0,
            LagSwitch      = 0,
            Cola           = 0,
            Leaderboard    = 0,
            EmoteSlot      = 0,
            AutoCrouch     = 0,
        },
    },
}

local SaveManager         = Fluent.SaveManager
local InterfaceManager    = Fluent.InterfaceManager
local FBM                 = Fluent.FloatingButtonManager


if not getgenv().ButtonTransparency then
    getgenv().ButtonTransparency = {
        Background = 0,
        Stroke     = 0,
        Text       = 0,
        Toggle     = 0,
    }
end

-- Transparansi bertahap per-value:
-- 0–10   : semua normal (background, stroke, text = 0)
-- 11–30  : background naik pelan (0 → 0.5), stroke & text tetap normal
-- 31–60  : background naik (0.5 → 0.85), stroke mulai naik (0 → 0.5)
-- 61–100 : semua naik, text mulai fade (0 → 1), stroke naik ke 1
local function _applyBtnTrans(raw)
    local v = math.clamp(tonumber(raw) or 0, 0, 100)
    local bg, stroke, text, toggle

    if v <= 10 then
        bg     = 0
        stroke = 0
        text   = 0
        toggle = 0
    elseif v <= 30 then
        local t = (v - 10) / 20
        bg     = t * 0.5
        stroke = 0
        text   = 0
        toggle = t * 0.1
    elseif v <= 60 then
        local t = (v - 30) / 30
        bg     = 0.5 + t * 0.35
        stroke = t * 0.5
        text   = 0
        toggle = 0.1 + t * 0.2
    else
        local t = (v - 60) / 40
        bg     = 0.85 + t * 0.15
        stroke = 0.5 + t * 0.5
        text   = t
        toggle = 0.3 + t * 0.7
    end

    getgenv().ButtonTransparency.Background = bg
    getgenv().ButtonTransparency.Stroke     = stroke
    getgenv().ButtonTransparency.Text       = text
    getgenv().ButtonTransparency.Toggle     = toggle
end

function DFunctions.CreateButton(ButtonName, Name, Size1, Size2, ScriptLogic, CircleMode, Family)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name          = ButtonName
    screenGui.Parent        = LocalPlayer.PlayerGui
    screenGui.ResetOnSpawn  = false

    local frame = Instance.new("Frame")
    frame.Name                  = ButtonName
    frame.Size                  = UDim2.new(Size1, 0, Size2, 0)
    frame.Position              = UDim2.new(0.5 - Size1 / 2, 0, 0.5 - Size2 / 2, 0)
    frame.BackgroundColor3      = Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = 0.7
    frame.Parent                = screenGui

    local gradient = Instance.new("UIGradient")
    gradient.Color  = getgenv().ButtonGradients.Background
    gradient.Parent = frame

    task.spawn(function()
        while task.wait(0.03) do
            gradient.Rotation = (gradient.Rotation + 1) % 360
            gradient.Color    = getgenv().ButtonGradients.Background
        end
    end)

    local stroke = Instance.new("UIStroke")
    stroke.Thickness      = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color          = Color3.new(1, 1, 1)
    stroke.Parent         = frame

    local gradientstroke = Instance.new("UIGradient")
    gradientstroke.Color    = getgenv().ButtonGradients.Stroke
    gradientstroke.Rotation = 0
    gradientstroke.Parent   = stroke

    task.spawn(function()
        while frame.Parent do
            gradientstroke.Rotation = (gradientstroke.Rotation + 0.5) % 360
            gradientstroke.Color    = getgenv().ButtonGradients.Stroke
            task.wait()
        end
    end)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent       = frame

    local button = Instance.new("TextButton")
    button.Size               = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text               = Name
    button.Font               = Enum.Font.SourceSansBold
    button.TextColor3         = Color3.fromRGB(255, 255, 255)
    button.TextSize           = 24
    button.TextScaled         = false
    button.Parent             = frame

    local toggle = Instance.new("TextButton")
    toggle.Size             = UDim2.new(0, 28, 0, 28)
    toggle.Position         = UDim2.new(1, 6, 0.5, -14)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.Text             = "○"
    toggle.TextColor3       = Color3.fromRGB(255, 255, 255)
    toggle.Visible          = false
    toggle.Parent           = frame

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent       = toggle

    local originalSize = UDim2.new(Size1, 0, Size2, 0)
    local holding  = false
    local holdStart = 0
    local hideAt   = 0

    frame:SetAttribute("IsCircle", false)

    local isCircle
    if CircleMode ~= nil then
        isCircle = CircleMode
    else
        isCircle = frame:GetAttribute("IsCircle")
    end

    local function applyShape(circle)
        frame:SetAttribute("IsCircle", circle)
        local s = math.min(frame.AbsoluteSize.X, frame.AbsoluteSize.Y)
        if circle then
            frame.Size          = UDim2.new(0, s, 0, s)
            button.TextWrapped  = true
            button.TextScaled   = true
            button.TextSize     = math.floor(s * 0.45)
            corner.CornerRadius = UDim.new(1, 0)
            toggle.Text         = "▢"
        else
            frame.Size          = originalSize
            button.TextWrapped  = false
            button.TextScaled   = false
            button.TextSize     = 24
            corner.CornerRadius = UDim.new(0, 15)
            toggle.Text         = "○"
        end
    end

    applyShape(isCircle)

    task.spawn(function()
        while task.wait(0.25) do
            if toggle.Visible and tick() - hideAt >= 10 then
                toggle.Visible = false
            end
        end
    end)

    button.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            holding   = true
            holdStart = tick()
        end
    end)

    button.InputEnded:Connect(function(i)
        if holding and (i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch) then
            holding = false
            if tick() - holdStart >= 0.6 then
                toggle.Visible = true
                hideAt = tick()
            end
        end
    end)

    toggle.MouseButton1Click:Connect(function()
        hideAt = tick()
        local current = frame:GetAttribute("IsCircle")
        applyShape(not current)
    end)

    button.Activated:Connect(function()
        if ScriptLogic then
            ScriptLogic(button)
        end
    end)

    -- Live-sync transparansi per-button dari attribute frame
    frame:SetAttribute("TransValue", 0)
    task.spawn(function()
        while frame.Parent do
            local v = math.clamp(frame:GetAttribute("TransValue") or 0, 0, 100)
            local bg, st, tx, tg = _calcBtnTrans(v)
            pcall(function()
                frame.BackgroundTransparency  = bg
                stroke.Transparency           = st
                button.TextTransparency       = tx
                toggle.BackgroundTransparency = tg
                toggle.TextTransparency       = tx
            end)
            task.wait(0.1)
        end
    end)

    FBM:AddButton(ButtonName, frame, false, Family or ButtonName)
    MakeDraggable(button, frame, false)

    return button
end

function DFunctions.UpdateButton(Name, Size1, Size2)
    local gui = LocalPlayer.PlayerGui:FindFirstChild(Name)
    if gui then
        local frame = gui:FindFirstChild(Name)
        if frame then
            frame.Size = UDim2.new(Size1, 0, Size2, 0)
            local isCircle = frame:GetAttribute("IsCircle")
            if isCircle then
                local s = math.min(frame.AbsoluteSize.X, frame.AbsoluteSize.Y)
                frame.Size = UDim2.new(0, s, 0, s)
            end
        end
    end
end

function DFunctions.DestroyButton(Name)
    local gui = LocalPlayer.PlayerGui:FindFirstChild(Name)
    if gui then
        gui:Destroy()
    end
end


function DFunctions.AutoRespawn()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char and char:GetAttribute("Downed") == true and DConfiguration.Main.RespawnType == "Spawnpoint" then
        game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
    elseif char and char:GetAttribute("Downed") == true and DConfiguration.Main.RespawnType == "Fake Revive" then
        local PreviousPosition
        PreviousPosition = LocalPlayer.Character.HumanoidRootPart.Position
        wait(0.2)
        game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
        wait(1)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(PreviousPosition)
    end
end

function DFunctions.Whistle()
    LocalPlayer.PlayerScripts.Events.KeybindUsed:Fire("Whistle", true)
    game:GetService("ReplicatedStorage").Events.Whistle:FireServer()
end

local _colaLeaderboard = {}
local _colaSpeedConn   = nil

function DFunctions.UseCola()
    pcall(function()
        ReplicatedStorage.Events.UseUsable:FireServer("Cola")
    end)
    local name = LocalPlayer.Name
    _colaLeaderboard[name] = (_colaLeaderboard[name] or 0) + 1
    DConfiguration.Main.Cola.Count = _colaLeaderboard[name]

    if DConfiguration.Main.Cola.SpeedEnabled then
        task.spawn(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local orig = hum.WalkSpeed
            hum.WalkSpeed = orig + DConfiguration.Main.Cola.SpeedAmount
            task.wait(DConfiguration.Main.Cola.SpeedDuration)
            if hum and hum.Parent then
                hum.WalkSpeed = orig
            end
        end)
    end
end

-- Passively detect other players using cola by watching speed spikes on their character
task.spawn(function()
    task.wait(5)
    local function watchPlayer(p)
        local char = p.Character or p.CharacterAdded:Wait()
        local function watchChar(c)
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local lastSpd = hum.WalkSpeed
            RunService.Heartbeat:Connect(function()
                local cur = hum.WalkSpeed
                if cur - lastSpd > 15 then
                    _colaLeaderboard[p.Name] = (_colaLeaderboard[p.Name] or 0) + 1
                end
                lastSpd = cur
            end)
        end
        watchChar(char)
        p.CharacterAdded:Connect(watchChar)
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then task.spawn(watchPlayer, p) end
    end
    Players.PlayerAdded:Connect(function(p)
        if p ~= LocalPlayer then task.spawn(watchPlayer, p) end
    end)
end)

function DFunctions.RemoveDamagePart()
    local Map = game.Workspace.Game.Map
    for i, v in pairs(Map:GetDescendants()) do
        if v:IsA("BasePart") and v.CanTouch == true then
            v.CanTouch = false
        end
    end
end

function DFunctions.DisableTouch(t)
    for i, v in next, t:GetChildren() do
        if v.IsA(v, "BasePart") then
            v.CanTouch = false
        end
    end
end

function DFunctions.DisableInvisParts(state)
    -- Try the dedicated InvisParts folder first; fall back to a full map scan
    -- so the feature works even when the folder is missing or nested differently.
    local function applyToMap(root)
        for _, v in ipairs(root:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency >= 1 then
                v.CanCollide = state
            end
        end
    end

    pcall(function()
        local invFolder = Workspace:FindFirstChild("Game")
            and Workspace.Game:FindFirstChild("Map")
            and Workspace.Game.Map:FindFirstChild("InvisParts")
        if invFolder then
            for _, v in ipairs(invFolder:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = state
                end
            end
        else
            -- Fallback: any fully-transparent collidable part in the map
            local mapRoot = Workspace:FindFirstChild("Game")
                and Workspace.Game:FindFirstChild("Map")
            if mapRoot then
                applyToMap(mapRoot)
            end
        end
    end)
end

function DFunctions.CreateTimer()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent       = LocalPlayer.PlayerGui
    screenGui.ResetOnSpawn = false
    screenGui.Name         = "TimerGui"

    local timerLabel = Instance.new("TextLabel")
    timerLabel.Parent             = screenGui
    timerLabel.Size               = UDim2.new(0, 200, 0, 50)
    timerLabel.Position           = UDim2.new(0.5, -100, 0.1, 0)
    timerLabel.BackgroundTransparency = 1
    timerLabel.TextScaled         = true
    timerLabel.Font               = Enum.Font.SourceSans
    timerLabel.TextColor3         = Color3.new(1, 1, 1)
end

function DFunctions.RemoveTimer()
    if LocalPlayer.PlayerGui:FindFirstChild("TimerGui") then
        LocalPlayer.PlayerGui.TimerGui:Destroy()
    end
end

function DFunctions.Noclip()
    pcall(function()
        for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v:IsA("MeshPart") then
                v.CanCollide = false
            end
        end
    end)
end

function DFunctions.AntiNextbot()
    if game.Workspace:FindFirstChild("Game") and game.Workspace.Game:FindFirstChild("Players")
    and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

        local playerTeam = game.Workspace.Game.Players[LocalPlayer.Name]:GetAttribute("Team")
        if playerTeam == "Nextbot" then return end

        for i, v in pairs(game.Workspace.Game.Players:GetDescendants()) do
            if v:IsA("Model") and v:GetAttribute("Team") == "Nextbot" then
                local humanoidRootPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("HRP")
                if humanoidRootPart then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                    if distance < DConfiguration.Combat.AntiNextbotRange then
                        if DConfiguration.Combat.AntiNextbotType == "Spawn" then
                            local parts = workspace.Game.Map.ItemSpawns:GetChildren()
                            local randomPart = parts[math.random(1, #parts)]
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(randomPart.Position)
                        elseif DConfiguration.Combat.AntiNextbotType == "Players" then
                            local randomPlayer = Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
                            if randomPlayer then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                                    randomPlayer.Character.Head.Position.X,
                                    randomPlayer.Character.Head.Position.Y,
                                    randomPlayer.Character.Head.Position.Z
                                )
                            end
                        end
                    end
                end
            end
        end
    end
end

function DFunctions.HookMovement(char)
    local success, module = pcall(function()
        return require(char:WaitForChild("Movement"))
    end)
    if not success then return end

    local oldFriction
    local oldAccel

    if module.ApplyFriction then
        oldFriction = hookfunction(module.ApplyFriction, function(...)
            local args = {...}
            if args[2] and char:GetAttribute("Crouching") == true then
                args[2] = math.max(-0.1, DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration - 0.9)
            elseif args[2] then
                args[2] = DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration
            end
            return oldFriction(unpack(args))
        end)
    end

    if module.Accelerate then
        oldAccel = hookfunction(module.Accelerate, function(...)
            local args = {...}
            if args[3] == 182 or args[4] == 182 then
                args[3] = DConfiguration.Misc.PlayerAdjustment.Update.AirStrafe
                args[4] = DConfiguration.Misc.PlayerAdjustment.Update.AirStrafe
            end
            return oldAccel(unpack(args))
        end)
    end

    -- Auto Jump Hold fix: patch the module's JumpRequest connection at runtime so that
    -- holding Space/ButtonB only performs one jump per physical press.
    -- Root cause: after jump 1 ends and JumpHeight is restored, the game re-fires
    -- JumpRequest (Space still held), setting JumpHeight=0 with nobody to reset v_u_7
    -- → JumpHeight stays 0 until key release, breaking BHOP Hold.
    -- We use getconnections (executor API) to find the connection and hookfunction it.
    if getconnections then
        local UIS_hook = game:GetService("UserInputService")
        local perPressFired = false

        UIS_hook.InputBegan:Connect(function(input, gpe)
            if not gpe and (input.KeyCode == Enum.KeyCode.Space
            or input.KeyCode == Enum.KeyCode.ButtonB) then
                perPressFired = false
            end
        end)
        UIS_hook.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space
            or input.KeyCode == Enum.KeyCode.ButtonB then
                perPressFired = false
            end
        end)
        -- Mobile: reset lock when JumpButton finger lifts
        task.spawn(function()
            local TG = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui", 8)
            if not TG then return end
            local CF2 = TG:WaitForChild("TouchControlFrame", 5)
            if not CF2 then return end
            local JB2 = CF2:FindFirstChild("JumpButton")
            if not JB2 then return end
            JB2.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Touch then
                    perPressFired = false
                end
            end)
        end)

        -- Hook the module's JumpRequest connection (first/only one registered by Init)
        local jumpConns = getconnections(UIS_hook.JumpRequest)
        for _, conn in ipairs(jumpConns) do
            if conn.Function then
                local origFn
                origFn = hookfunction(conn.Function, function(...)
                    if perPressFired then return end
                    perPressFired = true
                    return origFn(...)
                end)
                break
            end
        end
    end
end

function DFunctions.GetSpeedometer()
    local currentspeed = LocalPlayer.Character:GetAttribute("CurrentMoveSpeed")
    return currentspeed
end

local CachedRayParams = RaycastParams.new()
CachedRayParams.FilterType = Enum.RaycastFilterType.Exclude

function DFunctions.StartLag(ms)
    local LagTime = ms * 0.002
    local mode    = DConfiguration.Misc.Utilities.LagSwitch.Mode
    local character = LocalPlayer.Character
    if not character then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local storedVelocity = hrp.AssemblyLinearVelocity
    if storedVelocity.Magnitude < 1 then return end

    local start = tick()
    while tick() - start < LagTime do end

    if mode == "FastFlag" or LagTime < 0.2 then
        setfflag("MaxMissedWorldStepsRemembered", "9999")
        return
    end

    if mode ~= "Demon" or LagTime < 0.2 then return end

    CachedRayParams.FilterDescendantsInstances = {character}

    local multiplier = math.random(2, 4)
    local horizontalVelocity = Vector3.new(storedVelocity.X, 0, storedVelocity.Z)
    local direction  = horizontalVelocity.Magnitude > 0 and horizontalVelocity.Unit or hrp.CFrame.LookVector
    local distance   = math.min(horizontalVelocity.Magnitude * LagTime * multiplier, 30)
    local forwardPos = hrp.Position + direction * distance
    local targetPos  = forwardPos

    local forwardResult = workspace:Raycast(hrp.Position, forwardPos - hrp.Position, CachedRayParams)
    if forwardResult then
        targetPos = forwardResult.Position - direction * 2
    end

    local function detectSlope(dir, dist)
        return workspace:Raycast(hrp.Position + dir * dist, Vector3.new(0, -60, 0), CachedRayParams)
    end

    local longSlopeCheck  = detectSlope(direction, 50)
    local shortSlopeCheck = nil

    for i = 2, 20, 2 do
        local result = detectSlope(direction, i)
        if result then
            shortSlopeCheck = result
            break
        end
    end

    local slopeLengthBoost, shortSlopeBoost = 1, 1
    local slopeDirBoost = 1
    local hoverBuffer   = 0
    local slopeAngle    = 0
    local earlyBounce   = false

    if longSlopeCheck then
        local normal = longSlopeCheck.Normal
        slopeAngle = math.deg(math.acos(normal:Dot(Vector3.new(0, 1, 0))))
        if slopeAngle >= 20 and slopeAngle <= 80 then
            slopeLengthBoost = math.clamp(slopeAngle / 25, 1, 2.2)
            slopeDirBoost    = math.clamp(slopeAngle / 40, 1, 2)
            hoverBuffer      = math.clamp((slopeAngle - 20) * 0.06, 0, 3)
            if slopeAngle < 35 then
                targetPos = targetPos + Vector3.new(0, 3, 0) + direction * (2 * slopeDirBoost)
            else
                targetPos = targetPos + Vector3.new(0, slopeAngle * 0.3 + hoverBuffer, 0)
            end
        end
    end

    if shortSlopeCheck then
        local normal = shortSlopeCheck.Normal
        slopeAngle = math.deg(math.acos(normal:Dot(Vector3.new(0, 1, 0))))
        if slopeAngle >= 20 and slopeAngle <= 80 then
            shortSlopeBoost = math.clamp(slopeAngle / 22, 1, 2.5)
            slopeDirBoost   = slopeDirBoost + math.clamp(slopeAngle / 50, 0, 1.6)
            hoverBuffer     = hoverBuffer + math.clamp((slopeAngle - 20) * 0.05, 0, 3)
            local verticalDist = hrp.Position.Y - shortSlopeCheck.Position.Y
            local minForward   = 4
            local minUp        = 4
            if slopeAngle >= 50 and verticalDist < 3 then
                earlyBounce = true
                targetPos   = targetPos + direction * minForward + Vector3.new(0, minUp, 0)
            else
                if slopeAngle < 35 then
                    targetPos = targetPos + Vector3.new(0, 3, 0) + direction * (2 * slopeDirBoost)
                else
                    targetPos = targetPos + Vector3.new(0, slopeAngle * 0.4 + hoverBuffer, 0)
                end
            end
        end
    end

    if slopeAngle >= 35 then
        targetPos = targetPos + direction * (5 * slopeDirBoost)
    end

    local safetyCheck = workspace:Raycast(hrp.Position, targetPos - hrp.Position, CachedRayParams)
    if safetyCheck then
        targetPos = safetyCheck.Position + Vector3.new(0, 2, 0) - direction * 2
    end

    if shortSlopeCheck or longSlopeCheck then
        local hitPos      = (shortSlopeCheck or longSlopeCheck).Position
        local verticalDist = hrp.Position.Y - hitPos.Y
        if verticalDist < 2 then
            targetPos = hrp.Position + direction * 2 + Vector3.new(0, 2, 0)
        end
    end

    hrp.CFrame = CFrame.new(targetPos, targetPos + hrp.CFrame.LookVector)

    local delta      = targetPos - hrp.Position
    local spd        = storedVelocity.Magnitude
    local forwardBoost = math.clamp(spd * 0.4, 4, 20)
    local safeDir    = delta.Magnitude > 0 and delta.Unit or direction
    local safeCheck  = workspace:Raycast(hrp.Position, safeDir * forwardBoost, CachedRayParams)

    if not safeCheck then
        hrp.AssemblyLinearVelocity += safeDir * forwardBoost
    else
        local safeDist = (safeCheck.Position - hrp.Position).Magnitude
        if safeDist > 3 then
            hrp.AssemblyLinearVelocity += safeDir * (safeDist * 0.6)
        end
    end

    local bounceMultiplier = 1.2
    if slopeAngle >= 45 then
        local angleBoost = math.clamp((slopeAngle - 45) / 20, 0, 1.0)
        bounceMultiplier = 1.2 + angleBoost
    end

    if storedVelocity.Y < -60 then
        bounceMultiplier *= 0.9 * slopeLengthBoost * shortSlopeBoost
    elseif storedVelocity.Y < -30 then
        bounceMultiplier *= 1.0 * slopeLengthBoost * shortSlopeBoost
    end

    if storedVelocity.Y < -10 then
        local angleFactor = math.clamp((slopeAngle - 20) / 40, 0, 1)
        local bounceY     = math.abs(storedVelocity.Y) * (1.1 + angleFactor * 0.9)
        bounceY           = bounceY + storedVelocity.Magnitude * (0.3 + angleFactor * 0.5)
        bounceY           = math.clamp(bounceY * bounceMultiplier * 1.0, 0, 60 + storedVelocity.Magnitude * 0.4)

        hrp.AssemblyLinearVelocity = Vector3.new(
            storedVelocity.X * slopeDirBoost,
            bounceY,
            storedVelocity.Z * slopeDirBoost
        )

        if earlyBounce then
            local fwdBoost  = math.clamp(5 + storedVelocity.Magnitude * 0.1, 6, 20)
            local fwdCheck  = workspace:Raycast(hrp.Position, direction * fwdBoost, CachedRayParams)
            if not fwdCheck then
                hrp.CFrame = hrp.CFrame + direction * fwdBoost
            else
                local safeDist = (fwdCheck.Position - hrp.Position).Magnitude
                if safeDist > 3 then
                    hrp.CFrame = hrp.CFrame + direction * (safeDist * 0.5)
                end
            end
        end
    end

    hrp.Size = Vector3.new(3, 20, 3)
    wait(0.1)
    hrp.Size = Vector3.new(2, 4, 2)
end

function DFunctions.BounceFunction()
    local speedometer = DFunctions.GetSpeedometer()
    local char        = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid    = char and char:FindFirstChild("Humanoid")

    if speedometer then
        DConfiguration.Misc.Utilities.GetCurrentSpeed = speedometer
    end

    if not DConfiguration.Misc.Utilities.BounceModification.Enabled and humanoid then
        humanoid.WalkSpeed = 0
        return
    end

    if char and humanoid then
        if char:GetAttribute("Downed") == true or not DConfiguration.Misc.Utilities.BounceModification.Enabled then
            humanoid.WalkSpeed = 0
        elseif char:GetAttribute("Emoting") == true and char:GetAttribute("Crouching") == true then
            humanoid.WalkSpeed = DConfiguration.Misc.Utilities.BounceModification.EmoteBounce + DConfiguration.Misc.Utilities.GetCurrentSpeed
        elseif DConfiguration.Misc.Utilities.GetCurrentSpeed < 15 or char:GetAttribute("Emoting") == true or char:GetAttribute("Downed") == true then
            humanoid.WalkSpeed = 0
        else
            humanoid.WalkSpeed = DConfiguration.Misc.Utilities.BounceModification.DefaultBounce + DConfiguration.Misc.Utilities.GetCurrentSpeed
        end
    end
end

function DFunctions.SprintEmoteDash()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Type == "Legit"
    and (char and char:GetAttribute("Emoting") == true and char:GetAttribute("Crouching") == true) then
        DConfiguration.Misc.PlayerAdjustment.Debounce.GroundAcceleration = false
        DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration   = DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Acceleration
    else
        if DConfiguration.Misc.PlayerAdjustment.Debounce.GroundAcceleration then
            DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = DConfiguration.Misc.PlayerAdjustment.Saved.GroundAcceleration
            wait(0.1)
            DConfiguration.Misc.PlayerAdjustment.Debounce.GroundAcceleration = true
        end
    end

    if DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Type == "Blatant"
    and (char and char:GetAttribute("Emoting") == true) then
        DConfiguration.Misc.PlayerAdjustment.Update.Speed = DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Speed
    else
        DConfiguration.Misc.PlayerAdjustment.Update.Speed = DConfiguration.Misc.PlayerAdjustment.Saved.Speed
    end
end

function DFunctions.BHOPFunction()
    local speedometer       = DFunctions.GetSpeedometer()
    local char              = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidrootpart  = char:FindFirstChild("HumanoidRootPart")
    local humanoid          = char:FindFirstChildOfClass("Humanoid")
    local debounce

    if not char or not humanoidrootpart or not humanoid then return end

    -- Do not jump while downed
    if char:GetAttribute("Downed") == true then return end

    -- Reset the Movement module's jumpHeld flag so JumpHeight is restored before next jump
    pcall(function() char.Movement.JumpEnded:Fire() end)

    if DConfiguration.Misc.MovementModification.BHOP.Type == "Acceleration" then
        if speedometer > 60 then
            DConfiguration.Misc.MovementModification.BHOP.HipHeight2 = -1.05
        else
            DConfiguration.Misc.MovementModification.BHOP.HipHeight2 = -1.10
        end
        debounce = 0.01
        humanoid.HipHeight = DConfiguration.Misc.MovementModification.BHOP.HipHeight2
    elseif DConfiguration.Misc.MovementModification.BHOP.Type == "Ground Acceleration" then
        DConfiguration.Misc.MovementModification.BHOP.HipHeight2 = -2
        humanoid.HipHeight = DConfiguration.Misc.MovementModification.BHOP.HipHeight2
        debounce = 0.01
    elseif DConfiguration.Misc.MovementModification.BHOP.Type == "No Acceleration" then
        debounce = 0.125
    end

    if DConfiguration.Misc.MovementModification.BHOP.AutoAcceleration then
        local Speed     = speedometer
        local Threshold = math.clamp(Speed, 25, 50)
        local Devisor   = math.clamp(Speed / Threshold, 0, 6)
        local Decrease  = math.clamp(1 - (Devisor * 1.7), 0.01, 0.8)

        if Speed < DConfiguration.Misc.MovementModification.BHOP.MaxSpeed then
            DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = DConfiguration.Misc.MovementModification.BHOP.Acceleration
        else
            DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = Decrease
        end
    else
        DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = DConfiguration.Misc.MovementModification.BHOP.Acceleration
    end

    local now         = tick()
    local lastGrounded = 0

    if humanoid.FloorMaterial ~= Enum.Material.Air then
        lastGrounded = now
    end

    local grounded = (now - lastGrounded) < 0.06

    if DConfiguration.Misc.MovementModification.BHOP.JumpType == "Simulated" then
        if grounded and (now - DConfiguration.Misc.MovementModification.BHOP.lastTick) > debounce then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            DConfiguration.Misc.MovementModification.BHOP.lastTick = now
            task.delay(0.08, function()
                pcall(function() char.Movement.JumpEnded:Fire() end)
            end)
        end
    elseif DConfiguration.Misc.MovementModification.BHOP.JumpType == "Realistic" then
        if grounded and (now - DConfiguration.Misc.MovementModification.BHOP.lastTick) > debounce then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            DConfiguration.Misc.MovementModification.BHOP.lastTick = now
            task.delay(0.08, function()
                pcall(function() char.Movement.JumpEnded:Fire() end)
            end)
        end
    end
end

local _bhopHoldActive   = false
local _bhopLastJumpReq  = 0
local _bhopMobileHooked = false

-- Space-key hold tracking (PC)
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Space
    and DConfiguration.Misc.MovementModification.BHOP.JumpButton then
        _bhopHoldActive  = true
        _bhopLastJumpReq = tick()
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space
    and DConfiguration.Misc.MovementModification.BHOP.JumpButton then
        _bhopHoldActive = false
    end
end)

-- Mobile JumpButton hold tracking
task.spawn(function()
    local TouchGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui", 8)
    if not TouchGui then return end
    local Frame = TouchGui:WaitForChild("TouchControlFrame", 5)
    if not Frame then return end
    local JumpButton = Frame:FindFirstChild("JumpButton")
    if not JumpButton then return end
    _bhopMobileHooked = true
    JumpButton.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch
        and DConfiguration.Misc.MovementModification.BHOP.JumpButton then
            _bhopHoldActive  = true
            _bhopLastJumpReq = tick()
        end
    end)
    JumpButton.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch
        and DConfiguration.Misc.MovementModification.BHOP.JumpButton then
            _bhopHoldActive = false
        end
    end)
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if DConfiguration.Misc.MovementModification.BHOP.Enabled
    or DConfiguration.Misc.MovementModification.BHOP.Keybind
    or (_bhopHoldActive and DConfiguration.Misc.MovementModification.BHOP.JumpButton) then
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
end)

function DFunctions.ResetBHOP()
    local char     = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    DConfiguration.Misc.MovementModification.BHOP.HipHeight1 = -1.25
    DConfiguration.Misc.MovementModification.BHOP.HipHeight2 = -1.10

    if humanoid then
        humanoid.HipHeight = DConfiguration.Misc.MovementModification.BHOP.HipHeight1
        DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = 1
        wait(0.3)
        DConfiguration.Misc.PlayerAdjustment.Update.GroundAcceleration = 1
    end
end


local GamePlayers = workspace:WaitForChild("Game"):WaitForChild("Players")

Tabs.Main:AddSection("Game Modification")

Tabs.Main:AddSection("Billboard ESP")

local Toggle = Tabs.Main:AddToggle("BillboardNextbots", { Title = "Billboard Nextbots", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.ESP.Nextbots = value

    while DConfiguration.ESP.Nextbots and wait(0.1) do
        for _, v in pairs(GamePlayers:GetChildren()) do
            if not Players:FindFirstChild(v.Name) and v:FindFirstChild("HumanoidRootPart") then
                local ESPName = "NextbotESP"
                local hrp

                if v:FindFirstChild("Hitbox") then
                    hrp = v.Hitbox
                elseif v:FindFirstChild("Base") then
                    hrp = v.Base
                elseif v:FindFirstChild("Head") then
                    hrp = v.Head
                else
                    hrp = v:FindFirstChildWhichIsA("Part")
                end

                if hrp and not hrp:FindFirstChild(ESPName) then
                    CreateBillboardESP(ESPName, hrp, Color3.fromRGB(255, 255, 255), 18)
                end

                if hrp then
                    UpdateBillboardESP(ESPName, hrp, v.Name, Color3.fromRGB(255, 0, 0), 18, Camera.CFrame.Position)
                end
            end
        end
    end

    if not DConfiguration.ESP.Nextbots then
        for _, v in pairs(GamePlayers:GetDescendants()) do
            if not Players:FindFirstChild(v.Name) and v:FindFirstChild("HumanoidRootPart") then
                local hrp

                if v:FindFirstChild("Hitbox") then
                    hrp = v.Hitbox
                elseif v:FindFirstChild("Base") then
                    hrp = v.Base
                elseif v:FindFirstChild("Head") then
                    hrp = v.Head
                else
                    hrp = v:FindFirstChildWhichIsA("Part")
                end

                if not hrp then return end
                DestroyBillboardESP("NextbotESP", hrp)
            end
        end
    end
end)

local Toggle = Tabs.Main:AddToggle("BillboardPlayers", { Title = "Billboard Players", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.ESP.Players = value

    while DConfiguration.ESP.Players and wait(0.1) do
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local ESPName   = "PlayerESP"
                local PlayerChar = v.Character

                if PlayerChar then
                    if not PlayerChar.HumanoidRootPart:FindFirstChild(ESPName) then
                        CreateBillboardESP(ESPName, PlayerChar.HumanoidRootPart, Color3.fromRGB(255, 255, 255), 14)
                    end

                    local PlayerStats = GamePlayers:FindFirstChild(v.Name)
                    if PlayerStats and PlayerStats:GetAttribute("Downed") == true then
                        UpdateBillboardESP(ESPName, PlayerChar.HumanoidRootPart, v.Name, Color3.fromRGB(0, 255, 0), 14, Camera.CFrame.Position)
                    else
                        UpdateBillboardESP(ESPName, PlayerChar.HumanoidRootPart, v.Name, Color3.fromRGB(255, 255, 255), 14, Camera.CFrame.Position)
                    end
                end
            end
        end
    end

    if not DConfiguration.ESP.Players then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                DestroyBillboardESP("PlayerESP", v.Character.HumanoidRootPart)
            end
        end
    end
end)

Tabs.Main:AddSection("Tracer ESP")

local TracerLinesBots = {}
local TracerLines     = {}

local Toggle = Tabs.Main:AddToggle("TracersPlayers", {
    Title   = "Tracer Players",
    Default = false,
})

Toggle:OnChanged(function(State)
    DConfiguration.Tracers.Players = State

    if not DConfiguration.Tracers.Players then
        for part, _ in pairs(TracerLines) do
            if typeof(part) == "Instance" then
                DestroyTracerESP(TracerLines, part)
            else
                TracerLines[part] = nil
            end
        end
        TracerLines = {}
        return
    end

    task.spawn(function()
        while DConfiguration.Tracers.Players and task.wait() do
            if not DConfiguration.Tracers.Players then break end

            pcall(function()
                local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not localHRP then return end

                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            if not TracerLines[hrp] then
                                CreateTracerESP(TracerLines, hrp, 2, Color3.fromRGB(255, 255, 255))
                            end
                            local color = Color3.fromRGB(255, 255, 255)
                            local gamePlayer = workspace:FindFirstChild("Game") and workspace.Game.Players:FindFirstChild(player.Name)
                            if gamePlayer and gamePlayer:GetAttribute("Downed") then
                                color = Color3.fromRGB(0, 255, 0)
                            end
                            UpdateTracerESP(TracerLines, hrp, color)
                        end
                    end
                end

                for part, tracer in pairs(TracerLines) do
                    if typeof(part) == "Instance" then
                        local owner = part.Parent
                        local isValid = owner and Players:FindFirstChild(owner.Name)
                        if not isValid then
                            DestroyTracerESP(TracerLines, part)
                        end
                    else
                        TracerLines[part] = nil
                    end
                end
            end)
        end

        for part, _ in pairs(TracerLines) do
            if typeof(part) == "Instance" then
                DestroyTracerESP(TracerLines, part)
            else
                TracerLines[part] = nil
            end
        end
        TracerLines = {}
    end)
end)

local Toggle = Tabs.Main:AddToggle("TracersNextbots", {
    Title   = "Tracer Nextbots",
    Default = false,
})

Toggle:OnChanged(function(State)
    DConfiguration.Tracers.Nextbots = State

    if not DConfiguration.Tracers.Nextbots then
        for part, _ in pairs(TracerLinesBots) do
            if typeof(part) == "Instance" then
                DestroyTracerESP(TracerLinesBots, part)
            else
                TracerLinesBots[part] = nil
            end
        end
        TracerLinesBots = {}
        return
    end

    task.spawn(function()
        while DConfiguration.Tracers.Nextbots and task.wait() do
            if not DConfiguration.Tracers.Nextbots then break end

            pcall(function()
                for _, v in pairs(GamePlayers:GetChildren()) do
                    if not Players:FindFirstChild(v.Name) and v:FindFirstChild("HumanoidRootPart") then
                        local hrp = v:FindFirstChild("Hitbox") or v:FindFirstChild("Base") or v:FindFirstChild("Head") or v:FindFirstChildWhichIsA("Part")
                        if hrp then
                            if not TracerLinesBots[hrp] then
                                CreateTracerESP(TracerLinesBots, hrp, 2, Color3.fromRGB(255, 0, 0))
                            end
                            UpdateTracerESP(TracerLinesBots, hrp, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end

                for part, _ in pairs(TracerLinesBots) do
                    if typeof(part) ~= "Instance" then
                        TracerLinesBots[part] = nil
                    end
                end
            end)
        end

        for part, _ in pairs(TracerLinesBots) do
            if typeof(part) == "Instance" then
                DestroyTracerESP(TracerLinesBots, part)
            else
                TracerLinesBots[part] = nil
            end
        end
        TracerLinesBots = {}
    end)
end)

Tabs.Main:AddSection("Highlight ESP")

local Toggle = Tabs.Main:AddToggle("HighlightPlayers", { Title = "Highlight Players", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Highlight.Players = State

    task.spawn(function()
        while DConfiguration.Highlight.Players and task.wait(0.2) do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    if not player.Character:FindFirstChild("PlayerHighlight") then
                        CreateHighlightESP("PlayerHighlight", player.Character, Color3.fromRGB(0, 170, 255), Color3.fromRGB(255, 255, 255), DConfiguration.Highlight.OutlineOnly == false)
                    end
                end
            end
        end

        if not DConfiguration.Highlight.Players then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    DestroyHighlightESP("PlayerHighlight", player.Character)
                end
            end
        end
    end)
end)

local Toggle = Tabs.Main:AddToggle("HighlightNextbots", { Title = "Highlight Nextbots", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Highlight.Nextbots = State

    task.spawn(function()
        while DConfiguration.Highlight.Nextbots and task.wait(0.2) do
            for _, v in pairs(GamePlayers:GetChildren()) do
                if not Players:FindFirstChild(v.Name) then
                    if not v:FindFirstChild("NextbotHighlight") then
                        CreateHighlightESP("NextbotHighlight", v, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 255, 255), true)
                    end
                end
            end
        end

        if not DConfiguration.Highlight.Nextbots then
            for _, v in pairs(GamePlayers:GetChildren()) do
                if not Players:FindFirstChild(v.Name) then
                    DestroyHighlightESP("NextbotHighlight", v)
                end
            end
        end
    end)
end)

Tabs.Main:AddSection("Main")

local Toggle = Tabs.Main:AddToggle("AntiAFK", { Title = "Anti AFK", Default = true })

Toggle:OnChanged(function(value)
    DConfiguration.Main.AntiAFK = value
    if value then
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            if DConfiguration.Main.AntiAFK then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end)
    end
end)

do
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if DConfiguration.Main.AntiAFK then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

local Toggle = Tabs.Main:AddToggle("AutoRespawnToggle", { Title = "Auto Respawn", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.Main.AutoRespawn = value
    while DConfiguration.Main.AutoRespawn and wait(0.1) do
        spawn(DFunctions.AutoRespawn)
    end
end)

local Dropdown = Tabs.Main:AddDropdown("RespawnType", {
    Title   = "Respawn Type",
    Values  = { "Spawnpoint", "Fake Revive" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Main.RespawnType = Value
end)

Tabs.Main:AddButton({
    Title = "Respawn Now", Description = "Instantly trigger a respawn",
    Callback = function() spawn(DFunctions.AutoRespawn) end,
})

local Toggle = Tabs.Main:AddToggle("RespawnFloatBtn", { Title = "Respawn — Floating Button", Default = false })
Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("RespawnBtn", "Respawn", 0.15, 0.1, function()
            spawn(DFunctions.AutoRespawn)
        end, nil, "Main")
    else
        DFunctions.DestroyButton("RespawnBtn")
    end
end)

Tabs.Main:AddKeybind("AutoRespawnKeybind", {
    Title = "Auto Respawn Keybind", Mode = "Toggle", Default = "R",
    Callback = function(Value)
        DConfiguration.Main.AutoRespawn = Value
        if Value then
            task.spawn(function()
                while DConfiguration.Main.AutoRespawn and wait(0.1) do spawn(DFunctions.AutoRespawn) end
            end)
        end
    end,
})

local Toggle = Tabs.Main:AddToggle("AutoWhistle", { Title = "Auto Whistle", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.Main.AutoWhistle = value
    while DConfiguration.Main.AutoWhistle and wait(0.5) do
        spawn(DFunctions.Whistle)
    end
end)

Tabs.Main:AddSection("Map Modification")

local Toggle = Tabs.Main:AddToggle("RemoveDamage", { Title = "Remove Damage Objects", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.Removals.DamageParts = value
    while task.wait(1) and DConfiguration.Removals.DamageParts do
        spawn(DFunctions.RemoveDamagePart)
    end
end)

do
    local _iwProcessed = {}

    local _iwRepairKeywords = {
        "stair", "step", "ramp", "trimp", "platform", "invisibleplatform",
        "floor", "ground", "pad", "road", "path", "bridge"
    }

    local function _iwIsPlayerPart(obj)
        for _, player in pairs(Players:GetPlayers()) do
            local char = player.Character
            if char and obj:IsDescendantOf(char) then
                return true
            end
        end
        return false
    end

    local function _iwIsGameplayPart(name)
        name = string.lower(name)
        for _, keyword in pairs(_iwRepairKeywords) do
            if string.find(name, keyword, 1, true) then
                return true
            end
        end
        return false
    end

    local function _iwRunCleanAndFix()
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("MeshPart"))
                and not _iwProcessed[obj]
                and obj.Parent
            then
                if not _iwIsPlayerPart(obj)
                    and not _iwIsGameplayPart(string.lower(obj.Name))
                then
                    if obj.CanCollide and obj.Transparency >= 0.8 and obj.Position.Y > 50 then
                        pcall(function() obj:Destroy() end)
                    end
                end
                _iwProcessed[obj] = true
            end
        end
    end

    local _iwRConn  = nil
    local _iwThread = nil

    local Toggle = Tabs.Main:AddToggle("RemoveInvisibleWalls", { Title = "Remove Invisible Walls", Default = false })

    Toggle:OnChanged(function(value)
        DConfiguration.Removals.InvisibleWalls = value
        if value then
            _iwProcessed = {}
            _iwRunCleanAndFix()

            _iwRConn = UserInputService.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if input.KeyCode == Enum.KeyCode.R then
                    _iwRunCleanAndFix()
                end
            end)

            _iwThread = task.spawn(function()
                while DConfiguration.Removals.InvisibleWalls do
                    task.wait(30)
                    if DConfiguration.Removals.InvisibleWalls then
                        _iwRunCleanAndFix()
                    end
                end
            end)
        else
            if _iwRConn then
                _iwRConn:Disconnect()
                _iwRConn = nil
            end
            _iwThread = nil
        end
    end)
end

Tabs.Main:AddSection("Quick Actions")

Tabs.Main:AddSpace()

Tabs.Main:AddButton({
    Title       = "Open Leaderboard",
    Description = "Open the in-game leaderboard",
    Callback    = function()
        pcall(function()
            LocalPlayer.PlayerScripts.Events.KeybindUsed:Fire("Leaderboard", true)
        end)
    end,
})

Tabs.Main:AddSpace()

Tabs.Main:AddSection("Fly")

-- Fly system (crash-safe: uses RenderStepped connection, no busy loop)

_G.Fly      = false
_G.flySpeed = 20

do
    local _flyConn   = nil
    local _flyActive = false

    local function _stopFly()
        _flyActive = false
        if _flyConn then _flyConn:Disconnect(); _flyConn = nil end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum then pcall(function() hum.PlatformStand = false end) end
        if hrp then
            pcall(function() local v = hrp:FindFirstChild("FlyVelocity"); if v then v:Destroy() end end)
            pcall(function() local g = hrp:FindFirstChild("FlyGyro");     if g then g:Destroy() end end)
        end
    end

    local function _startFly()
        if _flyActive then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        if hrp:FindFirstChild("FlyVelocity") then return end

        _flyActive = true
        pcall(function() hum.PlatformStand = true end)

        local BV = Instance.new("BodyVelocity")
        BV.Name     = "FlyVelocity"
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.Parent   = hrp

        local BG = Instance.new("BodyGyro")
        BG.Name      = "FlyGyro"
        BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BG.D         = 100
        BG.CFrame    = hrp.CFrame
        BG.Parent    = hrp

        _flyConn = RunService.RenderStepped:Connect(function()
            if not _G.Fly or not hrp.Parent then
                _stopFly()
                return
            end
            pcall(function()
                local cam       = workspace.CurrentCamera
                local moveDir   = hum.MoveDirection
                local upVec     = Vector3.new(0, 1, 0)
                local speed     = (_G.flySpeed or 20) * 20

                if UserInputService:IsKeyDown(Enum.KeyCode.Space)
                or UserInputService:IsKeyDown(Enum.KeyCode.ButtonA) then
                    BV.Velocity = upVec * speed
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
                    or UserInputService:IsKeyDown(Enum.KeyCode.ButtonB) then
                    BV.Velocity = -upVec * speed
                elseif moveDir.Magnitude > 0 then
                    local fwd = cam.CFrame.LookVector
                    local rgt = cam.CFrame.RightVector
                    BV.Velocity = (rgt * moveDir.X - fwd * moveDir.Z).Unit * speed
                else
                    BV.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end)
    end

    local function toggleFly(enable)
        _G.Fly = enable
        if enable then
            _startFly()
        else
            _stopFly()
        end
    end

    -- Re-attach fly on character respawn while toggle is on
    LocalPlayer.CharacterAdded:Connect(function()
        _flyActive = false
        _flyConn   = nil
        if _G.Fly then
            task.delay(0.5, function()
                if _G.Fly then _startFly() end
            end)
        end
    end)

    local Toggle = Tabs.Main:AddToggle("FlyToggle", { Title = "Fly Toggle", Default = false })

    Toggle:OnChanged(function(Value)
        toggleFly(Value)
    end)

    Options.FlyToggle:SetValue(false)

    Tabs.Main:AddInput("FlySpeedInput", {
        Title       = "Fly Speed",
        Default     = tostring(_G.flySpeed),
        Placeholder = "Enter fly speed",
        Numeric     = true,
        Finished    = false,
        Callback    = function(Value)
            _G.flySpeed = tonumber(Value) or 20
        end,
    })

    local Toggle = Tabs.Main:AddToggle("FlyFloatBtn", { Title = "Fly — Floating Button", Default = false })
    Toggle:OnChanged(function(State)
        if State then
            DFunctions.CreateButton("FlyBtn", "Fly: OFF", 0.15, 0.1, function(btn)
                toggleFly(not _G.Fly)
                btn.Text = _G.Fly and "Fly: ON" or "Fly: OFF"
            end, nil, "Fly")
        else
            DFunctions.DestroyButton("FlyBtn")
        end
    end)

    Tabs.Main:AddKeybind("FlyKeybind", {
        Title    = "Fly Keybind",
        Mode     = "Toggle",
        Default  = "F",
        Callback = function(Value)
            toggleFly(Value)
        end,
    })
end

wait(Duration)

-- Combat Tab

Tabs.Combat:AddSection("Nextbot Modification")

local Toggle = Tabs.Combat:AddToggle("AntiNextbotToggle", { Title = "Anti Nextbot Toggle", Default = false })

Toggle:OnChanged(function(value)
    DConfiguration.Combat.AntiNextbot = value
    while DConfiguration.Combat.AntiNextbot and wait(0.1) do
        spawn(DFunctions.AntiNextbot)
    end
end)

local Dropdown = Tabs.Combat:AddDropdown("AntiBotTeleport", {
    Title   = "Anti Nextbot Teleport Type",
    Values  = { "Spawn", "Players" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Combat.AntiNextbotType = Value
end)

Tabs.Combat:AddInput("NextbotDistance", {
    Title       = "Anti Nextbot Distance",
    Default     = 15,
    Placeholder = "Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Combat.AntiNextbotRange = tonumber(Value) or 15
    end,
})

Tabs.Combat:AddKeybind("AntiNextbotKeybind", {
    Title = "Anti Nextbot Keybind", Mode = "Toggle", Default = "N",
    Callback = function(Value)
        DConfiguration.Combat.AntiNextbot = Value
        if Value then
            task.spawn(function()
                while DConfiguration.Combat.AntiNextbot and wait(0.1) do spawn(DFunctions.AntiNextbot) end
            end)
        end
    end,
})

wait(Duration)

-- Movement Tab

Tabs.Movement:AddSection("Player Adjustments")

Tabs.Movement:AddInput("PlayerSpeed", {
    Title       = "Player Speed",
    Description = "",
    Default     = "1500",
    Placeholder = "Speed Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.PlayerAdjustment.Update.Speed = tonumber(Value) or 1500
        DConfiguration.Misc.PlayerAdjustment.Saved.Speed  = tonumber(Value) or 1500
    end,
})

Tabs.Movement:AddInput("PlayerJump", {
    Title       = "Player Jump",
    Description = "",
    Default     = "3",
    Placeholder = "Jump Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.PlayerAdjustment.Update.JumpHeight = tonumber(Value) or 3
        DConfiguration.Misc.PlayerAdjustment.Saved.JumpHeight  = tonumber(Value) or 3
    end,
})

Tabs.Movement:AddInput("PlayerStrafeAcceleration", {
    Title       = "Air Strafe Acceleration",
    Description = "",
    Default     = "182",
    Placeholder = "182",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.PlayerAdjustment.Update.AirStrafe = tonumber(Value) or 182
        DConfiguration.Misc.PlayerAdjustment.Saved.AirStrafe  = tonumber(Value) or 182
    end,
})

Tabs.Movement:AddInput("AirAcceleration", {
    Title       = "Air Acceleration Multiplier",
    Description = "Applied while airborne (default 1)",
    Default     = "1",
    Placeholder = "1",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.PlayerAdjustment.Update.AirAcceleration = tonumber(Value) or 1
        DConfiguration.Misc.PlayerAdjustment.Saved.AirAcceleration  = tonumber(Value) or 1
    end,
})

Tabs.Movement:AddSpace()

local Toggle = Tabs.Movement:AddToggle("PlayerJumpPower", { Title = "Jump Power Toggle", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.Humanoids.OriginalJumpHeight = State

    while DConfiguration.Misc.Humanoids.OriginalJumpHeight and wait(0.1) do
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if not UseOriginalJump and humanoid then
            humanoid.UseJumpPower = false
            humanoid.JumpPower    = 20
        end

        if LocalPlayer.Character and humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower    = DConfiguration.Misc.Humanoids.JP
        end
    end
end)

Tabs.Movement:AddInput("PlayerJumpPower", {
    Title       = "Player Jump Power",
    Default     = "20",
    Placeholder = "Jump Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.Humanoids.JP = tonumber(Value) or 20
    end,
})

local Toggle = Tabs.Movement:AddToggle("PlayerWalkspeed", { Title = "Walkspeed Toggle", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.Humanoids.WalkspeedCF = State

    while DConfiguration.Misc.Humanoids.WalkspeedCF and wait(0.01) do
        local hb      = RunService.Heartbeat
        local speaker = game.Players.LocalPlayer
        local chr     = speaker.Character
        local hum     = chr and chr:FindFirstChildWhichIsA("Humanoid")
        local delta   = hb:Wait()

        if chr and hum.MoveDirection.Magnitude > 0 then
            chr:TranslateBy(hum.MoveDirection * DConfiguration.Misc.Humanoids.CF * delta * 10)
        end
    end
end)

Tabs.Movement:AddInput("PlayerWalkCf", {
    Title       = "Player Walkspeed",
    Default     = "5",
    Placeholder = "Walk Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.Humanoids.CF = tonumber(Value) or 5
    end,
})

-- In-Game Settings (path: Players.LocalPlayer.Settings)

do
    local function getSetting(name)
        local s = game:GetService("Players").LocalPlayer:FindFirstChild("Settings")
        return s and s:FindFirstChild(name)
    end
    local function setBool(name, v)
        local p = getSetting(name)
        if p then p.Value = v end
    end
    local function setNumber(name, v)
        local p = getSetting(name)
        if p then p.Value = v end
    end

    -- Keep values in sync if the module resets them
    local _overrides = {}
    RunService.Heartbeat:Connect(function()
        for name, val in pairs(_overrides) do
            local p = getSetting(name)
            if p and p.Value ~= val then p.Value = val end
        end
    end)

    Tabs.Movement:AddSection("In-Game Settings")

    -- Graphics group
    for _, name in ipairs({"FPShadows", "LowQuality", "Shadows"}) do
        local t = Tabs.Movement:AddToggle("IGS_" .. name, { Title = name, Default = false })
        t:OnChanged(function(State)
            _overrides[name] = State
            setBool(name, State)
        end)
    end

    Tabs.Movement:AddInput("IGS_FieldOfView", {
        Title = "FieldOfView", Default = "70", Placeholder = "70",
        Numeric = false, Finished = false,
        Callback = function(v)
            local n = tonumber(v) or 70
            _overrides["FieldOfView"] = n
            setNumber("FieldOfView", n)
        end,
    })

    Tabs.Movement:AddSpace()

    -- Audio group
    for _, name in ipairs({"BoomboxEnabled"}) do
        local t = Tabs.Movement:AddToggle("IGS_" .. name, { Title = name, Default = false })
        t:OnChanged(function(State)
            _overrides[name] = State
            setBool(name, State)
        end)
    end

    Tabs.Movement:AddInput("IGS_EmoteVolume", {
        Title = "EmoteVolume", Default = "1", Placeholder = "0–1",
        Numeric = false, Finished = false,
        Callback = function(v)
            local n = tonumber(v) or 1
            _overrides["EmoteVolume"] = n
            setNumber("EmoteVolume", n)
        end,
    })
    Tabs.Movement:AddInput("IGS_Music", {
        Title = "Music Volume", Default = "1", Placeholder = "0–1",
        Numeric = false, Finished = false,
        Callback = function(v)
            local n = tonumber(v) or 1
            _overrides["Music"] = n
            setNumber("Music", n)
        end,
    })

    Tabs.Movement:AddSpace()

    -- Gameplay group
    for _, name in ipairs({"CanBeCarried", "Jumpscares", "Ragdolls", "SprintViewmodels"}) do
        local t = Tabs.Movement:AddToggle("IGS_" .. name, { Title = name, Default = false })
        t:OnChanged(function(State)
            _overrides[name] = State
            setBool(name, State)
        end)
    end
end

Tabs.Movement:AddSection("Cola & Leaderboard")

Tabs.Movement:AddSpace()

-- Cola floating button (follows exact LagSwitch pattern)
local Toggle = Tabs.Movement:AddToggle("ColaButton", { Title = "Cola (Button)", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("ColaButton", "Use Cola", 0.15 + DConfiguration.Settings.GuiScale.Cola, 0.1 + DConfiguration.Settings.GuiScale.Cola, function(btn)
            DFunctions.UseCola()
            btn.Text = "Cola!"
            wait(0.15)
            btn.Text = "Use Cola"
        end, nil, "Utilities")
    else
        DFunctions.DestroyButton("ColaButton")
    end
end)

Tabs.Movement:AddInput("ColaButtonSize", {
    Title       = "Cola Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.Cola),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.Cola = num * 0.01
        else
            DConfiguration.Settings.GuiScale.Cola = 0
        end
        DFunctions.UpdateButton("ColaButton", 0.15 + DConfiguration.Settings.GuiScale.Cola, 0.1 + DConfiguration.Settings.GuiScale.Cola)
    end,
})

Tabs.Movement:AddInput("ColaButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("ColaButton", Value) end,
})

Tabs.Movement:AddKeybind("ColaKeybind", {
    Title    = "Cola Keybind",
    Mode     = "Toggle",
    Default  = "F",
    Callback = function(Value)
        if Value then DFunctions.UseCola() end
    end,
})

Tabs.Movement:AddSpace()

-- Leaderboard floating button (follows exact LagSwitch pattern)
local Toggle = Tabs.Movement:AddToggle("LeaderboardButton", { Title = "Leaderboard (Button)", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("LeaderboardButton", "Leaderboard", 0.15 + DConfiguration.Settings.GuiScale.Leaderboard, 0.1 + DConfiguration.Settings.GuiScale.Leaderboard, function(btn)
            pcall(function()
                LocalPlayer.PlayerScripts.Events.KeybindUsed:Fire("Leaderboard", true)
            end)
        end, nil, "Utilities")
    else
        DFunctions.DestroyButton("LeaderboardButton")
    end
end)

Tabs.Movement:AddInput("LeaderboardButtonSize", {
    Title       = "Leaderboard Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.Leaderboard),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.Leaderboard = num * 0.01
        else
            DConfiguration.Settings.GuiScale.Leaderboard = 0
        end
        DFunctions.UpdateButton("LeaderboardButton", 0.15 + DConfiguration.Settings.GuiScale.Leaderboard, 0.1 + DConfiguration.Settings.GuiScale.Leaderboard)
    end,
})

Tabs.Movement:AddInput("LeaderboardButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("LeaderboardButton", Value) end,
})

Tabs.Movement:AddKeybind("LeaderboardKeybind", {
    Title    = "Leaderboard Keybind",
    Mode     = "Toggle",
    Default  = "Tab",
    Callback = function(Value)
        if Value then
            pcall(function()
                LocalPlayer.PlayerScripts.Events.KeybindUsed:Fire("Leaderboard", true)
            end)
        end
    end,
})

Tabs.Movement:AddSpace()

-- Cola Usage Leaderboard popup button
Tabs.Movement:AddButton({
    Title       = "Cola Usage Leaderboard",
    Description = "Show cola usage counts this session",
    Callback    = function()
        local sorted = {}
        for name, count in pairs(_colaLeaderboard) do
            table.insert(sorted, { name = name, count = count })
        end
        table.sort(sorted, function(a, b) return a.count > b.count end)
        if #sorted == 0 then
            Fluent:Notify({ Title = "Cola Leaderboard", Content = "No cola used yet this session.", Duration = 4 })
        else
            local lines = {}
            for i, e in ipairs(sorted) do
                table.insert(lines, i .. ". " .. e.name .. "  x" .. e.count)
            end
            Fluent:Notify({ Title = "Cola Leaderboard", Content = table.concat(lines, "\n"), Duration = 7 })
        end
    end,
})

Tabs.Movement:AddSpace()

Tabs.Movement:AddSection("Utilities")

local Toggle = Tabs.Movement:AddToggle("LagSwitch", { Title = "Lag Switch (Button)", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("LagSwitchButton", "Start Lag", 0.15 + DConfiguration.Settings.GuiScale.LagSwitch, 0.1 + DConfiguration.Settings.GuiScale.LagSwitch, function(btn)
            task.spawn(function()
                DFunctions.StartLag(DConfiguration.Misc.Utilities.LagSwitch.MSDelay)
            end)
            btn.Text = "..."
            wait(0.1)
            btn.Text = "Start Lag"
        end, nil, "Lag Switch")
    else
        DFunctions.DestroyButton("LagSwitchButton")
    end
end)

Tabs.Movement:AddInput("LagSwitchButtonSize", {
    Title       = "Lag Switch Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.LagSwitch),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.LagSwitch = num * 0.01
        else
            DConfiguration.Settings.GuiScale.LagSwitch = 0
        end
        DFunctions.UpdateButton("LagSwitchButton", 0.15 + DConfiguration.Settings.GuiScale.LagSwitch, 0.1 + DConfiguration.Settings.GuiScale.LagSwitch)
    end,
})

Tabs.Movement:AddInput("LagSwitchButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("LagSwitchButton", Value) end,
})

Tabs.Movement:AddInput("DelayMS", {
    Title       = "Delay MS",
    Default     = "200",
    Placeholder = "Value",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.Utilities.LagSwitch.MSDelay = tonumber(Value) or 200
    end,
})

local Dropdown = Tabs.Movement:AddDropdown("LagMode", {
    Title   = "Lag Mode",
    Values  = { "Normal", "Demon", "FastFlag" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Misc.Utilities.LagSwitch.Mode = Value
end)

Tabs.Movement:AddKeybind("LagSwitchKeybind", {
    Title    = "Lag Switch Keybind",
    Mode     = "Hold",
    Default  = "L",
    Callback = function(Value)
        if Value then
            task.spawn(function()
                DFunctions.StartLag(DConfiguration.Misc.Utilities.LagSwitch.MSDelay)
            end)
        end
    end,
})

Tabs.Movement:AddSpace()

local Toggle = Tabs.Movement:AddToggle("AdjustBounce", { Title = "Modify Bounce", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.Utilities.BounceModification.Enabled = State
    while DConfiguration.Misc.Utilities.BounceModification.Enabled and wait(0.1) do
        spawn(DFunctions.BounceFunction)
    end
end)

Tabs.Movement:AddInput("PlayerBounce", {
    Title       = "Player Bounce",
    Default     = "80",
    Placeholder = "Bounce Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.Utilities.BounceModification.DefaultBounce = tonumber(Value) or 80
    end,
})

Tabs.Movement:AddInput("EmoteBounce", {
    Title       = "Emote Bounce",
    Default     = "120",
    Placeholder = "Bounce Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.Utilities.BounceModification.EmoteBounce = tonumber(Value) or 120
    end,
})

Tabs.Movement:AddSection("Game Automations")

local Toggle = Tabs.Movement:AddToggle("MacroMode", { Title = "Macro Button Toggle", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("MacroButton1", "Emote or Crouch", 0.15, 0.1, function()
            game:GetService("ReplicatedStorage").Events.Emote:FireServer(DConfiguration.Misc.GameAutomation.Macro.SelectedPrimary)
            LocalPlayer.Character.Communicator:InvokeServer("Crouching", true)
        end, nil, "Game Automations")

        DFunctions.CreateButton("MacroButton2", "Crouch", 0.15, 0.1, function(btn)
            local char       = LocalPlayer.Character
            local isCrouched = char and char:GetAttribute("Crouching") == true
            if isCrouched then
                LocalPlayer.Character.Communicator:InvokeServer("Crouching", false)
                btn.Text = "Crouch"
            else
                LocalPlayer.Character.Communicator:InvokeServer("Crouching", true)
                btn.Text = "Uncrouch"
            end
        end, nil, "Game Automations")
        task.spawn(function()
            while true do
                local char = LocalPlayer.Character
                if char then
                    local frame = DFunctions.GetButtonFrame and DFunctions.GetButtonFrame("MacroButton2")
                    if frame then
                        frame.Text = char:GetAttribute("Crouching") == true and "Uncrouch" or "Crouch"
                    end
                end
                task.wait(0.15)
            end
        end)
    else
        DFunctions.DestroyButton("MacroButton1")
        DFunctions.DestroyButton("MacroButton2")
    end
end)

Tabs.Movement:AddKeybind("MacroKeybind", {
    Title    = "Macro Button 1 Keybind",
    Mode     = "Hold",
    Default  = "Q",
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Emote:FireServer(DConfiguration.Misc.GameAutomation.Macro.SelectedPrimary)
                LocalPlayer.Character.Communicator:InvokeServer("Crouching", true)
            end)
        end
    end,
})

Tabs.Movement:AddKeybind("MacroCrouchKeybind", {
    Title    = "Macro Button 2 Keybind (Crouch)",
    Mode     = "Toggle",
    Default  = "C",
    Callback = function(Value)
        pcall(function()
            LocalPlayer.Character.Communicator:InvokeServer("Crouching", Value)
        end)
    end,
})

Tabs.Movement:AddInput("MacroButton1Size", {
    Title       = "Macro Button 1 Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.MacroButton1),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.MacroButton1 = num * 0.01
        else
            DConfiguration.Settings.GuiScale.MacroButton1 = 0
        end
        DFunctions.UpdateButton("MacroButton1", 0.15 + DConfiguration.Settings.GuiScale.MacroButton1, 0.1 + DConfiguration.Settings.GuiScale.MacroButton1)
    end,
})

Tabs.Movement:AddInput("MacroButton2Size", {
    Title       = "Macro Button 2 Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.MacroButton2),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.MacroButton2 = num * 0.01
        else
            DConfiguration.Settings.GuiScale.MacroButton2 = 0
        end
        DFunctions.UpdateButton("MacroButton2", 0.15 + DConfiguration.Settings.GuiScale.MacroButton2, 0.1 + DConfiguration.Settings.GuiScale.MacroButton2)
    end,
})

local Dropdown = Tabs.Movement:AddDropdown("SelectionEmoteSlot", {
    Title   = "Select Emote Slots",
    Values  = { "1", "2", "3", "4", "5", "6" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Misc.GameAutomation.Macro.SelectedPrimary = Value
end)

-- Emote Slot floating button
local _emoteSlot = 1

Tabs.Movement:AddSpace()

Tabs.Movement:AddInput("EmoteCustomNumber", {
    Title       = "Emote (fill in yourself)",
    Default     = "1",
    Placeholder = "Number value",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        local n = math.floor(math.max(1, tonumber(Value) or 1))
        _emoteSlot = n
        local gui = LocalPlayer.PlayerGui:FindFirstChild("EmoteSlotBtn")
        if gui then
            local frame = gui:FindFirstChild("EmoteSlotBtn")
            if frame then
                local btn = frame:FindFirstChildOfClass("TextButton")
                if btn then pcall(function() btn.Text = "Emote: " .. tostring(n) end) end
            end
        end
    end,
})

local Toggle = Tabs.Movement:AddToggle("EmoteSlotCycleBtn", { Title = "Emote Slot (Button)", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("EmoteSlotBtn", "Emote: " .. tostring(_emoteSlot), 0.15 + DConfiguration.Settings.GuiScale.EmoteSlot, 0.1 + DConfiguration.Settings.GuiScale.EmoteSlot, function(btn)
            pcall(function()
                ReplicatedStorage.Events.Emote:FireServer(tostring(_emoteSlot))
            end)
        end, nil, "Game Automations")
    else
        DFunctions.DestroyButton("EmoteSlotBtn")
    end
end)

Tabs.Movement:AddInput("EmoteSlotButtonSize", {
    Title       = "Emote Slot Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.EmoteSlot),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.EmoteSlot = num * 0.01
        else
            DConfiguration.Settings.GuiScale.EmoteSlot = 0
        end
        DFunctions.UpdateButton("EmoteSlotBtn", 0.15 + DConfiguration.Settings.GuiScale.EmoteSlot, 0.1 + DConfiguration.Settings.GuiScale.EmoteSlot)
    end,
})

Tabs.Movement:AddInput("EmoteSlotButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("EmoteSlotBtn", Value) end,
})

Tabs.Movement:AddKeybind("EmoteSlotKeybind", {
    Title    = "Emote Slot Keybind",
    Mode     = "Toggle",
    Default  = "E",
    Callback = function(Value)
        if Value then
            pcall(function()
                ReplicatedStorage.Events.Emote:FireServer(tostring(_emoteSlot))
            end)
        end
    end,
})

Tabs.Movement:AddSection("Auto Crouch")

do
    local _acEnabled  = false
    local _acDelay    = 0.3
    local _acThread   = nil

    local function startAutoCrouch()
        if _acThread then task.cancel(_acThread) end
        _acThread = task.spawn(function()
            while _acEnabled do
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Communicator") then
                        char.Communicator:InvokeServer("Crouching", true)
                        task.wait(_acDelay)
                        char.Communicator:InvokeServer("Crouching", false)
                    end
                end)
                task.wait(_acDelay)
            end
        end)
    end

    local ACToggle = Tabs.Movement:AddToggle("AutoCrouchButton", { Title = "Auto Crouch (Button)", Default = false })
    ACToggle:OnChanged(function(State)
        if State then
            DFunctions.CreateButton("AutoCrouchBtn",
                "Auto Crouch: OFF",
                0.15 + DConfiguration.Settings.GuiScale.AutoCrouch,
                0.1  + DConfiguration.Settings.GuiScale.AutoCrouch,
                function(btn)
                    _acEnabled = not _acEnabled
                    btn.Text   = _acEnabled and "Auto Crouch: ON" or "Auto Crouch: OFF"
                    if _acEnabled then
                        startAutoCrouch()
                    else
                        if _acThread then task.cancel(_acThread) end
                    end
                end,
                nil, "Auto Crouch")
        else
            _acEnabled = false
            if _acThread then task.cancel(_acThread) end
            DFunctions.DestroyButton("AutoCrouchBtn")
        end
    end)

    Tabs.Movement:AddInput("AutoCrouchDelay", {
        Title       = "Crouch Interval (seconds)",
        Default     = "0.3",
        Placeholder = "0.3",
        Numeric     = false,
        Finished    = false,
        Callback    = function(Value)
            _acDelay = tonumber(Value) or 0.3
        end,
    })

    Tabs.Movement:AddInput("AutoCrouchGuiSize", {
        Title       = "Auto Crouch Gui Size",
        Default     = tostring(DConfiguration.Settings.GuiScale.AutoCrouch),
        Placeholder = "0",
        Numeric     = true,
        Finished    = false,
        Callback    = function(Value)
            local num = tonumber(Value)
            DConfiguration.Settings.GuiScale.AutoCrouch = num and num * 0.01 or 0
            DFunctions.UpdateButton("AutoCrouchBtn",
                0.15 + DConfiguration.Settings.GuiScale.AutoCrouch,
                0.1  + DConfiguration.Settings.GuiScale.AutoCrouch)
        end,
    })

    Tabs.Movement:AddInput("AutoCrouchButtonTrans", {
        Title       = "Button Transparency (0–100)",
        Default     = "50",
        Placeholder = "0 = fully visible → 100 = fully invisible",
        Numeric     = false,
        Finished    = false,
        Callback    = function(Value) _applyBtnTrans("AutoCrouchBtn", Value) end,
    })

    Tabs.Movement:AddKeybind("AutoCrouchKeybind", {
        Title    = "Auto Crouch Keybind",
        Mode     = "Toggle",
        Default  = "V",
        Callback = function(Value)
            _acEnabled = Value
            if Value then
                startAutoCrouch()
            else
                if _acThread then task.cancel(_acThread) end
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Communicator") then
                        char.Communicator:InvokeServer("Crouching", false)
                    end
                end)
            end
        end,
    })
end

Tabs.Movement:AddSection("Movement Modification")

local Toggle = Tabs.Movement:AddToggle("SprintEmoteDash", { Title = "Aggressive Emote Dash", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Enabled = State

    if not DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Enabled then
        DConfiguration.Misc.PlayerAdjustment.Debounce.GroundAcceleration = false
        DConfiguration.Misc.PlayerAdjustment.Update.Speed = DConfiguration.Misc.PlayerAdjustment.Saved.Speed
    end
end)

local Dropdown = Tabs.Movement:AddDropdown("SprintEmoteType", {
    Title   = "Aggressive Emote Type",
    Values  = { "Legit", "Blatant" },
    Multi   = false,
    Default = 2,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Type = Value
end)

Tabs.Movement:AddInput("EmoteSpeed", {
    Title       = "Aggressive Emote Speed",
    Default     = "2000",
    Placeholder = "Emote Speed Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Speed = tonumber(Value) or 2000
    end,
})

Tabs.Movement:AddInput("CrouchSpeed", {
    Title       = "Aggressive Emote Acceleration (Negative Only)",
    Default     = "-2",
    Placeholder = "Acceleration Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Acceleration = tonumber(Value) or 0.2
    end,
})

Tabs.Movement:AddSpace()

local Toggle = Tabs.Movement:AddToggle("ModifyEmote", {
    Title   = "Modify Emote Movement",
    Default = false,
})

local connection

Toggle:OnChanged(function(State)
    DConfiguration.Misc.MovementModification.EmoteModification.ModifyEmote.Enabled = State

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if not State then return end

    connection = RunService.RenderStepped:Connect(function(dt)
        if not DConfiguration.Misc.MovementModification.EmoteModification.ModifyEmote.Enabled then
            connection:Disconnect()
            connection = nil
            return
        end

        local char = LocalPlayer.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        local moveDir = hum.MoveDirection
        if moveDir.Magnitude <= 0 then return end

        local emoting = char:GetAttribute("Emoting")
        local downed  = char:GetAttribute("Downed")
        if not (emoting or downed) then return end

        local targetCF = CFrame.lookAt(hrp.Position, hrp.Position + moveDir)
        local turnSpeed = DConfiguration.Misc.MovementModification.EmoteModification.ModifyEmote.TurnSpeed
        local alpha = math.clamp(turnSpeed * dt * 16, 0, 1)
        hrp.CFrame = hrp.CFrame:Lerp(targetCF, alpha)
    end)
end)

Tabs.Movement:AddInput("EmoteRotation", {
    Title       = "Emote Rotation Speed",
    Default     = "0.5",
    Placeholder = "Rotation Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.EmoteModification.ModifyEmote.TurnSpeed = tonumber(Value) or 0.5
    end,
})

Tabs.Movement:AddSpace()

local NormalGravity = game.Workspace.Gravity

local Toggle = Tabs.Movement:AddToggle("GravityToggle", { Title = "Gravity Button", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("GravityGui", "Gravity: OFF", 0.15 + DConfiguration.Settings.GuiScale.Gravity, 0.1 + DConfiguration.Settings.GuiScale.Gravity, function(btn)
            DConfiguration.Misc.MovementModification.Gravity.FloatingButton = not DConfiguration.Misc.MovementModification.Gravity.FloatingButton
            btn.Text = DConfiguration.Misc.MovementModification.Gravity.FloatingButton and "Gravity: ON" or "Gravity: OFF"
        end, nil, "Movement Modification")
    else
        DFunctions.DestroyButton("GravityGui")
    end
end)

Tabs.Movement:AddInput("GravityButtonSize", {
    Title       = "Gravity Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.Gravity),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.Gravity = num * 0.01
        else
            DConfiguration.Settings.GuiScale.Gravity = 0
        end
        DFunctions.UpdateButton("GravityGui", 0.15 + DConfiguration.Settings.GuiScale.Gravity, 0.1 + DConfiguration.Settings.GuiScale.Gravity)
    end,
})

Tabs.Movement:AddInput("GravityButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("GravityGui", Value) end,
})

Tabs.Movement:AddInput("GravityAdjust", {
    Title       = "Gravity Adjustment",
    Default     = "10",
    Placeholder = " Number",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.Gravity.Value = tonumber(Value) or 10
    end,
})

Tabs.Movement:AddKeybind("GravityKeybind", {
    Title    = "Gravity Keybind",
    Mode     = "Toggle",
    Default  = "H",
    Callback = function(Value)
        DConfiguration.Misc.MovementModification.Gravity.Keybind        = Value
        DConfiguration.Misc.MovementModification.Gravity.FloatingButton = Value
    end,
})

Tabs.Movement:AddSpace()

local Toggle = Tabs.Movement:AddToggle("BHOPToggle", { Title = "BHOP (Button)", Default = false })

Toggle:OnChanged(function(State)
    if State then
        DFunctions.CreateButton("BHOPGui", "Auto Jump: OFF", 0.15 + DConfiguration.Settings.GuiScale.AutoJump, 0.1 + DConfiguration.Settings.GuiScale.AutoJump, function(btn)
            DConfiguration.Misc.MovementModification.BHOP.FloatingButton = not DConfiguration.Misc.MovementModification.BHOP.FloatingButton
            btn.Text = DConfiguration.Misc.MovementModification.BHOP.FloatingButton and "Auto Jump: ON" or "Auto Jump: OFF"

            DConfiguration.Misc.MovementModification.BHOP.Enabled = DConfiguration.Misc.MovementModification.BHOP.FloatingButton

            if not DConfiguration.Misc.MovementModification.BHOP.FloatingButton then
                spawn(DFunctions.ResetBHOP)
                task.delay(0.1, DFunctions.ResetBHOP)
            end
        end, nil, "Auto Jump")
    else
        DFunctions.DestroyButton("BHOPGui")
    end
end)

local Toggle = Tabs.Movement:AddToggle("BHOPJumpButton", { Title = "BHOP (Jump Button)", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.MovementModification.BHOP.JumpButton = State
end)

-- BHOP Jump Button — works on all platforms (mobile touch + PC)
task.spawn(function()
    local TouchGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui", 5)
    if not TouchGui then return end
    local Frame = TouchGui:WaitForChild("TouchControlFrame", 5)
    if not Frame then return end
    local JumpButton = Frame:FindFirstChild("JumpButton")
    if not JumpButton then return end

    local isJumping = false

    JumpButton.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.Touch
        or  input.UserInputType == Enum.UserInputType.MouseButton1)
        and DConfiguration.Misc.MovementModification.BHOP.JumpButton then
            if not isJumping then
                isJumping = true
                DConfiguration.Misc.MovementModification.BHOP.Enabled = true
            end
        end
    end)

    JumpButton.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.Touch
        or  input.UserInputType == Enum.UserInputType.MouseButton1)
        and DConfiguration.Misc.MovementModification.BHOP.JumpButton
        and not DConfiguration.Misc.MovementModification.BHOP.FloatingButton then
            if isJumping then
                isJumping = false
                DConfiguration.Misc.MovementModification.BHOP.Enabled = false
                spawn(DFunctions.ResetBHOP)
            end
        end
    end)
end)

Tabs.Movement:AddInput("BHOPButtonSize", {
    Title       = "BHOP Gui Size",
    Default     = tostring(DConfiguration.Settings.GuiScale.AutoJump),
    Placeholder = "0",
    Numeric     = true,
    Finished    = false,
    Callback    = function(Value)
        local num = tonumber(Value)
        if num then
            DConfiguration.Settings.GuiScale.AutoJump = num * 0.01
        else
            DConfiguration.Settings.GuiScale.AutoJump = 0
        end
        DFunctions.UpdateButton("BHOPGui", 0.15 + DConfiguration.Settings.GuiScale.AutoJump, 0.1 + DConfiguration.Settings.GuiScale.AutoJump)
    end,
})

Tabs.Movement:AddInput("BHOPButtonTrans", {
    Title       = "Button Transparency (0–100)",
    Default     = "50",
    Placeholder = "0 = fully visible → 100 = fully invisible",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value) _applyBtnTrans("BHOPGui", Value) end,
})

local Dropdown = Tabs.Movement:AddDropdown("BHOPVersion", {
    Title   = "Select BHOP Version",
    Values  = { "Acceleration", "Ground Acceleration", "No Acceleration" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Misc.MovementModification.BHOP.Type = Value
end)

local Dropdown = Tabs.Movement:AddDropdown("JumpType", {
    Title   = "Select Jump Type",
    Values  = { "Simulated", "Realistic", "Nil" },
    Multi   = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    DConfiguration.Misc.MovementModification.BHOP.JumpType = Value
end)

Tabs.Movement:AddInput("BHOPAcceleration", {
    Title       = "BHOP Acceleration (Negative Only)",
    Default     = "-0.1",
    Placeholder = "-1",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.BHOP.Acceleration = tonumber(Value) or -0.1
    end,
})

Tabs.Movement:AddSpace()

local Toggle = Tabs.Movement:AddToggle("BHOPAutoAccelerate", { Title = "Auto Acceleration (Legit)", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.MovementModification.BHOP.AutoAcceleration = State
end)

Tabs.Movement:AddInput("BHOPMaxSpeed", {
    Title       = "Max Speed Acceleration",
    Default     = "70",
    Placeholder = "70",
    Numeric     = false,
    Finished    = false,
    Callback    = function(Value)
        DConfiguration.Misc.MovementModification.BHOP.MaxSpeed = tonumber(Value) or 70
    end,
})

Tabs.Movement:AddKeybind("BHOPKeybind", {
    Title    = "BHOP Keybind",
    Mode     = "Toggle",
    Default  = "J",
    Callback = function(Value)
        DConfiguration.Misc.MovementModification.BHOP.Keybind = Value
        DConfiguration.Misc.MovementModification.BHOP.Enabled = Value
        if not Value then spawn(DFunctions.ResetBHOP) end
    end,
})

RunService.Heartbeat:Connect(function()
    local bhopShouldRun = DConfiguration.Misc.MovementModification.BHOP.Enabled
        or DConfiguration.Misc.MovementModification.BHOP.Keybind
        or (_bhopHoldActive and DConfiguration.Misc.MovementModification.BHOP.JumpButton)

    if bhopShouldRun then
        task.spawn(DFunctions.BHOPFunction)
    end

    if DConfiguration.Misc.MovementModification.Gravity.FloatingButton or DConfiguration.Misc.MovementModification.Gravity.Keybind then
        game.Workspace.Gravity = DConfiguration.Misc.MovementModification.Gravity.Value
    else
        game.Workspace.Gravity = NormalGravity
    end

    if DConfiguration.Misc.MovementModification.EmoteModification.AggressiveEmoteDash.Enabled then
        spawn(DFunctions.SprintEmoteDash)
    end
end)

-- Edge Trimp

do
    local _ET = {
        Enabled          = false,
        Mode             = "Legit",
        BounceMultiplier = 4,
        FallThreshold    = 30,
        LegitScale       = 0.6,
        LastMaterial     = Enum.Material.Air,
        LastPos          = Vector3.new(),
    }

    LocalPlayer.CharacterAdded:Connect(function(c)
        local hrp = c:WaitForChild("HumanoidRootPart")
        _ET.LastPos      = hrp.Position
        _ET.LastMaterial = Enum.Material.Air
    end)

    RunService.Heartbeat:Connect(function(dt)
        if not _ET.Enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        local curMat  = hum.FloorMaterial
        local edgeHit = (curMat ~= _ET.LastMaterial)
                         and (curMat == Enum.Material.Air)
                         and (_ET.LastMaterial ~= Enum.Material.Air)
        _ET.LastMaterial = curMat

        if edgeHit then
            local vel    = dt > 0 and (hrp.Position - _ET.LastPos) / dt or Vector3.new()
            local fallV  = vel.Y
            if fallV < -_ET.FallThreshold then
                local bounce = math.abs(fallV)
                if _ET.Mode == "Legit" then
                    bounce = bounce * _ET.LegitScale
                elseif _ET.Mode == "Simulated" then
                    bounce = bounce * _ET.BounceMultiplier
                end
                hrp.Velocity = Vector3.new(hrp.Velocity.X, bounce, hrp.Velocity.Z)
            end
        end
        _ET.LastPos = hrp.Position
    end)

    Tabs.Movement:AddSection("Edge Trimp")

    Tabs.Movement:AddToggle("EdgeTrimpToggle", { Title = "Edge Trimp", Default = false })
        :OnChanged(function(State) _ET.Enabled = State end)

    Tabs.Movement:AddToggle("EdgeTrimpFloat", { Title = "Edge Trimp — Floating Button", Default = false })
        :OnChanged(function(State)
            if State then
                DFunctions.CreateButton("EdgeTrimpBtn", "Edge Trimp: OFF", 0.15, 0.1, function(btn)
                    _ET.Enabled = not _ET.Enabled
                    btn.Text = _ET.Enabled and "Edge Trimp: ON" or "Edge Trimp: OFF"
                end, nil, "Edge Trimp")
            else
                DFunctions.DestroyButton("EdgeTrimpBtn")
            end
        end)

    Tabs.Movement:AddDropdown("EdgeTrimpMode", {
        Title = "Edge Trimp Mode", Values = {"Legit","Simulated"}, Multi = false, Default = 1,
    }):OnChanged(function(Value) _ET.Mode = Value end)

    Tabs.Movement:AddInput("EdgeBounce",     { Title = "Simulated Multiplier", Default = "4",   Placeholder = "4",   Numeric = false, Finished = false, Callback = function(v) _ET.BounceMultiplier = tonumber(v) or 4   end })
    Tabs.Movement:AddInput("EdgeLegitScale", { Title = "Legit Scale (0–1)",    Default = "0.6", Placeholder = "0.6", Numeric = false, Finished = false, Callback = function(v) _ET.LegitScale       = tonumber(v) or 0.6 end })
    Tabs.Movement:AddInput("EdgeThreshold",  { Title = "Fall Threshold",       Default = "30",  Placeholder = "30",  Numeric = false, Finished = false, Callback = function(v) _ET.FallThreshold    = tonumber(v) or 30  end })

    Tabs.Movement:AddKeybind("EdgeTrimpKeybind", {
        Title = "Edge Trimp Keybind", Mode = "Toggle", Default = "E",
        Callback = function(Value) _ET.Enabled = Value end,
    })
end

Tabs.Movement:AddSection("Anti Lag")

local Toggle = Tabs.Movement:AddToggle("Anti_Lag1", { Title = "Low Anti Lag", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.AntiLags.Low = State

    if State then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius   = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
    end
end)

Options.Anti_Lag1:SetValue(false)

local Toggle = Tabs.Movement:AddToggle("Anti_Lag2", { Title = "Moderate Anti Lag", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.AntiLags.Moderate = State

    if State then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material    = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius   = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        for i = 1, #Lighting:GetChildren() do
            local e = Lighting:GetChildren()[i]
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end
end)

Options.Anti_Lag2:SetValue(false)

local decalsyeeted = false

local Toggle = Tabs.Movement:AddToggle("Anti_Lag3", { Title = "High Anti Lag", Default = false })

Toggle:OnChanged(function(State)
    DConfiguration.Misc.AntiLags.High = State
    decalsyeeted = State

    if State then
        local w = workspace
        local l = Lighting
        for _, v in pairs(w:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material    = "Plastic"
                v.Reflectance = 0
            elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius   = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") and decalsyeeted then
                v.Material    = "Plastic"
                v.Reflectance = 0
                v.TextureID   = 10385902758728957
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId = 0
            elseif v:IsA("ShirtGraphic") and decalsyeeted then
                v.Graphic = 0
            elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                v[v.ClassName .. "Template"] = 0
            end
        end
        for i = 1, #l:GetChildren() do
            local e = l:GetChildren()[i]
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
        w.DescendantAdded:Connect(function(v)
            wait(1)
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material    = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius   = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") and decalsyeeted then
                v.Material    = "Plastic"
                v.Reflectance = 0
                v.TextureID   = 10385902758728957
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId = 0
            elseif v:IsA("ShirtGraphic") and decalsyeeted then
                v.ShirtGraphic = 0
            elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
                v[v.ClassName .. "Template"] = 0
            end
        end)
    end
end)

Options.Anti_Lag3:SetValue(false)


local ItemsFolder = ReplicatedStorage.Items

local Folder = Instance.new("Folder", ItemsFolder)
Folder.Name = "D-Folder"

local ChangeEmote1     = "BoldMarch"
local ChangeEmote2     = "RockinStride"
local ChangeCosmetics1 = "HeartSkaters"
local ChangeCosmetics2 = "ToxicInferno"

local function Normalize(input)
    return input:lower():gsub("%s+", "")
end

local function FindRealName(folder, userInput)
    local normalizedInput = Normalize(userInput)
    for _, item in ipairs(folder:GetChildren()) do
        if Normalize(item.Name) == normalizedInput then
            return item.Name
        end
    end
    return nil
end

local function ChangeCosmetics(Name1, Name2)
    local Cosmetics = ReplicatedStorage.Items.Cosmetics
    local RealName1 = FindRealName(Cosmetics, Name1)
    local RealName2 = FindRealName(Cosmetics, Name2)

    if RealName1 and RealName2 then
        local I = Cosmetics:FindFirstChild(RealName1)
        local V = Cosmetics:FindFirstChild(RealName2)
        if I and V then
            I.Name = RealName2
            task.wait()
            V.Name = RealName1
        end
    end
end

local function ChangeEmotes(Name1, Name2)
    local Emotes = ReplicatedStorage.Items.Emotes
    local RealName1 = FindRealName(Emotes, Name1)
    local RealName2 = FindRealName(Emotes, Name2)

    if RealName1 and RealName2 then
        local I = Emotes:FindFirstChild(RealName1)
        local V = Emotes:FindFirstChild(RealName2)
        if I and V then
            I.Name = RealName2
            task.wait()
            V.Name = RealName1
        end
    end
end

Tabs.Visual:AddSection("Skin/Cosmetics Changer")

-- Unusual slot
local UnusualCurrent = ""
local UnusualTarget  = ""
Tabs.Visual:AddInput("UnusualCurrent", {
    Title = "Unusual — Current", Placeholder = "e.g. HeartSkaters",
    Numeric = false, Finished = false,
    Callback = function(Value) UnusualCurrent = Value end,
})
Tabs.Visual:AddInput("UnusualTarget", {
    Title = "Unusual — Target", Placeholder = "e.g. ToxicInferno",
    Numeric = false, Finished = false,
    Callback = function(Value) UnusualTarget = Value end,
})
Tabs.Visual:AddButton({
    Title = "Swap Unusual", Description = "",
    Callback = function()
        spawn(function() ChangeCosmetics(UnusualCurrent, UnusualTarget) end)
    end,
})

-- Cosmetic slot 2
local CosmeticCurrent2 = ""
local CosmeticTarget2  = ""
Tabs.Visual:AddInput("CosmeticCurrent2", {
    Title = "Cosmetic 2 — Current", Placeholder = "Cosmetic name",
    Numeric = false, Finished = false,
    Callback = function(Value) CosmeticCurrent2 = Value end,
})
Tabs.Visual:AddInput("CosmeticTarget2", {
    Title = "Cosmetic 2 — Target", Placeholder = "Cosmetic name",
    Numeric = false, Finished = false,
    Callback = function(Value) CosmeticTarget2 = Value end,
})
Tabs.Visual:AddButton({
    Title = "Swap Cosmetic 2", Description = "",
    Callback = function()
        spawn(function() ChangeCosmetics(CosmeticCurrent2, CosmeticTarget2) end)
    end,
})

-- Cosmetic slot 3
local CosmeticCurrent3 = ""
local CosmeticTarget3  = ""
Tabs.Visual:AddInput("CosmeticCurrent3", {
    Title = "Cosmetic 3 — Current", Placeholder = "Cosmetic name",
    Numeric = false, Finished = false,
    Callback = function(Value) CosmeticCurrent3 = Value end,
})
Tabs.Visual:AddInput("CosmeticTarget3", {
    Title = "Cosmetic 3 — Target", Placeholder = "Cosmetic name",
    Numeric = false, Finished = false,
    Callback = function(Value) CosmeticTarget3 = Value end,
})
Tabs.Visual:AddButton({
    Title = "Swap Cosmetic 3", Description = "",
    Callback = function()
        spawn(function() ChangeCosmetics(CosmeticCurrent3, CosmeticTarget3) end)
    end,
})

Tabs.Visual:AddSection("Emote Changer")

do
    local EmoteSlots = {}
    for i = 1, 6 do
        EmoteSlots[i] = { current = "", target = "" }
    end

    for i = 1, 6 do
        local slot = EmoteSlots[i]
        local idx  = tostring(i)
        Tabs.Visual:AddInput("EmoteCurrent" .. idx, {
            Title       = "Slot " .. idx .. " — Current Emote",
            Placeholder = "Emote name",
            Numeric     = false,
            Finished    = false,
            Callback    = function(Value) slot.current = Value end,
        })
        Tabs.Visual:AddInput("EmoteTarget" .. idx, {
            Title       = "Slot " .. idx .. " — Target Emote",
            Placeholder = "Emote name",
            Numeric     = false,
            Finished    = false,
            Callback    = function(Value) slot.target = Value end,
        })
        Tabs.Visual:AddButton({
            Title       = "Swap Emote Slot " .. idx,
            Description = "",
            Callback    = function()
                spawn(function() ChangeEmotes(slot.current, slot.target) end)
            end,
        })
    end
end

-- Crosshair (ported from PhantomWyrm)

Tabs.Visual:AddSection("Crosshair")

do
    local CrosshairConfig = {
        Enabled        = false,
        SpinEnabled    = false,
        UseCustomAsset = false,
        UseCustomSize  = false,
        RotationSpeed  = 5,
        Size           = 30,
        DefaultSize    = 30,
        AssetId        = "11722368307",
        DefaultAsset   = "11722368307",
    }

    local function updateCrosshairProperties()
        local pgui = LocalPlayer:FindFirstChild("PlayerGui")
        local sg   = pgui and pgui:FindFirstChild("SolasmotaryCrosshair")
        if not sg then return end
        local img = sg:FindFirstChild("CrosshairImage")
        if not img then return end
        local targetSize  = CrosshairConfig.UseCustomSize  and CrosshairConfig.Size    or CrosshairConfig.DefaultSize
        local targetAsset = CrosshairConfig.UseCustomAsset and CrosshairConfig.AssetId or CrosshairConfig.DefaultAsset
        img.Size  = UDim2.new(0, targetSize, 0, targetSize)
        img.Image = "rbxassetid://" .. tostring(targetAsset):gsub("%D", "")
        if not CrosshairConfig.SpinEnabled then img.Rotation = 0 end
    end

    local function startCrosshair()
        local pgui = LocalPlayer:WaitForChild("PlayerGui")
        if pgui:FindFirstChild("SolasmotaryCrosshair") then return end

        local sg = Instance.new("ScreenGui")
        sg.Name            = "SolasmotaryCrosshair"
        sg.IgnoreGuiInset  = true
        sg.ResetOnSpawn    = false
        sg.Parent          = pgui

        local img = Instance.new("ImageLabel", sg)
        img.Name                   = "CrosshairImage"
        img.Position               = UDim2.new(0.5, 0, 0.5, 0)
        img.AnchorPoint            = Vector2.new(0.5, 0.5)
        img.BackgroundTransparency = 1

        updateCrosshairProperties()

        task.spawn(function()
            while img and img.Parent and CrosshairConfig.Enabled do
                if CrosshairConfig.SpinEnabled then
                    img.Rotation = img.Rotation + CrosshairConfig.RotationSpeed
                else
                    img.Rotation = 0
                end
                task.wait()
            end
            if sg.Parent then sg:Destroy() end
        end)
    end

    Tabs.Visual:AddParagraph({
        Title   = "Crosshair Settings",
        Content = "Display a custom image crosshair at screen center",
    })

    Tabs.Visual:AddToggle("CrosshairToggle", {
        Title   = "Show Crosshair",
        Default = false,
        Callback = function(Value)
            CrosshairConfig.Enabled = Value
            if Value then
                startCrosshair()
            else
                local pgui = LocalPlayer:FindFirstChild("PlayerGui")
                local sg   = pgui and pgui:FindFirstChild("SolasmotaryCrosshair")
                if sg then sg:Destroy() end
            end
        end,
    })

    Tabs.Visual:AddToggle("CrosshairUseCustomID", {
        Title   = "Use Custom Asset ID",
        Default = false,
        Callback = function(Value)
            CrosshairConfig.UseCustomAsset = Value
            updateCrosshairProperties()
        end,
    })

    Tabs.Visual:AddInput("CrosshairAssetInput", {
        Title    = "Custom Asset ID",
        Default  = CrosshairConfig.AssetId,
        Numeric  = true,
        Finished = true,
        Callback = function(Value)
            CrosshairConfig.AssetId = Value
            if CrosshairConfig.UseCustomAsset then updateCrosshairProperties() end
        end,
    })

    Tabs.Visual:AddToggle("CrosshairSpinToggle", {
        Title   = "Enable Spin",
        Default = false,
        Callback = function(Value)
            CrosshairConfig.SpinEnabled = Value
            updateCrosshairProperties()
        end,
    })

    Tabs.Visual:AddSlider("CrosshairSpinSpeed", {
        Title    = "Spin Speed",
        Default  = 5,
        Min      = 1,
        Max      = 100,
        Rounding = 1,
        Callback = function(Value)
            CrosshairConfig.RotationSpeed = Value
        end,
    })

    Tabs.Visual:AddToggle("CrosshairCustomSize", {
        Title   = "Enable Custom Size",
        Default = false,
        Callback = function(Value)
            CrosshairConfig.UseCustomSize = Value
            updateCrosshairProperties()
        end,
    })

    Tabs.Visual:AddSlider("CrosshairSizeSlider", {
        Title    = "Crosshair Size",
        Default  = 30,
        Min      = 10,
        Max      = 300,
        Rounding = 0,
        Callback = function(Value)
            CrosshairConfig.Size = Value
            if CrosshairConfig.UseCustomSize then updateCrosshairProperties() end
        end,
    })

    -- Auto-restart crosshair if it disappears while enabled
    task.spawn(function()
        while true do
            if CrosshairConfig.Enabled then
                local pgui = LocalPlayer:FindFirstChild("PlayerGui")
                if pgui and not pgui:FindFirstChild("SolasmotaryCrosshair") then
                    startCrosshair()
                end
            end
            task.wait(1)
        end
    end)
end

do
    Tabs.Visual:AddSection("Nextbot Decal Changer")

    local NDC_selectedBots = {}
    local NDC_decalId      = ""

    -- Build nextbot list dynamically from NPCStorage ("All" prepended)
    local function NDC_getList()
        local list = {"All"}
        local npcStorage = ReplicatedStorage:FindFirstChild("NPCStorage")
        if npcStorage then
            for _, npc in ipairs(npcStorage:GetChildren()) do
                table.insert(list, npc.Name)
            end
        end
        return list
    end

    local NDC_Dropdown = Tabs.Visual:AddDropdown("NextbotDecalDropdown", {
        Title   = "Select Nextbot(s)",
        Values  = NDC_getList(),
        Multi   = true,
        Default = {},
        Search  = true,
    })
    NDC_Dropdown:OnChanged(function(Value)
        NDC_selectedBots = Value
    end)

    Tabs.Visual:AddInput("NextbotDecalId", {
        Title       = "Texture Decal ID",
        Default     = "124866450201164",
        Placeholder = "124866450201164",
        Numeric     = false,
        Finished    = false,
        Callback    = function(Value)
            NDC_decalId = tostring(Value):match("%d+") or ""
        end,
    })

    Tabs.Visual:AddButton({
        Title       = "Apply Decal",
        Description = "Apply texture to selected nextbot(s)",
        Callback    = function()
            if NDC_decalId == "" then
                Fluent:Notify({ Title = "Nextbot Decal", Content = "Enter a Decal ID first", Duration = 3 })
                return
            end
            local npcStorage = ReplicatedStorage:FindFirstChild("NPCStorage")
            if not npcStorage then
                Fluent:Notify({ Title = "Nextbot Decal", Content = "NPCStorage not found", Duration = 3 })
                return
            end
            local assetUrl  = "rbxassetid://" .. NDC_decalId
            local applyAll  = NDC_selectedBots["All"] == true
            local applied   = 0
            for _, npc in ipairs(npcStorage:GetChildren()) do
                if applyAll or NDC_selectedBots[npc.Name] == true then
                    pcall(function()
                        npc.Variants.Default.HumanoidRootPart
                           .HeadPos.BillboardGui.ImageLabel.Image = assetUrl
                        applied = applied + 1
                    end)
                end
            end
            Fluent:Notify({
                Title    = "Nextbot Decal",
                Content  = "Applied to " .. applied .. " nextbot(s)",
                Duration = 3,
            })
        end,
    })
end



Tabs.Settings:AddButton({
    Title       = "Remove FPS Counter",
    Description = "",
    Callback    = function()
        fpsCounter:Destroy()
    end,
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
FBM:SetLibrary(Fluent)

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("SolasmotaryXUniversal")
FBM:SetFolder("SolasmotaryXUniversal/Legacy-Evade/FloatingButtons")
SaveManager:SetFolder("SolasmotaryXUniversal/Legacy-Evade")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
FBM:BuildConfigSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()


local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Args   = {...}
    local method = getnamecallmethod()

    if self.Parent == LocalPlayer.Character and self.Name == "Communicator"
    and method == "InvokeServer" and Args[1] == "update" then
        return DConfiguration.Misc.PlayerAdjustment.Update.Speed, DConfiguration.Misc.PlayerAdjustment.Update.JumpHeight
    end

    return old(self, ...)
end))

LocalPlayer.CharacterAdded:Connect(function(character)
    task.delay(5, function()
        DFunctions.HookMovement(character)
    end)
end)

if LocalPlayer.Character then
    DFunctions.HookMovement(LocalPlayer.Character)
end
