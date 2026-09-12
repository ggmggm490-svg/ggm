-- [[ เธชเธเธฃเธดเธเธ•เนเธเธฑเนเธเน€เธ—เธเธชเธนเธเธชเธธเธ”: GOD MODE FLY FARM (NO KICK / NO RESET / NO RUBBERBAND) ]] --

if game:GetService("CoreGui"):FindFirstChild("GodEggFlyGui") then
    game:GetService("CoreGui"):FindFirstChild("GodEggFlyGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local GodBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Name = "GodEggFlyGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 100)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Title.Text = "GOD MODE EGG FLY (INFINITE SPEED)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

_G.GodAutoFly = false
_G.GodBodyActive = false

-- [[ 1. เธฃเธฐเธเธเธฃเนเธฒเธเธเธฒเธขเนเธเนเธเนเธเธฃเนเธเธเธฑเนเธเน€เธ—เธ (เธฅเนเธญเธเธชเธ–เธฒเธเธฐ เธเนเธญเธเธเธฑเธเธเธฒเธฃเธฃเธตเน€เธเนเธ•เธ•เธฑเธงเธ•เธฒเธข เนเธฅเธฐเธเธฑเธเน€เธ”เนเธ) ]]
local function ApplyGodBody()
    pcall(function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            -- เธเธดเธ”เธเธฑเนเธเธเธฒเธฃเธชเธฑเนเธเธฃเธตเน€เธเนเธ•เธซเธฃเธทเธญเธเธ”เธ•เธฒเธขเธเธฒเธเธ เธฒเธขเธเธญเธ/เธฃเธฐเธเธเน€เธเธก
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                if humanoid.Health < 10 then humanoid.Health = 100 end
            end
            
            -- เธ—เธณเธฅเธฒเธขเนเธฅเธฐเธ”เธฑเธเธเธฑเธเนเธฃเธเธชเธฐเธ—เนเธญเธเธเธฅเธฑเธ (เธเธฑเธเน€เธ”เนเธเธเธฅเธฑเธ / Anti-Rubberband 100%)
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    -- เธฅเธเนเธฃเธเน€เธเธทเนเธญเธขเนเธฅเธฐเนเธฃเธเธเธฅเธฑเธเธเธฒเธเธฃเธฐเธเธเน€เธเธดเธฃเนเธเน€เธงเธญเธฃเนเธ—เธตเนเธเธขเธฒเธขเธฒเธกเธ”เธถเธเธ•เธฑเธงเน€เธฃเธฒเธเธฅเธฑเธ
                    part.Velocity = Vector3.new(0,0,0)
                    part.RotVelocity = Vector3.new(0,0,0)
                    
                    -- เธชเธฃเนเธฒเธ BodyVelocity เนเธฅเธฐ BodyGyro เธเธฃเธญเธเธ•เธฑเธงเน€เธเธทเนเธญเธเธฑเธเธเธฑเธเธ—เธดเธจเธ—เธฒเธเธเธดเนเธเธชเธเธดเธ— เธ•เธฑเธงเนเธเนเธเนเธ•เนเธเธขเธฑเธเนเธ”เน
                    if _G.GodBodyActive and not part:FindFirstChild("GodAnchor") then
                        local bg = Instance.new("BodyGyro", part)
                        bg.Name = "GodAnchor"
                        bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
                        bg.cframe = part.CFrame
                        
                        local bv = Instance.new("BodyVelocity", part)
                        bv.Name = "GodVelocity"
                        bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bv.velocity = Vector3.new(0,0,0)
                    end
                end
            end
        end
    end)
end

GodBtn.Parent = MainFrame
GodBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
GodBtn.Size = UDim2.new(0.9, 0, 0, 45)
GodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
GodBtn.Text = "เน€เธเธดเธ”เธฃเธฐเธเธเธ•เธฑเธงเนเธเนเธเธเธฑเธเธ•เธฒเธข/เธเธฑเธเน€เธ”เนเธ: OFF"
GodBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
GodBtn.TextSize = 15
GodBtn.Font = Enum.Font.SourceSansBold

GodBtn.MouseButton1Click:Connect(function()
    _G.GodBodyActive = not _G.GodBodyActive
    if _G.GodBodyActive then
        GodBtn.Text = "เธฃเธฐเธเธเธ•เธฑเธงเนเธเนเธเธเธฑเธเธ•เธฒเธข/เธเธฑเธเน€เธ”เนon: ON"
        GodBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
        GodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            while _G.GodBodyActive do
                ApplyGodBody()
                task.wait(0.1)
            end
        end)
    else
        GodBtn.Text = "เน€เธเธดเธ”เธฃเธฐเธเธเธ•เธฑเธงเนเธเนเธเธเธฑเธเธ•เธฒเธข/เธเธฑเธเน€เธ”เนเธ: OFF"
        GodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        GodBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        -- เธฅเธเธ•เธฑเธงเธฅเนเธญเธเธญเธญเธเน€เธกเธทเนเธญเธเธดเธ”
        pcall(function()
            for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    if part:FindFirstChild("GodAnchor") then part.GodAnchor:Destroy() end
                    if part:FindFirstChild("GodVelocity") then part.GodVelocity:Destroy() end
                end
            end
        end)
    end
end)

-- [[ 2. เธฃเธฐเธเธเธเธดเธเธ•เธฃเธเน€เธเธฅเธตเธขเธฃเนเนเธเน เธเธงเธฒเธกเน€เธฃเนเธงเนเธชเธเนเธฃเนเธเธตเธ”เธเธณเธเธฑเธ” (Instant CFrame Loop) ]]
FlyBtn.Parent = MainFrame
FlyBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 45)
FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FlyBtn.Text = "เน€เธเธดเธ”เธเธดเธเธเธงเธฒเธกเน€เธฃเนเธงเนเธชเธเธชเธฑเธเนเธเน: OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
FlyBtn.TextSize = 15
FlyBtn.Font = Enum.Font.SourceSansBold

FlyBtn.MouseButton1Click:Connect(function()
    _G.GodAutoFly = not _G.GodAutoFly
    if _G.GodAutoFly then
        FlyBtn.Text = "เธเธดเธเธเธงเธฒเธกเน€เธฃเนเธงเนเธชเธเธชเธฑเธเนเธเน: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
        FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            while _G.GodAutoFly do
                task.wait(0.01) -- เธเธงเธฒเธกเน€เธฃเนเธงเธชเธนเธเธชเธธเธ”เนเธฃเนเธเธตเธ”เธเธณเธเธฑเธ”
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local hrp = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if hrp then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if not _G.GodAutoFly then break end
                            
                            -- เน€เธเธฒเธฐเธเธเน€เธเนเธฒเธซเธฒเธงเธฑเธ•เธ–เธธเน€เธเนเธฒเธซเธกเธฒเธขเธ—เธฑเธเธ—เธต
                            if v:IsA("BasePart") and (string.find(string.lower(v.Name), "egg") or v.Parent.Name == "Eggs") then
                                -- เธขเนเธฒเธขเธ•เธณเนเธซเธเนเธเธเธดเธเธฑเธ”เธ•เธฃเธ เน เนเธเธเธเธฑเธเธเธฅเธฑเธ (Instant Move) เธเธฃเนเธญเธกเธเธฑเธเธฃเธฐเธเธเธ•เธฃเธงเธเธเธฑเธเธเธงเธฒเธกเน€เธฃเนเธงเธ”เนเธงเธขเธเธฒเธฃเธฅเนเธฒเธเธเนเธฒ Velocity เธชเธ” เน
                                hrp.CFrame = v.CFrame * CFrame.new(0, 1, 0)
                                hrp.Velocity = Vector3.new(0,0,0)
                                task.wait(0.02) -- เธเธงเธฒเธกเน€เธฃเนเธงเธชเธนเธเธชเธธเธ”เธ—เธตเนเน€เธเธดเธฃเนเธเน€เธงเธญเธฃเนเธขเธฑเธเธฃเธญเธเธฃเธฑเธเนเธ”เนเนเธ”เธขเนเธกเนเธซเธฅเธธเธ”
                            end
                        end
                    end
                end)
            end
        end)
    else
        FlyBtn.Text = "เน€เธเธดเธ”เธเธดเธเธเธงเธฒเธกเน€เธฃเนเธงเนเธชเธเธชเธฑเธเนเธเน: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        FlyBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- [[ 3. เธเธธเนเธกเน€เธเธฅเธตเธขเธฃเนเธซเธเนเธฒเธเธญ ]]
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
CloseBtn.Size = UDim2.new(0.9, 0, 0, 40)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "เธเธดเธ”เธชเธเธฃเธดเธเธ•เนเธ–เธฒเธงเธฃ (Destroy)"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSans

CloseBtn.MouseButton1Click:Connect(function()
    _G.GodAutoFly = false
    _G.GodBodyActive = false
    pcall(function()
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                if part:FindFirstChild("GodAnchor") then part.GodAnchor:Destroy() end
                if part:FindFirstChild("GodVelocity") then part.GodVelocity:Destroy() end
            end
        end
    end)
    ScreenGui:Destroy()
end)

-- [[ 4. เธฃเธฐเธเธเธเนเธญเธเธเธฑเธเธเธฒเธฃเน€เธ•เธฐเธเนเธเน€เธเธดเธฃเนเธเน€เธงเธญเธฃเนเธเนเธฒเธกเธเธทเธ (Anti-Kick / Anti-AFK) ]]
pcall(function()
    local vu = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)
