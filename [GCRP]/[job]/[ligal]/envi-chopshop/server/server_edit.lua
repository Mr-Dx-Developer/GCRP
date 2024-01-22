WEBHOOK = '' -- REPLACE WITH YOUR WEBHOOK
--- EDIT HERE FOR CHECKING IF VEHICLE IS OWNED AND HARDCORE MODE COMPLETION

function HardcoreChopComplete(carData, vehicleModel, vehiclePlate)
    if Config.Debug then
        print('DATABASE Plate: ',carData.plate)
        print('Chopping vehicle plate: ', vehiclePlate)
        print('DATABASE vehicle model hash: ',GetHashKey(carData.vehicle))
        print('Chopping vehicle model: ', vehicleModel)
    end
    if not carData then
        return
    end
    if GetHashKey(carData.vehicle) ~= vehicleModel then
        print('envi-chopshop: Possible exploit attempt. - Vehicle model being chopped does not match the database. Player: '..GetPlayerName(source).. ' - Model: '..vehicleModel.. ' - Database Model: '..GetHashKey(carData.vehicle))
        return
    end
    if carData.plate ~= vehiclePlate then
        print('envi-chopshop: Possible exploit attempt. - Vehicle plate being chopped does not match the database. Player: '..GetPlayerName(source)..' - Plate: '..vehiclePlate.. ' - Database Plate: '..carData.plate)
        return
    end

    -- add additonal rewards or consequences here for PLAYER OWNED VEHICLES

    ---- [EXAMPLES] ----
    ---- Remove Car From Database (QB)

    -- MySQL.Async.execute('DELETE FROM player_vehicles WHERE plate = @plate', {
    --     ['@plate'] = carData.plate
    -- }, function(rowsChanged)
    --     if rowsChanged > 0 then
    --         print('envi-chopshop: '..carData.plate..' has been removed from the database.')
    --     else
    --         print('envi-chopshop: '..carData.plate..' was not found in the database.')
    --     end
    -- end)

    ---- Remove Car From Database (ESX)

    -- MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
    --     ['@plate'] = carData.plate
    -- }, function(rowsChanged)
    --     if rowsChanged > 0 then
    --         print('envi-chopshop: '..carData.plate..' has been removed from the database.')
    --     else
    --         print('envi-chopshop: '..carData.plate..' was not found in the database.')
    --     end
    -- end)
    
    local player = Framework.GetPlayer(source)
    if not player then return end
    local identifier = player.Identifier
    local name = player.Firstname..' '..player.Lastname
    local message = ":fire: Hardcore Chop Completed: "..name.." has chopped an OWNED "..vehicleModel.." with the plate "..vehiclePlate.." - Identifier: "..identifier
    SendDiscordLog(WEBHOOK, message, 15158332)
end

Framework.CreateCallback('envi-chopshop:isVehOwned', function(source, cb, vehiclePlate)    
    -- -- [NOTE]: You must edit this code to prevent players choopping their own vehicle even if HardcoreMode is false
    -- -- UNCOMMENT BELOW FOR QB-CORE   

    -- MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {        
    --     ['@plate'] = vehiclePlate
    -- }, function(result)
    --     if result[1] then
    --         -- GET ALL VEHICLE DATA
    --         local vehicleData = result[1]
    --         -- GET VEHICLE OWNER
    --         local owner = vehicleData.citizenid
    --         cb(vehicleData, owner)
    --     else
    --         cb(false)
    --     end
    -- end)

    -- -- [NOTE]: You must edit this code to prevent players choopping their own vehicle even if HardcoreMode is false
    -- -- UNCOMMENT BELOW FOR ESX

    -- MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
    --     ['@plate'] = vehiclePlate
    -- }, function(result)
    --     if result[1] then
    --         -- GET ALL VEHICLE DATA
    --         local vehicleData = result[1]
    --         -- GET VEHICLE OWNER
    --         local owner = vehicleData.owner
    --         cb(vehicleData, owner)
    --     else
    --         cb(false)
    --     end
    -- end)


    -- -- [NOTE]: Remove the line below if you uncomment the above code
    cb(false)

end)

------------------------------------------------------------------------------------------------------

RegisterNetEvent('envi-chopshop:payOut', function(reward, stage, shopName)
    if not stage then return end
    if Config.RewardsAccount then
        if Config.RewardsAccount == 'money' then Config.RewardsAccount = 'cash' end
        local src = source
        local player = Framework.GetPlayer(src)
        if not player then return end
        player.AddMoney(Config.RewardsAccount, reward)
        TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['reward_message'] .. reward, 'success', 3500)
        local identifier = player.Identifier
        local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
        if shop then
            local shopInfo = shop[1]
            if shopInfo then
                if shopInfo.owner ~= identifier then
                    local amount = reward / Config.ChopShops[shopName].Percentage
                    if Config.Debug then
                        print('envi-chopshop: '..shopName..' has been paid '..amount..' by '..identifier)
                    end
                    Database.query('UPDATE `envi-chopshop` SET `funds` = `funds` + ? WHERE `shop` = ?', {amount, shopName})
                end
            end
        end

        if Config.AdditionalRewardsItem then
            Framework.AddItem(src, Config.AdditionalRewardsItem, Config.AdditionalRewardsAmount)
        end
    end
end)

RegisterNetEvent('envi-chopshop:giveItem', function(itemFind)
    if itemFind then
        local randomItem = Config.LootItems[math.random(#Config.LootItems)]
        local player = Framework.GetPlayer(source)
        if player then
            Framework.AddItem(source, randomItem, math.random(Config.LootMin, Config.LootMax))
        end
    else
        print('envi-chopshop: Possible exploit attempt.')
    end
end)

RegisterNetEvent('envi-chopshop:salvageParts', function(part)
    local itemFound = false
    for k, v in pairs(Config.CarPartsItems) do
        if v == part then
            itemFound = true
        end
    end
    if itemFound then
        local player = Framework.GetPlayer(source)
        if player then
            Framework.AddItem(source, part, 1)
        end
    else
        print('envi-chopshop: Possible exploit attempt.')
    end
end)


Framework.CreateCallback('envi-chopshop:checkPolice', function(source, cb)
    local job = Config.JobToCheck
    local jobAmount = Config.AmountOnline
    local jobOnline = 0
    if Config.CheckPoliceOnline then
        local players = GetPlayers()
        for k, v in pairs(players) do
            local player = Framework.GetPlayer(tonumber(v))
            if player then
                if player.Job.Name == job then
                    jobOnline = jobOnline + 1
                end
            end
        end
        if jobOnline <= jobAmount then
            cb(false)
        else
            cb(true)
        end
    else
        cb(true)
    end
end)

Framework.CreateCallback('envi-chopshop:checkShopOwner', function(source, cb, shopName)
    local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
    if not shop then
        cb(nil)
    end
    local shopInfo = shop[1]
    if shopInfo then
        cb(shopInfo)
    else
        cb(nil)
    end
end)

Framework.CreateCallback('envi-chopshop:buyChopShop', function(source, cb, shopName, price)
    local player = Framework.GetPlayer(source)
    if not player then
        cb(false)
    end
    local identifier = player.Identifier
    local bankBalance = player.GetMoney('bank')
    local ownerName = player.Firstname..' '..player.Lastname
    if bankBalance >= price then
        player.RemoveMoney('bank', price)
        Database.query('INSERT INTO `envi-chopshop` (`shop`, `owner`, `ownerName`) VALUES (?, ?, ?)', {shopName, identifier, ownerName})
        cb(true)
    else
        cb(false)
    end
end)

local contractCooldown = {}
RegisterNetEvent('envi-chopshop:generateSpecialContract', function(shopName)
    local src = source
    if not shopName then return end
    local ownerPlayer = Framework.GetPlayer(src)
    if not ownerPlayer then return end
    local ownerName = ownerPlayer.Firstname..' '..ownerPlayer.Lastname
    local currentTime = os.time()
    if not contractCooldown[shopName] or currentTime > contractCooldown[shopName] then
        contractCooldown[shopName] = currentTime + Config.SpecialContractCooldown * 60
        local contract = math.random(1, #Config.SpecialContractVehicles)
        local vehicle = Config.SpecialContractVehicles[contract].model
        local vehicleName = lib.callback.await('envi-chopshop:getVehicleInfo', src, vehicle)
        Framework.AddItem(src, Config.ContractItem, 1, {vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
    else
        local timeInMins = math.floor((contractCooldown[shopName] - currentTime) / 60)
        TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['cannot_generate']..timeInMins..Config.Lang['cannot_generate'], 'error', 3500)
    end
end)

RegisterNetEvent('envi-chopshop:checkForContracts', function(vehicleName, shopName)
    if not shopName or not vehicleName then return end
    local src = source
    local item = Framework.HasItem(src, Config.ContractItem, 1)
    if item then
        local player = Framework.GetPlayer(src)
        if not player then return end
        local identifier = player.Identifier
        local shop = Database.query('SELECT * FROM `envi-chopshop` WHERE `shop` = ?', {shopName})
        if not shop then return end
        local shopInfo = shop[1]
        if not shopInfo then return end
        local ownerName = shopInfo.ownerName
        local itemWithData = Framework.HasItem(src, Config.ContractItem, 1, { vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
        if itemWithData then
            if shopInfo then
                if shopInfo.owner == identifier then
                    TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['cannot_claim_own'], 'error', 3500)
                    return
                end
            end
            Framework.RemoveItem(src, Config.ContractItem, 1, { vehicle = vehicleName, shop = shopName, shopOwner = ownerName})
            player.AddMoney('cash', Config.ContractCompleteBonus)
            TriggerClientEvent('envi-chopshop:notify', src, Config.Lang['completed_contract']..shopInfo.ownerName..Config.Lang['recieved_extra']..Config.ContractCompleteBonus, 'success', 3500)
            Database.query('UPDATE `envi-chopshop` SET `funds` = `funds` + ? WHERE `shop` = ?', {Config.ContractCompleteBonus, shopName})
            -- ADD WEBHOOK FOR CONTRACT 
            local message = ':moneybag: '..player.Firstname..' '..player.Lastname..' has completed a contract for '..shopInfo.ownerName..' and recieved an extra'..Config.ContractCompleteBonus..' - Vehicle: '..vehicleName..'- Identifier: '..identifier
            SendDiscordLog(WEBHOOK, message, 3066993)
        end
    end
end)

RegisterNetEvent('envi-chopshop:log', function(vehDisplayName, reward, shop)
    local src = source
    local player = Framework.GetPlayer(src)
    if not player then return end
    local identifier = player.Identifier
    local name = player.Firstname..' '..player.Lastname
    local message = ':car: '..name..' has chopped a '..vehDisplayName..' at '..shop..' and recieved '..reward..' - Identifier: '..identifier
    SendDiscordLog(WEBHOOK, message, 3447003)
end)

Framework.CreateUseableItem(Config.ContractItem, function(source, item, data)
    local metadata = data.metadata
    local src = source
    TriggerClientEvent('envi-chopshop:viewContract', src, metadata)
end)

function SendDiscordLog(webhookUrl, message, color)
    if not WEBHOOK or WEBHOOK == '' then
        return
    end
    local embed = {
        {
            ["color"] = color, -- You can set color based on log type
            ["title"] = "**Chop Shop Log**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Chop Shop Logs",
            },
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end


