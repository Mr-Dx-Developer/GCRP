if AK4Y.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif AK4Y.Framework == "oldqb" then 
    QBCore = nil
end

local testDriveZone = nil
local testDriveVeh, inTestDrive = 0, false

local firstX = true

Citizen.CreateThread(function()
    if AK4Y.Framework == "oldqb" then 
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
	elseif AK4Y.Framework == "qb" then
		while QBCore == nil do
            Citizen.Wait(200)
        end
    end
	Wait(4000)
	SendNUIMessage({
		type = 'setJs', 
		vehicles = AK4Y.Vehicles,
		categories = AK4Y.Categories,
		helicopters = AK4Y.Helicopters,
		weapons = AK4Y.Weapons,
		items = AK4Y.Items,
		moneys = AK4Y.Money,
		customItems = AK4Y.Customize,
		customPlatePrice = AK4Y.CustomPlatePriceOnBuyVehicle,
		minCharForPhone = AK4Y.MinCharForPhoneNumber,
		minCharForPlate = AK4Y.MinCharForPlate,
		maxCharForPhone = AK4Y.MaxCharForPhoneNumber,
		maxCharForPlate = AK4Y.MaxCharForPlate,
		credits = AK4Y.BuyCredits,
		language = AK4Y.Translate,
	})	
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

local openMenuSpamProtect = 0
RegisterCommand(AK4Y.OpenMenuCommand, function()
	if openMenuSpamProtect <= GetGameTimer() then 
		openMenuSpamProtect = GetGameTimer() + 1000
		if firstX then 
			firstX = false
			SendNUIMessage({
				type = 'setJs', 
				vehicles = AK4Y.Vehicles,
				categories = AK4Y.Categories,
				helicopters = AK4Y.Helicopters,
				weapons = AK4Y.Weapons,
				items = AK4Y.Items,
				moneys = AK4Y.Money,
				customItems = AK4Y.Customize,
				customPlatePrice = AK4Y.CustomPlatePriceOnBuyVehicle,
				minCharForPhone = AK4Y.MinCharForPhoneNumber,
				minCharForPlate = AK4Y.MinCharForPlate,
				maxCharForPhone = AK4Y.MaxCharForPhoneNumber,
				maxCharForPlate = AK4Y.MaxCharForPlate,
				credits = AK4Y.BuyCredits,
				language = AK4Y.Translate,
			})	
		end
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getPlayerDetails", function(result)
			apiKey = result.apiKey
            if result.steamid then
                steamID = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" .. apiKey .. "&steamids=" .. result.steamid
            else
                steamID = 'null'
            end
			SetNuiFocus(true,true)
			SendNUIMessage({
				type = 'openUi', 
				currentCredit = result.playerData.credit,
				firstName = result.charInfo.firstname,
				lastName = result.charInfo.lastname,
				steamid = steamID,
			})	
		end)
	else
		AK4Y.ClientNotify(AK4Y.Translate.openSpam, "error")
	end
end)

RegisterKeyMapping(AK4Y.OpenMenuCommand, "Open Donator Menu", "keyboard", AK4Y.OpenKey)


local sendInputSpamProtect = 0
RegisterNUICallback('sendInput', function(data, cb)
	if sendInputSpamProtect <= GetGameTimer() then
		sendInputSpamProtect = GetGameTimer() + 2000 
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:sendInput", function(result)
			if result then 	
				cb(result)
			else
				cb(false)
			end
		end, data)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end
end)

local getVehicleSpamProtect = 0
RegisterNUICallback('getVehicle', function(data, cb)
	if getVehicleSpamProtect <= GetGameTimer() then
		getVehicleSpamProtect = GetGameTimer() + 2000
		local carData = nil
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)
		local vehItemNameHash = GetHashKey(data.itemInfo.spawnName)
		if not IsModelInCdimage(vehItemNameHash) then return end RequestModel(vehItemNameHash)  while not HasModelLoaded(vehItemNameHash) do Wait(0) end
		local vehicle = CreateVehicle(vehItemNameHash, playerCoords.x, playerCoords.y, playerCoords.z - 200.0, 1.0, false, false)
		FreezeEntityPosition(vehicle, true)
		carData = QBCore.Functions.GetVehicleProperties(vehicle)
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getVehicle", function(result)
			DeleteVehicle(vehicle)
            DeleteEntity(vehicle)
			if result then 	
				cb(result)
			else
				cb(false)
			end
		end, data, carData)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end
end)

local getWeaponSpamProtect = 0
RegisterNUICallback('getWeapon', function(data, cb)
	if getWeaponSpamProtect <= GetGameTimer() then
		getWeaponSpamProtect = GetGameTimer() + 2000
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getWeapon", function(result)
			if result then 	
				cb(result)
			else
				cb(false)
			end
		end, data)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end
end)

local getItemSpamProtect = 0
RegisterNUICallback('getItem', function(data, cb)
	if getItemSpamProtect <= GetGameTimer() then
		getItemSpamProtect = GetGameTimer() + 2000
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getItem", function(result)
			if result then 	
				cb(result)
			else
				cb(false)
			end
		end, data)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end
end)

local getMoneySpamProtect = 0
RegisterNUICallback('getMoney', function(data, cb)
	if getMoneySpamProtect <= GetGameTimer() then
		getMoneySpamProtect = GetGameTimer() + 2000
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getMoney", function(result)
			if result then 	
				cb(result)
			else
				cb(false)
			end
		end, data)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end	
end)

local getCustomPlate = 0
RegisterNUICallback('getCustomPlate', function(data, cb)
	if getCustomPlate <= GetGameTimer() then
		getCustomPlate = GetGameTimer() + 2000
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			local oldPlate = GetVehicleNumberPlateText(veh)
			QBCore.Functions.TriggerCallback("ak4y-donateSystem:getCustomPlate", function(result)
				if result then 	
					local newPlate = data.input
					SetVehicleNumberPlateText(veh, data.input)
					if AK4Y.GiveAddKeys then 
						AK4Y.GiveAddKeysFunction(newPlate)
					end
					cb(true)
				else
					cb(AK4Y.Translate.errorDuringPurchase)
				end
			end, data, oldPlate)
		else
			cb(AK4Y.Translate.insideVehicle)
		end
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end	
end)

local getPrivNumber = 0
RegisterNUICallback('getPrivNumber', function(data, cb)
	if getPrivNumber <= GetGameTimer() then
		getPrivNumber = GetGameTimer() + 2000
		QBCore.Functions.TriggerCallback("ak4y-donateSystem:getPrivNumber", function(result)
			if result then 	
				cb(true)
			else
				cb(AK4Y.Translate.errorDuringPurchase)
			end
		end, data)
	else
		AK4Y.ClientNotify(AK4Y.Translate.spamNotify, "error")
		cb(false)
	end	
end)

RegisterNUICallback('closeMenu', function(data, cb)
	SetNuiFocus(false, false)
end)

function startTestDriveTimer(testDriveTime)
    local gameTimer = GetGameTimer()
    CreateThread(function()
        while inTestDrive do
            if GetGameTimer() < gameTimer + tonumber(1000 * testDriveTime) then
                local secondsLeft = GetGameTimer() - gameTimer
                drawTxt(AK4Y.Translate.testDriveRemaining..''..math.ceil(testDriveTime - secondsLeft / 1000), 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
            end
            Wait(0)
        end
    end)
end

RegisterNUICallback('startTestDrive', function(data, cb)
	if not inTestDrive and ClosestVehicle ~= 0 then
        local prevCoords = GetEntityCoords(PlayerPedId())
		if #(prevCoords - AK4Y.TestDriveCoords) < 10 then 
			inTestDrive = true
			QBCore.Functions.SpawnVehicle(data.spawnName, function(veh)
				local closestShop = insideShop
				TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
				SetVehicleNumberPlateText(veh, 'TESTDRIVE')
				SetEntityAsMissionEntity(veh, true, true)
				SetEntityHeading(veh, AK4Y.TestDriveCarSpawnLocation.w)
				AK4Y.GiveAddKeysFunction(QBCore.Functions.GetPlate(veh))
				TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
				testDriveVeh = veh
				AK4Y.ClientNotify(AK4Y.Translate.testDriveStarted, "success")
				SetTimeout(AK4Y.TestDriveTime * 60000, function()
					if testDriveVeh ~= 0 then
						testDriveVeh = 0
						inTestDrive = false
						QBCore.Functions.DeleteVehicle(veh)
						SetEntityCoords(PlayerPedId(), AK4Y.TestDriveCoords)
						AK4Y.ClientNotify(AK4Y.Translate.testDriveEnded, "success")
					end
				end)
			end, AK4Y.TestDriveCarSpawnLocation, false)
			startTestDriveTimer(AK4Y.TestDriveTime * 60)
			SetNuiFocus(false, false)
			cb(true)
		else
			cb(AK4Y.Translate.youShouldbeInZone)
		end
    else
		cb(AK4Y.Translate.alreadyInTestDrive)
    end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local performansCd = 1000
CreateThread(function()
    if AK4Y.TestDriveBlip then
        local Dealer = AddBlipForCoord(AK4Y.TestDriveCoords)
        SetBlipSprite (Dealer, 79)
        SetBlipDisplay(Dealer, 4)
        SetBlipScale  (Dealer, 0.70)
        SetBlipAsShortRange(Dealer, true)
        SetBlipColour(Dealer, 4)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(AK4Y.TestDriveBlipText)
        EndTextCommandSetBlipName(Dealer)
    end
	while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(AK4Y.TestDriveCoords - pos) < 10 then 
            performansCd = 1
            DrawText3D(AK4Y.TestDriveCoords.x, AK4Y.TestDriveCoords.y, AK4Y.TestDriveCoords.z+1, AK4Y.TestDriveDrawText)
        end
        Citizen.Wait(performansCd)
    end
end)
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.48, 0.48)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 245)
    SetTextOutline(true)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
