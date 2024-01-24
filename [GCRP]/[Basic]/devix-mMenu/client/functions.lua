local playTime = 9999999999 -- CASE
local lastSelected = nil -- CASE
local lastValidatedCase = nil -- CASE

if MENU.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif MENU.Framework == "oldqb" then 
    QBCore = nil
elseif MENU.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif MENU.Framework == "oldesx" then 
    ESX = nil
end

Citizen.CreateThread(function()
    if MENU.Framework == "oldqb" then 
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
	elseif MENU.Framework == "qb" then
		while QBCore == nil do
            Citizen.Wait(200)
        end
    elseif MENU.Framework == "oldesx" then 
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
	elseif MENU.Framework == "esx" then
		while ESX == nil do
            Citizen.Wait(200)
        end
    end
    Wait(1000)	
end)



if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        TriggerServerEvent('devix-mmenu:server:updatePrime')
    end)
else
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function()
        TriggerServerEvent('devix-mmenu:server:updatePrime')
    end)
end

------------------- STARTING!
local seconds = 0
local minutes = 0
local hours = 0
local days = 0
local timechecked = false
local count = 0

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------ CHECK THE TIME ON SPAWN
Citizen.CreateThread(function()
    while true do
        Wait(0)
		TriggerServerEvent('devix-mmenu:server:time')
		return
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------ RETRIEVING THE TIME ON SPAWN
RegisterNetEvent('devix-mmenu:client:sendDados')
AddEventHandler('devix-mmenu:client:sendDados', function(s, m, h, d)
    seconds = s
	minutes = m
    hours = h 
    days = d
    timechecked = true -- STARTS THE COUNT OF THE ONLINE TIME
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- THE MASTER COUNTER 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timechecked == true then
		    count = count + 1
			seconds = seconds + 1
			if seconds == 60 then
			    seconds = 0
			    minutes = minutes + 1
				if minutes == 60 then
				    minutes = 0
				    hours = hours + 1
				    if hours == 24 then
					    hours = 0
				        days = days + 1
				    end
				end
			end
		end
		TriggerServerEvent("devix-mmenu:server:savetime", seconds, minutes, hours, days)
		if count == MENU.savePlayerInServerTime then
		    count = 0
		    TriggerServerEvent("devix-mmenu:server:savetimedb", seconds, minutes, hours, days) 
		end
	end
end)


Citizen.CreateThread(function ()
    while true do
        if IsControlJustPressed(0, MENU.openMenuKey) then
            print('pressed MeNU')
            SendNUIMessage({
                action = "OPEN_MENU",
                images = MENU.HOMEPAGE.menuServerLogo,
                menuTopMenus = MENU.HOMEPAGE.menuTopMenus,
                menuBottomMenus = MENU.HOMEPAGE.menuBottomMenus,
                ticketAdminIDs = MENU.TICKET_ADMINS
            })
            SetNuiFocus(true, true)
            print('^1 [ OPENED MENU ] ')
        end
        Wait(0)
    end
end)



-- NUI CALLBACK

RegisterNUICallback('setEvent', function (data,cb)
    print('SET EVENT =>', data.eventName)
    TriggerEvent(data.eventName)
end)


RegisterNUICallback('purchaseStore', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:updateCoin', data.newCost, data.eventType, data.eventArgs, data.playerCoin, data.eventCost)
    if data.eventType == "car" then
        local props
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local vHash = GetHashKey(tostring(data.eventArgs))
        if not IsModelInCdimage(vHash) then return end RequestModel(vHash)  while not HasModelLoaded(vHash) do Wait(0) end
        local vehicle = CreateVehicle(vHash, pCoords.x, pCoords.y, pCoords.z - 200.0, 1.0, false, false)
        FreezeEntityPosition(vehicle, true)
        local vehHash = GetHashKey(vehicle)
        local plate = "COINBASED"
        if MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
            props = ESX.Game.GetVehicleProperties(vehicle)
        else
            props = QBCore.Functions.GetVehicleProperties(vehicle)
        end
        local hash = props.model
        local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
        local vehicleHash = GetHashKey(vehicleHash)
        TriggerServerEvent('devix-mmenu:server:giveCar', props, vehicleModel, vehicleHash, GetHashKey(vehicle), plate, vehicle)
        Wait(400)
        DeleteVehicle(vehicle)
        DeleteEntity(vehicle)
    else
        TriggerServerEvent(data.eventTrigger, data.eventArgs)
    end
end)




RegisterNUICallback('openSkillScreen', function ()
    MENU.openSkillSide()
end)


RegisterNetEvent('devix-mmenu:client:openCrewMenu', function ()
    MENU.openCrewMenu()
end)

RegisterNetEvent('devix-mmenu:client:closeScreen', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE_SCREEN"
    })
end)

RegisterNUICallback('closeScreen', function ()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('setFpsSettings', function (data,cb)
    -- print('fpsstatus>', data.fpsStatus)
    TriggerEvent('devix-mmenu:fps:client:event', data.fpsStatus)
end)




RegisterNUICallback('sendMessage', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:updateMessages', data.ticketID, data)
end)


RegisterNUICallback('getTicketMessages', function(data,cb)
    if MENU.Framework == "qb"  or MENU.Framework == "oldqb" then
        QBCore.Functions.TriggerCallback('devix-mmenu:server:CheckMessages', function(data, pID)
            cb({data, pID})
        end, data.ticketID)
    else
        ESX.TriggerServerCallback('devix-mmenu:server:CheckMessages', function(data, pID)
            cb({data, pID})
        end, data.ticketID)
    end
end)

RegisterNUICallback('setTicketOwner', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:setTicketOwner', data.ticketID)
end)
RegisterNUICallback('setRETicketOwner', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:setReTicketOwner', data.ticketID)
end)
RegisterNUICallback('closeTheTicket', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:closeTheTicket', data.ticketID)
end)
RegisterNUICallback('teleportToPlayer', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:teleportToPlayer', data.ticketID)
end)
RegisterNUICallback('bringToPlayer', function (data,cb)
    TriggerServerEvent('devix-mmenu:server:bringToPlayer', data.ticketID)
end)

RegisterNetEvent('devix-mmenu:client:sendNotify', function (status, text)
    print('status, text', status, text)
        SendNUIMessage({
        action = "SEND_NOTIFY",
        notifyStatus = status,
        text = text,
    })
end)

RegisterNetEvent('devix-mmenu:client:updateMessages', function (mChat, ticketID, pCid)
    SendNUIMessage({
        action = "UPDATE_MESSAGES",
        messages = json.decode(mChat),
        ticketID = ticketID,
        playerCID = pCid
    })
end)

-- EVENTS


RegisterNetEvent('devix-mmenu:client:openProfile', function()
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        QBCore.Functions.TriggerCallback('devix-mmenu:server:getPlayerProfile', function (data)
            SendNUIMessage({
                action = "OPEN_PROFILESCREEN",
                Locales = Locales,
                account = data.account,
                phone = data.phone,
                job = data.job,
                prime = data.prime,
                primeEndOfTime = data.primeEndOfTime,
                vehicles = data.playerVehicle,
                onlinetime = data.onlinetime
            })
        end)
    else
        ESX.TriggerServerCallback('devix-mmenu:server:getPlayerProfile', function (data)
            SendNUIMessage({
                action = "OPEN_PROFILESCREEN",
                Locales = Locales,
                account = data.account,
                phone = data.phone,
                job = data.job,
                prime = data.prime,
                primeEndOfTime = data.primeEndOfTime,
                vehicles = data.playerVehicle,
                onlinetime = data.onlinetime
            })
        end)
    end
end)

RegisterNetEvent('devix-mmenu:client:openStore', function()
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        QBCore.Functions.TriggerCallback('devix-mmenu:server:getPlayerCoin', function (data)
            SendNUIMessage({
                action = "OPEN_STORESCREEN",
                Locales = Locales,
                coin = data.coin,
                prime = data.prime,
                menus = MENU.storePages,
                coinIMG = MENU.coinIMG
            })
        end)
    else
        ESX.TriggerServerCallback('devix-mmenu:server:getPlayerCoin', function (data)
            SendNUIMessage({
                action = "OPEN_STORESCREEN",
                Locales = Locales,
                coin = data.coin,
                prime = data.prime,
                menus = MENU.storePages,
                coinIMG = MENU.coinIMG
            })
        end)
    end
end)

RegisterNetEvent('devix-mmenu:client:openBattlePass', function()  
    SendNUIMessage({
        action = "OPEN_BATTLESCREEN",
        Locales = Locales,
    })
end)


RegisterCommand('fs', function (source, args)
    SendNUIMessage({
        action = "setTaskUpdate",
        missionID = args[1],
        count = args[2]
    })
end)

RegisterNetEvent('devix-mmenu:client:updateTime', function (time)
    SendNUIMessage({
        action = "UPDATE_TIME",
        time = time
    })
    
end)

RegisterNetEvent('devix-mmenu:client:openRule', function()
    print('RULE TRIGGERED')
    SendNUIMessage({
        action = "OPEN_RULESCREEN",
        Locales = Locales,
        rule = RULE
    })
end)




RegisterNetEvent('devix-mmenu:openskill', function ()
    MENU.openSkillSide()
end)

RegisterNetEvent('devix-mmenu:openInventory', function ()
    MENU.openInventorySide()
end)

RegisterNetEvent('devix-mmenu:client:openJobSection', function()
    SendNUIMessage({
        action = "OPEN_JOBSCREEN",
        Locales = Locales,
        jobInfos = MENU.JOBSCREEN.Menus
    }) 
end)


RegisterNetEvent('devix-mmenu:client:openSettings', function ()
        SendNUIMessage({
        action = "OPEN_SETTINGSSCREEN",
        Locales = Locales,
        crosshair = MENU.SETTINGS_SCREEN["CROSSHAIR"]
    }) 
end)

RegisterNetEvent('devix-mmenu:client:openContact', function ()
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        QBCore.Functions.TriggerCallback('devix-mmenu:server:getTicket', function(status, data, isAdmin)
            print(status, isAdmin, json.encode(data))
            if not isAdmin then

                if status then
                    SendNUIMessage({
                        action = "SETUP_TICKETS",
                        Locales = Locales,
                        status = status,
                        data = data,
                        isAdmin = isAdmin
                    }) 
                else
                    SendNUIMessage({
                        action = "SETUP_TICKETS",
                        Locales = Locales,
                        status = status,
                        data = data,
                        isAdmin = isAdmin
                    }) 
                end
            else
                SendNUIMessage({
                    action = "SETUP_TICKETS",
                    Locales = Locales,
                    status = status,
                    data = data,
                    isAdmin = isAdmin
                }) 
            end
        end)
    else
        ESX.TriggerServerCallback('devix-mmenu:server:getTicket', function(status, data, isAdmin)
            print(status, isAdmin, json.encode(data))
            if not isAdmin then

                if status then
                    SendNUIMessage({
                        action = "SETUP_TICKETS",
                        Locales = Locales,
                        status = status,
                        data = data,
                        isAdmin = isAdmin
                    }) 
                else
                    SendNUIMessage({
                        action = "SETUP_TICKETS",
                        Locales = Locales,
                        status = status,
                        data = data,
                        isAdmin = isAdmin
                    }) 
                end
            else
                SendNUIMessage({
                    action = "SETUP_TICKETS",
                    Locales = Locales,
                    status = status,
                    data = data,
                    isAdmin = isAdmin
                }) 
            end
        end)
    end
end)

RegisterNetEvent('devix-mmenu:client:createTicket', function(ticketID, pAvatar, playerName)
    SendNUIMessage({
        action = "CREATE_TICKET",
        ticketID = ticketID,
        pAvatar = pAvatar,
        playerName = playerName
    })
end)





-- CASE SYSTEM


RegisterNetEvent('devix-mmenu:client:openCase', function ()
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        QBCore.Functions.TriggerCallback("devix-mmenu:case:getPlayerDetails", function(result)
            print('getPlayerDetails', json.encode(result))
            local firstname = result.firstname
            local lastname = ""
            apiKey = result.apiKey
            SetNuiFocus(true,true)
            SendNUIMessage({
                action = "SETUP_CASES",
                casesData = MENU.CASE["CASE_DATA"],
                caseSettings = MENU.CASE["SETTINGS"],
                playerCoin = result.coin,
                playerPrisma = result.prisma,
                playerFirstname = firstname,
                playerLastname = lastname,
                steamid = steamID,
                Locales = Locales,
                coinIMG = MENU.coinIMG,
                prismaIMG = MENU.prismaIMG,

            })	
        end)
    else
        ESX.TriggerServerCallback("devix-mmenu:case:getPlayerDetails", function(result)
            print('getPlayerDetails', json.encode(result))
            local firstname = result.firstname
            local lastname = ""
            apiKey = result.apiKey
            SetNuiFocus(true,true)
            SendNUIMessage({
                action = "SETUP_CASES",
                casesData = MENU.CASE["CASE_DATA"],
                caseSettings = MENU.CASE["SETTINGS"],
                playerCoin = result.coin,
                playerPrisma = result.prisma,
                playerFirstname = firstname,
                playerLastname = lastname,
                steamid = steamID,
                Locales = Locales,
                coinIMG = MENU.coinIMG,
                prismaIMG = MENU.prismaIMG,

            })	
        end)
    end
end)




RegisterNUICallback("updateCoins", function(data, cb)
    TriggerServerEvent('devix-mmenu:server:case:updateCoins', data.pCoin, data.pPrisma)
end)

RegisterNUICallback("collectItem", function(data, cb)
    print('COLLECT ITEM :>',json.encode(data.array))
    TriggerServerEvent("devix-mmenu:case:collectItem", data.array)
end)

RegisterNUICallback('setNewPoint', function (data,cb)
    SetNewWaypoint(tonumber(data.jobCoordsX), tonumber(data.jobCoordsY))    
end)

RegisterNUICallback('createTicket', function(data,cb)
    TriggerServerEvent('devix-mmenu:server:createTicket')
end)



RegisterNetEvent('devix-mmenu:case:serverNotif')
AddEventHandler('devix-mmenu:case:serverNotif', function(data)
	SendNUIMessage({
        type = 'serverNotif', 
        notifInfo = data,
    })	
end)


function disp_time(time)
    local days = math.floor(time/86400)
    local remaining = time % 86400
    local hours = math.floor(remaining/3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining/60)
    remaining = remaining % 60
    local seconds = remaining
    if (hours < 10) then
        hours = "0" .. tostring(hours)
    end
    if (minutes < 10) then
        minutes = "0" .. tostring(minutes)
    end
    if (seconds < 10) then
        seconds = "0" .. tostring(seconds)
    end
    if hours ~= "00" then 
        answer = hours..'h '..minutes..'m'
    else
        answer = minutes..'m'

    end
    return answer
end



getNeededPlayTime = function()
    return math.round((playTime - GetGameTimer()) / 60000, 2)
end

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end


local type 
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)

            local next = true
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end




local function GetWorldObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

local function GetWorldPeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local function GetWorldVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function GetWorldPickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

local function FPSBoosterUM(shadow,air,entity,dynamic,tracker,depth,bounds,distance,tweak,sirens,lights,notify)
    RopeDrawShadowEnabled(shadow)
    CascadeShadowsClearShadowSampleType()
    CascadeShadowsSetAircraftMode(air)
    CascadeShadowsEnableEntityTracker(entity)
    CascadeShadowsSetDynamicDepthMode(dynamic)
    CascadeShadowsSetEntityTrackerScale(tracker)
    CascadeShadowsSetDynamicDepthValue(depth)
    CascadeShadowsSetCascadeBoundsScale(bounds)
    SetFlashLightFadeDistance(distance)
    SetLightsCutoffDistanceTweak(tweak)
    DistantCopCarSirens(sirens)
    SetArtificialLightsState(lights)
    -- QBCore.Functions.Notify(notify,"success")
end

RegisterCommand("fps", function()
	exports['qb-menu']:openMenu({
        {
            header = "🔥 FPS Booster Menu",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "Reset",
            txt = "",
            params = {
                event = "devix-mmenu:fps:client:event",
                args = {
                   type = "reset"
                }
            }
        },
        {
            header = "Ultra Low",
            txt = "",
            params = {
                event = "devix-mmenu:fps:client:event",
                args = {
                    type = "ulow"
                }
            }
        },
        {
            header = "Low",
            txt = "",
            params = {
                event = "devix-mmenu:fps:client:event",
                args = {
                    type = "low"
                }
            }
        },
        {
            header = "Medium",
            txt = "",
            params = {
                event = "devix-mmenu:fps:client:event",
                args = {
                    type = "medium"
                }
            }
        },
    })
end)

RegisterNetEvent('devix-mmenu:fps:client:event', function(data)
    if data == "reset" then
        FPSBoosterUM(true,true,true,true,5.0,5.0,5.0,10.0,10.0,true,false,"Reset")
    elseif data == "ultralow" then
        FPSBoosterUM(false,false,true,false,0.0,0.0,0.0,0.0,0.0,false,nil,"Ultralow")
    elseif data == "low" then
        FPSBoosterUM(false,false,true,false,0.0,0.0,0.0,5.0,5.0,false,nil,"Low")
    elseif data == "medium" then
        FPSBoosterUM(true,false,true,false,5.0,3.0,3.0,3.0,3.0,false,false,"Medium")
    end
    type = data
end)

-- // Distance rendering and entity handler (need a revision)
CreateThread(function()
    while true do
        if type == "ultralow" then
            --// Find closest ped and set the alpha
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end

                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end

            --// Find closest object and set the alpha
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(obj) ~= 170 then
                        SetEntityAlpha(obj, 170)
                    end
                end
                Wait(1)
            end


            DisableOcclusionThisFrame()
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.4)
            SetArtificialLightsState(true)
        elseif type == "low" then
            --// Find closest ped and set the alpha
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                SetPedAoBlobRendering(ped, false)

                Wait(1)
            end

            --// Find closest object and set the alpha
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                Wait(1)
            end

            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.6)
            SetArtificialLightsState(true)
        elseif type == "medium" then
            --// Find closest ped and set the alpha
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    end
                end

                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end
        
            --// Find closest object and set the alpha
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    end
                end
                Wait(1)
            end

            OverrideLodscaleThisFrame(0.8)
        else
            Wait(500)
        end
        Wait(8)
    end
end)


CreateThread(function()
    while true do
        if type == "ulow" or type == "low" then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearPedBloodDamage(PlayerPedId())
            ClearPedWetness(PlayerPedId())
            ClearPedEnvDirt(PlayerPedId())
            ResetPedVisibleDamage(PlayerPedId())
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
            Wait(300)
        elseif type == "medium" then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            SetWindSpeed(0.0)
            Wait(1000)
        else
            Wait(1500)
        end
    end
end)

