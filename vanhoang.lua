--[[ 
    TIKTOK STYLE MINECRAFT X-RAY
    - Features: Total Stone Invisibility, White Outlines, FullBright
    - Targets: Diamonds, Gold, Iron, Emeralds, Coal
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
ToggleButton.Draggable = true 

local function toggleXray()
    isXrayOn = not isXrayOn
    
    -- Update UI
    ToggleButton.Text = isXrayOn and "X-RAY: ON" or "X-RAY: OFF"
    ToggleButton.BackgroundColor3 = isXrayOn and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(30, 30, 30)
    
    -- FullBright (Makes everything bright like the TikTok video)
    Lighting.Brightness = isXrayOn and 5 or 1
    Lighting.GlobalShadows = not isXrayOn
    Lighting.Ambient = isXrayOn and Color3.new(1, 1, 1) or Color3.new(0.5, 0.5, 0.5)

    -- Scanning all blocks
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
            
            local name = obj.Name:lower()
            -- Check if the block is an ORE
            local isOre = name:find("ore") or name:find("diamond") or name:find("gold") or name:find("iron") or name:find("emerald") or name:find("coal")
            
            if not isOre then
                -- MAKE EVERYTHING ELSE INVISIBLE (Stone, Dirt, Grass, etc.)
                obj.LocalTransparencyModifier = isXrayOn and 1 or 0
            else
                -- HIGHLIGHT ORES (Glowing effect with White Outline)
                if isXrayOn then
                    local hl = obj:FindFirstChild("TikTokXray") or Instance.new("Highlight")
                    hl.Name = "TikTokXray"
                    hl.FillTransparency = 0.2
                    hl.OutlineColor = Color3.new(1, 1, 1) -- Bright white outline
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = obj
                    
                    -- Color coding for each ore
                    if name:find("diamond") then hl.FillColor = Color3.new(0, 1, 1) -- Cyan
                    elseif name:find("gold") then hl.FillColor = Color3.new(1, 0.8, 0) -- Gold
                    elseif name:find("emerald") then hl.FillColor = Color3.new(0, 1, 0) -- Green
                    else hl.FillColor = Color3.new(1, 0, 0) end -- Other ores (Red)
                else
                    if obj:FindFirstChild("TikTokXray") then obj.TikTokXray:Destroy() end
                end
            end
        end
    end
end

ToggleButton.MouseButton1Click:Connect(toggleXray)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "X-Ray Minecraft",
    Text = "Script Loaded! Use the button to find Diamonds.",
    Duration = 5
})
