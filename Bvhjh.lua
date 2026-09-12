-- === HUB STRIP POINT ===
-- ==============================================================================
-- RE-EXECUTION GUARD + RESOURCE TRACKING
-- ==============================================================================
do 
    local prev = _G.OxideStealAnEgg 
    if prev and type(prev.Unload) == "function" then 
        pcall(prev.Unload) 
    end 
end 

local HUB = { conns = {}, drawings = {}, highlights = {}, dead = false } 
_G.OxideStealAnEgg = HUB 

local function track(conn) table.insert(HUB.conns, conn); return conn end 
local function trackDrawing(d) if d then table.insert(HUB.drawings, d) end; return d end 

-- สมมติฐาน: ตัวรันสคริปต์ของคุณได้ทำการโหลด Library (_G.OxideLib) ไว้ก่อนหน้านี้แล้วตามคำอธิบายในไฟล์
local Library = _G.OxideLib or loadstring(game:HttpGet("https://githubusercontent.com"))()

local Window = Library:CreateWindow({ 
    Name = "Oxide HUB | Ein Ei stehlen", 
    LoadingAnimation = true, 
    LoadingText = "Oxide", 
    LoadingDuration = 2.0, 
}) 

-- ==============================================================================
-- CONFIG / FLAG PERSISTENCE
-- ==============================================================================
local HAS_CONFIG = type(Library.SaveConfig) == "function" and type(Library.LoadConfig) == "function" and type(Library.ListConfigs) == "function" 
local CONFIG_NAME = "stealanegg" 
local dropdownResync = {} 

local function registerResync(handle, applyFn) 
    if handle and applyFn then 
        table.insert(dropdownResync, function() applyFn(handle:Get()) end) 
    end 
end 

local function ResyncAll() 
    for _, fn in ipairs(dropdownResync) do pcall(fn) end 
end 

-- ==============================================================================
-- SERVICES & LOCALS
-- ==============================================================================
local Players = game:GetService("Players") 
local RS = game:GetService("ReplicatedStorage") 
local RunService = game:GetService("RunService") 
local UserInputService = game:GetService("UserInputService") 
local Workspace = game:GetService("Workspace") 
local Lighting = game:GetService("Lighting") 
local TeleportService = game:GetService("TeleportService") 
local VirtualUser = game:GetService("VirtualUser") 
local LP = Players.LocalPlayer 

local function GetCamera() return Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera") end 

-- Instant ProximityPrompt Hold Eliminator
pcall(function() 
    local pps = game:GetService("ProximityPromptService") 
    track(pps.PromptButtonHoldBegan:Connect(function(prompt, player) 
        if player == LP and tostring(prompt) == "CarryAreaEgg" then 
            prompt.HoldDuration = 0 
        end 
    end)) 
end) 

-- Anti-Robux Purchase Prompt Shield
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

local function Notify(title, content, kind, dur) 
    pcall(function() 
        Window:Notify({ Title = title, Content = content, Type = kind or "Info", Duration = dur or 2.5 }) 
    end) 
end 

local function safeCallback(fn) 
    return function(...) 
        local ok, err = pcall(fn, ...) 
        if not ok then pcall(Notify, "Oxide HUB", "Error: " .. tostring(err), "Error", 4) end 
    end 
end 

-- ==============================================================================
-- CLIENT AC NEUTRALIZER & UGI CONSTANT WIPER
-- ==============================================================================
local function bypassClientDetections() 
    if typeof(filtergc) ~= "function" or typeof(debug) ~= "table" or typeof(debug.getupvalues) ~= "function" then return false, "no filtergc" end 
    local ok, fn = pcall(function() return filtergc("function", { Constants = { "gmatch", "GetFullName" }, }, true) end) 
    if not ok or type(fn) ~= "function" then return false, "filter miss" end 
    local setMeta = (typeof(setrawmetatable) == "function" and setrawmetatable) or (typeof(setmetatable) == "function" and setmetatable) 
    if not setMeta then return false, "no setmeta" end 
    local blocked = 0 
    local okUv, ups = pcall(debug.getupvalues, fn) 
    if not okUv or type(ups) ~= "table" then return false, "no upvalues" end 
    for _, tbl in pairs(ups) do 
        if typeof(tbl) == "table" then 
            local okSet = pcall(setMeta, tbl, { __newindex = function() end }) 
            if okSet then blocked = blocked + 1 end 
        end 
    end 
    return blocked > 0, blocked 
end 
pcall(bypassClientDetections) 

pcall(function() 
    local getgc = getgc or (debug and debug.getgc) 
    local setmeta = setrawmetatable or setmetatable 
    local getmeta = getrawmetatable or getmetatable 
    if getgc and setmeta then 
        for _, obj in ipairs(getgc(true)) do 
            if typeof(obj) == "table" and not (getmeta and getmeta(obj)) then 
                local mainrun = false 
                for _, v in pairs(obj) do if v == obj then mainrun = true break end end 
                if mainrun then 
                    for _, v in pairs(obj) do 
                        if typeof(v) == "number" and v >= 1 and v <= 3 and obj[v] == nil then 
                            pcall(setmeta, obj, { __newindex = function() end }) 
                            break 
                        end 
                    end 
                end 
            end 
        end 
    end 
end) 

pcall(function() 
    local getgc = getgc or (debug and debug.getgc) 
    local getconstants = getconstants or (debug and debug.getconstants) 
    local setconstant = setconstant or (debug and debug.setconstant) 
    local islclosure = islclosure or function(Function) return not pcall(setfenv, getfenv(Function)) end 
    if getgc and getconstants and setconstant then 
        for _, Function in ipairs(getgc(true)) do 
            if typeof(Function) == "function" and islclosure(Function) then 
                local ok, Source = pcall(debug.info, Function, "s") 
                if ok and type(Source) == "string" and Source:find("ReplicatedFirst", 1, true) and Source:find("UGI", 1, true) then 
                    local okC, Constants = pcall(getconstants, Function) 
                    if okC and type(Constants) == "table" then 
                        for Index, Constant in next, Constants do 
                            if type(Constant) == "string" and Constant == "Humanoid" then 
                                pcall(setconstant, Function, Index, "") 
                            end 
                        end 
                    end 
                end 
            end 
        end 
    end 
end) 

pcall(function() 
    local getgc = getgc or (debug and debug.getgc) 
    local getconstants = getconstants or (debug and debug.getconstants) 
    local islclosure = islclosure or function(fn) return not pcall(setfenv, getfenv(fn)) end 
    local HookFn = hookfunction or replaceclosure or hookfunc 
    if getgc and getconstants and HookFn and debug and debug.getstack and debug.setstack then 
        for _, fn in ipairs(getgc(true)) do 
            if typeof(fn) == "function" and islclosure(fn) then 
                local ok, consts = pcall(getconstants, fn) 
                if ok and type(consts) == "table" and table.find(consts, "X-14") then 
                    local cb = nil 
                    cb = HookFn(fn, function(...) 
                        local stack = debug.getstack(1) 
                        if type(stack) == "table" then 
                            for idx, val in pairs(stack) do 
                                if val == "X-14" then pcall(debug.setstack, 1, idx, nil) end 
                            end 
                        end 
                        if cb then return cb(...) end 
                    end) 
                end 
            end 
        end 
    end 
end) 

pcall(function() 
    local getgc = getgc or (debug and debug.getgc) 
    local islclosure = islclosure or function(v) return not pcall(setfenv, getfenv(v)) end 
    local getupvalues = getupvalues or (debug and debug.getupvalues) 
    local getupvalue = getupvalue or (debug and debug.getupvalue) 
    local setupvalue = setupvalue or (debug and debug.setupvalue) 
    local clonefunction = clonefunction or function(f) return function(...) return f(...) end end 
    if getgc and getupvalues and getupvalue and setupvalue then 
        for _, v in ipairs(getgc(true)) do 
            if typeof(v) == "function" and islclosure(v) then 
                local ok, upvs = pcall(getupvalues, v) 
                if ok and upvs and #upvs == 19 then 
                    local ok2, u2 = pcall(getupvalue, v, 2) 
                    if ok2 and typeof(u2) == "function" then 
                        local old = clonefunction(u2) 
                        pcall(setupvalue, v, 2, function(a, b) 
                            if b and typeof(b) == "table" then pcall(setmetatable, b, {}) end 
                            return old(a, b) 
                        end) 
                    end 
                end 
            end 
        end 
    end 
end) 

-- Memory Evidence Scrubber Loop
task.spawn(function() 
    if not getgc then return end 
    local st = nil 
    local function findIntegrityTable() 
        local ok, objs = pcall(getgc, true) 
        if ok and objs then 
            for _, o in pairs(objs) do 
                if type(o) == "table" then 
                    local hit = false 
pcall(function()
hit = (rawget(o, "ValidationLocked") ~= nil and rawget(o, "Evidence") ~= nil) or (rawget(o, "ThreatLevel") ~= nil and rawget(o, "LastObservedSample") ~= nil)
end)
if hit then return o end
end
end
end
return nil
end

track(LP.CharacterAdded:Connect(function() task.wait(1) st = findIntegrityTable() end))
while not HUB.dead do
if not st then st = findIntegrityTable() end
if st then
pcall(function()
local ev = rawget(st, "Evidence")
if type(ev) == "table" then
if (tonumber(ev.Speed) or 0) > 0 then rawset(ev, "Speed", 0) end
if (tonumber(ev.Teleport) or 0) > 0 then rawset(ev, "Teleport", 0) end
if (tonumber(ev.Flight) or 0) > 0 then rawset(ev, "Flight", 0) end
end
if rawget(st, "ThreatLevel") ~= "Trusted" then rawset(st, "ThreatLevel", "Trusted") end
if rawget(st, "ValidationLocked") == true then rawset(st, "ValidationLocked", false) end
if rawget(st, "FirstSuspiciousAt") ~= nil then rawset(st, "FirstSuspiciousAt", nil) end
if rawget(st, "KickQueued") == true then rawset(st, "KickQueued", false) end
if rawget(st, "TamperScore") ~= nil then rawset(st, "TamperScore", 0) end
if rawget(st, "InvalidHeartbeatCount") ~= nil then rawset(st, "InvalidHeartbeatCount", 0) end
local los = rawget(st, "LastObservedSample")
if los ~= nil then
if rawget(st, "LastGameplayTrustedSample") == nil then rawset(st, "LastGameplayTrustedSample", los) end
if rawget(st, "LastValidatedSample") == nil then rawset(st, "LastValidatedSample", los) end
if rawget(st, "LastValidatedGroundedSample") == nil then rawset(st, "LastValidatedGroundedSample", los) end
if rawget(st, "LastConfirmedGroundSample") == nil then rawset(st, "LastConfirmedGroundSample", los) end
if rawget(st, "LastGoodSample") == nil then rawset(st, "LastGoodSample", los) end
end
end)
end
task.wait(0.2)
end
end)

-- ==============================================================================
-- CHARACTER & MOVEMENT HELPERS
-- ==============================================================================
local function findChar() return LP.Character end
local function findHum() local ch = LP.Character return ch and ch:FindFirstChildOfClass("Humanoid") end
local function findHRP() local ch = LP.Character return ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart or ch:FindFirstChildWhichIsA("BasePart")) end

-- ==============================================================================
-- BAC TELEMETRY PACKET SPOOFER
-- ==============================================================================
local bxor = bit32.bxor
local unpack = table.unpack
local function isGuid(n) return #n==36 and n:sub(9,9)=="-" and n:sub(14,14)=="-" and n:sub(19,19)=="-" and n:sub(24,24)=="-" and n:gsub("-",""):match("^%x+$")~=nil end
local remoteSet, anyRemote = {}, nil

local function scanRemotes()
for _, s in ipairs(game:GetChildren()) do
local ok, list = pcall(s.GetDescendants, s)
if ok and list then
for _, o in ipairs(list) do
if o:IsA("RemoteEvent") and isGuid(o.Name) then
remoteSet[o] = true anyRemote = anyRemote or o
end
end
end
end
end
scanRemotes()

local function parseCounter(v) if type(v) ~= "string" then return end local n = v:match("^X%-(%d+)$") return n and tonumber(n) end
local function looksLikeState(t, r)
if type(t) ~= "table" then return false end
local hR, hM = false, false
pcall(function()
for _, v in pairs(t) do
if v == r then hR = true elseif type(v) == "string" and v:match("^X%-%d+$") then hM = true end
end
end)
return hR and hM
end

local function findState(r)
for l=2,24 do
local _, fn = pcall(debug.info, l, "f")
if type(fn) == "function" then
local _, ups = pcall(debug.getupvalues, fn)
if type(ups) == "table" then
for _, v in pairs(ups) do
if looksLikeState(v, r) then return v end
if type(v) == "table" then
local nested
pcall(function() for _, x in pairs(v) do if looksLikeState(x, r) then nested = x return end end end)
if nested then return nested end
end
end
end
end
end
end

local function mapState(st, a1, a2)
local m = {}
for k, v in pairs(st) do
if type(v) == "string" then
if v:match("^X%-%d+$") then m.marker = m.marker or k
elseif a1 and v == a1 then m.arg1 = m.arg1 or k
elseif a2 and v == a2 then m.arg2 = m.arg2 or k end
end
end
return m
end

local model = nil
local function digits(n) n = n % 1000 return math.floor(n/100), math.floor(n/10)%10, n%10 end
local function encode(m, c) local d1, d2, d3 = digits(c) return m.prefix .. string.char(bxor(d1, m.k1), bxor(d2, m.k2), bxor(d3, m.k3)) end

local function learn(r, a1, a2)
local st = findState(r) if not st then return end
local map = mapState(st, a1, a2) if not map.marker then return end
local c = parseCounter(rawget(st, map.marker)) if not c then return end
local d1, d2, d3 = digits(c)
local m = { state = st, map = map, remote = r, prefix = a1:sub(1, 9), k1 = bxor(a1:byte(10), d1), k2 = bxor(a1:byte(11), d2), k3 = bxor(a1:byte(12), d3), offset = c - os.time(), arg2 = a2 }
if encode(m, c) == a1 then return m end
end

local function liveCounter(m)
if m.state and m.map.marker then
local _, raw = pcall(rawget, m.state, m.map.marker)
local c = parseCounter(raw)
if c and math.abs((c - os.time()) - m.offset) <= 5 then return c end
end
return os.time() + m.offset
end

local function refreshArg2(m)
if m.state and m.map.arg2 then
local _, v = pcall(rawget, m.state, m.map.arg2)
if type(v) == "string" then m.arg2 = v end
end
return m.arg2
end

local HookFn = hookfunction or replaceclosure or hookfunc or detour_function
if anyRemote and HookFn then
local oldFire
oldFire = HookFn(anyRemote.FireServer, function(self, ...)
local args = table.pack(...)
if not remoteSet[self] then return oldFire(self, unpack(args, 1, args.n)) end
local a1 = args[1]
if type(a1) == "string" and #a1 == 12 then
if not model then model = learn(self, a1, args[2])
else
local c = parseCounter(rawget(model.state, model.map.marker))
if c and encode(model, c) ~= a1 then
local m = learn(self, a1, args[2])
if m then m.spoofed = model.spoofed model = m end
end
end
return oldFire(self, unpack(args, 1, args.n))
end
if model and type(a1) == "string" and #a1 == 4 then
local c = liveCounter(model)
args[1] = encode(model, c)
args[2] = refreshArg2(model)
model.spoofed = (model.spoofed or 0) + 1
return oldFire(self, unpack(args, 1, math.max(args.n, 2)))
end
return oldFire(self, unpack(args, 1, args.n))
end)
end

task.spawn(function()
while not HUB.dead do
task.wait(10)
local alive = false
for r in pairs(remoteSet) do if r:IsDescendantOf(game) then alive = true break end end
if not alive then
table.clear(remoteSet) anyRemote = nil model = nil scanRemotes()
end
end
end)

-- ==============================================================================
-- GAME NETWORKING & MODULE INTEGRATION
-- ==============================================================================
local EggState, PlotState, AreasData, RarityData, AssetsData, EggToolDisplay, AreaEggSlotIdentity
pcall(function() EggState = require(RS.Client.EggState) end)
pcall(function() PlotState = require(RS.Client.PlotState) end)
pcall(function() AreasData = require(RS.Data.Areas) end)
pcall(function() RarityData = require(RS.Data.Rarity) end)
pcall(function() AssetsData = require(RS.Data.Assets) end)
local SaveModule pcall(function() SaveModule = require(RS.Shared.Save) end)
pcall(function() EggToolDisplay = require(RS.Shared.Eggs.EggToolDisplay) end)
pcall(function() AreaEggSlotIdentity = (RS:FindFirstChild("Shared") and RS.Shared:FindFirstChild("Util") and require(RS.Shared.Util.AreaEggSlotIdentity)) or (RS:FindFirstChild("Util") and require(RS.Util.AreaEggSlotIdentity)) or (RS:FindFirstChild("Shared") and RS.Shared:FindFirstChild("Utils") and require(RS.Shared.Utils.AreaEggSlotIdentity)) end)

local function GetNetRemote(name)
local net = RS:FindFirstChild("Packages") and RS.Packages:FindFirstChild("Networking")
return net and net:FindFirstChild(name)
end

local function GetLocalSlot()
if PlotState and PlotState.ResolveLocalSlot then
local ok, slot = pcall(PlotState.ResolveLocalSlot)
if ok and slot then return slot end
end
return 1
end

local function GetLocalPlotCenter()
local plotObj = PlotState and PlotState.ResolvePlot and PlotState.ResolvePlot()
local pt = plotObj and plotObj.CenterPoint and (typeof(plotObj.CenterPoint) == "Vector3" and plotObj.CenterPoint or (plotObj.CenterPoint:IsA("BasePart") and plotObj.CenterPoint.Position))
if pt then return Vector3.new(pt.X, math.max(pt.Y, 70.4), pt.Z), CFrame.new(pt.X, math.max(pt.Y, 70.4), pt.Z) end
return Vector3.new(464.7, 70.4, -364.0), CFrame.new(464.7, 70.4, -364.0)
end

-- ==============================================================================
-- CLEAN ROAD & FLIGHT PATH NAVIGATION
-- ==============================================================================
local MAIN_ROAD_Z = -364.5
local stealMovementMethod = "Tween Glide"
local avoidTrapsEnabled = true
local autoClaimMonsterChests = false
local autoFeedMonster = false
local glideSpeed = 750

local function heartbeatTP(cframeTarget, holdTime)
local root = findHRP() if not root then return end
local char = LP.Character
if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then pcall(function() part.CanCollide = false end) end end end
local conn
conn = RunService.Heartbeat:Connect(function()
local r = findHRP() if r and r.Parent then r.CFrame = cframeTarget r.AssemblyLinearVelocity = Vector3.zero r.AssemblyAngularVelocity = Vector3.zero end
end)
task.wait(holdTime or 0.25)
if conn then conn:Disconnect() end
local r2 = findHRP() if r2 then r2.CFrame = cframeTarget r2.AssemblyLinearVelocity = Vector3.zero r2.AssemblyAngularVelocity = Vector3.zero end
end

local BYPASS_FLOAT_HEIGHT = 6.7
local BYPASS_LEG_OFFSET = Vector3.new(0, -6.7, 0)
local BYPASS_TP_OFFSET = Vector3.new(0, 6.7, 0)

local function bypassReturnTP(safeCFrame, holdTime)
local hrp = findHRP() if not hrp then return false end
local targetPart = Workspace:FindFirstChild("SpawnLocation", true)
if not targetPart or not targetPart:IsA("BasePart") then heartbeatTP(safeCFrame, holdTime or 0.3) return true end
pcall(function() targetPart.CanCollide = false end)
local char = LP.Character
if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then pcall(function() part.CanCollide = false end) end end end
local conn
conn = RunService.Heartbeat:Connect(function()
local r = findHRP() if not r or not r.Parent then return end
pcall(function() targetPart.CFrame = r.CFrame * CFrame.new(BYPASS_LEG_OFFSET) end)
r.CFrame = safeCFrame + BYPASS_TP_OFFSET
r.AssemblyLinearVelocity = Vector3.zero r.AssemblyAngularVelocity = Vector3.zero
pcall(function() targetPart.CFrame = safeCFrame end)
end)
task.wait(holdTime or 0.35)
if conn then conn:Disconnect() end
local r2 = findHRP() if r2 then r2.CFrame = safeCFrame r2.AssemblyLinearVelocity = Vector3.zero r2.AssemblyAngularVelocity = Vector3.zero end
return true
end

local function restoreCollisions()
local char = LP.Character if not char or not char.Parent then return end
for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end end
end

local function NeutralizeTraps()
local debris = Workspace:FindFirstChild("__DEBRIS") if not debris then return end
for _, d in ipairs(debris:GetChildren()) do
if d.Name == "PlayerTrap" and d:GetAttribute("Owner") ~= LP.Name then
if d:IsA("BasePart") then d.CanTouch = false d.CanQuery = false end
for _, c in ipairs(d:GetChildren()) do
if c:IsA("BasePart") then c.CanTouch = false c.CanQuery = false if c.Name == "Hitbox" then c.CFrame = CFrame.new(0, -999, 0) end end
end
local tt = d:FindFirstChildWhichIsA("TouchTransmitter", true) if tt then pcall(function() tt:Destroy() end) end
end
end
end

local function MoveToPoint(target, speed, easeOut)
local hrp = findHRP() if not hrp or not target then return false end
local start = hrp.Position local dist = (target - start).Magnitude
if dist < 1.0 then hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z) return true end
speed = math.clamp(tonumber(speed) or 750, 50, 750)
local t0 = os.clock() local totalDist = dist
while not HUB.dead do
local dt = RunService.Heartbeat:Wait() local curPos = hrp.Position local toTarget = target - curPos local remain = toTarget.Magnitude
if remain < 1.0 then break end
local stepSpeed = speed
if easeOut then local progress = 1 - math.clamp(remain / totalDist, 0, 1) stepSpeed = math.max(speed * (1 - progress * 0.8), 35) end
local step = math.min(stepSpeed * dt, remain) local dir = toTarget.Unit local nextPos = curPos + dir * step
hrp.CFrame = CFrame.lookAt(nextPos, nextPos + dir) hrp.AssemblyLinearVelocity = Vector3.zero hrp.AssemblyAngularVelocity = Vector3.zero
if os.clock() - t0 > (totalDist / 50 + 5) then break end
end
hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z) return true
end

local function FlyToPoint(target, speed, easeOut)
local hrp = findHRP() if not hrp or not target then return false end
local start = hrp.Position local dist = (target - start).Magnitude
if dist < 1.0 then hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z) return true end
speed = math.clamp(tonumber(speed) or 750, 50, 750)
local moveTime = math.max(dist / speed, 0.02) if easeOut then moveTime = moveTime * 1.25 end
local t0 = os.clock() local delta = target - start local dir = delta.Magnitude > 0.001 and delta.Unit or Vector3.new(1, 0, 0)
while os.clock() - t0 < moveTime and not HUB.dead do
local dt = RunService.Heartbeat:Wait() local linearAlpha = math.clamp((os.clock() - t0) / moveTime, 0, 1) local a = linearAlpha
if easeOut then a = math.sin(linearAlpha * (math.pi / 2)) end
local cur = start:Lerp(target, a) hrp.CFrame = CFrame.lookAt(cur, cur + dir)
local curSpeed = speed if easeOut then curSpeed = math.max(speed * (1 - linearAlpha * 0.8), 35) end
hrp.AssemblyLinearVelocity = Vector3.new(dir.X * curSpeed, math.clamp(dir.Y * curSpeed, -15, 150), dir.Z * curSpeed) hrp.AssemblyAngularVelocity = Vector3.zero
end
hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z) return true
end

local SAFE_BOUNDARY_X = 580 local SAFE_ZONE_SPEED = 245
local function TravelRoadPath(targetPos, speed, isApproach)
local hrp = findHRP() if not hrp or not targetPos then return false end
if avoidTrapsEnabled then pcall(NeutralizeTraps) end
local startPos = hrp.Position local safeY = math.max(startPos.Y, targetPos.Y, 70.4) local isReturningToBase = (targetPos.X < 560)
if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
MoveToPoint(Vector3.new(startPos.X, safeY, MAIN_ROAD_Z), speed, false)
MoveToPoint(Vector3.new(SAFE_BOUNDARY_X, safeY, MAIN_ROAD_Z), speed, false)
MoveToPoint(Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z), SAFE_ZONE_SPEED, false)
MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), SAFE_ZONE_SPEED, isApproach == true)
return true
else
MoveToPoint(Vector3.new(startPos.X, safeY, MAIN_ROAD_Z), speed, false)
MoveToPoint(Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z), speed, false)
MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), speed, isApproach == true)
return true
end
end

local function TravelFlyDirect(targetPos, speed, isApproach)
local hrp = findHRP() if not hrp or not targetPos then return false end
if avoidTrapsEnabled then pcall(NeutralizeTraps) end
local startPos = hrp.Position local isReturningToBase = (targetPos.X < 560) local flyAltitude = math.max(startPos.Y, targetPos.Y, 70.4) + 28
if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
FlyToPoint(Vector3.new(startPos.X, flyAltitude, startPos.Z), speed, false)
FlyToPoint(Vector3.new(SAFE_BOUNDARY_X, flyAltitude, MAIN_ROAD_Z), speed, false)
FlyToPoint(Vector3.new(SAFE_BOUNDARY_X, 70.4, MAIN_ROAD_Z), SAFE_ZONE_SPEED, false)
MoveToPoint(Vector3.new(targetPos.X, 70.4, MAIN_ROAD_Z), SAFE_ZONE_SPEED, false)
MoveToPoint(targetPos + Vector3.new(0, 1.2, 0), SAFE_ZONE_SPEED, isApproach == true)
return true
else
local totalDist = (targetPos - startPos).Magnitude
if totalDist < 25 then FlyToPoint(Vector3.new(targetPos.X, math.max(targetPos.Y, 70.0) + 1.2, targetPos.Z), speed, isApproach == true) return true end
FlyToPoint(Vector3.new(startPos.X, flyAltitude, startPos.Z), speed, false)
FlyToPoint(Vector3.new(targetPos.X, flyAltitude, targetPos.Z), speed, false)
FlyToPoint(Vector3.new(targetPos.X, math.max(targetPos.Y, 70.0) + 1.2, targetPos.Z), speed, isApproach == true)
return true
end
end

local function TravelSafeWalk(targetPos)
local hum = findHum() local hrp = findHRP() if not hum or not hrp or not targetPos then return false end
if avoidTrapsEnabled then pcall(NeutralizeTraps) end
local startPos = hrp.Position
for _, pt in ipairs({ Vector3.new(startPos.X, startPos.Y, MAIN_ROAD_Z), Vector3.new(targetPos.X, targetPos.Y, MAIN_ROAD_Z), targetPos + Vector3.new(0, 1.2, 0) }) do
if HUB.dead then break end hum:MoveTo(pt) local t0 = os.clock()
while (hrp.Position - pt).Magnitude > 4.5 and os.clock() - t0 < 5 and not HUB.dead do task.wait(0.05) end
end
return true
end

local function TravelToDestination(targetPos, speed, isApproach)
if stealMovementMethod == "Fly Glide" then return TravelFlyDirect(targetPos, speed, isApproach)
elseif stealMovementMethod == "Safe Walk" then return TravelSafeWalk(targetPos)
else return TravelRoadPath(targetPos, speed, isApproach) end
end

-- ==============================================================================
-- RARITY & AREA DICTIONARIES
-- ==============================================================================
local RARITY_SCORE_MAP = { ["Titan"] = 1100, ["Divine"] = 1000, ["Transcendent"] = 1000, ["Superior"] = 1000, ["Eternal"] = 900, ["Limited"] = 900, ["Secret"] = 800, ["Exotic"] = 800, ["Cosmic"] = 700, ["Exclusive"] = 700, ["Admin"] = 700, ["Mythic"] = 600, ["Mythical"] = 600, ["Prismatic"] = 600, ["Rainbow"] = 600, ["Squishy God"] = 600, ["BrainrotGod"] = 600, ["Legendary"] = 500, ["Epic"] = 400, ["Rare"] = 300, ["SuperRare"] = 200, ["Celestial"] = 200, ["Uncommon"] = 200, ["Basic"] = 100, ["Common"] = 100 }
local AREA_COORDINATES = { ["Base / Plot"] = Vector3.new(491.7, 70.4, -364.4), ["Stands & Shops"] = Vector3.new(539.5, 68.0, -364.5), ["Forest"] = Vector3.new(596.0, 68.0, -328.0), ["Lake"] = Vector3.new(744.0, 68.5, -408.0), ["Desert"] = Vector3.new(948.0, 69.5, -323.0), ["Jungle"] = Vector3.new(1188.0, 68.5, -408.0), ["Snow"] = Vector3.new(1492.0, 69.0, -315.0), ["Volcano"] = Vector3.new(1882.0, 68.0, -398.0), ["Abyss Ocean"] = Vector3.new(2280.0, 68.0, -326.0), ["Prehistoric"] = Vector3.new(2812.0, 69.0, -398.0), ["Cosmic"] = Vector3.new(3390.0, 68.0, -324.0), ["Cherry Blossom"] = Vector3.new(4028.0, 68.5, -396.0), ["Titan Temple"] = Vector3.new(4796.0, 69.5, -328.0), ["Monster Event"] = Vector3.new(539.5, 68.0, -411.3), ["Dragon Event"] = Vector3.new(539.5, 68.0, -318.0) }
local AREA_NAMES = { "Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano", "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple", "Monster Event", "Dragon Event" }
local RARITY_NAMES = { "Titan", "Divine", "Superior", "Eternal", "Limited", "Secret", "Exotic", "Cosmic", "Exclusive", "Mythic", "Rainbow", "Squishy God", "Legendary", "Epic", "Rare", "Uncommon", "Common" }
local MUTATION_FILTERS = { "Normal Only", "Mutated Only", "Parasite / Infested", "Rainbow Only", "Gold Only", "Silver Only", "Monstrous" }

-- Automation state
local autoStealEnabled = false local rareEggHunter = true local stealParasiteOnly = false local stealBigEggsOnly = false
local selectedStealRarities = {} local selectedStealAreas = {} local selectedMutationTypes = {}
local stealDelay = 1.5 local ignoredEggs = {} local savedReturnCFrame = nil
local autoHatchEnabled = false local autoPlantEnabled = false local hatchCheckDelay = 2.0
local autoUpgradeBase = false local autoUpgradeTreadmill = false local autoBuyTrails = false local autoEquipBestPets = false local autoClaimRewards = false
local autoSellPets = false local autoSellEggs = false local selectedSellPetRarities = {} local selectedSellEggRarities = {}
local DEFAULT_LOW_TIER_SELL = { ["Common"] = true, ["Uncommon"] = true, ["Rare"] = true, ["Epic"] = true, ["Legendary"] = true, ["Mythic"] = true }
local SELL_REQUEST_DELAY = 0.1 local instantPickupEnabled = true local noKnockbackEnabled = true
local batAuraEnabled = false local batAuraRadius = 20 local batAuraDelay = 0.2 local antiRagdollEnabled = true

local function GetEggRarityInfo(egg)
if not egg then return "Common", 100 end
if egg.Rarity then
local r = egg.Rarity local name = type(r) == "table" and (r.DisplayName or r._id or r.Name) or tostring(r)
return name, RARITY_SCORE_MAP[name] or 100
end
local cat = egg.AssetCategory or egg.Category or egg.Name
if cat and AssetsData then
local assetsDir = AssetsData.Directory or AssetsData local aInfo = assetsDir[cat]
if aInfo and aInfo.Rarity then
local r = aInfo.Rarity local name = type(r) == "table" and (r.DisplayName or r._id or r.Name) or tostring(r)
return name, RARITY_SCORE_MAP[name] or 100
end
end
return "Common", 100
end

local function isRarityAllowed(rarityName, filter)
if not filter or next(filter) == nil then return true end
return filter[rarityName] == true
end

local function isAreaAllowed(areaId, filter)
if not filter or next(filter) == nil then return true end
return filter[areaId] == true
end

local function isMutationAllowed(muts, record, filter)
local isParasite = (record and record.HasParasite == true) or (type(muts) == "table" and (table.find(muts, "Parasite") or table.find(muts, "Monstrous")))
if stealParasiteOnly and not isParasite then return false end
if not filter or next(filter) == nil then return true end
local hasMut = type(muts) == "table" and #muts > 0
for _, opt in pairs(filter) do
if opt == "Normal Only" and not hasMut and not isParasite then return true
elseif opt == "Mutated Only" and (hasMut or isParasite) then return true
elseif (opt == "Parasite / Infested" or opt == "Monstrous") and isParasite then return true end
end
return false
end

local function GetMatchingFieldEggs(areasFilter, raritiesFilter, mutationsFilter)
if not EggState or not EggState.ReadFieldEggs then return {} end
local ok, snapshot = pcall(EggState.ReadFieldEggs) if not ok or not snapshot or not snapshot.Records then return {} end
local matched = {}
for _, record in ipairs(snapshot.Records) do
if record.State == "Slot" and record.BoundsCFrame then
if not (ignoredEggs[record.Uid] and (os.clock() - ignoredEggs[record.Uid] < 2.5)) then
local areaOk = isAreaAllowed(record.AreaId, areasFilter)
local rarityName, baseScore = GetEggRarityInfo(record)
local rarityOk = isRarityAllowed(rarityName, raritiesFilter)
local muts = record.Mutations or {}
if areaOk and rarityOk and isMutationAllowed(muts, record, mutationsFilter) then
table.insert(matched, { record = record, rarity = rarityName, score = baseScore })
end
end
end
end
if #matched > 1 then table.sort(matched, function(a, b) return a.score > b.score end) end
return matched
end

local function EnsureSavedReturnPosition()
if not savedReturnCFrame then local hrp = findHRP() if hrp then savedReturnCFrame = hrp.CFrame end end
end

local function isPlayerCarryingEgg()
local pg = LP:FindFirstChildOfClass("PlayerGui")
if pg and pg:FindFirstChild("DropHeldEgg") and pg.DropHeldEgg.Enabled then return true end
local char = LP.Character
if char then
for _, t in ipairs(char:GetChildren()) do
if t:IsA("Model") and (t.Name:lower():find("egg") or t:GetAttribute("Uid")) then return true end
if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then return true end
end
end
return false
end

local function PlantAllCarriedEggsInPen()
local toolsToPlant = {}
for _, t in ipairs(LP.Character:GetChildren()) do
if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
local uid = EggToolDisplay.GetToolUid(t) if uid then table.insert(toolsToPlant, uid) end
end
end
for _, t in ipairs(LP.Backpack:GetChildren()) do
if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
local uid = EggToolDisplay.GetToolUid(t) if uid then table.insert(toolsToPlant, uid) end
end
end
local plantedCount = 0
for _, eggUid in ipairs(toolsToPlant) do
local offset = CFrame.new(math.random(-6, 6), 0, math.random(-6, 6))
local ok, res = pcall(function() return EggState and EggState.PlantEgg and EggState.PlantEgg(eggUid, offset) end)
if ok and res then plantedCount = plantedCount + 1 end
end
return plantedCount
end

local function HatchAllReadyEggs()
if not EggState or not EggState.ReadOwnedEggs then return 0 end
local ok, snapshot = pcall(EggState.ReadOwnedEggs, LP.UserId) if not ok or not snapshot then return 0 end
local count = 0 local records = snapshot.Records or snapshot
if typeof(records) == "table" then
for uid, eggData in pairs(records) do
if typeof(eggData) == "table" and (eggData.Placement ~= nil) then
pcall(function()
if EggState.BeginHatch then EggState.BeginHatch(uid) end task.wait(0.05)
if EggState.FinishHatch then EggState.FinishHatch(uid) end count = count + 1
end)
end
end
end
return count
end

local function StealSpecificEggRobust(targetItem)
local record = targetItem.record or targetItem if not record or not record.Uid or not record.BoundsCFrame then return false end
local hrp = findHRP() if not hrp then return false end EnsureSavedReturnPosition()
local targetPos = record.BoundsCFrame.Position local isInstantTP = (stealMovementMethod == "Anti Guard")

TravelToDestination(targetPos + Vector3.new(0, 1.2, 0), glideSpeed, true)
task.wait(isInstantTP and 0.25 or 0.5)

local slotKey = AreaEggSlotIdentity and AreaEggSlotIdentity.LooksLikeFirstAreaUid and AreaEggSlotIdentity.LooksLikeFirstAreaUid(record.Uid) and AreaEggSlotIdentity.SlotKey(record.AreaId, record.NestId)
local carryRemote = GetNetRemote("RF/EggWorld/AskFieldEggCarry")
if carryRemote then pcall(function() carryRemote:InvokeServer({ Uid = record.Uid, FirstAreaSlotKey = slotKey }) end) end

local safePlotCenter = GetLocalPlotCenter() local safeCFrame = CFrame.new(safePlotCenter + Vector3.new(0, 1.2, 0))
if isInstantTP then bypassReturnTP(safeCFrame, 0.35) restoreCollisions() PlantAllCarriedEggsInPen() return true end

TravelToDestination(safePlotCenter, SAFE_ZONE_SPEED, true)
PlantAllCarriedEggsInPen() return true
end

local function StealBestEggOnce()
pcall(HatchAllReadyEggs)
local eggs = GetMatchingFieldEggs(selectedStealAreas, selectedStealRarities, selectedMutationTypes)
if #eggs == 0 then return false end
return StealSpecificEggRobust(eggs[1])
end

-- ==============================================================================
-- BASE, HOMESTEAD & REWARDS AUTOMATION LOGIC
-- ==============================================================================
local function UpgradeHomesteadBase()
local re1 = GetNetRemote("RE/Homestead/AskNearbyPurchase") if re1 then re1:FireServer() end
local re2 = GetNetRemote("RE/Homestead/AskBaseTierRaise") if re2 then re2:FireServer() end
end

local function UpgradeTreadmillTier() local rf = GetNetRemote("RF/Treadmill/AskTierRaise") if rf then rf:InvokeServer() end end
local function EquipBestPets() local rf = GetNetRemote("RF/Haul/WearBest") or GetNetRemote("RF/PenRoster/ConfirmEquipBestBadge") if rf then rf:InvokeServer() end end
local function ClaimMonsterChests() local rf1 = GetNetRemote("RF/MonsterParasite/AskChestClaim") if rf1 then rf1:InvokeServer() end end

local function SellSelectedPets()
local re = GetNetRemote("RE/PetSatchel/SellPet") if not re or not SaveModule then return end
local save = SaveModule.Get and SaveModule.Get() local inv = save and save.Inventory if type(inv) ~= "table" then return end
for uid, petData in pairs(inv) do
if type(petData) == "table" and not petData.Locked and isRarityAllowed(petData.Rarity or "Common", selectedSellPetRarities) then
re:FireServer(uid) task.wait(0.08)
end
end
end

local function SellSelectedEggs()
if not SaveModule then return end local save = SaveModule.Get and SaveModule.Get() if not save or type(save.EggInventory) ~= "table" then return end
local wear = GetNetRemote("RF/EggWorld/AskWearTool") local sell = GetNetRemote("RE/PetSatchel/SellPet") if not wear or not sell then return end
for uid, eggData in pairs(save.EggInventory) do
if type(eggData) == "table" and not eggData.Placement and not eggData.Locked then
local rName = GetEggRarityInfo(eggData)
if isRarityAllowed(rName, selectedSellEggRarities) then wear:InvokeServer(uid) sell:FireServer({ uid }) task.wait(SELL_REQUEST_DELAY) end
end
end
end

local function ClaimAllAvailableRewards()
pcall(function() local rf = GetNetRemote("RF/AwayEarnings/AskCollect") if rf then rf:InvokeServer() end end)
pcall(function() local rf = GetNetRemote("RF/Codex/AskRedeemAll") if rf then rf:InvokeServer() end end)
pcall(ClaimMonsterChests)
end

-- ==============================================================================
-- LOOPS & WORKERS
-- ==============================================================================
task.spawn(function() while not HUB.dead do if autoStealEnabled then pcall(StealBestEggOnce) end task.wait(stealDelay) end end)
task.spawn(function() while not HUB.dead do if autoHatchEnabled then pcall(HatchAllReadyEggs) end if autoPlantEnabled then pcall(PlantAllCarriedEggsInPen) end task.wait(hatchCheckDelay) end end)
task.spawn(function()
while not HUB.dead do
if autoUpgradeBase then pcall(UpgradeHomesteadBase) end
if autoUpgradeTreadmill then pcall(UpgradeTreadmillTier) end
if autoEquipBestPets then pcall(EquipBestPets) end
if autoClaimRewards then pcall(ClaimAllAvailableRewards) end
if autoSellPets then pcall(SellSelectedPets) end
if autoSellEggs then pcall(SellSelectedEggs) end
task.wait(2.5)
end
end)

-- ==============================================================================
-- VISUALS & ESP
-- ==============================================================================
local esp = { enabled = false, eggs = true, traps = false, players = false, maxDistance = 800 }
local trackedEspObjects = {}

local function createDrawingObject()
if not Drawing then return {} end
local o = {}
o.name = trackDrawing(Drawing.new("Text")) o.name.Size = 13 o.name.Center = true o.name.Outline = true o.name.Visible = false
o.dist = trackDrawing(Drawing.new("Text")) o.dist.Size = 11 o.dist.Center = true o.dist.Outline = true o.dist.Visible = false
return o
end

track(RunService.RenderStepped:Connect(function()
if HUB.dead or not esp.enabled then
for _, obj in pairs(trackedEspObjects) do if obj.name then obj.name.Visible = false end if obj.dist then obj.dist.Visible = false end end
return
end
local hrp = findHRP() local myPos = hrp and hrp.Position or Vector3.zero local cam = GetCamera() if not cam then return end
local renderItems = {}

if esp.eggs and EggState and EggState.ReadFieldEggs then
local ok, snap = pcall(EggState.ReadFieldEggs)
if ok and snap and snap.Records then
for _, egg in ipairs(snap.Records) do
if egg.State == "Slot" and egg.BoundsCFrame then
local pos = egg.BoundsCFrame.Position local dist = (pos - myPos).Magnitude
if dist <= esp.maxDistance then
local rName = GetEggRarityInfo(egg)
table.insert(renderItems, { Key = egg.Uid, Pos = pos, Name = (egg.AssetCategory or "Egg") .. " (" .. rName .. ")", Color = Color3.fromRGB(255, 200, 50), Dist = dist })
end
end
end
end
end

local activeKeys = {}
for _, item in ipairs(renderItems) do
activeKeys[item.Key] = true local obj = trackedEspObjects[item.Key] or createDrawingObject() trackedEspObjects[item.Key] = obj
local screenPos, onScreen = cam:WorldToViewportPoint(item.Pos)
if onScreen and obj.name and obj.dist then
obj.name.Text = item.Name obj.name.Position = Vector2.new(screenPos.X, screenPos.Y - 14) obj.name.Color = item.Color obj.name.Visible = true
obj.dist.Text = math.floor(item.Dist) .. " studs" obj.dist.Position = Vector2.new(screenPos.X, screenPos.Y + 2) obj.dist.Visible = true
else
if obj.name then obj.name.Visible = false end if obj.dist then obj.dist.Visible = false end
end
end
for k, obj in pairs(trackedEspObjects) do if not activeKeys[k] then if obj.name then obj.name.Visible = false end if obj.dist then obj.dist.Visible = false end end end
end))

-- Fullbright
local fullbrightEnabled = false
local function SetFullbright(v)
fullbrightEnabled = v
if v then Lighting.Ambient = Color3.fromRGB(255, 255, 255) Lighting.Brightness = 2 else Lighting.Ambient = Color3.fromRGB(130, 130, 130) end
end

-- ==============================================================================
-- MOVEMENT MODIFIERS
-- ==============================================================================
local walkSpeedEnabled, walkSpeedVal = false, 24
local jumpPowerEnabled, jumpPowerVal = false, 60
local flying, flySpeed = false, 60

track(RunService.Stepped:Connect(function()
local hum = findHum() if not hum then return end
if walkSpeedEnabled then hum.WalkSpeed = walkSpeedVal end
if jumpPowerEnabled then hum.UseJumpPower = true hum.JumpPower = jumpPowerVal end
end))

local function startFly()
local hrp = findHRP() if not hrp then return end flying = true hrp.Anchored = true
local bg = Instance.new("BodyGyro") bg.MaxTorque = Vector3.new(1,1,1)*1e5 bg.P = 1e5 bg.CFrame = hrp.CFrame bg.Parent = hrp
HUB._fly = {
conn = track(RunService.RenderStepped:Connect(function(dt)
local cam = GetCamera() if not cam or not flying then return end
local dir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
if dir.Magnitude > 0 then hrp.CFrame = hrp.CFrame + dir.Unit * flySpeed * dt end
bg.CFrame = cam.CFrame
end)),
gyro = bg, hrp = hrp
}
end

local function stopFly() flying = false if HUB._fly then pcall(function() HUB._fly.conn:Disconnect() HUB._fly.hrp.Anchored = false HUB._fly.gyro:Destroy() end) HUB._fly = nil end end

-- ==============================================================================
-- GUI TABS CREATION & CONFIGURATION
-- ==============================================================================
local EggsTab = Window:AddTab({ Name = "Eggs", Subtitle = "Steal, hatch & plant", Icon = "crown" })
local BaseTab = Window:AddTab({ Name = "Base", Subtitle = "Homestead & training", Icon = "bolt" })
local CombatTab = Window:AddTab({ Name = "Combat", Subtitle = "Bat, slaps & defense", Icon = "combat" })
local PlayerTab = Window:AddTab({ Name = "Player", Subtitle = "Movement & teleports", Icon = "player" })
local SettingsTab = Window:AddTab({ Name = "Settings", Subtitle = "Configs & unloader", Icon = "gear" })

-- TAB 1: EGGS
local StealSub = EggsTab:AddSubTab("Auto Steal")
local HatchSub = EggsTab:AddSubTab("Auto Hatch & Plant")
local EggEspSub = EggsTab:AddSubTab("Egg Tracker ESP")

StealSub:AddToggle({ Name = "Auto Steal Eggs", Default = false, Flag = "steal_auto", Callback = function(v) autoStealEnabled = v EnsureSavedReturnPosition() end })
StealSub:AddDropdown({ Name = "Movement Method", Options = { "Tween Glide", "Fly Glide", "Safe Walk", "Anti Guard" }, Default = "Tween Glide", Flag = "steal_method", Callback = function(v) stealMovementMethod = v end })
StealSub:AddMultiDropdown({ Name = "Rarities Filter", Options = RARITY_NAMES, Default = {}, Flag = "steal_rarities", Callback = function(s) selectedStealRarities = s end })
StealSub:AddMultiDropdown({ Name = "Areas Filter", Options = AREA_NAMES, Default = {}, Flag = "steal_areas", Callback = function(s) selectedStealAreas = s end })
StealSub:AddSlider({ Name = "Glide Speed", Min = 50, Max = 750, Default = 750, Suffix = " studs/s", Flag = "glide_speed", Callback = function(v) glideSpeed = v end })

HatchSub:AddToggle({ Name = "Auto Hatch Ready Eggs", Default = false, Flag = "hatch_auto", Callback = function(v) autoHatchEnabled = v end })
HatchSub:AddToggle({ Name = "Auto Place Egg (Base Pen)", Default = false, Flag = "plant_auto", Callback = function(v) autoPlantEnabled = v end })

EggEspSub:AddToggle({ Name = "Egg ESP Enabled", Default = false, Flag = "esp_eggs_enabled", Callback = function(v) esp.enabled = v end })

-- TAB 2: BASE
local UpgradesSub = BaseTab:AddSubTab("Homestead")
local SalesSub = BaseTab:AddSubTab("Auto Sell")
UpgradesSub:AddToggle({ Name = "Auto Upgrade Base", Default = false, Flag = "up_base_auto", Callback = function(v) autoUpgradeBase = v end })
UpgradesSub:AddToggle({ Name = "Auto Upgrade Treadmill", Default = false, Flag = "up_tread_auto", Callback = function(v) autoUpgradeTreadmill = v end })
SalesSub:AddToggle({ Name = "Auto Sell Pets", Default = false, Flag = "auto_sell_pets", Callback = function(v) autoSellPets = v end })

-- TAB 3: COMBAT
local GuardSub = CombatTab:AddSubTab("Defense")
GuardSub:AddToggle({ Name = "Anti-Trap Immunity", Default = true, Flag = "avoid_traps", Callback = function(v) avoidTrapsEnabled = v end })

-- TAB 4: PLAYER
local MoveSub = PlayerTab:AddSubTab("Movement")
local PerfSub = PlayerTab:AddSubTab("Performance")
MoveSub:AddToggle({ Name = "Enable WalkSpeed", Default = false, Flag = "speed_enabled", Callback = function(v) walkSpeedEnabled = v end })
MoveSub:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 500, Default = 24, Flag = "speed_val", Callback = function(v) walkSpeedVal = v end })
MoveSub:AddToggle({ Name = "Smooth Fly", Default = false, Flag = "fly_enabled", Callback = function(v) if v then startFly() else stopFly() end end })
PerfSub:AddToggle({ Name = "Fullbright", Default = false, Flag = "fullbright", Callback = function(v) SetFullbright(v) end })

-- TAB 5: SETTINGS
local ConfigSub = SettingsTab:AddSubTab("Configuration")
ConfigSub:AddButton({ Name = "Unload Oxide HUB", Callback = function() HUB.Unload() end })

-- ==============================================================================
-- CLEANUP HANDLER
-- ==============================================================================
HUB.Unload = function()
HUB.dead = true
for _, c in ipairs(HUB.conns) do pcall(function() c:Disconnect() end) end
for _, d in ipairs(HUB.drawings) do pcall(function() d:Remove() end) end
stopFly() SetFullbright(false)
local hum = findHum() if hum then hum.WalkSpeed = 16 end
pcall(function() Window:Destroy() end)
_G.OxideStealAnEgg = nil
Notify("Oxide HUB", "Unloaded successfully!", "Success")
end

Notify("Oxide HUB", "Ein Ei stehlen script loaded successfully!", "Success", 3.5)

