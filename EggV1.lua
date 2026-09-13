-- ==============================================================================
-- RE-EXECUTION GUARD + RESOURCE TRACKING
-- ==============================================================================
do
    local prev = _G.OxideStealAnEgg
    if prev and type(prev.Unload) == "function" then pcall(prev.Unload) end
end
local HUB = { conns = {}, drawings = {}, highlights = {}, dead = false }
_G.OxideStealAnEgg = HUB
local function track(conn) table.insert(HUB.conns, conn); return conn end

-- ==============================================================================
-- CONFIG / SETTINGS (ค่าเริ่มต้นเริ่มต้นใช้งาน)
-- ==============================================================================
local autoStealEnabled          = true
local rareEggHunter             = true
local stealMovementMethod       = "Tween Glide"
local avoidTrapsEnabled         = true
local instantPickupEnabled      = true
local noKnockbackEnabled        = true
local antiRagdollEnabled        = true
local stealDelay                = 1.5
local glideSpeed                = 750

local autoHatchEnabled          = true
local autoPlantEnabled          = true
local hatchCheckDelay           = 2.0

local autoUpgradeBase           = true
local autoUpgradeTreadmill      = true
local autoEquipBestPets         = true
local autoClaimRewards          = true

-- ==============================================================================
-- SERVICES & LOCALS
-- ==============================================================================
local Players             = game:GetService("Players")
local RS                  = game:GetService("ReplicatedStorage")
local RunService          = game:GetService("RunService")
local Workspace           = game:GetService("Workspace")
local CoreGui             = game:GetService("CoreGui")
local TweenService        = game:GetService("TweenService")
local LP                  = Players.LocalPlayer

-- ลบ UI เก่าที่ซ้ำซ้อน
if CoreGui:FindFirstChild("OxideHubDelta") then
    CoreGui.OxideHubDelta:Destroy()
end

-- ==============================================================================
-- CREATING DELTA STYLE GUI
-- ==============================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OxideHubDelta"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- ปุ่มเปิด/ปิดเมนูลอย (Toggle Button)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ToggleBtn.Text = "Oxide"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn
local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 255, 150)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleBtn

-- หน้าต่างหลัก (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 360, 0, 280)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Visible = true
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 55)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- หัวข้อเมนู (Header Bar)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header
local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Text = "OXIDE HUB  [DELTA EDITION]"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.HelveticaBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มปิดหน้าต่างบน Header
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- ฟังก์ชันลากหน้าต่าง (Drag Window สำหรับมือถือ)
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.Width.Scale, startPos.Width.Offset + delta.X, startPos.Height.Scale, startPos.Height.Offset + delta.Y)
    end
end)

-- ควบคุมการเปิดปิดจากปุ่ม
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- พื้นที่แสดงรายการฟังก์ชัน (Scrolling Container)
local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.Size = UDim2.new(1, -20, 1, -55)
Container.Position = UDim2.new(0, 10, 0, 48)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 400)
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- ฟังก์ชันสร้างปุ่มสวิตช์เปิด/ปิด (Create Toggle Function)
local function CreateToggle(name, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Frame.Parent = Container
    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 6)
    FrameCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Text = "  " .. name
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    
    local Button = Instance.new("TextButton")
    Button.Parent = Frame
    Button.Size = UDim2.new(0, 45, 0, 22)
    Button.Position = UDim2.new(1, -50, 0, 8)
    Button.BackgroundColor3 = default and Color3.fromRGB(0, 200, 120) or Color3.fromRGB(60, 60, 70)
    Button.Text = ""
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 11)
    BtnCorner.Parent = Button
    
    local Circle = Instance.new("Frame")
    Circle.Parent = Button
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = default and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 4, 0, 3)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    local state = default
    Button.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(0, 200, 120) or Color3.fromRGB(60, 60, 70)}):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 4, 0, 3)}):Play()
    end)
end

-- ==============================================================================
-- ADDING TOGGLES TO GUI
-- ==============================================================================
CreateToggle("Auto Steal Eggs (ขโมยไข่ออโต้)", autoStealEnabled, function(v) autoStealEnabled = v end)
CreateToggle("Rare Egg Hunter (เน้นไข่แรร์ก่อน)", rareEggHunter, function(v) rareEggHunter = v end)
CreateToggle("Instant Pickup 0s (เก็บไข่ทันที)", instantPickupEnabled, function(v) instantPickupEnabled = v end)
CreateToggle("Avoid Enemy Traps (ทำลายกับดักศัตรู)", avoidTrapsEnabled, function(v) avoidTrapsEnabled = v end)
CreateToggle("No Knockback (ป้องกันการกระเด็น)", noKnockbackEnabled, function(v) noKnockbackEnabled = v end)
CreateToggle("Anti Ragdoll (ลุกขึ้นทันทีเมื่อล้ม)", antiRagdollEnabled, function(v) antiRagdollEnabled = v end)
CreateToggle("Auto Hatch Owned Eggs (ฟักไข่ออโต้)", autoHatchEnabled, function(v) autoHatchEnabled = v end)
CreateToggle("Auto Plant Eggs in Pen (วางไข่ในคอก)", autoPlantEnabled, function(v) autoPlantEnabled = v end)
CreateToggle("Auto Upgrade Base (อัปเกรดฐานออโต้)", autoUpgradeBase, function(v) autoUpgradeBase = v end)
CreateToggle("Auto Upgrade Treadmill (อัปเกรดลู่วิ่ง)", autoUpgradeTreadmill, function(v) autoUpgradeTreadmill = v end)
CreateToggle("Auto Equip Best Pets (ใส่สัตว์เลี้ยงที่ดีสุด)", autoEquipBestPets, function(v) autoEquipBestPets = v end)
CreateToggle("Auto Claim All Rewards (รับรางวัลออโต้)", autoClaimRewards, function(v) autoClaimRewards = v end)

-- เปลี่ยนสไตล์การเดินทางผ่านปุ่ม
CreateToggle("Fly Glide Mode (เปิด=บิน / ปิด=เดินสไลด์)", (stealMovementMethod == "Fly Glide"), function(v)
    stealMovementMethod = v and "Fly Glide" or "Tween Glide"
end)

-- ==============================================================================
-- BYPASS & GAME MECHANICS HOOKS (จากสคริปต์ต้นฉบับของคุณ)
-- ==============================================================================
pcall(function()
    local pps = game:GetService("ProximityPromptService")
    track(pps.PromptButtonHoldBegan:Connect(function(prompt, player)
        if player == LP and tostring(prompt) == "CarryAreaEgg" and instantPickupEnabled then
            prompt.HoldDuration = 0
        end
    end))
end)

pcall(function()
    local coreGui = game:GetService("CoreGui")
    track(coreGui.ChildAdded:Connect(function(child)
        if child.Name == "PurchasePrompt" then
            task.wait(0.04)
            pcall(function()
                local cancel = child:FindFirstChild("CancelButton", true)
                if cancel and typeof(cancel) == "Instance" and cancel:IsA("GuiButton") then
                    pcall(function() cancel.MouseButton1Click:Fire() end)
                end
            end)
        end
    end))
end)

-- CHARACTER & MOVEMENT HELPERS
local function findHum()
    local ch = LP.Character
    return ch and ch:FindFirstChildOfClass("Humanoid")
end
local function findHRP()
    local ch = LP.Character
    return ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart or ch:FindFirstChildWhichIsA("BasePart"))
end

local function GetLocalPlotCenter()
    local PlotState = require(RS.Client.PlotState)
    local plotObj = PlotState and PlotState.ResolvePlot and PlotState.ResolvePlot()
    local pt = plotObj and plotObj.CenterPoint and (typeof(plotObj.CenterPoint) == "Vector3" and plotObj.CenterPoint or (plotObj.CenterPoint:IsA("BasePart") and plotObj.CenterPoint.Position))
    if pt then return Vector3.new(pt.X, math.max(pt.Y, 70.4), pt.Z) end
    return Vector3.new(464.7, 70.4, -364.0)
end

-- NAVIGATION ENGINE
local MAIN_ROAD_Z = -364.5
local SAFE_BOUNDARY_X = 580
local SAFE_ZONE_SPEED = 245

local function MoveToPoint(target, speed)
    local hrp = findHRP()
    if not hrp or not target then return false end
    speed = math.clamp(tonumber(speed) or 750, 50, 750)
    local t0 = os.clock()
    while not HUB.dead do
        local dt = RunService.Heartbeat:Wait()
        local curPos = hrp.Position
        local toTarget = target - curPos
        local remain = toTarget.Magnitude
        if remain < 1.0 then break end
        local step = math.min(speed * dt, remain)
        local dir = toTarget.Unit
        local nextPos = curPos + dir * step
        hrp.CFrame = CFrame.lookAt(nextPos, nextPos + dir)
        hrp.AssemblyLinearVelocity = Vector3.zero
        if os.clock() - t0 > (remain / 50 + 5) then break end
    end
    hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
    return true
end

local function FlyToPoint(target, speed)
    local hrp = findHRP()
    if not hrp or not target then return false end
    local start = hrp.Position
    local dist = (target - start).Magnitude
    speed = math.clamp(tonumber(speed) or 750, 50, 750)
    local moveTime = math.max(dist / speed, 0.02)
    local t0 = os.clock()
    local delta = target - start
    local dir = delta.Magnitude > 0.001 and delta.Unit or Vector3.new(1, 0, 0)
    while os.clock() - t0 < moveTime and not HUB.dead do
        RunService.Heartbeat:Wait()
        local linearAlpha = math.clamp((os.clock() - t0) / moveTime, 0, 1)
        local cur = start:Lerp(target, linearAlpha)
        hrp.CFrame = CFrame.lookAt(cur, cur + dir)
        hrp.AssemblyLinearVelocity = dir * speed
    end
    hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
    return true
end

local function NeutralizeTraps()
    local debris = Workspace:FindFirstChild("__DEBRIS")
    if not debris then return end
    for _, d in ipairs(debris:GetChildren()) do
        if d.Name == "PlayerTrap" and d:GetAttribute("Owner") ~= LP.Name then
            if d:IsA("BasePart") then d.CanTouch = false; d.CanQuery = false end
        end
    end
end

local function TravelToDestination(targetPos, speed)
    local hrp = findHRP()
    if not hrp or not targetPos then return false end
    if avoidTrapsEnabled then pcall(NeutralizeTraps) end
    local startPos = hrp.Position
    local safeY = math.max(startPos.Y, targetPos.Y, 70.4)
    local isReturningToBase = (targetPos.X < 560)

    if stealMovementMethod == "Fly Glide" then
        local flyAltitude = safeY + 28
        if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
            FlyToPoint(Vector3.new(startPos.X, flyAltitude, startPos.Z), speed)
            FlyToPoint(Vector3.new(SAFE_BOUNDARY_X, flyAltitude, MAIN_ROAD_Z), speed)
            MoveToPoint(Vector3.new(targetPos.X, 70.4, MAIN_ROAD_Z), SAFE_ZONE_SPEED)
            MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), SAFE_ZONE_SPEED)
        else
            FlyToPoint(Vector3.new(startPos.X, flyAltitude, startPos.Z), speed)
            FlyToPoint(Vector3.new(targetPos.X, flyAltitude, targetPos.Z), speed)
            FlyToPoint(targetPos + Vector3.new(0, 1.2, 0), speed)
        end
    else
        if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
            MoveToPoint(Vector3.new(startPos.X, safeY, MAIN_ROAD_Z), speed)
            MoveToPoint(Vector3.new(SAFE_BOUNDARY_X, safeY, MAIN_ROAD_Z), speed)
            MoveToPoint(Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z), SAFE_ZONE_SPEED)
            MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), SAFE_ZONE_SPEED)
        else
            MoveToPoint(Vector3.new(startPos.X, safeY, MAIN_ROAD_Z), speed)
            MoveToPoint(Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z), speed)
            MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), speed)
        end
    end
    return true
end

-- CORE EGG LOGIC
local RARITY_SCORE_MAP = { ["Titan"] = 1100, ["Divine"] = 1000, ["Secret"] = 800, ["Mythic"] = 600, ["Legendary"] = 500, ["Common"] = 100 }
local function GetEggRarityInfo(egg)
    if not egg then return "Common", 100 end
    if egg.Rarity then
        local name = type(egg.Rarity) == "table" and (egg.Rarity.DisplayName or egg.Rarity.Name) or tostring(egg.Rarity)
        return name, RARITY_SCORE_MAP[name] or 100
    end
    return "Common", 100
end

local function GetMatchingFieldEggs()
    local EggState = require(RS.Client.EggState)
    if not EggState or not EggState.ReadFieldEggs then return {} end
    local ok, snapshot = pcall(EggState.ReadFieldEggs)
    if not ok or not snapshot or not snapshot.Records then return {} end

    local matched = {}
    for _, record in ipairs(snapshot.Records) do
        if record.State == "Slot" and record.BoundsCFrame then
            local rarityName, baseScore = GetEggRarityInfo(record)
            table.insert(matched, { record = record, rarity = rarityName, score = baseScore })
        end
    end
    if #matched > 1 and rareEggHunter then
        table.sort(matched, function(a, b) return a.score > b.score end)
    end
    return matched
end

local function isPlayerCarryingEgg()
    local char = LP.Character
    if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") and (t.Name:lower():find("egg") or t:GetAttribute("IsEgg")) then return true end
        end
    end
    return false
end

local function PlantAllCarriedEggsInPen()
    local EggState = require(RS.Client.EggState)
    local EggToolDisplay = require(RS.Shared.Eggs.EggToolDisplay)
    local toolsToPlant = {}
    for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") and EggToolDisplay.IsEggTool(t) then
            local uid = EggToolDisplay.GetToolUid(t)
            if uid then table.insert(toolsToPlant, uid) end
        end
    end
    for _, eggUid in ipairs(toolsToPlant) do
        pcall(function() EggState.PlantEgg(eggUid, CFrame.new(math.random(-5, 5), 0, math.random(-5, 5))) end)
    end
end

local function StealSpecificEggRobust(targetItem)
    local record = targetItem.record or targetItem
    if not record then return false end
    local targetPos = record.BoundsCFrame.Position
    TravelToDestination(targetPos + Vector3.new(0, 1.2, 0), glideSpeed)
    task.wait(0.3)

    local net = RS:FindFirstChild("Packages") and RS.Packages:FindFirstChild("Networking")
    local carryRemote = net and net:FindFirstChild("RF/EggWorld/AskFieldEggCarry")
    if carryRemote then pcall(function() carryRemote:InvokeServer({ Uid = record.Uid }) end) end

    local tPickup = os.clock()
    while os.clock() - tPickup < 1.2 do
        if isPlayerCarryingEgg() then break end
        task.wait(0.1)
    end

    local safePlotCenter = GetLocalPlotCenter()
    TravelToDestination(safePlotCenter, glideSpeed)
    task.wait(0.4)
    PlantAllCarriedEggsInPen()
    return true
end

local function HatchAllReadyEggs()
    local EggState = require(RS.Client.EggState)
    if not EggState or not EggState.ReadOwnedEggs then return end
    local ok, snapshot = pcall(EggState.ReadOwnedEggs, LP.UserId)
    if not ok or not snapshot then return end
    for uid, eggData in pairs(snapshot.Records or snapshot) do
        if typeof(eggData) == "table" and eggData.Placement then
            pcall(function()
                EggState.BeginHatch(uid)
                task.wait(0.05)
                EggState.FinishHatch(uid)
            end)
        end
    end
end

-- ==============================================================================
-- AUTOMATION LOOPS (ลูปทำงานเบื้องหลัง)
-- ==============================================================================
local function GetNetRemote(name)
    local net = RS:FindFirstChild("Packages") and RS.Packages:FindFirstChild("Networking")
    return net and net:FindFirstChild(name)
end

-- 1. ลูปขโมยไข่
task.spawn(function()
    while not HUB.dead do
        if autoStealEnabled then
            local eggs = GetMatchingFieldEggs()
            if #eggs > 0 then StealSpecificEggRobust(eggs[1]) end
        end
        task.wait(stealDelay)
    end
end)

-- 2. ลูปฟักไข่ & วางไข่
task.spawn(function()
    while not HUB.dead do
        if autoHatchEnabled then pcall(HatchAllReadyEggs) end
        if autoPlantEnabled then pcall(PlantAllCarriedEggsInPen) end
        task.wait(hatchCheckDelay)
    end
end)

-- 3. ลูปรวมระบบอัปเกรดและรับรางวัลอัตโนมัติ
task.spawn(function()
    while not HUB.dead do
        if autoUpgradeBase then
            local re1 = GetNetRemote("RE/Homestead/AskNearbyPurchase")
            if re1 then re1:FireServer() end
        end
        if autoUpgradeTreadmill then
            local rf = GetNetRemote("RF/Treadmill/AskTierRaise")
            if rf then rf:InvokeServer() end
        end
        if autoEquipBestPets then
            local rf = GetNetRemote("RF/Haul/WearBest")
            if rf then rf:InvokeServer() end
        end
        if autoClaimRewards then
            pcall(function()
                local rf1 = GetNetRemote("RF/AwayEarnings/AskCollect")
                if rf1 then rf1:InvokeServer() end
                local rf2 = GetNetRemote("RF/Codex/AskRedeemAll")
                if rf2 then rf2:InvokeServer() end
            end)
        end
        task.wait(3.0)
    end
end)

-- 4. ระบบแก้ทางล้ม/กระเด็น และทำลายตับดักศัตรู
track(RunService.Heartbeat:Connect(function()
    if HUB.dead do return end
    if antiRagdollEnabled then
        local hum = findHum()
        if hum and hum:GetState() == Enum.HumanoidStateType.Physics then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    if avoidTrapsEnabled then pcall(NeutralizeTraps) end
end))

print("Oxide HUB Custom GUI Loaded for Delta Executor Successfully!")
