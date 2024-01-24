--  This area just Replacer
--  ESX TO QB | QB TO ESX

-- BURADA EVENTLERIN COGU GETPLAYER CITIZEN ID TARZI GETFIRSTNAME TARZI TUM EVENTLER FONKSIYONLANDIRILACAK
-- BU SAYEDE SADECE CALLBACKLER HARICI HEPSI CONVERTER ICERIGINDE OLACAK
DEVIX = {}

DEVIX.GetPlayer = function(pSource)  
    local ply
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        ply = QBCore.Functions.GetPlayer(pSource)
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        ply = ESX.GetPlayerFromId(pSource)
    end
    return ply
end

DEVIX.GetPlayerIdentifier = function(player)  
    local ply
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        ply = player.PlayerData.citizenid

    elseif MENU.Framework == "esx" or MENU.Framework == "oldesx" then
        ply = player.identifier
    end
    return ply
end

DEVIX.GetDataPlayer = function (ply, result)
    local data = {}
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        data.account = ply.PlayerData.citizenid
        data.phone = ply.PlayerData.charinfo.phone
        data.joblabel = ply.PlayerData.job.label
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        local result = ExecuteSql("SELECT * FROM users WHERE identifier = '" .. DEVIX.GetPlayerIdentifier(ply) .. "'")
        if result[1] ~= nil then
            data.account = result[1].identifier
            data.phone = result[1].phone_number
            data.joblabel = result[1].job
        else
            print('[^1 DEVIX-DEBUG ]: ^4 GetDataPlayer Functions are not found result #4412')
        end
    end
    return data
end

DEVIX.GetPlayerName = function (ply)
    local data = {}
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        data.firstname =  ply.PlayerData.charinfo.firstname
        data.lastname = ply.PlayerData.charinfo.lastname
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        local result = ExecuteSql("SELECT * FROM users WHERE identifier = '" .. DEVIX.GetPlayerIdentifier(ply) .. "'")
        data.firstname =  result[1].firstname
        data.lastname = result[1].lastname
    end
    return data
end

DEVIX.GetPlayerFromIdentifier = function (ply)
    local data
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        data =  QBCore.Functions.GetPlayerByCitizenId(ply)
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        data =  ESX.GetPlayerFromIdentifier(ply)
    end
    return data
end


DEVIX.GetPlayerSource = function (ply)
    local data
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        data =  ply.PlayerData.source
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        data =  ply.source
    end
    return data
end

DEVIX.AddItem = function (player, itemname, amount)
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        player.Functions.AddItem(tostring(itemname), amount)
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        player.addInventoryItem(tostring(itemname), amount)
    end
end

DEVIX.AddMoney = function (player, cashtype, amount)
    if MENU.Framework == "qb" or MENU.Framework == "oldqb" then
        player.Functions.AddMoney(cashtype, tonumber(amount))
    elseif MENU.Framework == "esx"  or MENU.Framework == "oldesx" then
        player.addAccountMoney(cashtype, tonumber(amount))
    end
end
