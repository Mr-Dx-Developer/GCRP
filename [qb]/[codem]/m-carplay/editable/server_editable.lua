bot_Token = ""

Citizen.CreateThread(function()
    while Core == nil do
        Citizen.Wait(0)
    end
    Citizen.Wait(500)

    RegisterCallback('mCarplay:getNeon', function (source, cb, plate, vehicleSQL)
        local src = source
        local getNeonData
        if vehicleSQL == 'player_vehicles' then
            getNeonData = ExecuteSql('SELECT mods FROM `player_vehicles` WHERE `plate` = @plate', {
                ['@plate'] = plate
            })
        elseif vehicleSQL == 'owned_vehicles' then    
            getNeonData = ExecuteSql('SELECT vehicle FROM `owned_vehicles` WHERE `plate` = @plate', {
                ['@plate'] = plate
            })
        end
        
        if getNeonData and next(getNeonData) then
            local neonData = json.decode(getNeonData[1].mods)
            if neonData and neonData.neonEnabled then
                for _, isEnabled in pairs(neonData.neonEnabled) do
                    if isEnabled then
                        cb(true)  
                    end
                end
            end
        end
        cb(false) 
    end)
end)