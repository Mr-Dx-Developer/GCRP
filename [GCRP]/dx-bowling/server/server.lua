local occupiedTracks = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('dx-bowling:start')
AddEventHandler('dx-bowling:start', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Config['payment']['allowPayment'] then
        if Player.Functions.RemoveMoney("bank", Config['payment']['amount']) then
            TriggerClientEvent('dx-bowling:chooseTrack', source, occupiedTracks)
        else
            TriggerClientEvent('dx-bowling:failed', source)
            TriggerClientEvent('QBCore:Notify', source, Strings["dont_money"], "error")
        end        
    else
        TriggerClientEvent('dx-bowling:chooseTrack', source, occupiedTracks)
    end
    
end)

RegisterServerEvent('dx-bowling:end')
AddEventHandler('dx-bowling:end', function(track)
    local src, old = source, occupiedTracks
    occupiedTracks = {}
    for k, v in pairs(old) do 
        if v ~= src then
            occupiedTracks[k] = v
        end
    end
    TriggerClientEvent('dx-bowling:cancel', src)
end)

RegisterServerEvent('dx-bowling:choose')
AddEventHandler('dx-bowling:choose', function(track)
    local src = source
    if not occupiedTracks[track] then
        occupiedTracks[track] = src
        TriggerClientEvent('dx-bowling:play', src, track)
    else
        TriggerClientEvent('dx-bowling:cancel', src)
    end
end)

AddEventHandler('playerDropped', function()
    local src, old = source, occupiedTracks
    occupiedTracks = {}
    for k, v in pairs(old) do 
        if v ~= src then
            occupiedTracks[k] = v
        end
    end
end)