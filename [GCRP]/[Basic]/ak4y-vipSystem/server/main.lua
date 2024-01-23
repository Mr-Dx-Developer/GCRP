if AK4Y.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif AK4Y.Framework == "oldqb" then 
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
end


QBCore.Functions.CreateCallback('ak4y-donateSystem:getPlayerDetails', function(source, cb)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local charInfo = xPlayer.PlayerData.charinfo
    local identifier = GetPlayerIdentifiers(_source)[1]
    local steamid = tonumber(identifier:gsub("steam:",""), 16)

    local callbackData = {}
    if AK4Y.Mysql == "oxmysql" then 
        local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
        if result[1] == nil then 
            callbackData = {
                playerData = {
                    ["credit"] = 0,
                },
                charInfo = charInfo,
                apiKey = steamApiKey,
                steamid = steamid,
            }
        else
            callbackData = {
                playerData = result[1], 
                charInfo = charInfo,
                apiKey = steamApiKey,
                steamid = steamid,
            }
        end
        cb(callbackData)
    elseif AK4Y.Mysql == "mysql-async" then
        MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] == nil then 
                callbackData = {
                    playerData = {
                        ["credit"] = 0,
                    },
                    charInfo = charInfo,
                    apiKey = steamApiKey,
                    steamid = steamid,
                }
            else
                callbackData = {
                    playerData = result[1], 
                    charInfo = charInfo,
                    apiKey = steamApiKey,
                    steamid = steamid,
                }
            end
            cb(callbackData)
        end) 
    end
end)



QBCore.Functions.CreateCallback('ak4y-donateSystem:sendInput', function(source, cb, data)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local inputData = data.input
    if AK4Y.Mysql == "oxmysql" then
        local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem_codes WHERE code = ?', { inputData })
        if result[1] ~= nil then 
            MySQL.query('DELETE FROM ak4y_donatesystem_codes WHERE code = ?', {inputData})
            local result2 = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result2[1] ~= nil then 
                MySQL.update('UPDATE ak4y_donatesystem SET credit = credit + '..result[1].credit..' WHERE citizenid = ?', { citizenId })
            else
                MySQL.insert('INSERT INTO ak4y_donatesystem (citizenid, credit) VALUES (?, ?)', {
                    citizenId,
                    result[1].credit,
                })
            end
            SendToDiscord("CitizenID: ``"..citizenId.."``\nCredit: ``"..result[1].credit.."\nCode: ``"..inputData.."``\nUsed code!")
            cb(result[1].credit)
        else
            cb(false)
        end
    elseif AK4Y.Mysql == "mysql-async" then 
        MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem_codes WHERE code = @code", {
            ["@code"] = inputData
        }, function (result)
            if result[1] ~= nil then 
                MySQL.Async.execute('DELETE FROM ak4y_donatesystem_codes WHERE code = @code', {['@code'] = inputData})
                MySQL.Async.fetchAll("SELECT * FROM ak4y_donatesystem WHERE citizenid = @citizenid", {
                    ["@citizenid"] = citizenId
                }, function (result2)
                    if result2[1] ~= nil then 
                        MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit + @credit WHERE citizenid = @citizenid", {
                            ['@citizenid'] = citizenId,
                            ['@credit'] = result[1].credit
                        })
                    else
                        MySQL.Async.execute('INSERT INTO ak4y_donatesystem (citizenid, credit) VALUES (@citizenid, @credit)', {
                            ["@citizenid"] = citizenId,
                            ["@credit"] = result[1].credit,
                        })
                    end
                    SendToDiscord("CitizenID: ``"..citizenId.."``\nCredit: ``"..result[1].credit.."\nCode: ``"..inputData.."``\nUsed code!")
                    cb(result[1].credit)
                end) 
            else
                cb(false)
            end
        end) 
    end
end)

QBCore.Functions.CreateCallback('ak4y-donateSystem:getItem', function(source, cb, veri)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    for k, v in pairs(AK4Y.Items) do
        if v.id == veri.itemInfo.id then 
            data = v
            break
        end
    end
    if data then
        local costCredit = tonumber(data.costCredit)
        local rewardItem = data.itemName
        local rewardItemCount = data.itemCount
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                    xPlayer.Functions.AddItem(rewardItem, rewardItemCount)
                    SendToDiscord("CitizenID: ``"..citizenId.."``\nItem: ``"..rewardItem.."``\nGot item!")
                    cb(true)
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
                        MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                        xPlayer.Functions.AddItem(rewardItem, rewardItemCount)
                        SendToDiscord("CitizenID: ``"..citizenId.."``\nItem: ``"..rewardItem.."``\nGot item!")
                        cb(true)
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

QBCore.Functions.CreateCallback('ak4y-donateSystem:getMoney', function(source, cb, veri)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    for k, v in pairs(AK4Y.Money) do
        if v.id == veri.itemInfo.id then 
            data = v
            break
        end
    end
    if data then 
        local costCredit = tonumber(data.costCredit)
        local rewardMoney = data.inGameMoney
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                    xPlayer.Functions.AddMoney('bank', rewardMoney)
                    SendToDiscord("CitizenID: ``"..citizenId.."``\nMoney:``"..rewardMoney.."``\nGot money!")
                    cb(true)
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
                        MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                        xPlayer.Functions.AddMoney('bank', rewardMoney)
                        SendToDiscord("CitizenID: ``"..citizenId.."``\nMoney:``"..rewardMoney.."``\nGot money!")
                        cb(true)
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


RegisterCommand('purchase_donate_credit', function(source, args)
	local src = source
    if src == 0 then
        local dec = json.decode(args[1])
        local tbxid = dec.transid
        local credit = dec.credit
        while inProgress do
            Wait(1000)
        end
        inProgress = true
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem_codes WHERE code = ?', { tbxid })
            if result[1] == nil then
                MySQL.insert('INSERT INTO ak4y_donatesystem_codes (code, credit) VALUES (?, ?)', { tbxid, credit })
                SendToDiscord("Code: ``"..tbxid.."``\nCredit: ``"..credit.."``\nsuccessfuly into your database!")
            end
            inProgress = false  
        elseif AK4Y.Mysql == "mysql-async" then
            MySQL.Async.fetchAll('SELECT * FROM ak4y_donatesystem_codes WHERE code = @code', {['@code'] = tbxid}, function(result)
                if result[1] == nil then
                    MySQL.Async.execute('INSERT INTO ak4y_donatesystem_codes (code, credit) VALUES (@code, @credit)', {
                        ["@code"] = tbxid,
                        ["@credit"] = credit,
                    })
                    SendToDiscord("Code: ``"..tbxid.."``\nCredit: ``"..credit.."``\nsuccessfuly into your database!")
                end
                inProgress = false
            end)  
        end
    end
end)


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if AK4Y.UseTebex then 
            local tebexConvar = GetConvar('sv_tebexSecret', '')
            if tebexConvar == '' or tebexConvar == nil then
                print('^1////////////////////////////////////////////////////////////////////////////////////////////////////////////')
                print('^1//////////////////////////////////////////^Tebex Secret Missing.^1//////////////////////////////////////////')
                print('^1////////////////////////////////////////////////////////////////////////////////////////////////////////////')
                print('ak4y-donateSystem: Tebex Secret Missing please set in server.cfg and try again. Script will not work correctly.')
                shouldStop = true
            end
        end
	end
end)

local DISCORD_NAME = "ak4y-donateSystem"
local DISCORD_IMAGE = "https://i.imgur.com/Q72RWcB.png"
DiscordWebhook = Discord_Webhook
function SendToDiscord(name, message, color)
	if DiscordWebhook == "CHANGE_WEBHOOK" then
	else
		local connect = {
            {
                ["color"] = color,
                ["title"] = "**".. name .."**",
                ["description"] = message,
                ["footer"] = {
                ["text"] = "ak4y development",
                },
            },
	    }
		PerformHttpRequest(DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatarrl = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
	end
end


QBCore.Functions.CreateCallback('ak4y-donateSystem:getWeapon', function(source, cb, veri)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local citizenId = xPlayer.PlayerData.citizenid
    local data = nil
    for k, v in pairs(AK4Y.Weapons) do
        if v.id == veri.itemInfo.id then 
            data = v
            break
        end
    end
    if data then
        local costCredit = tonumber(data.costCredit)
        local rewardItem = data.weaponName
        if AK4Y.Mysql == "oxmysql" then
            local result = MySQL.query.await('SELECT * FROM ak4y_donatesystem WHERE citizenid = ?', { citizenId })
            if result[1] ~= nil then 
                if result[1].credit >= costCredit then
                    MySQL.update('UPDATE ak4y_donatesystem SET credit = credit - ? WHERE citizenid = ?', { costCredit, citizenId })
                    if AK4Y.WeaponType == "item" then 
                        xPlayer.Functions.AddItem(rewardItem, 1)
                    elseif AK4Y.WeaponType == "weapon" then 
                        xPlayer.addWeapon(rewardItem, 1)
                    end
                    SendToDiscord("CitizenID: ``"..citizenId.."``\nItem: ``"..rewardItem.."``\nGot item!")
                    cb(true)
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
                        MySQL.Async.execute("UPDATE ak4y_donatesystem SET credit = credit - "..costCredit.." WHERE citizenid = @citizenid", {["@citizenid"] = citizenId})
                        if AK4Y.WeaponType == "item" then 
                            xPlayer.Functions.AddItem(rewardItem, 1)
                        elseif AK4Y.WeaponType == "weapon" then 
                            xPlayer.addWeapon(rewardItem, 1)
                        end
                        SendToDiscord("CitizenID: ``"..citizenId.."``\nItem: ``"..rewardItem.."``\nGot item!")
                        cb(true)
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


function addCredit(player, creditCount)
    local src = tonumber(player)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then 
        local citizenId = xPlayer.PlayerData.citizenid
        local deger = tonumber(creditCount)
        local result = ExecuteSql("SELECT * FROM ak4y_donatesystem WHERE citizenid = '"..citizenId.."'")
        if result[1] ~= nil then 
            ExecuteSql("UPDATE ak4y_donatesystem SET credit = credit + '"..deger.."' WHERE citizenid = '"..citizenId.."'")
            return true
        else
            ExecuteSql("INSERT INTO ak4y_donatesystem (citizenid, credit) VALUES ('"..citizenId.."', '"..deger.."')")
            return true
        end
    else
        return false
    end 
end

function removeCredit(player, creditCount)
    local src = tonumber(player)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then 
        local citizenId = xPlayer.PlayerData.citizenid
        local deger = tonumber(creditCount)
        local result = ExecuteSql("SELECT * FROM ak4y_donatesystem WHERE citizenid = '"..citizenId.."'")
        if result[1] ~= nil then 
            ExecuteSql("UPDATE ak4y_donatesystem SET credit = credit - '"..deger.."' WHERE citizenid = '"..citizenId.."'")
            return true
        else
            return true
        end
    else
        return false
    end 
end


function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if AK4Y.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif AK4Y.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif AK4Y.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end