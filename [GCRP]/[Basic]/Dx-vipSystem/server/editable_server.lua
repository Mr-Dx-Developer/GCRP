
QBCore.Functions.CreateCallback('ak4y-donateSystem:getVehicle', function(source, cb, veri, carData)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    local data2 = veri
    if data2.itemInfo.vehType == "car" then
        for k, v in pairs(AK4Y.Vehicles) do
            if v.id == veri.itemInfo.id then 
                data = v
                break
            end
        end
    elseif data2.itemInfo.vehType == "air" then
        for k, v in pairs(AK4Y.Helicopters) do
            if v.id == veri.itemInfo.id then 
                data = v
                data2.itemInfo.vehType = "helicopter"
                break
            end
        end
    end
    if data then
        local vehicle = data.spawnName
        local plate = GeneratePlate()
        if AK4Y.Mysql == "mysql-async" then 
            while plate == nil do 
                Wait(10)
            end
        end
        local costCredit = tonumber(data.costCredit)
        local plateCheck = false
        if data2.extra ~= "undefined" then 
            plateCheck = true
            plate = data2.extra:upper()
            costCredit = costCredit + AK4Y.CustomPlatePriceOnBuyVehicle
        end
        local vehicleData = carData
        vehicleData.plate = plate
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    if plateCheck then 
                        local resultPlate = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
                        if resultPlate[1] == nil then 
                            MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                                xPlayer.PlayerData.license,
                                citizenId,
                                vehicle,
                                GetHashKey(vehicle),
                                json.encode(vehicleData),
                                plate,
                                AK4Y.DefaultGarage,
                                1
                            })
                            SendToDiscord("CitizenID: ``"..citizenId.."``\nVehicle: ``"..vehicle.."\nPlate: ``"..plate.."``\nPurchased vehicle!")
                            cb(true)
                        else
                            cb(false)
                        end
                    else
                        MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                            xPlayer.PlayerData.license,
                            citizenId,
                            vehicle,
                            GetHashKey(vehicle),
                            json.encode(vehicleData),
                            plate,
                            AK4Y.DefaultGarage,
                            1
                        })
                        SendToDiscord("CitizenID: ``"..citizenId.."``\nVehicle: ``"..vehicle.."\nPlate: ``"..plate.."``\nPurchased vehicle!")
                        cb(true)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        elseif AK4Y.Mysql == "mysql-async" then
            MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem WHERE citizenid = @citizenid", {
                ["@citizenid"] = citizenId
            }, function (result)
                if result[1] ~= nil then 
                    if result[1].credit >= costCredit then
                        if plateCheck then 
                            MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {
                                ["@plate"] = plate
                            }, function (resultPlate)
                                if resultPlate[1] == nil then 
                                    MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                                    MySQL.Async.execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @state)', {
                                        ["@license"] = xPlayer.PlayerData.license,
                                        ["@citizenid"] = citizenId,
                                        ["@vehicle"] = vehicle,
                                        ["@hash"] = GetHashKey(vehicle),
                                        ["@mods"] = json.encode(vehicleData),
                                        ["@plate"] = plate,
                                        ["@garage"] = AK4Y.DefaultGarage,
                                        ["@state"] = 1
                                    })
                                    SendToDiscord("CitizenID: ``"..citizenId.."``\nVehicle: ``"..vehicle.."\nPlate: ``"..plate.."``\nPurchased vehicle!")
                                    cb(true)
                                else
                                    cb(false)
                                end
                            end) 
                        else
                            MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                            MySQL.Async.execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @state)', {
                                ["@license"] = xPlayer.PlayerData.license,
                                ["@citizenid"] = citizenId,
                                ["@vehicle"] = vehicle,
                                ["@hash"] = GetHashKey(vehicle),
                                ["@mods"] = json.encode(vehicleData),
                                ["@plate"] = plate,
                                ["@garage"] = AK4Y.DefaultGarage,
                                ["@state"] = 1
                            })


                            SendToDiscord("CitizenID: ``"..citizenId.."``\nVehicle: ``"..vehicle.."\nPlate: ``"..plate.."``\nPurchased vehicle!")
                            cb(true)
                        end
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end) 
        end
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('ak4y-donateSystem:getCustomPlate', function(source, cb, veri, plate)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    for k, v in pairs(AK4Y.Customize) do
        if v.id == veri.itemInfo.id then 
            data = v
            break
        end
    end
    if data then 
        local costCredit = tonumber(data.costCredit)
        local newPlate = veri.input:upper()
        local oldPlate = string.gsub(plate, "%s+", "")
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    local resultPlate = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { newPlate })
                    if resultPlate[1] == nil then
                        local lastCheckPlate = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { oldPlate })
                        if lastCheckPlate[1] == nil then 
                            cb(false)
                        else
                            if lastCheckPlate[1].citizenid == citizenId then 
                                MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                                local jsonData = json.decode(lastCheckPlate[1].mods)
                                if jsonData.plate ~= nil then 
                                    jsonData.plate = newPlate
                                    local mods = json.encode(jsonData)
                                    MySQL.update('UPDATE player_vehicles SET plate = ?, mods = ? WHERE plate = ?', { newPlate, mods, oldPlate })
                                else
                                    MySQL.update('UPDATE player_vehicles SET plate = ? WHERE plate = ?', { newPlate, oldPlate })
                                end
                                SendToDiscord("CitizenID: ``"..citizenId.."``\nOld Plate: ``"..oldPlate.."``\nNew Plate: ``"..newPlate.."``\nVehicle plate changed!")
                                cb(true)
                            else
                                cb(false)
                            end
                        end
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        elseif AK4Y.Mysql == "mysql-async" then
            MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem WHERE citizenid = @citizenid", {
                ["@citizenid"] = citizenId
            }, function (result)
                if result[1] ~= nil then 
                    if result[1].credit >= costCredit then
                        MySQL.Async.fetchAll("SELECT * FROM player_vehicles WHERE plate = @plate", {
                            ["@plate"] = newPlate
                        }, function (resultPlate)
                            if resultPlate[1] == nil then
                                MySQL.Async.fetchAll("SELECT * FROM player_vehicles WHERE plate = @plate", {
                                    ["@plate"] = oldPlate
                                }, function (lastCheckPlate)
                                    if lastCheckPlate[1] == nil then 
                                        cb(false)
                                    else
                                        if lastCheckPlate[1].citizenid == citizenId then 
                                            MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                                            local jsonData = json.decode(lastCheckPlate[1].mods)
                                            if jsonData.plate ~= nil then 
                                                jsonData.plate = newPlate
                                                local mods = json.encode(jsonData)
                                                MySQL.Async.execute("UPDATE player_vehicles SET plate = @plate, mods = @mods WHERE plate = @oldPlate", {
                                                    ["@oldPlate"] = oldPlate,
                                                    ["@plate"] = newPlate,
                                                    ["@mods"] = mods,
                                                })              
                                            else
                                                MySQL.Async.execute("UPDATE player_vehicles SET plate = @plate WHERE plate = @oldPlate", {
                                                    ["@oldPlate"] = oldPlate,
                                                    ["@plate"] = newPlate,
                                                })  
                                            end
                                            SendToDiscord("CitizenID: ``"..citizenId.."``\nOld Plate: ``"..oldPlate.."``\nNew Plate: ``"..newPlate.."``\nVehicle plate changed!")
                                            cb(true)
                                        else
                                            cb(false)
                                        end
                                    end
                                end)
                            else
                                cb(false)
                            end
                        end) 
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end) 
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('ak4y-donateSystem:getPrivNumber', function(source, cb, veri)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    for k, v in pairs(AK4Y.Customize) do
        if v.id == veri.itemInfo.id then 
            data = v
            break
        end
    end
    if data then
        local costCredit = tonumber(data.costCredit)
        local newNumber = veri.input
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    local resultData = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', { citizenId })
                    if resultData[1] ~= nil then 
                        if AK4Y.Phone == "qb-phone" then 
                            local query = '%' .. newNumber .. '%'
                            local checkPhone = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
                            if checkPhone == 0 then
                                local charInfo = json.decode(resultData[1].charinfo)
                                if charInfo.phone then 
                                    MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                                    charInfo.phone = newNumber
                                    cb(true)
                                    DropPlayer(_source, "[ak4y-donateSystem] Phone number changed!")
                                    SendToDiscord("CitizenID: ``"..citizenId.."``\nNew Number: ``"..newNumber.."``\nPhone number changed!")
                                    Wait(5000)
                                    local newInfo = json.encode(charInfo)
                                    MySQL.update('UPDATE players SET charinfo = ? WHERE citizenid = ?', { newInfo, citizenId })
                                else
                                    cb(false)
                                end
                            else
                                cb(false)
                            end
                        elseif AK4Y.Phone == "gcphone" then
                            local resultPhone = MySQL.query.await('SELECT * FROM players WHERE number = ?', { newNumber })
                            if resultPhone[1] == nil then
                                local charInfo = json.decode(resultData[1].charinfo)
                                if charInfo.phone then 
                                    MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                                    charInfo.phone = newNumber
                                    cb(true)
                                    DropPlayer(_source, "[ak4y-donateSystem] Phone number changed!")
                                    SendToDiscord("CitizenID: ``"..citizenId.."``\nNew Number: ``"..newNumber.."``\nPhone number changed!")
                                    Wait(5000)
                                    local newInfo = json.encode(charInfo)
                                    if resultData[1].number ~= nil then 
                                        MySQL.update('UPDATE players SET number = ?, charinfo = ? WHERE citizenid = ?', { newNumber, newInfo, citizenId })
                                    else
                                        MySQL.update('UPDATE players SET charinfo = ? WHERE citizenid = ?', { newInfo, citizenId })
                                    end
                                else
                                    cb(false)
                                end 
                            else
                                cb(false)                                    
                            end
                        end
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        elseif AK4Y.Mysql == "mysql-async" then 
            MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem WHERE citizenid = @citizenid", {
                ["@citizenid"] = citizenId
            }, function (result)
                if result[1] ~= nil then 
                    if result[1].credit >= costCredit then
                        MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid", {
                            ["@citizenid"] = citizenId
                        }, function (resultData)
                            if resultData[1] ~= nil then 
                                if AK4Y.Phone == "qb-phone" then 
                                    local query = '%' .. newNumber .. '%'
                                    MySQL.Async.fetchAll("SELECT COUNT(*) as count FROM players WHERE charinfo LIKE @number", {
                                        ["@number"] = query
                                    }, function (checkPhone)
                                        if checkPhone[1].count == 0 then 
                                            local charInfo = json.decode(resultData[1].charinfo)
                                            if charInfo.phone then 
                                                charInfo.phone = newNumber
                                                MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                                                cb(true)
                                                DropPlayer(_source, "[ak4y-donateSystem] Phone number changed!")
                                                SendToDiscord("CitizenID: ``"..citizenId.."``\nNew Number: ``"..newNumber.."``\nPhone number changed!")
                                                Wait(5000)
                                                local newInfo = json.encode(charInfo)
                                                MySQL.Async.execute("UPDATE players SET charinfo = @charinfo WHERE citizenid = @citizenid", {
                                                    ["@citizenid"] = citizenId,
                                                    ["@charinfo"] = newInfo,
                                                })  
                                            else
                                                cb(false)
                                            end
                                        else
                                            cb(false)
                                        end
                                    end)
                                elseif AK4Y.Phone == "gcphone" then 
                                    MySQL.Async.fetchAll("SELECT * FROM players WHERE number = @number", {
                                        ["@number"] = newNumber
                                    }, function (resultPhone)
                                        if resultPhone[1] == nil then
                                            local charInfo = json.decode(resultData[1].charinfo)
                                            if charInfo.phone then 
                                                MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                                                charInfo.phone = newNumber
                                                cb(true)
                                                DropPlayer(_source, "[ak4y-donateSystem] Phone number changed!")
                                                SendToDiscord("CitizenID: ``"..citizenId.."``\nNew Number: ``"..newNumber.."``\nPhone number changed!")
                                                Wait(5000)
                                                local newInfo = json.encode(charInfo)
                                                if resultData[1].number ~= nil then 
                                                    MySQL.Async.execute("UPDATE players SET number = @number, charinfo = @charinfo WHERE citizenid = @citizenid", {
                                                        ["@citizenid"] = citizenId,
                                                        ["@number"] = newNumber,
                                                        ["@charinfo"] = newInfo,
                                                    })  
                                                else
                                                    MySQL.Async.execute("UPDATE players SET charinfo = @charinfo WHERE citizenid = @citizenid", {
                                                        ["@citizenid"] = citizenId,
                                                        ["@charinfo"] = newInfo,
                                                    })  
                                                end
                                            else
                                                cb(false)
                                            end 
                                        else
                                            cb(false)                                    
                                        end
                                    end)
                                end
                            else
                                cb(false)
                            end
                        end)
                    else
                        cb(false)
                    end
                end
            end)
        end
    else
        cb(false)
    end
end)

function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local send = false
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end