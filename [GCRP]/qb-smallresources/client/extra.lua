local QBCore = exports['qb-core']:GetCoreObject()
-------- DRIVE BY--------

--[[ local player = PlayerId()
CreateThread(function()
    while true do
        local inVehicle = IsPedSittingInAnyVehicle(PlayerPedId())
        if inVehicle then
            local veh = GetVehiclePedIsUsing(PlayerPedId()) -- Only needed if we want to block for certain cars vehicle class
            local vehClass = GetVehicleClass(veh)
            if vehClass == 0 or vehClass == 1 or vehClass == 2 or vehClass == 3 or vehClass == 4 or vehClass == 5 or vehClass == 6 or vehClass == 7  or vehClass == 8 or vehClass == 9 or vehClass == 10 or vehClass == 11 or vehClass == 12 or vehClass == 13 or vehClass == 14 or vehClass == 15 or vehClass == 16 or vehClass == 17 or vehClass == 18 or vehClass == 19 or vehClass == 20 or vehClass == 21 or vehClass == 22 then
                SetPlayerCanDoDriveBy(player, false)
            else
                SetPlayerCanDoDriveBy(player, true)
            end
        end
        Wait(1000)
    end
end) ]]

---- Bynnny Hop -------

CreateThread(function()
    while true do
        Wait(100)
        local ped = PlayerPedId()
        if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
            local chance_result = math.random()
            --You can change the chance as you want! Just changed 0.2!
            if chance_result < 0.2 then 
                Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
                QBCore.Functions.Notify('You are too tired!', 'error', 2500)
                SetPedToRagdoll(ped, 5000, 1, 2)
            else
                Wait(2000)
            end
        end
    end
end)

---- Emergency Vehicle Kick ----

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local ped = GetPlayerPed(-1)
        PlayerData = QBCore.Functions.GetPlayerData()
        
        if GetVehicleClass( GetVehiclePedIsIn(ped, false ) ) == 18 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then
               
                TaskLeaveVehicle(ped,vehicle,0)
                QBCore.Functions.Notify("You are not allowed to drive this vehicle.", "error")
            end
	end
   end
end)


RegisterNetEvent('xM:Client:UseGiftBox', function(source)
    local src = source
    local ply = QBCore.Functions.GetPlayerData()
	QBCore.Functions.Progressbar('xMgiftbox', 'Opening gift!!', Config.OpenTime, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'anim@gangops@facility@servers@',
		anim = 'hotwire',
		flags = 16,
	}, {}, {}, function()
		for i=1, Config.AmountOfItems do
			local item = math.random(#Config.Joingiftitem)
			TriggerServerEvent('xMjoingift:server:recieveItem', Config.Joingiftitem[item].item, math.random (Config.Joingiftitem[item].minAmount, Config.Joingiftitem[item].maxAmount))
			TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[Config.Joingiftitem[item].item], "add")
		end
		end, function()
	end)
end)

