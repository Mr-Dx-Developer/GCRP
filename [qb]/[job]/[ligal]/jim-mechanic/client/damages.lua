AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end
    Wait(2000)
    TriggerServerEvent("jim-mechanic:server:getStatusList", true)
end)

onPlayerLoaded(function() Wait(5000) TriggerServerEvent("jim-mechanic:server:getStatusList", true) end)

function GetVehicleStatus(vehicle)
    local plate = trim(GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(vehicle)))
    if not VehicleStatus[plate] then
        if Config.System.Debug then print("^5Debug^7: ^4GetVehicleStatus^7[^6"..plate.."^7]^2 not found^7,^2 loading^7...") end
        VehicleStatus[plate] = triggerCallback("jim-mechanic:server:GetStatus", vehicle)
        while not VehicleStatus[plate] do print("waiting") Wait(10) end
    else
        if Config.System.Debug then print("^5Debug^7: ^4GetVehicleStatus^7[^6"..plate.."^7]^2 found^7,^2 ensuring^7...") end
        VehicleStatus[plate] = triggerCallback("jim-mechanic:server:GetStatus", vehicle)
    end
    return VehicleStatus[plate]
end

function SetVehicleStatus(vehicle, part, level)
    --if Config.System.Debug then print("^5Debug^7: ^2Updating ^4VehicleStatus ^2with server") end
    TriggerServerEvent("jim-mechanic:server:updateVehiclePart", VehToNet(vehicle), part, level)
end

AddStateBagChangeHandler('jim_updateVehiclePart', nil, function(bagName, key, value)
    print(GetEntityFromStateBagName(bagName), value.plate, value.plate, value.level)
    if VehicleStatus and VehicleStatus[value.plate] then
        local entity = GetEntityFromStateBagName(bagName)
        if entity == 0 then return end

        VehicleStatus[value.plate][value.part] = value.level
        if Config.System.Debug then print("^5Debug^7: ^2Recieving ^4VehicleStatus^7[^6"..value.plate.."^7][^6"..value.part.."^7] = ^6"..json.encode(value.level).."^7") end
    end
end)

local DamageComponents = { "oil", "axle", "battery", "fuel", "spark" }

function DamageRandomComponent(vehicle)
    if vehicle ~= 0 and DoesEntityExist(vehicle) and not IsThisModelABicycle(GetEntityModel(vehicle)) then
        local plate = trim(GetVehicleNumberPlateText(vehicle))
        if Config.Repairs.ExtraDamages and VehicleStatus[plate] then
            local plate = trim(GetVehicleNumberPlateText(vehicle))
            local dmgFctr = math.random() + math.random(0, 2)
            local randomComponent = DamageComponents[math.random(1, #DamageComponents)]
            local durabilityTable = { ["oil"] = "oillevel", ["axle"] = "shaftlevel", ["battery"] = "cylinderlevel", ["spark"] = "cablelevel", ["fuel"] = "fuellevel", }
            local randomDamage = (math.random() + math.random(0, 1)) * dmgFctr
            for i = 1, VehicleStatus[plate][durabilityTable[randomComponent]] do randomDamage -= ((randomDamage / 2) - VehicleStatus[plate][durabilityTable[randomComponent]] / 4) end
            SetVehicleStatus(vehicle, randomComponent, VehicleStatus[plate][randomComponent] - randomDamage)
            ApplyEffects(vehicle, randomComponent)
        else
            if Config.System.Debug then
                print("^5Debug^7: ^4Vehicle damaged and tried to change ^6ExtraDamages^2 but it was disabled^7")
            end
        end
    end
end
exports('GetVehicleStatus', GetVehicleStatus)
exports('SetVehicleStatus', SetVehicleStatus)
exports('DamageRandomComponent', DamageRandomComponent)

RegisterNetEvent('jim-mechanic:client:setVehicleStatus', function(plate, status)
    VehicleStatus[plate] = status
    if type(VehicleStatus[plate]["oriWheelX"]) == "string" then VehicleStatus[plate]["oriWheelX"] = json.decode(VehicleStatus[plate]["oriWheelX"]) end
end)

RegisterNetEvent('jim-mechanic:client:getStatusList', function(newList)
    VehicleStatus = newList
end)

--=== ADD/REMOVE UPGRADE PARTS ===--
RegisterNetEvent('jim-mechanic:client:applyExtraPart', function(data) local Ped = PlayerPedId() emptyHands(Ped)
    local data = data.client and data.client or data
    if not enforceRestriction("perform") then return end
    if not Checks() then return end
    local vehicle = vehChecks() local above = isVehicleLift(vehicle)
    local cam = createTempCam(Ped, GetEntityCoords(vehicle))
    if not enforceClassRestriction(searchCar(vehicle).class) then return end
    if DoesEntityExist(vehicle) then
        local emote = { anim = above and "idle_b" or "fixing_a_ped", dict = above and "amb@prop_human_movie_bulb@idle_a" or "mini@repair", flag = above and 1 or 16 }
        local plate = trim(GetVehicleNumberPlateText(vehicle))

        GetVehicleStatus(VehToNet(vehicle))
        local extrapart = ""
        if data.mod == "oilp" then extrapart = "oillevel"
        elseif data.mod == "drives" then extrapart = "shaftlevel"
        elseif data.mod == "cylind" then extrapart = "cylinderlevel"
        elseif data.mod == "cables" then extrapart = "cablelevel"
        elseif data.mod == "fueltank" then extrapart = "fuellevel" end

        local currentLevel = VehicleStatus[plate][extrapart]
        if not lookAtEngine(vehicle) then return end
        SetVehicleEngineOn(vehicle, false, false, true)
        if Config.Overrides.DoorAnimations then SetVehicleDoorOpen(vehicle, 4, false, false) end
        if data.remove ~= true then
            if currentLevel == data.level then triggerNotify(nil, "LVL: "..data.level..Loc[Config.Lan]["common"].already, "error") else
                if progressBar({label = Loc[Config.Lan]["common"].installing.." LVL: "..data.level, time = math.random(7000,10000), cancel = true, anim = emote.anim, dict = emote.dict, flag = emote.flag, cam = cam }) then
                    if (VehicleStatus[plate][extrapart] ~= currentLevel) or (not hasItem(data.mod..data.level, 1)) then TriggerServerEvent("jim-mechanic:server:DupeWarn", data.mod..data.level) emptyHands(Ped) return end
                    qblog("`"..Items[data.mod..data.level].label.." - "..data.mod..data.level.."` installed [**"..trim(GetVehicleNumberPlateText(vehicle)).."**]")
                    SetVehicleStatus(vehicle, extrapart, data.level)
                    updateCar(vehicle)
                    removeItem(data.mod..data.level, 1)
                    if currentLevel ~= 0 then addItem( data.mod..currentLevel, 1) end
                    triggerNotify(nil, Items[data.mod..data.level].label.." "..Loc[Config.Lan]["common"].installed, "success")
                else
                    triggerNotify(nil, Loc[Config.Lan]["common"].instfail, "error")
                end
            end
        else
            if progressBar({label = Loc[Config.Lan]["common"].removing, time = math.random(7000,10000), cancel = true, anim = emote.anim, dict = emote.dict, flag = emote.flag, cam = cam }) then
                if VehicleStatus[plate][extrapart] ~= currentLevel then emptyHands(Ped) TriggerServerEvent("jim-mechanic:server:DupeWarn", data.mod..currentLevel) return end
                SetVehicleStatus(vehicle, extrapart, 0)
                    qblog("`"..Items[data.mod..currentLevel].label.." - "..data.mod..currentLevel.."` removed [**"..trim(GetVehicleNumberPlateText(vehicle)).."**]")
                    updateCar(vehicle)
                    addItem( data.mod..currentLevel, 1)
                    triggerNotify(nil, Items[data.mod..currentLevel].label.." "..Loc[Config.Lan]["common"].removed, "success")
            else
                triggerNotify(nil, Loc[Config.Lan]["common"].remfail, "error")
            end
        end
        SetVehicleDoorShut(vehicle, 4, false)
        emptyHands(Ped)
    end
end)

--=== Damage Effects ===--
local effectActive = false
local function oilEffect(vehicle)
    triggerNotify(nil, "Your engine is overheating")
    local engineHealth = GetVehicleEngineHealth(vehicle)
    SetVehicleEngineHealth(vehicle, engineHealth - math.random(20, 30))
    effectActive = false
end

local function axleEffect(vehicle)
    triggerNotify(nil, "The steering feels wrong..")
    for i = 0, 360 do SetVehicleSteeringScale(vehicle,i) Wait(15) end
    effectActive = false
end

local function sparkEffect(vehicle)
    triggerNotify(nil, "The Engine has stalled")
    SetVehicleEngineOn(vehicle, 0, 0, 1)
    Wait(5000)
    SetVehicleEngineOn(vehicle, 1, 0, 0)
    effectActive = false
end

local function batteryEffect(vehicle)
    triggerNotify(nil, "There's something affecting your lights..")
    local lightLvl = 1.0
    for i = 0, 1000 do lightLvl -= 0.003
        SetVehicleLightMultiplier(vehicle, lightLvl)
        Wait(0)
        if lightLvl <= 0 then break end
    end
    SetVehicleBrakeLights(vehicle, false)
    SetVehicleLights(vehicle, 0)
    SetVehicleInteriorlight(vehicle, 0)
    SetVehicleLightMultiplier(vehicle, 1.0)
    Wait(2500)
    SetVehicleLights(vehicle, 2)
    effectActive = false
end

local function fuelEffect(vehicle)
    triggerNotify(nil, "You hear something dripping..")
    local fuel = GetVehicleFuelLevel(vehicle)
    SetVehicleFuelLevel(vehicle, fuel - math.random(1, 6))
    --[[local tankHealth = GetVehiclePetrolTankHealth(vehicle)
    local engineHealth = GetVehicleEngineHealth(vehicle)
    local cooldown = 300
    SetVehicleCanLeakPetrol(vehicle, true)
    SetVehiclePetrolTankHealth(vehicle, 640.0)
    while cooldown > 0 do cooldown -= 1
        SetVehicleEngineHealth(vehicle, engineHealth)
        Wait(0)
    end
    SetVehicleCanLeakPetrol(vehicle, false)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)
    SetVehicleEngineHealth(vehicle, engineHealth)]]
    effectActive = false
end

function ApplyEffects(vehicle, randomComponent)
    if effectActive == true then return end
    local plate = trim(GetVehicleNumberPlateText(vehicle))
    local noEffect = { "Vans", "Cycles", "Boats", "Helicopters", "Commercial", "Trains" }
    local canEffect = true
    for _, class in pairs(noEffect) do if searchCar(vehicle).class == class then canEffect = false break end end
    if canEffect then
        if VehicleStatus[plate] then
            local parts = {
                ["oil"] = function() if VehicleStatus[plate]["oil"] <= Config.Repairs.EffectLevels["oil"] then oilEffect(vehicle) end end,
                ["axle"] = function() if VehicleStatus[plate]["axle"] <= Config.Repairs.EffectLevels["axle"] then axleEffect(vehicle) end end,
                ["spark"] = function() if VehicleStatus[plate]["spark"] <= Config.Repairs.EffectLevels["spark"] then sparkEffect(vehicle) end end,
                ["battery"] = function() if VehicleStatus[plate]["battery"] <= Config.Repairs.EffectLevels["battery"] then batteryEffect(vehicle) end end,
                ["fuel"] = function() if VehicleStatus[plate]["fuel"] <= Config.Repairs.EffectLevels["fuel"] then fuelEffect(vehicle) end end,
            }
            if math.random(1, 100) <= 50 then
                parts[randomComponent]()
            end
        end
    end
end