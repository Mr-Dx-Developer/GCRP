bot_Token = ""
bot_logo = "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
bot_name = "Codem Store"

local discord_webhook = {
    ['bill'] = "",
    ['cancelled'] = "",
    ['paybill'] = ""
}


function discordLogBilling(src, data, discordWebhook, desc)
    local xPlayer = GetPlayerFromIdentifier(data.targetIdentifier) or 'undefined'
    local xSource = GetSource(xPlayer) or 'undefined'
    local message = {
        username = bot_name,
        embeds = {
            {
                title = botname,
                color = 0xFFA500,
                author = {
                    name = desc,
                },
                fields = {
                    { name = "Invoiced Player Name", value = data.name or false,              inline = true },
                    { name = "Invoiced Player ID",   value = src or false,                    inline = true },
                    { name = "Invoiced Player JOB",  value = data.societyname or 'undefined', inline = true },
                    {
                        name = "──────────────────────────────────────────────────",
                        value = "",
                        inline = false
                    },
                    { name = "Player Name", value = data.targetname or false,         inline = true },
                    { name = "Player ID",   value = xSource or 'undefined',           inline = true },
                    { name = "Amount",      value = data.amount or 'undefined',       inline = true },
                    { name = "Reason",      value = data.invoicelabel or 'undefined', inline = true },
                    { name = "Unique Id",   value = data.uniqueid or 'undefined',     inline = true },
                },
                footer = {
                    text = "Codem Store - https://discord.gg/zj3QsUfxWs",
                    icon_url =
                    "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png"
                },

                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        },
        avatar_url = bot_logo
    }

    PerformHttpRequest(discord_webhook[discordWebhook], function(err, text, headers) end,
        "POST",
        json.encode(message),
        { ["Content-Type"] = "application/json" })
end

local cooldowns = {}


Citizen.CreateThread(function()
    while Core == nil do
        Citizen.Wait(0)
    end
    Citizen.Wait(500)
    RegisterCallback('codem-billing:getMyBilling', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local billingData = allBillingData[identifier]
        if billingData then
            cb(billingData)
        else
            cb(false)
        end
    end)
    RegisterCallback('codem-billing:getPlayerName', function(source, cb, targetSrc)
        local src = source
        local Player = GetPlayer(targetSrc)
        if Player then
            cb(GetName(tonumber(targetSrc)))
        else
            cb(false)
        end
    end)
    RegisterCallback('codem-billing:findBillingPlayer', function(source, cb, plyid)
        local src = source
        local myPed = GetPlayerPed(source)
        local myCoords = GetEntityCoords(myPed)
        if tonumber(plyid) == tonumber(src) then
            cb(false)
            return Config.Notification(Config.NotificationText['notbillyour'].text,
                Config.NotificationText['notbillyour'].type,
                true, src)
        end

        local data = {}
        for _, v in pairs(GetPlayers()) do
            if tonumber(v) == tonumber(plyid) then
                local targetPed = GetPlayerPed(v)
                local targetCoords = GetEntityCoords(targetPed)
                local dist = #(myCoords - targetCoords)
                if dist < 8.0 then
                    local name = GetName(tonumber(v))
                    data = {
                        name = name,
                        id = v,
                    }
                end
            end
        end
        if data then
            cb(data)
        else
            Config.Notification(Config.NotificationText['notfindplayer'].text,
                Config.NotificationText['notfindplayer'].type,
                true, src)
            cb(false)
        end
    end)


    RegisterCallback('codem-billing:GetNearbyPlayers', function(source, cb)
        local src = source
        local players = {}
        local myPed = GetPlayerPed(source)
        local myCoords = GetEntityCoords(myPed)
        for _, v in pairs(GetPlayers()) do
            if tonumber(v) ~= tonumber(src) then
                local targetPed = GetPlayerPed(v)
                local targetCoords = GetEntityCoords(targetPed)
                local dist = #(myCoords - targetCoords)
                if dist < 8.0 then
                    local name = GetName(tonumber(v))
                    local avatar = GetDiscordAvatar(tonumber(v)) or Config.ExampleProfilePicture
                    table.insert(players, {
                        name = name,
                        id = v,
                        avatar = avatar
                    })
                end
            end
        end
        cb(players)
    end)
    RegisterCallback('codem-billing:cancelBilling', function(source, cb, id)
        local src = source
        local identifier = GetIdentifier(src)
        local isAdmin = false
        if Config.Admin[GetIdentifier(src)] then
            isAdmin = true
        end
        if not isAdmin then
            cb(false)
            return Config.Notification(Config.NotificationText['notacces'].text, Config.NotificationText['notacces']
                .type,
                true, src)
        end

        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if tonumber(invoice.uniqueid) == tonumber(id) then
                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'canceled' WHERE uniqueid = '" ..
                        tonumber(invoice.uniqueid) .. "'")
                    invoice.status = 'canceled'
                    Citizen.Wait(100)
                    discordLogBilling(src, invoice, 'cancelled', Config.Locales['CANCELBILLING'])
                    cb(allBillingData)
                    return
                end
            end
        end
    end)
    RegisterCallback('codem-billing:cancelmybilling', function(source, cb, id)
        local src = source
        local identifier = GetIdentifier(src)
        local isAdmin = false
        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if tonumber(invoice.uniqueid) == tonumber(id) then
                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'canceled' WHERE uniqueid = '" ..
                        tonumber(invoice.uniqueid) .. "'")
                    invoice.status = 'canceled'
                    Citizen.Wait(100)
                    discordLogBilling(src, invoice, 'cancelled', Config.Locales['CANCELBILLING'])
                    cb(allBillingData[identifier])
                    return
                end
            end
        end
    end)

    RegisterCallback('codem-billing:checkInvoice', function(source, cb, uniqueid)
        local src = source

        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if tonumber(invoice.uniqueid) == tonumber(uniqueid) then
                    if invoice.status == 'unpaid' then
                        cb(invoice)
                        return
                    elseif invoice.status == 'canceled' then
                        cb(false)
                        return Config.Notification(Config.NotificationText['cancelledbill'].text,
                            Config.NotificationText['cancelledbill'].type, true, src)
                    else
                        cb(false)
                        return Config.Notification(Config.NotificationText['paidbill'].text,
                            Config.NotificationText['paidbill'].type, true, src)
                    end
                end
            end
        end
        Config.Notification(Config.NotificationText['wrongbillid'].text,
            Config.NotificationText['wrongbillid'].type, true, src)
        cb(false)
    end)


    RegisterCallback('codem-billing:cancelBillingJob', function(source, cb, id)
        local src = source
        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if tonumber(invoice.uniqueid) == tonumber(id) then
                    if invoice.identifier == GetIdentifier(src) then
                        ExecuteSql("UPDATE `codem_billing` SET `status` = 'canceled' WHERE uniqueid = '" ..
                            tonumber(invoice.uniqueid) .. "'")
                        invoice.status = 'canceled'
                        Citizen.Wait(100)
                        discordLogBilling(src, invoice, 'cancelled', Config.Locales['CANCELBILLING'])
                    else
                        cb(false)
                        return Config.Notification(Config.NotificationText['notowner'].text,
                            Config.NotificationText['notowner'].type, true, src)
                    end
                end
            end
        end
        cb(allBillingData)
        return
    end)

    RegisterCallback('codem-billing:getAllBill', function(source, cb)
        local newData = {}
        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                table.insert(newData, invoice)
            end
        end
        if #newData > 0 then
            cb(newData)
        else
            cb(false)
        end
    end)

    RegisterCallback('codem-billing:getPlayerMoney', function(source, cb)
        local src = source
        local playerMoney = getPlayerMoney(src)
        cb(playerMoney)
    end)

    RegisterCallback('codem-billing:getPlayerAccount', function(source, cb)
        local src = source
        local isAdmin = false
        if Config.Admin[GetIdentifier(src)] then
            isAdmin = true
        end

        local data = {
            money = getPlayerMoney(src),
            avatar = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
            name = GetName(src),
            isAdmin = isAdmin
        }
        cb(data)
    end)

    RegisterCallback('codem-billing:getSocietyBills', function(source, cb, society)
        local newData = {}
        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if invoice.societyname == society then
                    table.insert(newData, invoice)
                end
            end
        end
        if #newData > 0 then
            cb(newData)
        else
            cb(false)
        end
    end)

    RegisterCallback('codem-billing:getmyAllBillingData', function(source, cb)
        local src = source
        local xidentifier = GetIdentifier(tonumber(src))
        local newData = {}
        for identifier, invoices in pairs(allBillingData) do
            for _, invoice in pairs(invoices) do
                if invoice.identifier == xidentifier then
                    if invoice.societyname == 'identifier' then
                        table.insert(newData, invoice)
                    end
                end
            end
        end
        cb(newData)
    end)

    RegisterCallback('codem-billing:searchBillName', function(source, cb, name)
        if name then
            local src = source
            if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
                Config.Notification(Config.NotificationText['beforewait'].text,
                    Config.NotificationText['beforewait'].type, true,
                    src)
                return
            end
            cooldowns[source] = os.time()
            local newData = {}
            for identifier, invoices in pairs(allBillingData) do
                for _, invoice in pairs(invoices) do
                    -- if invoice.targetname == name then
                    --     table.insert(newData, invoice)
                    -- end
                    if string.match(invoice.targetname, name) then
                        table.insert(newData, invoice)
                    end
                end
            end
            if next(newData) then
                cb(newData)
            else
                Config.Notification(Config.NotificationText['noypaybill'].text,
                    Config.NotificationText['noypaybill'].type,
                    true, src)
                cb(false)
            end
        end
    end)
    RegisterCallback('codem-billing:searchBill', function(source, cb, id)
        local src = source
        if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
            Config.Notification(Config.NotificationText['beforewait'].text,
                Config.NotificationText['beforewait'].type, true,
                src)
            return
        end
        cooldowns[source] = os.time()
        local xPlayer = GetPlayer(tonumber(id))
        if xPlayer then
            local xidentifier = GetIdentifier(tonumber(id))
            local newData = {}
            for identifier, invoices in pairs(allBillingData) do
                for _, invoice in pairs(invoices) do
                    if invoice.targetIdentifier == xidentifier then
                        table.insert(newData, invoice)
                    end
                end
            end
            if next(newData) then
                cb(newData)
            else
                Config.Notification(Config.NotificationText['noypaybill'].text,
                    Config.NotificationText['noypaybill'].type,
                    true, src)
                cb(false)
            end
        else
            Config.Notification(Config.NotificationText['notfindplayer'].text,
                Config.NotificationText['notfindplayer'].type,
                true, src)
            cb(false)
        end
    end)


    RegisterCallback('codem-billing:payAllBills', function(source, cb)
        if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
            Config.Notification(Config.NotificationText['beforewait'].text,
                Config.NotificationText['beforewait'].type, true,
                src)
            return
        end
        cooldowns[source] = os.time()
        local src = source
        local xPlayer = GetPlayer(src)
        if not xPlayer then return end
        local playerMoney = getPlayerMoney(src)
        local playerIdentifier = GetIdentifier(src)
        local bills = allBillingData[playerIdentifier]
        local totalAmount = 0
        for _, billData in pairs(bills) do
            totalAmount = totalAmount + tonumber(billData.amount)
        end
        local kdv = totalAmount * Config.Tax
        local totalAmountWithKdv = math.floor(totalAmount + tonumber(kdv))
        if tonumber(playerMoney) < tonumber(totalAmountWithKdv) then
            cb(false)
            return Config.Notification(Config.NotificationText['notmoney'].text,
                Config.NotificationText['notmoney'].type, true, src)
        end
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            for k, v in pairs(bills) do
                if v.status == 'unpaid' then
                    if v.societyname == 'identifier' then
                        local xPlayer = GetPlayerFromIdentifier(v.identifier)
                        local newkdv = v.amount * Config.Tax
                        local newtotalAmountWithKdv = math.floor(v.amount + tonumber(newkdv))
                        local success = RemoveMoney(src, tonumber(newtotalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['undefinedjob'].text,
                                Config.NotificationText['undefinedjob'].type, true,
                                src)
                            cb(false)
                            return
                        end

                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, newtotalAmountWithKdv)
                            v.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)
                            sendToNotifyOwner(v.targetname, v.identifier, newtotalAmountWithKdv)
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(v.uniqueid) .. "'")
                        else
                            local PlayerData = MySQL.Sync.prepare('SELECT * FROM users where identifier = ?',
                                { v.identifier })
                            if PlayerData then
                                PlayerData.accounts = json.decode(PlayerData.accounts)
                                PlayerData.accounts.bank = PlayerData.accounts.bank + tonumber(newtotalAmountWithKdv)
                                MySQL.Async.insert(
                                    'INSERT INTO users (identifier, accounts) VALUES (:identifier, :accounts) ON DUPLICATE KEY UPDATE accounts = :accounts',
                                    {
                                        identifier = PlayerData.identifier,
                                        accounts = json.encode(PlayerData.accounts),
                                    })
                                v.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)
                                sendToNotifyOwner(v.targetname, v.identifier, newtotalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(v.uniqueid) .. "'")
                            end
                        end
                    else
                        TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. v.societyname, function(account)
                            local newkdv = v.amount * Config.Tax
                            local newtotalAmountWithKdv = math.floor(v.amount + tonumber(newkdv))
                            local success = RemoveMoney(src, tonumber(newtotalAmountWithKdv))
                            if not success then
                                Config.Notification(Config.NotificationText['undefinedjob'].text,
                                    Config.NotificationText['undefinedjob'].type, true,
                                    src)
                                return
                            end
                            account.addMoney(newtotalAmountWithKdv)
                            v.status = 'paid'
                            sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(v.uniqueid) .. "'")
                        end)
                    end
                end
            end
            Citizen.Wait(150)
            cb(allBillingData[playerIdentifier])
        else
            for k, v in pairs(bills) do
                if v.status == 'unpaid' then
                    if v.societyname == 'identifier' then
                        local xPlayer = GetPlayerFromIdentifier(v.identifier)
                        local newkdv = v.amount * Config.Tax
                        local newtotalAmountWithKdv = math.floor(v.amount + tonumber(newkdv))
                        local success = RemoveMoney(src, tonumber(newtotalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['undefinedjob'].text,
                                Config.NotificationText['undefinedjob'].type, true,
                                src)
                            cb(false)
                            return
                        end
                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, newtotalAmountWithKdv)
                            v.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)
                            sendToNotifyOwner(v.targetname, v.identifier, newtotalAmountWithKdv)
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(v.uniqueid) .. "'")
                        else
                            local PlayerData = Core.Player.GetOfflinePlayer(v.identifier)
                            if PlayerData then
                                PlayerData.PlayerData.money.bank = PlayerData.PlayerData.money.bank +
                                    tonumber(newtotalAmountWithKdv)
                                Core.Player.SaveOffline(PlayerData.PlayerData)
                                v.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)

                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(v.uniqueid) .. "'")
                            end
                        end
                    else
                        local newkdv = v.amount * Config.Tax
                        local newtotalAmountWithKdv = math.floor(v.amount + tonumber(newkdv))
                        local success = RemoveMoney(src, tonumber(newtotalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['undefinedjob'].text,
                                Config.NotificationText['undefinedjob'].type, true,
                                src)
                            cb(false)
                            return
                        end
                        
                        if Config.newManagementSystem then
                            local account_money = exports["qb-banking"]:GetAccount(v.societyname)
                            if account_money and account_money.account_balance then
                                exports["qb-banking"]:AddMoney(v.societyname, tonumber(newtotalAmountWithKdv))
                            else
                                if Config.CreateJobAccount then
                                    exports["qb-banking"]:CreateJobAccount(v.societyname, 0)
                                    Wait(350)
                                    exports["qb-banking"]:AddMoney(v.societyname, tonumber(newtotalAmountWithKdv))
                                end
                            end
                        else
                            exports["qb-management"]:AddMoney(v.societyname, tonumber(newtotalAmountWithKdv))
                        end

                        Wait(100)
                        v.status = 'paid'
                        ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                            tonumber(v.uniqueid) .. "'")
                        sendToNotifyOwner(v.name, v.targetIdentifier, newtotalAmountWithKdv)
                        sendToNotifyOwner(v.targetname, v.identifier, newtotalAmountWithKdv)
                    end
                end
            end
            Citizen.Wait(150)
            cb(allBillingData[playerIdentifier])
        end
    end)

    RegisterCallback('codem-billing:payBill', function(source, cb, billid)
        local src = source
        if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
            Config.Notification(Config.NotificationText['beforewait'].text,
                Config.NotificationText['beforewait'].type, true,
                src)
            return
        end
        cooldowns[source] = os.time()
        local xPlayer = GetPlayer(src)
        if not xPlayer then return end

        local playerMoney = getPlayerMoney(src)
        local playerIdentifier = GetIdentifier(src)
        for _, billData in pairs(allBillingData[playerIdentifier]) do
            if tonumber(billData.uniqueid) == tonumber(billid) then
                if tonumber(playerMoney) >= tonumber(billData.amount) then
                    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                        if billData.societyname == 'identifier' then
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            local kdv = billData.amount * Config.Tax
                            local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                            local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                            if not success then
                                Config.Notification(Config.NotificationText['undefinedjob'].text,
                                    Config.NotificationText['undefinedjob'].type, true,
                                    src)
                                cb(false)
                                return
                            end
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                                cb(allBillingData[playerIdentifier])
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billid) .. "'")
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM users WHERE identifier = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    money = json.decode(PlayerData[1].accounts)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `users` SET `accounts` = '" ..
                                        json.encode(money) .. "' WHERE identifier = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billid) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                        src)
                                end
                            end
                        else
                            TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. billData.societyname,
                                function(account)
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                                    if not success then
                                        Config.Notification(Config.NotificationText['undefinedjob'].text,
                                            Config.NotificationText['undefinedjob'].type, true,
                                            src)
                                        return
                                    end
                                    account.addMoney(totalAmountWithKdv)
                                    billData.status = 'paid'
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billid) .. "'")
                                end)
                        end
                    else
                        local kdv = billData.amount * Config.Tax
                        local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                        local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['errormoney'].text,
                                Config.NotificationText['errormoney'].type, true,
                                src)
                            cb(false)
                            return
                        end
                        if billData.societyname ~= 'identifier' then


                            if Config.newManagementSystem then
                                local account_money = exports["qb-banking"]:GetAccount(billData.societyname)
                                if account_money and account_money.account_balance then
                                    exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                else
                                    if Config.CreateJobAccount then
                                        exports["qb-banking"]:CreateJobAccount(billData.societyname, 0)
                                        Wait(350)
                                        exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                    end
                                end
                            else
                                exports["qb-management"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                            end

                            Wait(100)
                            billData.status = 'paid'
                            cb(allBillingData[playerIdentifier])
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billid) .. "'")
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                        else
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                cb(allBillingData[playerIdentifier])
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billid) .. "'")
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM players WHERE citizenid = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    money = json.decode(PlayerData[1].money)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `players` SET `money` = '" ..
                                        json.encode(money) .. "' WHERE citizenid = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billid) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                        src)
                                end
                            end
                        end
                    end
                else
                    Config.Notification(Config.NotificationText['notmoney'].text,
                        Config.NotificationText['notmoney'].type, true,
                        src)
                end
            end
        end
    end)

    RegisterCallback('codem-billing:payBillFind', function(source, cb, billdata)
        local src = source
        if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
            Config.Notification(Config.NotificationText['beforewait'].text,
                Config.NotificationText['beforewait'].type, true,
                src)
            return
        end
        cooldowns[source] = os.time()
        local xPlayer = GetPlayer(src)
        if not xPlayer then return end

        local playerMoney = getPlayerMoney(src)
        local playerIdentifier = billdata.targetIdentifier
        for _, billData in pairs(allBillingData[playerIdentifier]) do
            if tonumber(billData.uniqueid) == tonumber(billdata.uniqueid) then
                if tonumber(playerMoney) >= tonumber(billData.amount) then
                    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                        if billData.societyname == 'identifier' then
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            local kdv = billData.amount * Config.Tax
                            local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                            local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                            if not success then
                                Config.Notification(Config.NotificationText['undefinedjob'].text,
                                    Config.NotificationText['undefinedjob'].type, true,
                                    src)
                                cb(false)
                                return
                            end
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                                cb(allBillingData[playerIdentifier])
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billdata.uniqueid) .. "'")
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM users WHERE identifier = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    money = json.decode(PlayerData[1].accounts)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `users` SET `accounts` = '" ..
                                        json.encode(money) .. "' WHERE identifier = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billdata.uniqueid) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                        src)
                                end
                            end
                        else
                            TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. billData.societyname,
                                function(account)
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                                    if not success then
                                        Config.Notification(Config.NotificationText['undefinedjob'].text,
                                            Config.NotificationText['undefinedjob'].type, true,
                                            src)
                                        return
                                    end
                                    account.addMoney(totalAmountWithKdv)
                                    billData.status = 'paid'
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billdata.uniqueid) .. "'")
                                end)
                        end
                    else
                        local kdv = billData.amount * Config.Tax
                        local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                        local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['errormoney'].text,
                                Config.NotificationText['errormoney'].type, true,
                                src)
                            cb(false)
                            return
                        end
                        if billData.societyname ~= 'identifier' then
                            if Config.newManagementSystem then
                                local account_money = exports["qb-banking"]:GetAccount(billData.societyname)
                                if account_money and account_money.account_balance then
                                    exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                else
                                    if Config.CreateJobAccount then
                                        exports["qb-banking"]:CreateJobAccount(billData.societyname, 0)
                                        Wait(350)
                                        exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                    end
                                end
                            else
                                exports["qb-management"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                            end

                            Wait(100)
                            billData.status = 'paid'
                            cb(allBillingData[playerIdentifier])
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billdata.uniqueid) .. "'")
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                        else
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                cb(allBillingData[playerIdentifier])
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billdata.uniqueid) .. "'")
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM players WHERE citizenid = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    money = json.decode(PlayerData[1].money)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `players` SET `money` = '" ..
                                        json.encode(money) .. "' WHERE citizenid = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    cb(allBillingData[playerIdentifier])
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billdata.uniqueid) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                        src)
                                end
                            end
                        end
                    end
                else
                    Config.Notification(Config.NotificationText['notmoney'].text,
                        Config.NotificationText['notmoney'].type, true,
                        src)
                end
            end
        end
    end)

    if Config.UsableItem ~= false or Config.UsableItem ~= "" then
        if Config.Framework == 'oldesx' or Config.Framework == 'esx' then
            Core.RegisterUsableItem(Config.UsableItem, function(source)
                TriggerClientEvent('codem-billing:openBillingMenu', source)
            end)
        else
            Core.Functions.CreateUseableItem(Config.UsableItem, function(source)
                TriggerClientEvent('codem-billing:openBillingMenu', source)
            end)
        end
    end
end)

RegisterServerEvent('codem-billing:payBill', function(billingId)
    local src = source
    if cooldowns[source] and (os.time() - cooldowns[source] < 5) then
        Config.Notification(Config.NotificationText['beforewait'].text,
            Config.NotificationText['beforewait'].type, true,
            src)
        return
    end
    cooldowns[source] = os.time()
    local xPlayer = GetPlayer(src)
    if not xPlayer then return end
    local playerMoney = getPlayerMoney(src)
    local playerIdentifier = GetIdentifier(src)
    for _, billData in pairs(allBillingData[playerIdentifier]) do
        if tonumber(billData.id) == tonumber(billingId) then
            if tonumber(playerMoney) >= tonumber(billData.amount) then
                if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                    if billData.societyname == 'identifier' then
                        local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                        local kdv = billData.amount * Config.Tax
                        local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                        local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['undefinedjob'].text,
                                Config.NotificationText['undefinedjob'].type, true,
                                src)
                            return
                        end
                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, totalAmountWithKdv)
                            billData.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                            discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                                tonumber(billingId) .. "'")
                        else
                            local PlayerData = ExecuteSql("SELECT * FROM users WHERE identifier = '" ..
                                billData.identifier .. "' ")
                            if PlayerData then
                                money = json.decode(PlayerData[1].accounts)
                                money.bank = money.bank + tonumber(totalAmountWithKdv)
                                ExecuteSql("UPDATE `users` SET `accounts` = '" ..
                                    json.encode(money) .. "' WHERE identifier = '" .. billData.identifier .. "'")
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                                    tonumber(billingId) .. "'")
                                discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                            else
                                Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                    Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                            end
                        end
                    else
                        TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. billData.societyname,
                            function(account)
                                local kdv = billData.amount * Config.Tax
                                local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                                if not success then
                                    Config.Notification(Config.NotificationText['undefinedjob'].text,
                                        Config.NotificationText['undefinedjob'].type, true,
                                        src)
                                    return
                                end
                                account.addMoney(totalAmountWithKdv)
                                billData.status = 'paid'
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                                    tonumber(billingId) .. "'")
                            end)
                    end
                else
                    local kdv = billData.amount * Config.Tax
                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                    local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                    if not success then
                        Config.Notification(Config.NotificationText['errormoney'].text,
                            Config.NotificationText['errormoney'].type, true,
                            src)
                        return
                    end
                    if billData.societyname ~= 'identifier' then

                        if Config.newManagementSystem then
                            local account_money = exports["qb-banking"]:GetAccount(billData.societyname)
                            if account_money and account_money.account_balance then
                                exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                            else
                                if Config.CreateJobAccount then
                                    exports["qb-banking"]:CreateJobAccount(billData.societyname, 0)
                                    Wait(350)
                                    exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                end
                            end
                        else
                            exports["qb-management"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                        end
                        Wait(100)
                        billData.status = 'paid'
                        ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                            tonumber(billingId) .. "'")
                        sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                        sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                    else
                        local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, totalAmountWithKdv)
                            billData.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                                tonumber(billingId) .. "'")
                            discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                        else
                            local PlayerData = ExecuteSql("SELECT * FROM players WHERE citizenid = '" ..
                                billData.identifier .. "' ")
                            if PlayerData then
                                local kdv = billData.amount * Config.Tax
                                local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                money = json.decode(PlayerData[1].money)
                                money.bank = money.bank + tonumber(totalAmountWithKdv)
                                ExecuteSql("UPDATE `players` SET `money` = '" ..
                                    json.encode(money) .. "' WHERE citizenid = '" .. billData.identifier .. "'")
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE id = '" ..
                                    tonumber(billingId) .. "'")
                                discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                            else
                                Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                    Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                            end
                        end
                    end
                end
            else
                Config.Notification(Config.NotificationText['notmoney'].text,
                    Config.NotificationText['notmoney'].type, true,
                    src)
            end
        end
    end
end)

RegisterServerEvent('codem-billing:server:PayBillBank', function(source, billingId)
    local src = source
    local xPlayer = GetPlayer(src)
    if not xPlayer then return end
    local playerMoney = getPlayerMoney(src)
    local playerIdentifier = GetIdentifier(src)
    for _, billData in pairs(allBillingData[playerIdentifier]) do

        if tonumber(billData.uniqueid) == tonumber(billingId) then
            if tonumber(playerMoney) >= tonumber(billData.amount) then
                if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                    if billData.societyname == 'identifier' then
                        local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                        local kdv = billData.amount * Config.Tax
                        local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                        local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['undefinedjob'].text,
                                Config.NotificationText['undefinedjob'].type, true,
                                src)
                            return
                        end
                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, totalAmountWithKdv)
                            billData.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                            discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billingId) .. "'")
                        else
                            local PlayerData = ExecuteSql("SELECT * FROM users WHERE identifier = '" ..
                                billData.identifier .. "' ")
                            if PlayerData then
                                money = json.decode(PlayerData[1].accounts)
                                money.bank = money.bank + tonumber(totalAmountWithKdv)
                                ExecuteSql("UPDATE `users` SET `accounts` = '" ..
                                    json.encode(money) .. "' WHERE identifier = '" .. billData.identifier .. "'")
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billingId) .. "'")
                                discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                            else
                                Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                    Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                            end
                        end
                    else
                        TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. billData.societyname,
                            function(account)
                                local kdv = billData.amount * Config.Tax
                                local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                                if not success then
                                    Config.Notification(Config.NotificationText['undefinedjob'].text,
                                        Config.NotificationText['undefinedjob'].type, true,
                                        src)
                                    return
                                end
                                account.addMoney(totalAmountWithKdv)
                                billData.status = 'paid'
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billingId) .. "'")
                            end)
                    end
                else
                    local kdv = billData.amount * Config.Tax
                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                    local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                    if not success then
                        Config.Notification(Config.NotificationText['errormoney'].text,
                            Config.NotificationText['errormoney'].type, true,
                            src)
                        return
                    end
                    if billData.societyname ~= 'identifier' then
                        if Config.newManagementSystem then
                            local account_money = exports["qb-banking"]:GetAccount(billData.societyname)
                            if account_money and account_money.account_balance then
                                exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                            else
                                if Config.CreateJobAccount then
                                    exports["qb-banking"]:CreateJobAccount(billData.societyname, 0)
                                    Wait(350)
                                    exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                end
                            end
                        else
                            exports["qb-management"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                        end
                        Wait(100)
                        billData.status = 'paid'
                        ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                            tonumber(billingId) .. "'")
                        sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                        sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                    else
                        local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                        if xPlayer then
                            local xSource = GetSource(xPlayer)
                            AddMoney(xSource, totalAmountWithKdv)
                            billData.status = 'paid'
                            Citizen.Wait(100)
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billingId) .. "'")
                            discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                        else
                            local PlayerData = ExecuteSql("SELECT * FROM players WHERE citizenid = '" ..
                                billData.identifier .. "' ")
                            if PlayerData then
                                local kdv = billData.amount * Config.Tax
                                local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                money = json.decode(PlayerData[1].money)
                                money.bank = money.bank + tonumber(totalAmountWithKdv)
                                ExecuteSql("UPDATE `players` SET `money` = '" ..
                                    json.encode(money) .. "' WHERE citizenid = '" .. billData.identifier .. "'")
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billingId) .. "'")
                                discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                            else
                                Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                    Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                            end
                        end
                    end
                end
            else
                Config.Notification(Config.NotificationText['notmoney'].text,
                    Config.NotificationText['notmoney'].type, true,
                    src)
            end
        end
    end
end)

RegisterServerEvent('codem-billing:server:PayBillBankV2', function(source, billingId)
    local src = source
    local xPlayer = GetPlayer(src)
    if not xPlayer then return end
    local result = ExecuteSql("SELECT * FROM `codem_billing` WHERE `id` = ?", { billingId })
    if result then
        local billingId = result[1].uniqueid
        local playerMoney = getPlayerMoney(src)
        local playerIdentifier = GetIdentifier(src)
        for _, billData in pairs(allBillingData[playerIdentifier]) do
            if tonumber(billData.uniqueid) == tonumber(billingId) then
                if tonumber(playerMoney) >= tonumber(billData.amount) then
                    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
                        if billData.societyname == 'identifier' then
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            local kdv = billData.amount * Config.Tax
                            local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                            local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                            if not success then
                                Config.Notification(Config.NotificationText['undefinedjob'].text,
                                    Config.NotificationText['undefinedjob'].type, true,
                                src)
                                return
                            end
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billingId) .. "'")
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM users WHERE identifier = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    money = json.decode(PlayerData[1].accounts)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `users` SET `accounts` = '" ..
                                        json.encode(money) .. "' WHERE identifier = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billingId) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                                end
                            end
                        else
                            TriggerEvent("esx_addonaccount:getSharedAccount", 'society_' .. billData.societyname,
                                function(account)
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                                    if not success then
                                        Config.Notification(Config.NotificationText['undefinedjob'].text,
                                            Config.NotificationText['undefinedjob'].type, true,
                                        src)
                                        return
                                    end
                                    account.addMoney(totalAmountWithKdv)
                                    billData.status = 'paid'
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billingId) .. "'")
                                end)
                        end
                    else
                        local kdv = billData.amount * Config.Tax
                        local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                        local success = RemoveMoney(src, tonumber(totalAmountWithKdv))
                        if not success then
                            Config.Notification(Config.NotificationText['errormoney'].text,
                                Config.NotificationText['errormoney'].type, true,
                            src)
                            return
                        end
                        if billData.societyname ~= 'identifier' then

                            if Config.newManagementSystem then
                                local account_money = exports["qb-banking"]:GetAccount(billData.societyname)
                                if account_money and account_money.account_balance then
                                    exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                else
                                    if Config.CreateJobAccount then
                                        exports["qb-banking"]:CreateJobAccount(billData.societyname, 0)
                                        Wait(350)
                                        exports["qb-banking"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                                    end
                                end
                            else
                                exports["qb-management"]:AddMoney(billData.societyname, tonumber(totalAmountWithKdv))
                            end
                            Wait(100)
                            billData.status = 'paid'
                            ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                tonumber(billingId) .. "'")
                            sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                            sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                        else
                            local xPlayer = GetPlayerFromIdentifier(billData.identifier)
                            if xPlayer then
                                local xSource = GetSource(xPlayer)
                                AddMoney(xSource, totalAmountWithKdv)
                                billData.status = 'paid'
                                Citizen.Wait(100)
                                sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                sendToNotifyOwner(billData.targetname, billData.identifier, totalAmountWithKdv)
                                ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                    tonumber(billingId) .. "'")
                                discordLogBilling(xSource, billData, 'paybill', 'Paid Bill')
                            else
                                local PlayerData = ExecuteSql("SELECT * FROM players WHERE citizenid = '" ..
                                    billData.identifier .. "' ")
                                if PlayerData then
                                    local kdv = billData.amount * Config.Tax
                                    local totalAmountWithKdv = math.floor(billData.amount + tonumber(kdv))
                                    money = json.decode(PlayerData[1].money)
                                    money.bank = money.bank + tonumber(totalAmountWithKdv)
                                    ExecuteSql("UPDATE `players` SET `money` = '" ..
                                        json.encode(money) .. "' WHERE citizenid = '" .. billData.identifier .. "'")
                                    billData.status = 'paid'
                                    Citizen.Wait(100)
                                    sendToNotifyOwner(billData.name, billData.targetIdentifier, totalAmountWithKdv)
                                    ExecuteSql("UPDATE `codem_billing` SET `status` = 'paid' WHERE uniqueid = '" ..
                                        tonumber(billingId) .. "'")
                                    discordLogBilling(src, billData, 'paybill', 'Offline billing player')
                                else
                                    Config.Notification(Config.NotificationText['offlinenotplayer'].text,
                                        Config.NotificationText['offlinenotplayer'].type, true,
                                    src)
                                end
                            end
                        end
                    end
                else
                    Config.Notification(Config.NotificationText['notmoney'].text,
                        Config.NotificationText['notmoney'].type, true,
                    src)
                end
            end
        end
    end

end)

function createBilling(src, targetId, amount, reason, society)
    local src = src
    if targetId == '' then
        Config.Notification(Config.NotificationText['writeid'].text,
            Config.NotificationText['writeid'].type, true,
            src)
        return
    end
    if amount == '' then
        Config.Notification(Config.NotificationText['amountinvoice'].text,
            Config.NotificationText['amountinvoice'].type, true,
            src)
        return
    end
    if reason == '' then
        Config.Notification(Config.NotificationText['reasonsection'].text,
            Config.NotificationText['reasonsection'].type, true,
            src)
        return
    end
    local identifier = GetIdentifier(src)
    local name = GetName(src)
    local targetIdentifier = GetIdentifier(tonumber(targetId))
    local targetName = GetName(tonumber(targetId))
    local invoiceLabel = reason
    local status = 'unpaid'
    local jobname
    if Config.AllowBillingJobs[society] == nil then
        if Config.SendInvoiceAsStaffAccount then
            jobname = 'identifier'
        else
            Config.Notification(Config.NotificationText['notallowpersonelaccount'].text,
                Config.NotificationText['notallowpersonelaccount'].type, true,
                src)
            return
        end
    else
        jobname = society
    end
    local uniqueId = false
    local UniqueFound = false
    local date = os.date("%Y-%m-%d %H:%M")
    while not UniqueFound do
        uniqueId = math.random(100000, 999999)
        local result = ExecuteSql("SELECT COUNT(*) as count FROM codem_billing WHERE uniqueid = '" ..
            tonumber(uniqueId) .. "'")
        if result[1].count == 0 then
            UniqueFound = true
        else
            uniqueId = math.random(100000, 999999)
            UniqueFound = true
        end
    end
    ExecuteSql(
        "INSERT INTO `codem_billing` (`identifier`, `name`, `targetidentifier`, `targetname`, `amount`, `invoicelabel`, `status`, `societyname`,`uniqueid`,`date`) VALUES ('" ..
        identifier ..
        "', '" ..
        name ..
        "',  '" ..
        targetIdentifier ..
        "' , '" ..
        targetName ..
        "', '" ..
        amount .. "','" .. invoiceLabel .. "','" .. status .. "','" .. jobname .. "','" .. uniqueId .. "','" ..
        date .. "')"
    )
    local data = {
        identifier = identifier,
        name = name,
        targetIdentifier = targetIdentifier,
        targetname = targetName,
        amount = amount,
        invoicelabel = invoiceLabel,
        status = status,
        societyname = jobname,
        uniqueid = uniqueId,
        date = date,
        dateupdate = 'false',
        seconddate = addDaysToDate(date, Config.HowManyDays),
        jobLabel = Config.AllowBillingJobs[society] or 'Personel Account'
    }
    if not allBillingData[targetIdentifier] then
        allBillingData[targetIdentifier] = {}
    end
    table.insert(allBillingData[targetIdentifier], data)
    TriggerClientEvent('codem-billing:updateBillData', tonumber(targetId), allBillingData[targetIdentifier])
    discordLogBilling(src, data, 'bill', 'Billing Player')
    Config.Notification(string.format(Config.NotificationText['createbill'].text, name, amount),
        Config.NotificationText['paybill'].type, true,
        tonumber(targetId))
    Config.Notification(string.format(Config.NotificationText['createdbill'].text, targetName, amount),
        Config.NotificationText['paybill'].type, true,
        tonumber(src))
    TriggerClientEvent('codem-notification:showNotify', tonumber(targetId))
    TriggerClientEvent('codem-billing:refreshPage', tonumber(src))
end

Citizen.CreateThread(function()
    Core, Config.Framework = GetCore()
end)

function AddMoney(source, amount)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            Player.addAccountMoney('bank', tonumber(amount))
        else
            Player.Functions.AddMoney("bank", tonumber(amount))
        end
    end
end

function getPlayerMoney(source)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            local money = Player.getAccount('bank').money
            return money
        else
            local money = Player.PlayerData.money["bank"]
            return money
        end
    end
end

function RemoveMoney(source, amount)
    local success = false
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if Player.getAccount('bank').money >= amount then
                Player.removeAccountMoney('bank', amount)
                success = true
            end
        else
            if Player.Functions.RemoveMoney("bank", amount) then
                success = true
            end
        end
    end
    return success
end

function GetPlayer(source)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    else
        Player = Core.Functions.GetPlayer(source)
    end
    return Player
end

function GetPlayerFromIdentifier(identifier)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromIdentifier(identifier)
    else
        Player = Core.Functions.GetPlayerByCitizenId(identifier)
    end
    return Player
end

function GetIdentifier(source)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            return Player.getIdentifier()
        else
            return Player.PlayerData.citizenid
        end
    end
end

function GetJob(source)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            return Player.getJob().name, Player.getJob().grade
        else
            return Player.PlayerData.job.name, Player.PlayerData.job.grade.level
        end
    end
    return false
end

function GetName(source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = Core.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    elseif Config.Framework == 'standalone' then
        return GetPlayerName(source)
    end
end

function GetSource(xPlayer)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        return xPlayer.source
    else
        if xPlayer and xPlayer.PlayerData then
            return xPlayer.PlayerData.source
        end
    end
end

function sendToNotifyOwner(name, identifier, amount)
    local xPlayer = GetPlayerFromIdentifier(identifier)
    if xPlayer then
        Config.Notification(string.format(Config.NotificationText['paybill'].text, name, amount),
            Config.NotificationText['paybill'].type, true,
            GetSource(xPlayer))
    end
end
