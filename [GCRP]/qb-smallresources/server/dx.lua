local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("powerbank", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) then
        if (Player.PlayerData.items[item.slot].info.uses - 1) <= 0 then
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item.name], "remove")
            Player.Functions.RemoveItem(item.name, 1, item.slot)
        else
            Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
            Player.Functions.SetInventory(Player.PlayerData.items)
        end
        TriggerClientEvent("kael-xens:client:userpowerbank", source)
    end
end)

RegisterNetEvent('kael-xens:server:sendMeText', function(msg) 
    local ped = GetPlayerPed(source)
    local pCoords = GetEntityCoords(ped)
    local Players = QBCore.Functions.GetPlayers()
    for i=1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(pCoords - tCoords) < 20 then
            TriggerClientEvent('QBCore:Command:ShowMe3D', Player, source, msg)
        end
    end
end)