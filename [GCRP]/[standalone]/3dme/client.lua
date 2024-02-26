
local QBCore = exports['qb-core']:GetCoreObject()
local pedDisplaying = {}

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text rgba()
    SetTextColour(0, 0, 0, 0.8)
    SetTextScale(0.0, 0.7 * scale)
    SetTextFont(0)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

RegisterCommand('me', function(source, args, raw)
    local text = string.sub(raw, 4)
    
    QBCore.Functions.TriggerCallback('3dme:sex', function(firstname,lastname)
        name =  '* '..firstname..' '..lastname..' '..text..''
        TriggerServerEvent('3dme:shareDisplay', text, name, firstname, lastname)
    end)
end)

function Display(ped, text, name)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= 250 then
        if dist <= 10 then
            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message system">' .. name .. '</div>',
                multiline = true,
                args = { text }
            })
        end
        
        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(7000)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), ''..text)

            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId, name)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text, name)
    end
end)