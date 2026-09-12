-- [[ เธชเธเธฃเธดเธเธ•เนเธเธดเธเน€เธเนเธเนเธเนเธฃเธฐเธเธเธกเธเธธเธฉเธขเนเนเธฃเนเธเนเธฒเธข + เธเธฑเธเน€เธ•เธฐ 100% BYPASS - DELTA ]] --

if game:GetService("CoreGui"):FindFirstChild("UltimateEggBypassGui") then
    game:GetService("CoreGui"):FindFirstChild("UltimateEggBypassGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")
local ToggleGodBtn = Instance.new("TextButton")
local AutoEquipBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Name = "UltimateEggBypassGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "HUMAN FLY EGG FARM (BYPASS)"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

_G.HumanFlyFarm = false
_G.GodModeActive = false
_G.AutoEquipBest = false

-- 1. เธฃเธฐเธเธเธเธดเธเน€เธเธตเธขเธเนเธเธเธเธเน€เธฅเนเธ (Smooth Human Fly Simulation)
ToggleFarmBtn.Parent = MainFrame
ToggleFarmBtn.Position = UDim2.new(0.05, 0, 0.18, 0)
ToggleFarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleFarmBtn.Text = "เธฃเธฐเธเธเธเธดเธเน€เธเธตเธขเธเนเธเธเธเธ: OFF"
ToggleFarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleFarmBtn.TextSize = 15
ToggleFarmBtn.Font = Enum.Font.SourceSansBold

ToggleFarmBtn.MouseButton1Click:Connect(function()
    _G.HumanFlyFarm = not _G.HumanFlyFarm
    if _G.HumanFlyFarm then
        ToggleFarmBtn.Text = "เธฃเธฐเธเธเธเธดเธเน€เธเธตเธขเธเนเธเธเธเธ: ON"
        ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
        ToggleFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            local TweenService = game:GetService("TweenService")
            while _G.HumanFlyFarm do
                task.wait(0.2)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local hrp = character and character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    
                    if hrp and humanoid then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if not _G.HumanFlyFarm then break end
                            
                            if v:IsA("BasePart") and (string.find(string.lower(v.Name), "egg") or v.Parent.Name == "Eggs") then
                                local distance = (hrp.Position - v.Position).Magnitude
                                if distance > 4 then
                                    -- เธ—เธณเธเธฒเธฃเธเธดเธเธฅเธญเธขเธ•เธฑเธงเนเธฅเธฐเธฅเนเธญเธเธเธงเธฒเธกเน€เธฃเนเธงเนเธซเนเน€เธเธตเธขเธเธ•เธฒ
                                    humanoid.PlatformStand = true
                                    hrp.Velocity = Vector3.new(0, 0.1, 0)
                                    
                                    -- เนเธเนเธเธงเธฒเธกเน€เธฃเนเธงเนเธเธเธเธเธ—เธตเน (Human Speed Simulator) เนเธกเนเน€เธฃเนเธเธเธฃเธงเธ”เธเธฃเธฒเธ”เธเธเธฃเธฐเธเธเน€เธ•เธฐ
                                    local humanSpeed = 45 
                                    local tweenInfo = TweenInfo.new(distance / humanSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = v.CFrame * CFrame.new(0, 1.5, 0)})
                                    tween:Play()
                                    tween.Completed:Wait()
                                    task.wait(0.4) -- เธซเธเนเธงเธเน€เธงเธฅเธฒเน€เธชเธตเนเธขเธงเธงเธดเธเธฒเธ—เธตเน€เธเธทเนเธญเนเธซเนเน€เธเธดเธฃเนเธเน€เธงเธญเธฃเนเธเธดเธ”เธงเนเธฒเธเธเน€เธ”เธดเธเธกเธฒเน€เธเนเธเธเธฃเธดเธ เน
                                end
                            end
                        end
                        humanoid.PlatformStand = false
                    end
                end)
            end
            pcall(function() game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false end)
        end)
    else
        ToggleFarmBtn.Text = "เธฃเธฐเธเธเธเธดเธเน€เธเธตเธขเธเนเธเธเธเธ: OFF"
        ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ToggleFarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- 2. เธฃเธฐเธเธเธญเธกเธ•เธฐ/เธฅเนเธญเธเนเธกเนเนเธซเนเธฃเธตเน€เธเนเธ•เธ•เธฑเธงเธ•เธฒเธข (Absolute Hardcore Anti-Reset)
ToggleGodBtn.Parent = MainFrame
ToggleGodBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
ToggleGodBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleGodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleGodBtn.Text = "เธฃเธฐเธเธเธเธฑเธเธเธฑเธเธซเนเธฒเธกเธ•เธฒเธข: OFF"
ToggleGodBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleGodBtn.TextSize = 15
ToggleGodBtn.Font = Enum.Font.SourceSansBold

ToggleGodBtn.MouseButton1Click:Connect(function()
    _G.GodModeActive = not _G.GodModeActive
    if _G.GodModeActive then
        ToggleGodBtn.Text = "เธฃเธฐเธเธเธเธฑเธเธเธฑเธเธซเนเธฒเธกเธ•เธฒเธข: ON"
        ToggleGodBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
        ToggleGodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            while _G.GodModeActive do
                task.wait(0.1)
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    local humanoid = character and character:FindFirstChild("Humanoid")
                    
                    if humanoid then
                        -- เธเธฅเนเธญเธเธเธณเธชเธฑเนเธเธเธฒเธฃเธฃเธตเน€เธเนเธ•เธ•เธฑเธงเน€เธญเธเธ•เธฒเธขเธเธญเธเธ•เธฑเธงเธฅเธฐเธเธฃเธ—เธฑเนเธเธซเธกเธ”
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                        
                        -- เธเธฑเธเธเธฑเธเนเธซเนเน€เธฅเธทเธญเธ”เนเธกเนเธกเธตเธงเธฑเธเธฅเธ”เธฅเธเน€เธซเธฅเธทเธญ 0
                        if humanoid.Health < 15 then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end
                end)
            end
        end)
    else
        ToggleGodBtn.Text = "เธฃเธฐเธเธเธเธฑเธเธเธฑเธเธซเนเธฒเธกเธ•เธฒเธข: OFF"
        ToggleGodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ToggleGodBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end)
    end
end)

-- 3. เธฃเธฐเธเธเนเธชเนเธ•เธฑเธงเธ—เธตเนเธ”เธตเธ—เธตเนเธชเธธเธ”เธญเธฑเธ•เนเธเธกเธฑเธ•เธด (Auto Equip Best Pets)
AutoEquipBtn.Parent = MainFrame
AutoEquipBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
AutoEquipBtn.Size = UDim2.new(0.9, 0, 0, 40)
AutoEquipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoEquipBtn.Text = "เนเธชเนเธชเธฑเธ•เธงเนเน€เธฅเธตเนเธขเธเธ—เธตเนเธ”เธตเธ—เธตเนเธชเธธเธ”เธญเธฑเธ•เนเธเธกเธฑเธ•เธด: OFF"
AutoEquipBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoEquipBtn.TextSize = 14
AutoEquipBtn.Font = Enum.Font.SourceSansBold

AutoEquipBtn.MouseButton1Click:Connect(function()
    _G.AutoEquipBest = not _G.AutoEquipBest
    if _G.AutoEquipBest then
        AutoEquipBtn.Text = "เนเธชเนเธชเธฑเธ•เธงเนเน€เธฅเธตเนเธขเธเธ—เธตเนเธ”เธตเธ—เธตเนเธชเธธเธ”เธญเธฑเธ•เนเธเธกเธฑเธ•เธด: ON"
        AutoEquipBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 70)
        AutoEquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            while _G.AutoEquipBest do
                task.wait(1.5)
                pcall(function()
                    -- เธฅเธนเธเธขเธดเธ Remote Event เน€เธเธทเนเธญเธชเธงเธกเนเธชเนเธ•เธฑเธงเธ—เธตเนเธ”เธตเธ—เธตเนเธชเธธเธ”เนเธ”เธขเธ•เธฃเธเนเธเธขเธฑเธเธฃเธฐเธเธเน€เธเธก
                    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if v:IsA("RemoteEvent") and (string.find(string.lower(v.Name), "equipbest") or string.find(string.lower(v.Name), "equip_best")) then
                            v:FireServer()
                        end
                    end
                end)
            end
        end)
    else
        AutoEquipBtn.Text = "เนเธชเนเธชเธฑเธ•เธงเนเน€เธฅเธตเนเธขเธเธ—เธตเนเธ”เธตเธ—เธตเนเธชเธธเธ”เธญเธฑเธ•เนเธเธกเธฑเธ•เธด: OFF"
        AutoEquipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        AutoEquipBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- 4. เธเธธเนเธกเธเธดเธ”เน€เธกเธเธนเธชเธเธฃเธดเธเธ•เน
CloseBtn.Parent = MainFrame
CloseBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
CloseBtn.Size = UDim2.new(0.9, 0, 0, 40)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.Text = "เธเธดเธ”เนเธฅเธฐเธ–เธญเธเธเธฒเธฃเธ•เธดเธ”เธ•เธฑเนเธเธชเธเธฃเธดเธเธ•เน"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold

CloseBtn.MouseButton1Click:Connect(function()
    _G.HumanFlyFarm = false
    _G.GodModeActive = false
    _G.AutoEquipBest = false
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
    end)
    ScreenGui:Destroy()
end)

-- เนเธเนเธ”เธเนเธญเธเธเธฑเธเธเธฒเธฃเธ•เธฃเธงเธเธเธฑเธเนเธเธ Real-time เธเนเธฒเธกเธเธทเธ (Anti-Kick / Anti-AFK Bypass)
local vu = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    pcall(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.5)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

print("[SUCCESS] เธฃเธฐเธเธเธเนเธญเธเธเธฑเธเนเธฅเธฐเธชเธเธฃเธดเธเธ•เนเธเธดเธเน€เธเธตเธขเธเธ–เธนเธเธ•เธดเธ”เธ•เธฑเนเธเธชเธกเธเธนเธฃเธ“เนเนเธฅเนเธง!")
