// 					Severe						

local Mods = {
    "i0gc", "Aadenxox2", "Puhgee", "Regrater", "Rikumah", "FallenToast12", "Hisitox", "Gen5Turbo",
    "Lastgueston_earth", "JustSynnnn", "Kazusaki", "VeronicaLadyy", "Froggerrrrboi", "h9teful",
    "Not_Stormzy", "BryPon_YT", "zemqs", "GuyOne311", "SpaJzrer", "yolo_KL221", "efdeepppp",
    "MercilessBanditTaken", "0dneyray", "Lost_Test", "MiniatureSigy", "KittenBagelz", "Here4Money2", "PingTheChad",
    "david123456ro", "Master_nerdwhaI", "Chezz1946", "CeleronD_Rus2", "Edvard_As",
    "neddleduck", "YTGonzo", "Warm_Vibes", "AsianAbrex", "PreSpawns"
}
local modDrawings = {}
local displayedMods = {}
local function createModDrawing(playerName, index)
    local drawing = Drawing.new("Text")
    drawing.Text = playerName .. " is in the server"
    drawing.Size = 20
    drawing.Color = {255, 255, 255}
    drawing.Outline = true
    drawing.OutlineColor = {0, 0, 0}
    drawing.Position = {10, 200 + (index * 25)}
    drawing.Visible = true
    return drawing
end
local function clearDrawings()
    for _, drawing in pairs(modDrawings) do
        drawing:Remove()
    end
    modDrawings = {}
end
local function ModCheck()
    local workspace = findservice(Game, "Workspace")
    local index = 0
    for _, playerName in ipairs(Mods) do
        local player = findfirstchild(workspace, playerName)
        if player and not displayedMods[playerName] then
            index = index + 1
            modDrawings[playerName] = createModDrawing(playerName, index)
            displayedMods[playerName] = true
        end
    end
end
local function mainLoop()
    while true do
        ModCheck()
        wait(5)
        clearDrawings()
        wait(5)
    end
end
spawn(mainLoop)

	--[[ SETTINGS ]]--
local ESPConfig = {
    NameColor = {255, 255, 255},
    ArmorYesColor = {255, 255, 255},
    ArmorNoColor = {255, 255, 255}, 
    HazmatColor = {255, 255, 255},
    AttachmentColor = {255, 255, 255},
    OutlineColor = {0, 0, 0},
    renderDistance = 500,
    updateInterval = 3.0,
    renderInterval = 0.01,
    offsets = {
        x = -10,
        nameX = -21,
        nameY = 4,
        kittedY = -8,
        attachmentY = 16,
        minYOffset = 0,
        maxYOffset = 20
    }
}

local Workspace = getchildren(Game)[1]
local localPlayer = getlocalplayer()
local PlayersESP = {}
local inHand = {
    ["Salvaged AK47"] = true, ["Salvaged M14"] = true, ["Boulder"] = true, ["Salvaged SMG"] = true, ["Salvaged RPG"] = true,
    ["Military M4A1"] = true, ["Military Barrett"] = true, ["Small Medkit"] = true, ["Salvaged P250"] = true, ["Bandage"] = true,
    ["Crossbow"] = true, ["Wooden Bow"] = true, ["Nail Gun"] = true, ["Salvaged Pump Shotgun"] = true, ["Salvaged Break Action"] = true,
    ["Bruno's M4A1"] = true, ["Salvaged Python"] = true, ["Lighter"] = true, ["Stone Pickaxe"] = true, ["Stone Hatchet"] = true, ["Stone Spear"] = true,
    ["Wooden Spear"] = true, ["Machete"] = true, ["Hammer"] = true, ["Salvaged Skorpion"] = true, ["Military MP7"] = true, ["Timed Charge"] = true,
    ["Mining Drill"] = true, ["Steel Pickaxe"] = true, ["Steel Axe"] = true, ["Building Plan"] = true, ["Grenade"] = true, ["Salvaged Ak74u"] = true,
    ["Chainsaw"] = true, ["Dynamite Bundle"] = true, ["Military PKM"] = true, ["External Wooden Wall"] = true, ["External Stone Wall"] = true,
    ["Metal Barricade"] = true, ["Small Storage Box"] = true, ["Base Cabinet"] = true, ["Dynamite Stick"] = true, ["Salvaged Pipe Rifle"] = true,
    ["Bone Tool"] = true, ["Saw Bat"] = true, ["Shotgun Trap"] = true, ["Salvaged AK74u"] = true, ["Iron Shard Pickaxe"] = true,
    ["Iron Shard Hatchet"] = true, ["Military USP"] = true,
}
local function isModelOrPart(inst)
    local className = getclassname(inst)
    return className == "Model" or className == "Part" or className == "MeshPart" or className == "Camera"
end
local localHrp = nil
local function updateLocalHrp()
    local char = getcharacter(localPlayer)
    local rootPart = char and findfirstchild(char, "HumanoidRootPart")
    localHrp = rootPart and isModelOrPart(rootPart) and rootPart or nil
end
local function getModelInfo(playerModel, playerHealth)
    local modelName, kittedStatus, attachments = "", "[Armor : No]", {}
    local children = getchildren(playerModel)
    local attachmentNames = {
        ["Holo Sight"] = "Holo",
        ["Weapon Flashlight"] = "Light",
        ["Military Lasersight"] = "Lasersight",
        ["Salvaged Lasersight"] = "Lasersight",
        ["Extended Mag"] = "Extended",
        ["Military Acog Sight"] = "Acog",
        ["Salvaged Sight"] = "Salv Sight",
        ["Salvaged Sniper Scope"] = "Sniper Scope",
        ["Military Sniper Scope"] = "Sniper Scope"
    }
    local armors = {
        ["Armor_60"] = "Haz Suit",
        ["Armor_149"] = "MC",
        ["Armor_123"] = "WH",
        ["Armor_125"] = "WL",
        ["Armor_124"] = "WC",
        ["Armor_223"] = "BH",
        ["Armor_222"] = "BC",
        ["Armor_143"] = "STL",
        ["Armor_141"] = "STH",
        ["Armor_142"] = "STC",
        ["Armor_145"] = "SLVGH",
        ["Armor_146"] = "SLVGC",
        ["Armor_147"] = "SLVGL",
        ["Armor_122"] = "FJ",
        ["Armor_159"] = "Wetsuit",
        ["Armor_150"] = "ML",
        ["Armor_151"] = "HH",
        ["Armor_272"] = "BOC",
        ["Armor_271"] = "BOH"
    }
    local foundArmors = {}
    if children then
        for _, item in ipairs(children) do
            if isModelOrPart(item) then
                local itemName = getname(item)
                if inHand[itemName] then 
                    modelName = itemName
                    local attachmentsFolder = findfirstchild(item, "Attachments")
                    if attachmentsFolder then
                        for _, attachment in ipairs(getchildren(attachmentsFolder)) do
                            if isModelOrPart(attachment) then
                                local attachmentName = getname(attachment)
                                local shortName = attachmentNames[attachmentName] or attachmentName
                                table.insert(attachments, shortName)
                            end
                        end
                    end
                end
                for armorPrefix, armorStatus in pairs(armors) do
                    if itemName:sub(1, #armorPrefix) == armorPrefix and not foundArmors[armorStatus] then
                        foundArmors[armorStatus] = true
                    end
                end
                if itemName:sub(1, 5) == "Armor" and next(foundArmors) == nil then
                    kittedStatus = "[Armor : Yes]"
                end
            end
        end
    end
    if next(foundArmors) ~= nil then
        local armorList = {}
        for armorStatus, _ in pairs(foundArmors) do
            if armorStatus ~= "Haz Suit" and armorStatus ~= "Wetsuit" then
                table.insert(armorList, armorStatus)
            end
        end
        table.sort(armorList, function(a, b)
            local order = {H = 1, C = 2, L = 3}
            local aOrder = order[a:sub(-1)] or (a == "FJ" and 2 or 4)
            local bOrder = order[b:sub(-1)] or (b == "FJ" and 2 or 4)
            if aOrder == bOrder then
                return a < b
            end
            return aOrder < bOrder
        end)
        if #armorList == 0 then
            if foundArmors["Haz Suit"] then
                table.insert(armorList, "Haz Suit")
            elseif foundArmors["Wetsuit"] then
                table.insert(armorList, "Wetsuit")
            end
        end
        kittedStatus = "[" .. table.concat(armorList, ", ") .. "]"
    end
    if kittedStatus == "[Armor : No]" and playerHealth < 60 then
        kittedStatus = "[Fresh Spawn]"
    end
    return modelName, kittedStatus, table.concat(attachments, ", ")
end
local function updateDrawPosAndSize(draw, pos, size)
    draw.Position = pos
    draw.Size = size
end
local function updatePlayerESP(player, rootPart, kittedStatus, modelName, attachments)
    local playerESP = PlayersESP[player]
    if not playerESP then
        local nameDraw, kitDraw, attachDraw = createDrawing()
        playerESP = {
            Part = rootPart,
            NameDrawing = nameDraw,
            KittedDrawing = kitDraw,
            AttachmentDrawing = attachDraw,
            Parent = player,
            LastUpdate = { Kitted = "", Attachments = "" },
            CurrentTargetModel = nil
        }
        PlayersESP[player] = playerESP
    end
    if playerESP.LastUpdate.Kitted == "[Fresh Spawn]" and modelName ~= "" then
        kittedStatus = "[Armor : No]"
    end
    if kittedStatus ~= playerESP.LastUpdate.Kitted then
        playerESP.KittedDrawing.Text = kittedStatus
        playerESP.KittedDrawing.Color = kittedStatus == "[Armor : Yes]" and ESPConfig.ArmorYesColor or
                                        kittedStatus == "[Haz Suit]" and ESPConfig.HazmatColor or
                                        ESPConfig.ArmorNoColor
        playerESP.LastUpdate.Kitted = kittedStatus
    end
    if attachments ~= playerESP.LastUpdate.Attachments then
        playerESP.AttachmentDrawing.Text = attachments ~= "" and "[" .. attachments .. "]" or ""
        playerESP.LastUpdate.Attachments = attachments
    end
    playerESP.CachedName = modelName
end
local function removePlayerESP(player)
    local data = PlayersESP[player]
    if data then
        data.NameDrawing:Remove()
        data.KittedDrawing:Remove()
        data.AttachmentDrawing:Remove()
        PlayersESP[player] = nil
    end
end
local function updatePlayers()
    local players = getchildren(Workspace) or {}
end
local function createDrawing()
    local function newText(size, color)
        local draw = Drawing.new("Text")
        draw.Size = size
        draw.Color = color
        draw.Center = false
        draw.Outline = true
        draw.OutlineColor = ESPConfig.OutlineColor
        return draw
    end
    return newText(13, ESPConfig.NameColor), newText(12, ESPConfig.OutlineColor), newText(11, ESPConfig.AttachmentColor)
end
local function updateDrawVisibility(data, visible)
    if data.NameDrawing.Visible ~= visible then
        data.NameDrawing.Visible = visible
        data.KittedDrawing.Visible = visible
        data.AttachmentDrawing.Visible = visible
    end
end
local function updateDrawPosAndSize(draw, pos, size)
    draw.Position = pos
    draw.Size = size
end
local function updatePlayerESP(player, rootPart, kittedStatus, modelName, attachments)
    local playerESP = PlayersESP[player]
    if not playerESP then
        local nameDraw, kitDraw, attachDraw = createDrawing()
        playerESP = {
            Part = rootPart,
            NameDrawing = nameDraw,
            KittedDrawing = kitDraw,
            AttachmentDrawing = attachDraw,
            Parent = player,
            LastUpdate = { Kitted = "", Attachments = "" },
            CurrentTargetModel = nil
        }
        PlayersESP[player] = playerESP
    end
    if kittedStatus ~= playerESP.LastUpdate.Kitted then
        playerESP.KittedDrawing.Text = kittedStatus
        playerESP.KittedDrawing.Color = kittedStatus == "[Armor : Yes]" and ESPConfig.ArmorYesColor or
                                        kittedStatus == "[Haz Suit]" and ESPConfig.HazmatColor or
                                        ESPConfig.ArmorNoColor
        playerESP.LastUpdate.Kitted = kittedStatus
    end
    if attachments ~= playerESP.LastUpdate.Attachments then
        playerESP.AttachmentDrawing.Text = attachments ~= "" and "[" .. attachments .. "]" or ""
        playerESP.LastUpdate.Attachments = attachments
    end
    playerESP.CachedName = modelName
end
local function removePlayerESP(player)
    local data = PlayersESP[player]
    if data then
        data.NameDrawing:Remove()
        data.KittedDrawing:Remove()
        data.AttachmentDrawing:Remove()
        PlayersESP[player] = nil
    end
end
local function updatePlayers()
    local players = getchildren(Workspace) or {}
    local updatedPlayers = {}
    local localChar = getcharacter(localPlayer)
    local localCharName = localChar and getname(localChar)
    for _, player in ipairs(players) do
        if isModelOrPart(player) and getname(player) ~= localCharName then
            local humanoid = findfirstchildofclass(player, "Humanoid")
            local rootPart = findfirstchild(player, "HumanoidRootPart")
            if humanoid and gethealth(humanoid) > 1 and rootPart and isModelOrPart(rootPart) then
                updatedPlayers[player] = true
                local modelName, kittedStatus, attachments = getModelInfo(player, gethealth(humanoid))
                updatePlayerESP(player, rootPart, kittedStatus, modelName, attachments)
            end
        end
    end
    for player, data in pairs(PlayersESP) do
        if not updatedPlayers[player] or not isModelOrPart(data.Parent) then
            removePlayerESP(player)
        else
            updateDrawVisibility(data, true)
        end
    end
end
local function waitForRespawn()
    while true do
        if not getcharacter(localPlayer) or not findfirstchild(getcharacter(localPlayer), "HumanoidRootPart") then
            repeat wait(1) until findfirstchild(getcharacter(localPlayer), "HumanoidRootPart")
            updateLocalHrp()
        end
        wait(ESPConfig.updateInterval)
    end
end
local function periodicUpdate()
    while true do
        updatePlayers()
        wait(2)
    end
end
spawn(periodicUpdate)
local function caching()
    if not localHrp then updateLocalHrp() end
    local localHrpPos = localHrp and getposition(localHrp)
    if not localHrpPos then return end
    local renderDistSq = ESPConfig.renderDistance * ESPConfig.renderDistance
    local updates = {}
    for player, data in pairs(PlayersESP) do
        local part = data.Part
        local parent = data.Parent
        local visible = false
        if part and parent and isModelOrPart(parent) and isModelOrPart(part) then
            local pos3D = getposition(part)
            if pos3D then
                local dx, dy, dz = localHrpPos.x - pos3D.x, localHrpPos.y - pos3D.y, localHrpPos.z - pos3D.z
                local distSq = dx * dx + dy * dy + dz * dz
                if distSq <= renderDistSq then
                    local distfactrPos2D = worldtoscreenpoint({pos3D.x, pos3D.y + 4, pos3D.z})
                    local distfacPos2D = worldtoscreenpoint({pos3D.x, pos3D.y - 3, pos3D.z})
                    table.insert(updates, {
                        data = data,
                        distfactrPosX = distfactrPos2D.x,
                        distfactrPosY = distfactrPos2D.y,
                        distfacPosX = distfacPos2D.x,
                        distfacPosY = distfacPos2D.y,
                        distSq = distSq
                    })
                    visible = true
                end
            end
        end
        updateDrawVisibility(data, visible)
    end
    return updates
end
local function renderESP(updates)
    for _, update in ipairs(updates) do
        local data = update.data
        local distSq = update.distSq
        local distance = math.sqrt(distSq)
        local scaling = math.max(0.75, 1 - (distance / ESPConfig.renderDistance) * 0.5)
        local distfactrPosX, distfactrPosY = update.distfactrPosX, update.distfactrPosY
        local distfacPosX, distfacPosY = update.distfacPosX, update.distfacPosY
        local yOffset = math.min(ESPConfig.offsets.maxYOffset, (distance / ESPConfig.renderDistance) * ESPConfig.offsets.maxYOffset)
        updateDrawPosAndSize(data.KittedDrawing, {distfacPosX + ESPConfig.offsets.nameX, distfacPosY + ESPConfig.offsets.kittedY + yOffset}, 12 * scaling)
        updateDrawPosAndSize(data.NameDrawing, {distfacPosX + ESPConfig.offsets.nameX, distfacPosY + ESPConfig.offsets.nameY + yOffset}, 14 * scaling)
        updateDrawPosAndSize(data.AttachmentDrawing, {distfacPosX + ESPConfig.offsets.nameX, distfacPosY + ESPConfig.offsets.nameY + ESPConfig.offsets.attachmentY + yOffset}, 11 * scaling)
        data.NameDrawing.Text = data.CachedName ~= "" and string.format("[%s]", data.CachedName) or ""
        data.KittedDrawing.Text = data.LastUpdate.Kitted
        data.AttachmentDrawing.Text = data.LastUpdate.Attachments ~= "" and "[" .. data.LastUpdate.Attachments .. "]" or ""
    end
end
local running = true
local debounce = false
local function stopLoops()
    running = false
    for _, data in pairs(PlayersESP) do
        data.NameDrawing:Remove()
        data.KittedDrawing:Remove()
        data.AttachmentDrawing:Remove()
    end
    PlayersESP = {}
end
local function sigmaLoop(func, interval)
    while running do
        local success, err = pcall(func)
        if not success then
            warn("Error in loop:", err)
        end
        wait(interval)
    end
end
local function endLoop()
    while running do
        if not debounce and getpressedkey() == "End" then
            debounce = true
            stopLoops()
            wait(2)
            running = true
            debounce = false
            spawn(function() sigmaLoop(updatePlayers, ESPConfig.updateInterval) end)
            spawn(function() sigmaLoop(function() renderESP(caching()) end, ESPConfig.renderInterval) end)
            spawn(endLoop)
            break
        end
        updateLocalHrp()
        wait(ESPConfig.updateInterval)
    end
end
spawn(function() sigmaLoop(updatePlayers, ESPConfig.updateInterval) end)
spawn(function() sigmaLoop(function() renderESP(caching()) end, ESPConfig.renderInterval) end)
spawn(endLoop)
spawn(waitForRespawn)
