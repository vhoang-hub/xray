--[[ 
    ULTIMATE MINECRAFT X-RAY (TIKTOK STYLE)
    - Features: Full Invisible Stone, Glowing Ores, FullBright
    - Works on: Mobile & PC
]]

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local isXrayOn = false

-- Create UI Toggle Button
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "XrayGui"
ScreenGui.Parent = game:GetService("CoreGui")

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "X-RAY: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 18
ToggleButton.Draggable = true -- Move button anywhere

local function toggleXray()
    isXrayOn = not isXrayOn
    
    -- Update UI Appearance
    ToggleButton.Text = isXrayOn and "X-RAY: ON" or "X-RAY: OFF"
    ToggleButton.BackgroundColor3 = isXrayOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
    
    -- Lighting Settings (FullBright)
    Lighting.Brightness = isXrayOn and 4 or 1
    Lighting.GlobalShadows = not isXrayOn
    Lighting.Ambient = isXrayOn and Color3.new(1, 1, 1) or Color3.new(0.5, 0.5, 0.5)

    -- Scanning for blocks
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
            
            local name = obj.Name:lower()
            
            -- HIDE TRASH BLOCKS (Stone, Dirt, etc.)
            if name:find("stone") or name:find("dirt") or name:find("grass") or name:find("sand") or name:find("cobble") then
                -- Sets transparency to 1 (Invisible) to reveal ores behind them
                obj.LocalTransparencyModifier = isXrayOn and 1 or 0
            
            -- HIGHLIGHT ORE BLOCKS (Diamond, Gold, etc.)
            elseif name:find("ore") or name:find("diamond") or name:find("gold") or name:find("iron") or name:find("coal") or name:find("emerald") then
                if isXrayOn then
                    local highlight = obj:FindFirstChild("XrayHighlight") or Instance.new("Highlight")
                    highlight.Name = "XrayHighlight"
                    highlight.FillTransparency = 0.4 
                    highlight.OutlineTransparency = 0 
                    highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline like the video
                    
                    -- Color coding for different ores
                    if name:find("diamond") then
                        highlight.FillColor = Color3.fromRGB(0, 255, 255) -- Cyan
                    elseif name:find("gold") then
                        highlight.FillColor = Color3.fromRGB(255, 215, 0) -- Gold
                    elseif name:find("iron") then
                        highlight.FillColor = Color3.fromRGB(200, 200, 200) -- Grey
                    elseif name:find("emerald") then
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green
                    else
                        highlight.FillColor = Color
