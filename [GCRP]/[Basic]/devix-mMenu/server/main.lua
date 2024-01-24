
if MENU.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif MENU.Framework == "oldqb" then 
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
elseif MENU.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif MENU.Framework == "oldesx" then 
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) object = obj end)
end

local se = {}
local mi = {}
local hr = {}
local di = {}
local tebexapikey  = false
local APIFound = false
local date
local getTime
local lastDay
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local API = GetConvar('steam_webApiKey', 'NULL')
        print('^2 API',API)
        if API == "none" or API == "" or API == nil then
            APIFound = false
        else
            APIFound = true
        end
        if MENU.TEBEX_SETTINGS.status then
            local tebexapikey = GetConvar('sv_tebexSecret', 'NULL') 
            if tebexapikey == "none" or tebexapikey == "" or tebexapikey == nil then
                print('^2[^7devix-MMENU:DEBUG^2] TEBEX SECRET KEY NOT FOUND PLEASE CHECK! #12991^0')
            else
                print('^2[^7devix-MMENU:DEBUG^2] TEBEX SECRET CONNECTED! #12992^0')
            end
        end
    end
end)



if MENU.Framework == "qb" or MENU.Framework == "oldqb" then


    QBCore.Functions.CreateCallback('devix-mmenu:server:getPlayerProfile', function (source,cb)
        print('[ devix-mmenu:server:getPlayerProfile ]')
        local ply = DEVIX.GetPlayer(source)
        local result = ExecuteSql('SELECT * FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
            local pVehicle = ExecuteSql('SELECT * FROM player_vehicles WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        else
            local pVehicle = ExecuteSql('SELECT * FROM owned_vehicles WHERE `owner` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        end        
        data = {}
        data.account = DEVIX.GetDataPlayer(ply, result).account 
        data.phone = DEVIX.GetDataPlayer(ply, result).phone 
        data.job = DEVIX.GetDataPlayer(ply, result).joblabel
        data.prime =  result[1].prime or 0
        data.primeEndOfTime = playerCheckPrimeDay(source)
        print('TIME >',se[source].total,mi[source].total,  hr[source].total, di[source].total)
        data.onlinetime = {sec = se[source].total, min = mi[source].total, hour = hr[source].total, day = di[source].total}
        data.playerVehicle = {}
        if pVehicle ~= nil then

            for k, v in pairs(pVehicle) do
                print(k, v.plate)
                data.playerVehicle[v.plate] = v.plate
            end
        else
            data.playerVehicle = nil
        end

        cb(data)
    end)



    QBCore.Functions.CreateCallback('devix-mmenu:server:getPlayerCoin', function (source,cb)
        local ply = DEVIX.GetPlayer(source)
        local result = ExecuteSql('SELECT prime,coin FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        data = {}
        data.prime = result[1].prime or Locales.PrimeOffText
        data.coin = result[1].coin or 0
        if result[1].prime == nil then
    	    ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = 0 WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
        end
        if result[1].coin == nil then
    	    ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = 0 WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
        end
        cb(data)
    end)


    --Functions
    QBCore.Functions.CreateCallback('devix-mmenu:case:getPlayerDetails', function(source, cb)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]
        local steamid = tonumber(identifier:gsub("steam:",""), 16)
        local xPlayer = DEVIX.GetPlayer(src)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local pSteam = GetPlayerName(src)
        local firstName = GetPlayerName(src)
        data = {}
        data.coin = GetCoin(src)
        data.prisma = GetPrisma(src)
        data.steamid = steamid
        data.firstname = firstName
        cb(data)
    end)


    QBCore.Functions.CreateCallback('devix-mmenu:case:selectedCaseOpen', function(source, cb, caseData, itemData)
        local src = source
        local xPlayer = DEVIX.GetPlayer(src)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local pCoin = GetCoin(src)
        local result = ExecuteSql("SELECT * FROM devix_caseopening WHERE "..MENU.sqltableAltName.." = '"..citizenId.."'")
        if result[1] ~= nil then    
            if caseData.priceType == "GC" then 
                if pCoin >= caseData.price then 
                    setCoin(src, (pCoin - caseData.price))
                    local currentDate = os.time() 
                    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
                    SendToDiscord("cases", Locales.casesLangs["personOpenedCase"]..' \n CitizenID:**'.. citizenId.. '** \n CASE UNIQUE ID **'..caseData.uniqueId..'** \n **'.. date..'**')
                    cb(true)
                else
                    cb(false)
                end
            else
                if result[1].silvercoin >= caseData.price then 
                    ExecuteSql("UPDATE devix_caseopening SET silvercoin = silvercoin - '"..caseData.price.."' WHERE "..MENU.sqltableAltName.." = '"..citizenId.."'")
                    local currentDate = os.time() 
                    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
                    SendToDiscord("cases", Locales.casesLangs["personOpenedCase"]..' \n CitizenID:**'.. citizenId.. '** \n CASE UNIQUE ID **'..caseData.uniqueId..'** \n **'.. date..'**')
                    cb(true)
                else
                    cb(false)
                end
            end
        else
            cb(false)
        end
    end)


    QBCore.Functions.CreateCallback('devix-mmenu:case:sendInput', function(source, cb, data)
        local _source = source
        local xPlayer = DEVIX.GetPlayer(_source)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local inputData = data.input
        local pCoin = GetCoin(_source)

        local result = ExecuteSql("SELECT * FROM devix_mmenu_tebexcodes WHERE tebexid = '"..inputData.."'")
        if result[1] == nil then
            if result[1].type == "coin" then
                amount = pCoin + result[1].amount
    	        ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..amount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
                cb(result[1].amount)
            elseif result[1].type =="prime" then
    	        ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = 'true' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
            end
            ExecuteSql("DELETE FROM devix_mmenu_tebexcodes WHERE tebexid = '"..inputData.."'")
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.addedClaimEvents)
            local currentDate = os.time() 
            local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
            SendToDiscord("cases", Locales.casesLangs["codeUsed"]..' \n CitizenID:**'.. citizenID.. '** \n CODE **'..inputData..'** \n CREDIT'..result[1].amount..'\n**'.. date..'**')
        else
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.tebexIDNotFounded)
            cb(false)
        end
    end)


    -- !burada problem var ticket açıldıktan sonra sanki admin paneliymiş gibi gösteriyor, heisAdmin dalgası sıkıntılı temize çekilip tekrar yapılacak
    QBCore.Functions.CreateCallback('devix-mmenu:server:getTicket', function(source, cb, ticketID) 
        -- ? Oyuncu ownerID üzerinden oyuncunun ticketi açık mı değil mi bakılacak, yoksa ticket oluştur butonu oluştur.
        -- * devixmmenu_tickets üzerinde ticket status olacağı için kapalılarda araya kaynayabilir o yüzden açık ticketler göz önüne alınacak

        -- !  Adminler için ayrı çekim yapılacak =>
        local tickets = {}
        local ply = DEVIX.GetPlayer(source)
        heisAdmin = false
        for k, v in pairs(MENU.TICKET_ADMINS) do
            print('k == DEVIX.GetPlayerIdentifier(ply)',k == DEVIX.GetPlayerIdentifier(ply))
            if k == DEVIX.GetPlayerIdentifier(ply) then

                heisAdmin = true
            end
        end
        if heisAdmin then
            local data = ExecuteSql("SELECT * FROM `devixmmenu_tickets`")
            for k, v in pairs(data) do
                tickets[v.ticketid] = {ticketID = v.ticketid, ticketOwnerID = v.ticketOwnerID, ticketOwnerImage = v.ticketOwnerImage, ticketAdminID = v.ticketAdminID or nil, ticketAdminImage = v.ticketAdminImage, status =v.status, createDate = v.createDate, pID = DEVIX.GetPlayerIdentifier(ply)}
            end
            cb(true, tickets, heisAdmin) -- bu sayede admin ise ayrı bir adminler için alan belirlenecek
        else
            local data = ExecuteSql("SELECT * FROM `devixmmenu_tickets` WHERE ticketOwnerID = '"..DEVIX.GetPlayerIdentifier(ply).."'")
            if json.encode(data) ~= "[]" then
                for k, v in pairs(data) do 
                    if v.status == "open" then
                        local result =  ExecuteSql("SELECT * FROM `devixmmenu_tickets` WHERE ticketOwnerID = '"..DEVIX.GetPlayerIdentifier(ply).."'")
                        if result ~= nil then

                            for k, v in pairs(result) do
                                print(k, json.encode(v))
                                tickets[v.ticketid] = {ticketID = v.ticketid, ticketOwnerID = v.ticketOwnerID, ticketOwnerImage = v.ticketOwnerImage, ticketAdminID = v.ticketAdminID, ticketAdminImage = v.ticketAdminImage, status = v.status, createDate = v.createDate, pID = DEVIX.GetPlayerIdentifier(ply)}
                            end
                        end
                        -- ! açık ticket varsa direkt olarak mesajları kontrol edip append atıcak, "'devix-mmenu:server:CheckMessages'" üzerinde aynı kodu işleyicek.
                        -- local messages = ExecuteSql("SELECT * FROM `devixmmenu_tickets_chat` WHERE ticketID = '"..v.ticketID.."'")
                        cb(true, tickets, heisAdmin)
                    else
                        cb(false, nil , heisAdmin)
                    end    
                end
            else
                cb(false, nil, heisAdmin)
            end
        end
    end)


    QBCore.Functions.CreateCallback('devix-mmenu:server:CheckMessages', function (source,cb, ticketID)
        local src = source
        local ply = DEVIX.GetPlayer(src)
        -- ! Burada yapılacak olan şey => Ticket'e basıldığı zaman ticketID'sinden yazılan mesajları çekip appendliyecek.
        local result = ExecuteSql("SELECT * FROM `devixmmenu_tickets_messages` WHERE `ticketID` = '"..ticketID.."' ORDER BY `date` ASC")

        messagesData = {}
        if json.encode(result) ~= "[]" then
            for i, v in ipairs(result) do
                print(i, result[i].date)
                messagesData[#messagesData+1] = json.decode(result[i].messages)
            end
            cb(messagesData, DEVIX.GetPlayerIdentifier(ply))
        else
            cb(nil)
        end
    end)



    QBCore.Functions.CreateCallback('devix-mmenu:server:getPlayerTime', function(source, cb)
    	local segundo = tonumber(se[source].total)
    	local minuto = tonumber(mi[source].total)
    	local hora = tonumber(hr[source].total)
    	local dia = tonumber(di[source].total)
    	second = math.floor(segundo)
    	minute = math.floor(minuto)
    	hour = math.floor(hora)
    	day = math.floor(dia)
    	print('GetPlayer Time > ', second, minute,hour)
    	time = { second= second, minute = minute, hour = hour, day = day}
    	cb(time)
    end)

else

     ESX.RegisterServerCallback('devix-mmenu:server:getPlayerProfile', function (source,cb)
        print('[ devix-mmenu:server:getPlayerProfile ]')
        local ply = DEVIX.GetPlayer(source)
        local result = ExecuteSql('SELECT * FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
            local pVehicle = ExecuteSql('SELECT * FROM player_vehicles WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        else
            local pVehicle = ExecuteSql('SELECT * FROM owned_vehicles WHERE `owner` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        end
        data = {}
        data.account = DEVIX.GetDataPlayer(ply, result).account 
        data.phone = DEVIX.GetDataPlayer(ply, result).phone 
        data.job = DEVIX.GetDataPlayer(ply, result).joblabel
        data.prime =  result[1].prime or 0
        data.primeEndOfTime = playerCheckPrimeDay(source)
        print('TIME >',se[source].total,mi[source].total,  hr[source].total, di[source].total)
        data.onlinetime = {sec = se[source].total, min = mi[source].total, hour = hr[source].total, day = di[source].total}
        data.playerVehicle = {}
        if pVehicle ~= nil then
            
            for k, v in pairs(pVehicle) do
                print(k, v.plate)
                data.playerVehicle[v.plate] = v.plate
            end
        else
            data.playerVehicle = nil
        end
    
        cb(data)
    end)
    
    
    
    ESX.RegisterServerCallback('devix-mmenu:server:getPlayerCoin', function (source,cb)
        local ply = DEVIX.GetPlayer(source)
        local result = ExecuteSql('SELECT prime,coin FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
        data = {}
        data.prime = result[1].prime or Locales.PrimeOffText
        data.coin = result[1].coin or 0
        if result[1].prime == nil then
    	    ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = 0 WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
        end
        if result[1].coin == nil then
    	    ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = 0 WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
        end
        cb(data)
    end)
    
    
    --Functions
    ESX.RegisterServerCallback('devix-mmenu:case:getPlayerDetails', function(source, cb)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]
        local steamid = tonumber(identifier:gsub("steam:",""), 16)
        local xPlayer = DEVIX.GetPlayer(src)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local pSteam = GetPlayerName(src)
        local firstName = GetPlayerName(src)
        data = {}
        data.coin = GetCoin(src)
        data.prisma = GetPrisma(src)
        data.steamid = steamid
        data.firstname = firstName
        cb(data)
    end)
    
    
    ESX.RegisterServerCallback('devix-mmenu:case:selectedCaseOpen', function(source, cb, caseData, itemData)
        local src = source
        local xPlayer = DEVIX.GetPlayer(src)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local pCoin = GetCoin(src)
        local result = ExecuteSql("SELECT * FROM devix_caseopening WHERE "..MENU.sqltableAltName.." = '"..citizenId.."'")
        if result[1] ~= nil then    
            if caseData.priceType == "GC" then 
                if pCoin >= caseData.price then 
                    setCoin(src, (pCoin - caseData.price))
                    local currentDate = os.time() 
                    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
                    SendToDiscord("cases", Locales.casesLangs["personOpenedCase"]..' \n CitizenID:**'.. citizenId.. '** \n CASE UNIQUE ID **'..caseData.uniqueId..'** \n **'.. date..'**')
                    cb(true)
                else
                    cb(false)
                end
            else
                if result[1].silvercoin >= caseData.price then 
                    ExecuteSql("UPDATE devix_caseopening SET silvercoin = silvercoin - '"..caseData.price.."' WHERE "..MENU.sqltableAltName.." = '"..citizenId.."'")
                    local currentDate = os.time() 
                    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
                    SendToDiscord("cases", Locales.casesLangs["personOpenedCase"]..' \n CitizenID:**'.. citizenId.. '** \n CASE UNIQUE ID **'..caseData.uniqueId..'** \n **'.. date..'**')
                    cb(true)
                else
                    cb(false)
                end
            end
        else
            cb(false)
        end
    end)
    
    
    ESX.RegisterServerCallback('devix-mmenu:case:sendInput', function(source, cb, data)
        local _source = source
        local xPlayer = DEVIX.GetPlayer(_source)
        local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)
        local inputData = data.input
        local pCoin = GetCoin(_source)
    
        local result = ExecuteSql("SELECT * FROM devix_mmenu_tebexcodes WHERE tebexid = '"..inputData.."'")
        if result[1] == nil then
            if result[1].type == "coin" then
                amount = pCoin + result[1].amount
    	        ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..amount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
                cb(result[1].amount)
            elseif result[1].type =="prime" then
    	        ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = 'true' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
            end
            ExecuteSql("DELETE FROM devix_mmenu_tebexcodes WHERE tebexid = '"..inputData.."'")
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.addedClaimEvents)
            local currentDate = os.time() 
            local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
            SendToDiscord("cases", Locales.casesLangs["codeUsed"]..' \n CitizenID:**'.. citizenID.. '** \n CODE **'..inputData..'** \n CREDIT'..result[1].amount..'\n**'.. date..'**')
        else
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.tebexIDNotFounded)
            cb(false)
        end
    end)
    
    
    -- !burada problem var ticket açıldıktan sonra sanki admin paneliymiş gibi gösteriyor, heisAdmin dalgası sıkıntılı temize çekilip tekrar yapılacak
    ESX.RegisterServerCallback('devix-mmenu:server:getTicket', function(source, cb, ticketID) 
        -- ? Oyuncu ownerID üzerinden oyuncunun ticketi açık mı değil mi bakılacak, yoksa ticket oluştur butonu oluştur.
        -- * devixmmenu_tickets üzerinde ticket status olacağı için kapalılarda araya kaynayabilir o yüzden açık ticketler göz önüne alınacak
    
        -- !  Adminler için ayrı çekim yapılacak =>
        local tickets = {}
        local ply = DEVIX.GetPlayer(source)
        heisAdmin = false
        for k, v in pairs(MENU.TICKET_ADMINS) do
            print('k == DEVIX.GetPlayerIdentifier(ply)',k == DEVIX.GetPlayerIdentifier(ply))
            if k == DEVIX.GetPlayerIdentifier(ply) then
                
                heisAdmin = true
            end
        end
        if heisAdmin then
            local data = ExecuteSql("SELECT * FROM `devixmmenu_tickets`")
            for k, v in pairs(data) do
                tickets[v.ticketid] = {ticketID = v.ticketid, ticketOwnerID = v.ticketOwnerID, ticketOwnerImage = v.ticketOwnerImage, ticketAdminID = v.ticketAdminID or nil, ticketAdminImage = v.ticketAdminImage, status =v.status, createDate = v.createDate, pID = DEVIX.GetPlayerIdentifier(ply)}
            end
            cb(true, tickets, heisAdmin) -- bu sayede admin ise ayrı bir adminler için alan belirlenecek
        else
            local data = ExecuteSql("SELECT * FROM `devixmmenu_tickets` WHERE ticketOwnerID = '"..DEVIX.GetPlayerIdentifier(ply).."'")
            if json.encode(data) ~= "[]" then
                for k, v in pairs(data) do 
                    if v.status == "open" then
                        local result =  ExecuteSql("SELECT * FROM `devixmmenu_tickets` WHERE ticketOwnerID = '"..DEVIX.GetPlayerIdentifier(ply).."'")
                        if result ~= nil then
                        
                            for k, v in pairs(result) do
                                print(k, json.encode(v))
                                tickets[v.ticketid] = {ticketID = v.ticketid, ticketOwnerID = v.ticketOwnerID, ticketOwnerImage = v.ticketOwnerImage, ticketAdminID = v.ticketAdminID, ticketAdminImage = v.ticketAdminImage, status = v.status, createDate = v.createDate, pID = DEVIX.GetPlayerIdentifier(ply)}
                            end
                        end
                        -- ! açık ticket varsa direkt olarak mesajları kontrol edip append atıcak, "'devix-mmenu:server:CheckMessages'" üzerinde aynı kodu işleyicek.
                        -- local messages = ExecuteSql("SELECT * FROM `devixmmenu_tickets_chat` WHERE ticketID = '"..v.ticketID.."'")
                        cb(true, tickets, heisAdmin)
                    else
                        cb(false, nil , heisAdmin)
                    end    
                end
            else
                cb(false, nil, heisAdmin)
            end
        end
    end)
    
    
    ESX.RegisterServerCallback('devix-mmenu:server:CheckMessages', function (source,cb, ticketID)
        local src = source
        local ply = DEVIX.GetPlayer(src)
        -- ! Burada yapılacak olan şey => Ticket'e basıldığı zaman ticketID'sinden yazılan mesajları çekip appendliyecek.
        local result = ExecuteSql("SELECT * FROM `devixmmenu_tickets_messages` WHERE `ticketID` = '"..ticketID.."' ORDER BY `date` ASC")
        
        messagesData = {}
        if json.encode(result) ~= "[]" then
            for i, v in ipairs(result) do
                print(i, result[i].date)
                messagesData[#messagesData+1] = json.decode(result[i].messages)
            end
            cb(messagesData, DEVIX.GetPlayerIdentifier(ply))
        else
            cb(nil)
        end
    end)
    
    
    
    ESX.RegisterServerCallback('devix-mmenu:server:getPlayerTime', function(source, cb)
    	local segundo = tonumber(se[source].total)
    	local minuto = tonumber(mi[source].total)
    	local hora = tonumber(hr[source].total)
    	local dia = tonumber(di[source].total)
    	second = math.floor(segundo)
    	minute = math.floor(minuto)
    	hour = math.floor(hora)
    	day = math.floor(dia)
    	print('GetPlayer Time > ', second, minute,hour)
    	time = { second= second, minute = minute, hour = hour, day = day}
    	cb(time)
    end)
    
end



-- ! events

RegisterNetEvent('devix-mmenu:server:case:updateCoins', function(pCoin, pPrisma)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..pCoin.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET prisma = '"..pPrisma.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
end)


RegisterNetEvent('devix-mmmenu:server:addPlayerTheCoin', function(playerSourceID, amount)
    local ply = DEVIX.GetPlayer(playerSourceID)
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..amount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
end)

RegisterNetEvent('devix-mmmenu:server:addPlayerThePrisma', function(playerSourceID, amount)
    local ply = DEVIX.GetPlayer(playerSourceID)
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET prisma = '"..amount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
end)

RegisterNetEvent('devix-mmenu:case:collectItem', function(data)  
    local _source = source
    local xPlayer = DEVIX.GetPlayer(_source)
    local citizenId = DEVIX.GetPlayerIdentifier(xPlayer)

    local firstName = GetPlayerName(_source)
    local lastName = ""
    
    local itemType = data[2]
    local itemName = data[3]
    local itemCount = tonumber(data[4])
    print('data:>', data[2])
    print('data2:>', json.encode(data))
    
    if itemType == "item" then 
        xPlayer.Functions.AddItem(itemName, itemCount)
    elseif itemType == "weapon" then 
        if MENU.CASE["SETTINGS"].WeaponsAreItem then 
            for i = 1, count, 1 do 
                DEVIX.AddItem(xPlayer, tostring(args), 1)
            end
            DEVIX.AddItem(xPlayer, tostring(args), 1)

        end
    elseif itemType == "vehicle" then
        for i = 1, itemCount do 
            local plate = GeneratePlate()
            local vehicleData = {}
            vehicleData.model = GetHashKey(itemName)
            vehicleData.plate = plate
            -- ExecuteSql("INSERT INTO owned_vehicles (identifier, plate, vehicle, stored) VALUES ('"..identifier.."', '"..plate.."', '"..json.encode(vehicleData).."', 0)")
        end
    elseif itemType == "money" then 
        DEVIX.AddMoney(xPlayer, "cash", tonumber(args))
    end
    local currentDate = os.time() 
    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
    SendToDiscord("cases", Locales.casesLangs["collectItem"]..' \n CitizenID:**'.. citizenId.. '** \n ITEM: **'..itemName..'** \n COUNT: **'..itemCount..'** \n '..'ITEM TYPE: **'..itemType..'** \n **'.. date..'**')
end)




RegisterNetEvent('devix-mmenu:server:earnXP', function(amount)
    local src  = source
    local Player = DEVIX.GetPlayer(src)
    if Player ~= nil then
        
        local info = ExecuteSql("SELECT level FROM "..MENU.sqltableName.." WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(Player).."'")
        if json.decode(info[1].level) ~= nil then
            info = json.decode(info[1].level)
        else
            TriggerEvent('devix-mmenu:server:createSkillInfo', src)
            Wait(1500)
            local infoLast = ExecuteSql("SELECT level FROM "..MENU.sqltableName.." WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(Player).."'")
            if json.decode(infoLast[1].level) ~= nil then
                info = json.decode(infoLast[1].level)
            else
                info = {}
            end
            Wait(1000)
        end   
        -- print('info[3] > ',info.xp, amount, info.xp + amount)
        info.xp = info.xp + amount
        if tonumber(info.xp) >= tonumber(info.needxp) then
            currentlevel = info.needxp
            info.needxp = math.ceil( 100 + (currentlevel * ((MENU.Levelingdif + 100) * 0.01)) )
            info.currentlevel = info.currentlevel + 1
        end
        ExecuteSql("UPDATE "..MENU.sqltableName.." SET level = '"..json.encode(info).."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(Player).."'")
    end
end)



RegisterServerEvent('devix-mmenu:server:createSkillInfo')
AddEventHandler('devix-mmenu:server:createSkillInfo', function(source)
    local Player = DEVIX.GetPlayer(source)
    info = {}
    info.xp = 0
    info.needxp = 100
    info.currentlevel = 0
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET level = '"..json.encode(info).."'WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(Player).."'")
end)
 

RegisterNetEvent('devix-mmenu:server:updateCoin', function(newCost, type, arg, playerCoin, eventCost)
     local src = source
    local ply = DEVIX.GetPlayer(src)
    ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..newCost.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")
    local currentDate = os.time() 
    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
    SendToDiscord("store", Locales.storeLangs["newItemBuyed"]..' \n CitizenID:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TYPE: **'..type..'** \nARG: **'..arg..'**\n Player Last Coin: **'..playerCoin..'**\n COST: **'..eventCost..'** \n**'.. date..'**')
end)




RegisterNetEvent('devix-mmenu:server:giveCar', function (props, vehicleModel, vehicleHash, vHash, plt, vehicle)
    -- ! Oyuncunun datasına arabayı direkt olarak ekleyecek
    local src = source
    local ply = ESX.GetPlayerFromId(src)
    local plate = ""
    if plt == "COINBASED" then
        plate = GeneratePlate()
        SetVehicleNumberPlateText(vehicle, plate)
        props.plate = plate
    end
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        ExecuteSql("INSERT INTO player_vehicles (license, "..MENU.sqltableAltName..", vehicle, hash, mods, plate, state) VALUES ('"..ply.PlayerData.license.."', '"..DEVIX.GetPlayerIdentifier(ply).."', '"..props.model.."', '"..vehicleHash.."', '"..json.encode(props).."', '"..props.plate.."', 1)")
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        ExecuteSql("INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES ('"..ply.identifier.."', '"..props.plate.."', '"..json.encode(props).."', 'car', 1)")
    end
end)

RegisterNetEvent('devix-mmenu:client:giveMoney', function (args)
    -- ! Oyuncunun datasına parayı direkt olarak ekleyecek
    local src = source
    local ply = DEVIX.GetPlayer(src)
    -- ply.Functions.AddMoney("cas")
    DEVIX.AddMoney(ply, "cash", tonumber(args))
end)

RegisterNetEvent('devix-mmenu:client:giveItem', function (args)
    -- ! Oyuncunun datasına Yemeği direkt olarak ekleyecek
    local src = source
    local ply = DEVIX.GetPlayer(src)
    DEVIX.AddItem(ply, tostring(args), 1)
    -- ply.Functions.AddItem(tostring(args), 1)
end)



RegisterNetEvent('devix-mmenu:server:createTicket', function ()
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local identifier = GetPlayerIdentifiers(src)[1]
    ticketID = "TICKET_"..math.random(0000000000,9999999999)
    if APIFound then 
        pAvatar = GetPlayerSteamAvatar(GetPlayerIdentifiers(src)[1])
    else
        pAvatar = "https://cdn.discordapp.com/attachments/1053660049391767552/1079822616908550304/image.png"
    end
    playerName = DEVIX.GetPlayerName(ply).firstname.. ' '.. DEVIX.GetPlayerName(ply).lastname 
    ExecuteSql("INSERT INTO devixmmenu_tickets (`ticketid`,`ticketOwnerID`, `ticketOwnerImage`, `status`) VALUES ('"..ticketID.."','"..DEVIX.GetPlayerIdentifier(ply).."', '"..pAvatar.."', 'open')")
    TriggerClientEvent('devix-mmenu:client:createTicket', src, ticketID, pAvatar, playerName)
    local currentDate = os.time() 
    local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
    SendToDiscord("ticket", Locales.ticketLangs["newOpenTicket"]..' \n **'.. playerName.. '** \n **'..DEVIX.GetPlayerIdentifier(ply)..'** \n **'.. date..'**')
end)

RegisterNetEvent('devix-mmenu:server:setTicketOwner', function(ticketid)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local result = ExecuteSql("SELECT ticketAdminID FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
    if result[1].ticketAdminID == "" or   result[1].ticketAdminID == nil then
       ExecuteSql("UPDATE devixmmenu_tickets SET ticketAdminID = '"..DEVIX.GetPlayerIdentifier(ply).."' WHERE ticketid = '"..ticketid.."'")
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.setTicketMessage)
        local currentDate = os.time() 
        local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
        SendToDiscord("ticket", Locales.ticketLangs["setTicketOwner"]..' \n ADMIN:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TICKEDID: **'..ticketid..'** \n **'.. date..'**')
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.alreadyTakenThisTicket)
    end
end)

RegisterNetEvent('devix-mmenu:server:setReTicketOwner', function(ticketid)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local result = ExecuteSql("SELECT ticketAdminID FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
    if result[1].ticketAdminID == DEVIX.GetPlayerIdentifier(ply) then
        ExecuteSql("UPDATE devixmmenu_tickets SET ticketAdminID = null WHERE ticketid = '"..ticketid.."'")
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.reTicketOwner)
        local currentDate = os.time() 
        local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
        SendToDiscord("ticket", Locales.ticketLangs["reTicketOwner"]..' \n ADMIN:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TICKEDID: **'..ticketid..'** \n **'.. date..'**')
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src,'error', Locales.notOwnTicket)
    end
end)

RegisterNetEvent('devix-mmenu:server:closeTheTicket', function(ticketid)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local result = ExecuteSql("SELECT ticketAdminID FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
    if result[1].ticketAdminID == DEVIX.GetPlayerIdentifier(ply) then
        ExecuteSql("DELETE FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
        ExecuteSql("DELETE FROM devixmmenu_tickets_messages WHERE ticketid = '"..ticketid.."'")
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.succsesCloseTicket)
        local currentDate = os.time() 
        local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
        SendToDiscord("ticket", Locales.ticketLangs["closeTheTicket"]..' \n ADMIN:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TICKEDID: **'..ticketid..'** \n **'.. date..'**')
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.notOwnTicket)
    end
end)

RegisterNetEvent('devix-mmenu:server:teleportToPlayer', function (ticketid)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local result = ExecuteSql("SELECT * FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
    local targetPlayerID =  DEVIX.GetPlayerByCitizenId(result[1].ticketOwnerID)
    if result[1].ticketAdminID == DEVIX.GetPlayerIdentifier(ply) then
        
        if targetPlayerID == nil then
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.playerNotFound)
        else
            local targetPlayerCoords = GetEntityCoords(GetPlayerPed(DEVIX.GetPlayerSource(targetPlayerID)))
            SetEntityCoords(DEVIX.GetPlayerSource(ply), targetPlayerCoords.x, targetPlayerCoords.y, targetPlayerCoords.z, 0, 0, 0, true)
            local currentDate = os.time() 
            local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
            SendToDiscord("ticket", Locales.ticketLangs["teleportToPlayer"]..' \n ADMIN:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TICKEDID: **'..ticketid..'** \n TARGETID: **'..DEVIX.GetPlayerIdentifier(targetPlayerID)..'** \n **'.. date..'**')
        end
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.notOwnTicket)
    end
end)

RegisterNetEvent('devix-mmenu:server:bringToPlayer', function (ticketid)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local result = ExecuteSql("SELECT * FROM devixmmenu_tickets WHERE ticketid = '"..ticketid.."'")
    local targetPlayerID =  DEVIX.GetPlayerFromIdentifier(result[1].ticketOwnerID)
    if result[1].ticketAdminID == DEVIX.GetPlayerIdentifier(ply) then
        if targetPlayerID == nil then
            TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.playerNotFound)
        else
            local targetPlayerCoords = GetEntityCoords(GetPlayerPed(DEVIX.GetPlayerSource(targetPlayerID)))
            SetEntityCoords(DEVIX.GetPlayerSource(targetPlayerID), playerCoords.x, playerCoords.y, playerCoords.z, 0, 0, 0, true)
            local currentDate = os.time() 
            local date = os.date("%Y-%m-%d %H:%M:%S", currentDate)
            SendToDiscord("ticket", Locales.ticketLangs["bringToPlayer"]..' \n ADMIN:**'.. DEVIX.GetPlayerIdentifier(ply).. '** \n TICKEDID: **'..ticketid..'** \n TARGETID: **'..DEVIX.GetPlayerIdentifier(targetPlayerID)..'** \n **'.. date..'**')
        end
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.notOwnTicket)
    end
end)


RegisterNetEvent('devix-mmenu:server:updateMessages', function(ticketID, data)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    mChat  = {}
    mChat[data.ticketID] = {
        ["message"] =  data.message,
        ["sender"] =  DEVIX.GetDataPlayer(ply).account,
        ["firstname"] =  DEVIX.GetPlayerName(ply).firstname,
        ["lastname"] =  DEVIX.GetPlayerName(ply).lastname,
        ["time"] = data.currentMessageTime,
        ["date"] = data.currentTimeDate,
        ["playerImage"] =  data.pAvatar,
        ["ticketID"] = data.ticketID,
        ["grade"] = "normal"
    }
    local result = ExecuteSql("SELECT * FROM devixmmenu_tickets WHERE ticketid = '"..ticketID.."'")
    if result[1] ~= nil then 
        ExecuteSql("INSERT INTO devixmmenu_tickets_messages (`ticketID`,`messages`) VALUES ('"..ticketID.."','"..json.encode(mChat).."')")
        TriggerClientEvent('devix-mmenu:client:updateMessages', -1, json.encode(mChat), ticketID, DEVIX.GetPlayerIdentifier(ply))
    else
        TriggerClientEvent('devix-mmenu:client:closeScreen', src)
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.ticketHasBeenClose)
    end
end)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
        local result
		generatedPlate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))
        if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
            result = ExecuteSql("SELECT 1 FROM player_vehicles WHERE plate = '" ..generatedPlate.."'")
        else
            result = ExecuteSql("SELECT 1 FROM owned_vehicles WHERE plate = '"..generatedPlate.."'")
        end
        print('GENERATED PLATE =>', generatedPlate, result[1])
        if result[1] == nil then 
            doBreak = true
        end

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GetCoin(pSource)
    local ply = DEVIX.GetPlayer(pSource)
    local result = ExecuteSql('SELECT coin FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
    coin = 0
    if result[1].coin ~= nil then
        coin = result[1].coin
    end
    return coin
end

function GetPrisma(pSource)
    local ply = DEVIX.GetPlayer(pSource)
    local result = ExecuteSql('SELECT prisma FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
    prisma = 0
    if result[1].prisma ~= nil then
        prisma = result[1].prisma
    end
    return prisma
end

function setCoin(pSource, newAmount)
    local ply = DEVIX.GetPlayer(pSource)
	ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..newAmount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
end

function setPrisma(pSource, newAmount)
    local ply = DEVIX.GetPlayer(pSource)
	ExecuteSql("UPDATE "..MENU.sqltableName.." SET prisma = '"..newAmount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
end


function getPrime(src)
    local ply = DEVIX.GetPlayer(pSource)
    local result = ExecuteSql('SELECT prime FROM '..MENU.sqltableName..' WHERE `'..MENU.sqltableAltName..'` = "'..DEVIX.GetPlayerIdentifier(ply)..'" ')
    local prime = result[1].prime or 0
    return prime
end

RegisterNetEvent('devix-mmenu:server:updatePrime', function()
    local src = source
    playerCheckPrimeDay(src)
end)

function playerCheckPrimeDay(src)
    local ply = DEVIX.GetPlayer(src)
    local primes = ExecuteSql("SELECT prime FROM "..MENU.sqltableName.." WHERE `"..MENU.sqltableAltName.."` = '"..DEVIX.GetPlayerIdentifier(ply).."'")
    primeText = ""
    if primes[1].prime == 1 then -- Eğer ki prime varsa alttaki sistem devreye girecek
        local pDate = ExecuteSql("SELECT date FROM devix_mmenu_primebought_day WHERE `id` = '"..DEVIX.GetPlayerIdentifier(ply).."'")
        if pDate[1] ~= nil then
            
            local timestamp = tonumber(pDate[1].date) / 1000 -- convert the given Unix timestamp to seconds
            local date = os.date("%Y-%m-%d %H:%M:%S", timestamp)
            
            -- Number of days to add to the date
            local days = MENU.PRIME_TIME
            
            -- Calculate the new date after adding the specified number of days
            local new_timestamp = timestamp + days * 24 * 60 * 60 -- add days to the timestamp in seconds
            local new_date = os.date("%Y-%m-%d %H:%M:%S", new_timestamp)
            local currentDate = os.time()
            local lastDay = math.ceil((new_timestamp - currentDate) / (24 * 60 * 60))
            if currentDate == new_timestamp then
                primeText = Locales.primeEnded
                ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = '0' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
                ExecuteSql("DELETE FROM devix_mmenu_primebought_day WHERE `id` = '"..DEVIX.GetPlayerIdentifier(ply).."'")
                
            else
                primeText = ""..lastDay.." "..Locales.primeDayLeft
            end
        end
        return primeText
    else
        return primeText
    end
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end



RegisterCommand(MENU.TEBEX_SETTINGS.command, function(source,args)
    local src = source
    local ply = DEVIX.GetPlayer(src)
    local tebexID = args[1]
    local result = ExecuteSql("SELECT * FROM devix_mmenu_tebexcodes WHERE tebexid = '"..tebexID.."'")
    if result[1] == nil then
        if result[1].type == "coin" then
	        ExecuteSql("UPDATE "..MENU.sqltableName.." SET coin = '"..result[1].amount.."' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  
        elseif result[1].type == "prime" then
            local primeDate = ExecuteSql("SELECT * FROM devix_mmenu_primebought_day WHERE id = '"..DEVIX.GetPlayerIdentifier(ply).."'")
            if primeDate[1] == nil then
                 TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.primeAlreadyTaken)
            else
                ExecuteSql("INSERT INTO devix_mmenu_primebought_day (id) VALUES ('"..DEVIX.GetPlayerIdentifier(ply).."')")
	            ExecuteSql("UPDATE "..MENU.sqltableName.." SET prime = 'true' WHERE "..MENU.sqltableAltName.." = '"..DEVIX.GetPlayerIdentifier(ply).."'")  

            end
        end
        ExecuteSql("DELETE FROM devix_mmenu_tebexcodes WHERE tebexid = '"..tebexID.."'")
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'succses', Locales.addedClaimEvents)
    else
        TriggerClientEvent('devix-mmenu:client:sendNotify', src, 'error', Locales.tebexIDNotFounded)
    end
end)




RegisterCommand(MENU.TEBEX_SETTINGS.tebexSendToServerCommand, function(source,args)
    print(':: ADDED TO SERVER :: ',json.encode(args[1]))
    if source == 0 then
        local info = json.decode(args[1])
        ExecuteSql("INSERT INTO devix_mmenu_tebexcodes (tebexid, mail, type, amount) VALUES ('"..info.tebexid.."', '"..info.mail.."', '"..info.type.."', '"..info.amount.."')")
        SendToDiscord("TEBEX PAY : ``"..info.tebexid.."``\n LIST: ``"..info.mail.." "..info.type.." "..info.amount.."``\nPURCHASE!")
    end
end)


RegisterCommand('cDate', function(src, args)
    playerCheckPrimeDay(src)
end)


local DISCORD_NAME = "DISCORD NAME"
local DISCORD_IMAGE = "https://steamuserimages-a.akamaihd.net/ugc/848220336390493472/73E4DDF575623F925D0E727FBB0AE67EBFF6902E/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true"
-- Discord_Webhook = MENU.Discord_Webhook["cases"]
function SendToDiscord(type, message)
    -- Burada MENU.Discord_Webhook içerisinde barındıran yerler var oradaki Yerleri Locales kısımlarıyla birlikte dolduracak ;
    -- print(Locales..''..type..Color)
    color = type .. string.sub("Color", 1)
    header = type .. string.sub("Header", 1)
    print(type, message)
    local embed = {
        {
            ["color"] = Locales[color],
            ["title"] = "**".. Locales[header] .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "DEVIX - 'zhonnz#2373",
            },
        }
    }
    PerformHttpRequest(MENU.Discord_Webhook[type], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
--  ONLINE TIME 


-- CHECKING THE PLAYER TIME WHEN HE JOINS THE SERVER
RegisterServerEvent("devix-mmenu:server:time")
AddEventHandler("devix-mmenu:server:time", function()
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	local gotInfo = ExecuteSql('SELECT * FROM menu_player_times WHERE id = "'..identifier..'"')

	if gotInfo[1] ~= nil then
		TriggerClientEvent("devix-mmenu:client:sendDados", _source, gotInfo[1].Seconds, gotInfo[1].Minutes, gotInfo[1].Hours, gotInfo[1].Days)
	else
		local news = 0
		local newm = 0
		local newh = 0
		local newd = 0
		ExecuteSql('INSERT INTO menu_player_times (id, Seconds, Minutes, Hours, Days) VALUES ("'..identifier..'", "'..news..'", "'..newm..'", "'..newh..'","'..newd..'")')
		TriggerClientEvent("devix-mmenu:client:sendDados", _source, news, newm, newh, newd)
	end
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAVING THE TIME IN THE TABLES
RegisterServerEvent("devix-mmenu:server:savetime")
AddEventHandler("devix-mmenu:server:savetime", function(s, m, h, d)
	local _source = source
	se[_source] = {
        ['total'] = s
    }	
    mi[_source] = {
        ['total'] = m
    }
    hr[_source] = {
        ['total'] = h
    }
    di[_source] = {
        ['total'] = d
    }	
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAVING THE TIME IN THE DB
RegisterServerEvent("devix-mmenu:server:savetimedb")
AddEventHandler("devix-mmenu:server:savetimedb", function(s, m, h, d)
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]	
	ExecuteSql("UPDATE menu_player_times SET Seconds = "..s.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Minutes = "..m.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Hours = "..h.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Days = "..h.." WHERE id = '"..identifier.."'")
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SAVING THE TIME WHEN PLAYER DISCONNECT
AddEventHandler('playerDropped', function() 
    local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]	
	ExecuteSql("UPDATE menu_player_times SET Seconds = "..se[_source].total.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Minutes = "..mi[_source].total.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Hours = "..hr[_source].total.." WHERE id = '"..identifier.."'")
	ExecuteSql("UPDATE menu_player_times SET Days = "..di[_source].total.." WHERE id = '"..identifier.."'")
end)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- USEFUL FUNCTIONS

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end


function GetPlayerSteamAvatar(identifier)
    print("[DEVIX-MMENU:DEBUG 2] GetPlayerSteamAvatar : ID :> ", identifier, string.len(identifier), APIFound)
    if string.len(identifier) >= 30 then 
        return "https://cdn.discordapp.com/attachments/1053660049391767552/1079822616908550304/image.png"
    end
        
        local sid  = tonumber(identifier:gsub("steam:",""), 16)
        local link = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=3753B61005BAFCB2E37A5A03A727A8AE&steamids="..sid
        local p = {}
        PerformHttpRequest(link, function(errorCode, resultData, resultHeaders)
            a = json.decode(resultData)
            if not a then
                print('Steam api is temporarily unavailable, or too busy to respond')
                p.avatarfull = "https://cdn.discordapp.com/attachments/1053660049391767552/1079822616908550304/image.png"
            else
                for k,v in pairs(a["response"]) do
                    for index, value in pairs(v) do
                        p.avatarfull = value.avatarfull
                    end
                end
            end
        end)
    Wait(1320)
    return p.avatarfull
end


function GetTime(time, inMilliSeconds)
    time = tonumber(time)
    if not time then return 0 end
    return time * 24 * 60 * 60 * (inMilliSeconds and 1000 or 1)
end