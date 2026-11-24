
--================================
--       LUMB3R HUB v1.3
--       BLACK + PURPLE
--================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- KEY SYSTEM
local VALID_KEYS = {
    ["SRAEME"] = true,
    ["BaoChau"] = true,
    ["BC"] = true,
    ["byeb"] = true,
    ["br"] = true
}

-- 20 GAMES
local GAMES = {
    "The Strongest Battlegrounds",
    "Blox Fruits",
    "Evade",
    "99 Nights in the Forest",
    "Muscle Legends",
    "Cameraman TD",
    "Steal a Brainrot",
    "Steal an Egg",
    "Throw Food for Animals",
    "Break Eggs for Animals",
    "Death Ball",
    "Solve the Rubik",
    "Murder Mystery 2",
    "Lift Rock for Eggs",
    "Dead Rails",
    "Animal Hospital",
    "The Evolution of Ego",
    "Jujutsu Shenanigans",
    "RIVALS",
    "Meme Sea"
}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LUMB3R_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(obj)
    create("UICorner", {
        CornerRadius = UDim.new(0, 10)
    }, obj)
end

-- DRAG FUNCTION
local function drag(frame, handle)
    local dragging = false
    local startPos
    local framePos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            framePos = frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- MAIN HUB
local main = create("Frame", {
    Size = UDim2.fromOffset(430, 370),
    Position = UDim2.new(0.5, -215, 0.5, -185),
    BackgroundColor3 = Color3.fromRGB(17, 17, 23),
    BorderSizePixel = 0,
    Visible = false
}, gui)

round(main)

create("UIStroke", {
    Color = Color3.fromRGB(145, 75, 220),
    Thickness = 2
}, main)

local header = create("TextLabel", {
    Size = UDim2.new(1, -45, 0, 45),
    BackgroundTransparency = 1,
    Text = "LUMB3R HUB",
    TextColor3 = Color3.fromRGB(195, 145, 255),
    TextSize = 23,
    Font = Enum.Font.GothamBold
}, main)

local close = create("TextButton", {
    Size = UDim2.fromOffset(35, 35),
    Position = UDim2.new(1, -40, 0, 5),
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    BackgroundColor3 = Color3.fromRGB(100, 40, 140),
    Font = Enum.Font.GothamBold
}, main)

round(close)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

drag(main, header)

-- SEARCH
local search = create("TextBox", {
    Size = UDim2.new(1, -20, 0, 35),
    Position = UDim2.fromOffset(10, 52),
    BackgroundColor3 = Color3.fromRGB(35, 30, 45),
    TextColor3 = Color3.new(1, 1, 1),
    PlaceholderText = "Search games...",
    Text = "",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    ClearTextOnFocus = false
}, main)

round(search)

-- GAME LIST
local list = create("ScrollingFrame", {
    Size = UDim2.new(1, -20, 1, -105),
    Position = UDim2.fromOffset(10, 95),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Color3.fromRGB(150, 80, 220),
    CanvasSize = UDim2.new(0, 0, 0, 0)
}, main)

local layout = create("UIListLayout", {
    Padding = UDim.new(0, 6)
}, list)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    list.CanvasSize = UDim2.new(
        0, 0, 0, layout.AbsoluteContentSize.Y + 5
    )
end)

-- REFRESH
local function refresh()
    for _, obj in ipairs(list:GetChildren()) do
        if obj:IsA("TextButton") then
            obj:Destroy()
        end
    end

    for i, name in ipairs(GAMES) do
        if string.find(
            name:lower(),
            search.Text:lower(),
            1,
            true
        ) then
            local button = create("TextButton", {
                Size = UDim2.new(1, -5, 0, 36),
                BackgroundColor3 = Color3.fromRGB(42, 32, 55),
                TextColor3 = Color3.fromRGB(240, 230, 255),
                Text = i .. ". " .. name,
                TextSize = 14,
                Font = Enum.Font.GothamMedium
            }, list)

            round(button)

            button.MouseButton1Click:Connect(function()
                print("Selected: " .. name)
            end)
        end
    end
end

search:GetPropertyChangedSignal("Text"):Connect(refresh)

-- KEY WINDOW
local keyFrame = create("Frame", {
    Size = UDim2.fromOffset(330, 205),
    Position = UDim2.new(0.5, -165, 0.5, -102),
    BackgroundColor3 = Color3.fromRGB(17, 17, 23),
    BorderSizePixel = 0
}, gui)

round(keyFrame)

create("UIStroke", {
    Color = Color3.fromRGB(145, 75, 220),
    Thickness = 2
}, keyFrame)

create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 45),
    BackgroundTransparency = 1,
    Text = "LUMB3R KEY SYSTEM",
    TextColor3 = Color3.fromRGB(195, 145, 255),
    TextSize = 20,
    Font = Enum.Font.GothamBold
}, keyFrame)

local keyBox = create("TextBox", {
    Size = UDim2.new(1, -30, 0, 40),
    Position = UDim2.fromOffset(15, 60),
    BackgroundColor3 = Color3.fromRGB(38, 32, 48),
    TextColor3 = Color3.new(1, 1, 1),
    PlaceholderText = "Enter your key...",
    Text = "",
    ClearTextOnFocus = false,
    Font = Enum.Font.Gotham
}, keyFrame)

round(keyBox)

local verify = create("TextButton", {
    Size = UDim2.new(1, -30, 0, 38),
    Position = UDim2.fromOffset(15, 110),
    BackgroundColor3 = Color3.fromRGB(110, 55, 175),
    Text = "VERIFY KEY",
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold,
    TextSize = 15
}, keyFrame)

round(verify)

local status = create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.fromOffset(10, 158),
    BackgroundTransparency = 1,
    Text = "Enter a valid key",
    TextColor3 = Color3.fromRGB(170, 170, 170),
    Font = Enum.Font.Gotham,
    TextSize = 12
}, keyFrame)

-- VERIFY
verify.MouseButton1Click:Connect(function()
    if VALID_KEYS[keyBox.Text] then
        status.Text = "KEY ACCEPTED!"
        status.TextColor3 = Color3.fromRGB(100, 255, 140)

        task.wait(0.4)

        keyFrame.Visible = false
        main.Visible = true
        refresh()
    else
        status.Text = "INVALID KEY!"
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

print("LUMB3R HUB v1.3 loaded!")
print("20 games | 5 keys")
