local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        InIt()
    end
end)

function InIt()
    CreateThread(function()
        while true do 
            local InWater = IsEntityInWater(PlayerPedId())
            local HasPhone = QBCore.Functions.HasItem("phone")
            local BetteryCheck = exports["lb-phone"]:GetBattery()
            if InWater and HasPhone and BetteryCheck ~= 0 then 
                exports["lb-phone"]:SetBattery(0)
                QBCore.Functions.Notify("Your Phone Battery Is Dead!", "error")
            end
            Wait(5000)
        end
    end)
end

RegisterNetEvent("kael-xens:client:userpowerbank", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local PlayerName = PlayerData.charinfo.lastname
    local PlayerNamefirstname = PlayerData.charinfo.firstname
    TriggerServerEvent('kael-xens:server:sendMeText', PlayerNamefirstname.. " " ..PlayerName .. ' ~r~Charging Phone...~s~')
    QBCore.Functions.Progressbar("pphonechargepower", "Using Power Bank...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        exports["lb-phone"]:ToggleOpen(true, false)
        exports["lb-phone"]:ToggleCharging(true)
        IsCharging = true
        CreateThread(function()
            while IsCharging do 
                if exports["lb-phone"]:GetBattery() >= 100 then 
                    IsCharging = false 
                    exports["lb-phone"]:ToggleCharging(false)
                    exports["lb-phone"]:ToggleOpen(false, false)
                    QBCore.Functions.Notify("Your Phone Is 100% Charged!", "success")
                end 
                Wait(2000)
            end
        end)
    end)
end)
