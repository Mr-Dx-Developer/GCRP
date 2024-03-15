local pedCreated
local countdownOnGoing
local gameOnGoing
local playerQueue = {}
local existingKarts = {}
local timer = cfg.gameSettings.queueTimer
local index = 1
local players = 1

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("dx-bumperkart:updateTable")
AddEventHandler("dx-bumperkart:updateTable", function()
    local source = source
    local playersQueued = tablelength(playerQueue)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.RemoveMoney(cfg.paymentAccount, cfg.PlayFee) then
        if gameOnGoing then
            TriggerClientEvent("dx-bumperkart:GameOngoing", source)
            return
        end
        
        if playersQueued > 0 then
            for k, v in pairs(playerQueue) do
                if v.tempid == source then
                    TriggerClientEvent("dx-bumperkart:alreadyInQueue", source)
                    return false
                end
            end

            if playersQueued >= cfg.maxPlayers then
                TriggerClientEvent("dx-bumperkart:SlotsFilled", source)
                return false
            else
                
            TriggerClientEvent("dx-bumperkart:JoinedQueue", source, timer)
            playerQueue[index] = {tempid = source}
            index = index + 1
            if not countdownOnGoing then
                countdownOnGoing = true
                Wait(timer / 1000)
                startCountdown()
                countdownOnGoing = false
                
            end
            end
        else
            TriggerClientEvent("dx-bumperkart:JoinedQueue", source, timer)
            playerQueue[index] = {tempid = source}
            index = index + 1
            if not countdownOnGoing then
                countdownOnGoing = true
                Wait(timer / 1000)
                startCountdown()
                countdownOnGoing = false
            end
            return
            
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have enough money", "error")
    end
end)

RegisterNetEvent("dx-bumperkart:BumperKartStart")
AddEventHandler("dx-bumperkart:BumperKartStart", function()
    if not gameOnGoing then
        gameOnGoing = true
        startGame(source)
        Citizen.Wait(cfg.gameSettings.timeToPlayGame * 1000)
        endGame()
    end
end)

function startGame(source)
        for k, v in pairs(playerQueue) do 
            if tablelength(existingKarts) == tablelength(playerQueue) then
                break
            else
                if k > tablelength(playerQueue) then
                    
                else
                    
                    local bumperKart = Citizen.InvokeNative(`CREATE_AUTOMOBILE` & 0xFFFFFFFF, cfg.bumperKarts.vehicleModel, cfg.bumperKarts.locations[k], 360.0)
                    Citizen.Wait(200)
                    local netId = NetworkGetNetworkIdFromEntity(bumperKart)
                    existingKarts[k] = {netId = netId, tempid = v.tempid}
                    SetPedIntoVehicle(GetPlayerPed(v.tempid), bumperKart, -1)
                    local plate = "GRNAROW"..k
                    SetVehicleNumberPlateText(bumperKart, plate)
                    TriggerClientEvent("dx-bumperkart:setVehicleOwnership", source, plate)  
                    
                end
                
            end
        end
    playerQueue = {}
end

function endGame()
    if gameOnGoing then
        for k, v in pairs(existingKarts) do
            if DoesEntityExist(NetworkGetEntityFromNetworkId(v.netId)) then
                DeleteEntity(NetworkGetEntityFromNetworkId(v.netId))
                SetEntityCoords(GetPlayerPed(v.tempid), cfg.gameSettings.spawnLocAfterGame, false, false, true, true)
                TriggerClientEvent("dx-bumperkart:gameover", v.tempid)
            end
        end
    end
    gameOnGoing = false
    countdownOnGoing = false
    existingKarts = {}
    playerQueue = {}
    timer = cfg.gameSettings.queueTimer
    index = 1
    players = 1
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end
    
function startCountdown()
    while timer > 0 do
        timer = timer - 1
        Wait(1000)
    end
    local playersQueued = tablelength(playerQueue)
    if playersQueued >= cfg.minPlayers then
        for i = 1, #playerQueue do
            if players > i then
                players = 1
                break
            else
                players = players + 1
                TriggerClientEvent("dx-bumperkart:BumperKartStarted", playerQueue[i].tempid)
            end
        end        
    else
        while timer > 0 do
            timer = timer - 1
            Wait(500)
        end
        for k, v in pairs(playerQueue) do
            TriggerClientEvent("dx-bumperkart:NotEnoughPlayers", playerQueue[k].tempid)
            timer = 5
            end
        end
end
