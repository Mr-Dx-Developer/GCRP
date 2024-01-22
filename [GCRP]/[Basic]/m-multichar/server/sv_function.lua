RegisterNetEvent("m-multichar-server-LoadPlayer",function(data)
    src = source
	if QBCore.Player.Login(src, data.citizenid) then
        SetPlayerRoutingBucket(src, Config.DefaultBucket)
        print('^2[qb-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..data.citizenid..') has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        loadHouseData(src)   
        CodeM.PlayTime.PlayTimeLogin(data.citizenid)
        TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(src) .. "** ("..data.citizenid.." | "..src..") loaded..")
        Config.SetSpawnTrigger(src, data, false)
        TriggerClientEvent("m-multichar-server-closeNui", src)
        
	end
end)

QBCore.Functions.CreateCallback('m-multichar-server-GetCharacters', function(source, cb)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
	if not license then
		DropPlayer(source, "We can't find your license id!")
		return
	end
	chars = {}
    local result = ExecuteSql('SELECT * FROM players WHERE license = "'..license..'"')
    for i = 1, (#result), 1 do
        result[i].charinfo = json.decode(result[i].charinfo)
        result[i].money = json.decode(result[i].money)
        result[i].job = json.decode(result[i].job)
        local totalPlayedTime = CodeM.PlayTime.GetTotalPlayTime(result[i].citizenid)
        result[i].totalPlayedTime = totalPlayedTime
        table.insert(chars, result[i])
    end
    cb(chars)
    steamname = GetPlayerName(source)
    steampp = GetSteamPP(source)
    TriggerClientEvent("m-multichar-set-steam-info",source, steamname, steampp, source)
end)

RegisterNetEvent("m-multichar-server-CreateChar",function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    if QBCore.Player.Login(src, false, newData) then
        if Config.UseQBApartments then
            SetPlayerRoutingBucket(src, Config.DefaultBucket)
            print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
            QBCore.Commands.Refresh(src)
            loadHouseData(src)
            TriggerClientEvent("m-multichar:client:closeNUIdefault", src)
            Config.SetSpawnTrigger(src, newData, true)
            local ply = QBCore.Functions.GetPlayer(src)
            CodeM.PlayTime.PlayTimeLogin(ply.PlayerData.citizenid)
            CodeM.GiveStarterItems(src)
        else
            SetPlayerRoutingBucket(src, Config.DefaultBucket)
            print('^2[qb-core]^7 '..GetPlayerName(src)..' has successfully loaded!')
            QBCore.Commands.Refresh(src)
            loadHouseData(src)
            TriggerClientEvent("m-multichar-server-closeNui", src)
            Config.SetSpawnTrigger(src, newData, true)
            local ply = QBCore.Functions.GetPlayer(src)
            CodeM.PlayTime.PlayTimeLogin(ply.PlayerData.citizenid)
            CodeM.GiveStarterItems(src)
        end
	end
end)

RegisterServerEvent('m-multichar:server:deleteCharacter')
AddEventHandler('m-multichar:server:deleteCharacter', function(citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
end) 

QBCore.Functions.CreateCallback("m-multichar:server:getSkin", function(source, cb, cid)
    local src = source
    if (Config.Clothes == "default") then
        local result = ExecuteSql('SELECT * FROM playerskins WHERE citizenid= "'..cid..'" AND active = 1')
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    elseif (Config.Clothes == "illenium-appearance") then
        local result = ExecuteSql('SELECT * FROM playerskins WHERE citizenid = "'..cid..'" AND active = 1')
		if result[1] ~= nil then
			cb(json.decode(result[1].skin))
		else
			cb(nil)
		end
    end
end)

CodeM.GiveStarterItems = function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "A1-A2-A | AM-B | C1-C-CE"
        end
        if Config.CodemInventory then
            exports["codem-inventory"]:AddItem(src, v.item, 1, false, info)
        else
            Player.Functions.AddItem(v.item, 1, false, info)
        end
    end
end

function loadHouseData(src)
    local HouseGarages = {}
    local Houses = {}
    local result = MySQL.query.await('SELECT * FROM houselocations', {})
    if result[1] ~= nil then
        for _, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = v.garage ~= nil and json.decode(v.garage) or {}
            Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = owned,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {},
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage,
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", src, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", src, Houses)
end

QBCore.Commands.Add("logout", 'Change Character', {}, false, function(source)
    local src = source
    QBCore.Player.Logout(src)
    TriggerClientEvent('m-multichar-client-Load', src)
end, "admin")

