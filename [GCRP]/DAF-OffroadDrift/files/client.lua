

local rychlost = 0
local jazda = 0
local offroad = false
Citizen.CreateThread(function()
	if Config.StopOffroad then
		while true do
			Wait(1000)
				car = GetVehiclePedIsIn(PlayerPedId(),false)
				if GetPedInVehicleSeat(car, -1) == PlayerPedId() then
					Citizen.Wait(250)
					local zivot = GetVehicleEngineHealth(car)
					road_type = GetVehicleWheelSurfaceMaterial(car, 1)
					rychlost = GetEntitySpeed(car)
					suma = 0
					offroad = false
					local class = GetVehicleClass(car)
					
					if Config.TireDamage then
						tires_list(car)
						if not IsEntityInAir(car) then
							if rychlost >= Config.TireDamageSpeed/3.6 then
								SetVehicleEngineHealth(car, zivot-suma*rychlost)
							end
						else
							Wait(100)
						end
					end
				
					if IsVehicleOffroadTyped(class) and type_of_wheel(car)then
						if not cesta_list(road_type) then
							if Config.EnablePartOffroad then
								if IsNotOffroad(class) then
									if rychlost >= Config.PartOffroadVehiclesSpeedLimit/3.6 then
										if Config.EnablePartOffroadBadHandling then
											ToggleOff("on", car)
										end
										if not IsEntityInAir(car) then
											if zivot >= Config.MinCarHealth then
												SetVehicleEngineHealth(car, zivot-rychlost*Config.EngineDamageCoefficientOffroadVehicles)
											end
										else
											Wait(100)
										end
									else
										ToggleOff("off", car)
									end
								else
									if Config.DamageOffroad then
										if rychlost >= Config.OffroadVehiclesSpeedLimit/3.6 then
											if not IsEntityInAir(car) then
												if zivot >= Config.MinCarHealth then
													SetVehicleEngineHealth(car, zivot-rychlost*Config.EngineDamageCoefficientOffroadVehicles)
												end
											else
												Wait(100)
											end
										end
									end
									ToggleOff("off", car)
								end
							else
								ToggleOff("off", car)
							end
						else
							ToggleOff("off", car)
						end
					else
						if cesta_list(road_type) then
							if not drift then
								jazda = 0
								ToggleOff("off", car)
							end
						else
							offroad = true
							jazda = jazda + 1
							if jazda >= 1 and rychlost > Config.OffroadLimit/3.6 then
								ToggleOff("on", car)
								if Config.DamageOffroad then
									if not IsEntityInAir(car) then
										if zivot >= Config.MinCarHealth then
											SetVehicleEngineHealth(car, zivot-rychlost*Config.EngineDamageCoefficient)
										end
									else
										Wait(100)
									end
								end
							else
								if not drift then
									ToggleOff("off", car)
								end 
							end
						end
					end
				else
					Wait(1000)
				end
			end
		end
end)

local tires = {0, 1, 2, 3, 4, 5, 6}
local Idcka = {4, 5, 3, 6, 68, 1, 12, 15, 13, 174, 55, 181,0, 59}
local tires_offroad = {6, 3, 4}
local vehicleClassHalfOffroad = {2, 8, 9, 10, 11, 13, 17, 18, 19, 4}
local vehicleClassFullOff = {2, 8, 9}
local vehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9, 18}

function ToggleOff(status, car)
	if status == "on" then
		SetVehicleReduceTraction(car, true)
		SetVehicleReduceGrip(car, true)

	elseif status == "off" then
		SetVehicleReduceTraction(car, false)
		SetVehicleReduceGrip(car, false)
		
	end
end

function type_of_wheel(car)
	for index, value in ipairs(tires_offroad) do
		Wait(5)
		if GetVehicleWheelType(car) == value then
			return true
		end
	end
	return false
end

function tires_list(car)
	for index, value in ipairs(tires) do
		Wait(0)
		if IsVehicleTyreBurst(car, value, true) then
			suma = suma + Config.DamagePerTire
		end
	end
	return false
end

function cesta_list(road_type)
	for index, value in ipairs(Idcka) do
		Wait(0)
		if value == road_type then
			return true
		end
	end

	return false
end

local driftMode = false




Citizen.CreateThread( function()
if Config.EnableDrift then
		while true do
			Wait(10)
			if IsPedInAnyVehicle(PlayerPedId()) then
				car = GetVehiclePedIsIn(PlayerPedId(), false)
				if IsControlPressed(0, Config.DriftKey) then
					Wait(5)
					if not offroad then
						if not Config.StopOffroad then
							rychlost = GetEntitySpeed(car)
						end
						if rychlost <= Config.DriftMaxSpeed/3.6 then
							if not drift then
								Wait(15)
									if GetPedInVehicleSeat(car, -1) == PlayerPedId() then
										if IsVehicleClassWhitelisted(GetVehicleClass(car)) then
											drift = true
											ToggleOff("on", car)
										end
									end
								end
						else
							drift = false
							Wait(25)
						end
					end
				else
					drift = false
					Wait(5)
					
					if not Config.StopOffroad then
						ToggleOff("off", car)
					end
				end
			else		
				Wait(500)
			end
		end
	end
end)
	
	

	
function IsNotOffroad(vehicleClass)
	for index, value in ipairs(vehicleClassFullOff) do
		Wait(0)
		if value == vehicleClass then
			return false
		end
	end

	return true
end

function IsVehicleOffroadTyped(vehicleClass)
	for index, value in ipairs(vehicleClassHalfOffroad) do
		Wait(0)
		if value == vehicleClass then
			return true
		end
	end

	return false
end

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		Wait(0)
		if value == vehicleClass then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end
        end
    end
end)