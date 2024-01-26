bot_Token = ""
 Webhook = {
    ['pass'] = '',
    ['item'] = '',
    ['vcoin'] = '',
}


 Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}


Framework = nil
Citizen.CreateThread(function()
    Framework = GetFrameworkObject()
end)

GetPlayerCharacterNameESX = function(source)
    local xPlayer = Framework.GetPlayerFromId(tonumber(source))
    if xPlayer then
        return xPlayer.getName()
    else
        return "0"
    end
end


RegisterServerEvent("m-vipsystem:OpenVipMenu")
AddEventHandler("m-vipsystem:OpenVipMenu", function()
    local src = source
    local Player = GetPlayer(src)
    if Config.Framework == "new-qb" or Config.Framework == 'old-qb' then
        if not PlayerData[Player.PlayerData.citizenid] then
            PlayerData[Player.PlayerData.citizenid] = {
                coin = 0,
                image = '',
                name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                activepass = "false",
                purchasehistory = {}
            }
            ExecuteSql("INSERT INTO mvip (identifier, activepass, purchasehistory, coin) VALUES ('"..Player.PlayerData.citizenid.."', '"..PlayerData[Player.PlayerData.citizenid].activepass.."', '"..json.encode(PlayerData[Player.PlayerData.citizenid].purchasehistory).."', '"..PlayerData[Player.PlayerData.citizenid].coin.."')")
        end
        PlayerData[Player.PlayerData.citizenid].name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        if Config.ProfilePicture == 'discord' then
            PlayerData[Player.PlayerData.citizenid].image = GetDiscordAvatar(src) or Config.DefaultPicture
        elseif Config.ProfilePicture == 'steam' then 
            PlayerData[Player.PlayerData.citizenid].image = GetSteamPP(src) or Config.DefaultPicture
        end
        TriggerClientEvent("mvip-client-Open", src, PlayerData[Player.PlayerData.citizenid])
    else
        if not PlayerData[Player.identifier] then
            PlayerData[Player.identifier] = {
                coin = 0,
                image = '',
                name = GetPlayerCharacterNameESX(src),
                activepass = "false",
                purchasehistory = {}
            }
            ExecuteSql("INSERT INTO mvip (identifier, activepass, purchasehistory, coin) VALUES ('"..Player.identifier.."', '"..PlayerData[Player.identifier].activepass.."', '"..json.encode(PlayerData[Player.identifier].purchasehistory).."', '"..PlayerData[Player.identifier].coin.."')")
        end
        PlayerData[Player.identifier].name = GetPlayerCharacterNameESX(src)
       
        if Config.ProfilePicture == 'discord' then
            PlayerData[Player.identifier].image = GetDiscordAvatar(src) or Config.DefaultPicture
        elseif Config.ProfilePicture == 'steam' then 
            PlayerData[Player.identifier].image = GetSteamPP(src) or Config.DefaultPicture
        end
        TriggerClientEvent("mvip-client-Open", src, PlayerData[Player.identifier])
    end
end)





CheckPlayerMoney = function(source, money)
    money = tonumber(money)
    local Player = GetPlayer(source)
    if money < 0 then
        return true
    end
    local identifier = nil
    if Config.Framework == "esx" then
       identifier = Player.identifier
    elseif Config.Framework == "new-qb" or Config.Framework == "old-qb" then
        identifier = Player.PlayerData.citizenid
    end
    if PlayerData[identifier] then
        if PlayerData[identifier].coin >= money then
            PlayerData[identifier].coin = PlayerData[identifier].coin - money
            ExecuteSql("UPDATE `mvip` SET `coin` = '"..PlayerData[identifier].coin.."' WHERE `identifier` = '"..identifier.."'")
            return true
        else
            return false
        end
    else
        PlayerData[identifier] = {
            coin = 0
        }
        return false
    end
end

AddItem = function(source, rtype, item, count)
    local Player = GetPlayer(source)
    if (rtype == "item") then
        if Config.Framework == "esx" then
            if Config.Inventory == "ox_inventory" then
                exports.ox_inventory:AddItem(source, item, count)
            else
                Player.addInventoryItem(item, count)
            end
        else
            Player.Functions.AddItem(item, count)
        end
    elseif (rtype == "car") then
        giveVehicleDatabase(source, item)
    elseif (rtype == "money") then
        if Config.Framework == "esx" then
            Player.addMoney(count)
        elseif Config.Framework == "new-qb" or Config.Framework == "old-qb" then
            Player.Functions.AddMoney("cash", count)
        end
    elseif (rtype == "") then -- your custom reward type
        -- your custom reward code

    end
end




AddPurchaseHistory = function(src, data)
    local Player = GetPlayer(src)
    if Config.Framework == "esx" then
        local identifier = Player.identifier
        if PlayerData[identifier] then
            PlayerData[identifier].purchasehistory[#PlayerData[identifier].purchasehistory+1] = {
                brand = data.brand,
                model = data.model,
                price = data.price,
                date = os.date("%x")
            }
            ExecuteSql("UPDATE mvip SET purchasehistory = '"..json.encode(PlayerData[identifier].purchasehistory).."' WHERE identifier = '"..identifier.."'")
            TriggerClientEvent("mvip-client-update", src, PlayerData[identifier])
        end
        TriggerClientEvent("mvip-client-update", src, PlayerData[identifier])
    elseif Config.Framework == 'new-qb' or Config.Framework == 'old-qb' then
        local identifier = Player.PlayerData.citizenid
        if PlayerData[identifier] then
            PlayerData[identifier].purchasehistory[#PlayerData[identifier].purchasehistory+1] = {
                brand = data.brand,
                model = data.model,
                price = data.price,
                date = os.date("%x")
            }
            ExecuteSql("UPDATE mvip SET purchasehistory = '"..json.encode(PlayerData[identifier].purchasehistory).."' WHERE identifier = '"..identifier.."'")
            TriggerClientEvent("mvip-client-update", src, PlayerData[identifier])
        end
    end
end

GivePass = function(src, pass)
    local Player = GetPlayer(src)
    local identifier = nil
    if Config.Framework == "new-qb" or Config.Framework == "old-qb" then
        identifier = Player.PlayerData.citizenid
    else
        identifier = Player.identifier
    end
    if tostring(PlayerData[identifier].activepass) == tostring(pass) then
        Config.SendMessage(Config.Translate["alreadyhavepass"], true, 'server', src)
        return
    end
    PlayerData[identifier].activepass = pass
    PlayerData[identifier].activepasstime = os.time()
    PlayerData[identifier].remainingpasstime = Config.PassIntervalDay
    local passdata = Config.Passes[pass]
    if not passdata then return print("unknown pass") end
    rewards = passdata.rewards
    for k,v in pairs(rewards) do
        if v.give then
            for i,j in pairs(v.give) do
                AddItem(src, v.type, j.model, j.count or 1)
            end
        end
    end 
    ExecuteSql("UPDATE mvip SET activepass = '"..PlayerData[identifier].activepass.."', activepasstime = '"..PlayerData[identifier].activepasstime.."' WHERE identifier = '"..identifier.."'")
    Config.SendMessage(Config.Translate["boughtpass"], false, 'server', src)
    TriggerClientEvent("mvip-client-update", src, PlayerData[identifier] or {})
    local formatted = Config.Translate["buypass"]:format(GetPlayerName(src), pass)
   -- TriggerEvent("m-vipsystem:CreateLogs", Config.Translate["buypasstitle"], "green", formatted, src, "pass")
end 

AddPass = function(src, pass)
    local Player = GetPlayer(src)
    local identifier = nil
    if Config.Framework == "new-qb" or Config.Framework == "old-qb" then
        identifier = Player.PlayerData.citizenid
    else
        identifier = Player.identifier
    end
    if PlayerData[identifier].activepass ~= 'false' then
        Config.SendMessage(Config.Translate["alreadyhavepass"], true, 'server', src)
        return
    end
    PlayerData[identifier].activepass = pass
    PlayerData[identifier].activepasstime = os.time()
    PlayerData[identifier].remainingpasstime = Config.PassIntervalDay
    local passdata = Config.Passes[pass]
    if not passdata then return print("unknown pass") end
    rewards = passdata.rewards
    for k,v in pairs(rewards) do
        if v.give then
            for i,j in pairs(v.give) do
                AddItem(src, v.type, j.model, j.count or 1)
            end
        end
    end 
    ExecuteSql("UPDATE mvip SET activepass = '"..PlayerData[identifier].activepass.."', activepasstime = '"..PlayerData[identifier].activepasstime.."' WHERE identifier = '"..identifier.."'")
    Config.SendMessage(Config.Translate["boughtpass"], false, 'server', src)
    TriggerClientEvent("mvip-client-update", src, PlayerData[identifier] or {})
    local formatted = Config.Translate["buypass"]:format(GetPlayerName(src), pass)
   -- TriggerEvent("m-vipsystem:CreateLogs", Config.Translate["buypasstitle"], "green", formatted, src, "pass")
end 

function giveVehicleDatabase(plyid, name)
    local Player = GetPlayer(plyid)
    local plate = GeneratePlate()
    local vehicleProps = GetVehicleProperties(name, plate)
    if Player then
        if Config.Framework == 'esx'  then
            local identifier = Player.identifier
            if identifier then
                
                local garage = 'SanAndreasAvenue'

                local plate = GeneratePlate()
                local vehicleProps = GetVehicleProperties(name, plate)
                if identifier and plate and vehicleProps then
                    ExecuteSql(string.format("INSERT INTO owned_vehicles (owner, plate, vehicle, stored, parking) VALUES ('%s', '%s', %q, '%s', '%s')", identifier, plate, json.encode(vehicleProps), "1", garage))
                end
            end
        elseif Config.Framework == 'oldesx' then
            local identifier = Player.identifier
            if identifier then
                local plate = GeneratePlate()
                local vehicleProps = GetVehicleProperties(name, plate)
                if identifier and plate and vehicleProps then
                    ExecuteSql(string.format("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES ('%s', '%s', %q)", identifier, plate, json.encode(vehicleProps)))
                end
            end        
        else
            local identifier = Player.PlayerData.citizenid
            local garage = 'pillboxgarage'
            ExecuteSql(string.format("INSERT INTO `player_vehicles` (license, citizenid, vehicle, hash, mods, plate, garage) VALUES ('%s', '%s', '%s', '%s', %q, '%s', '%s')",
            Player.PlayerData.license, identifier, name, GetHashKey(name), json.encode(vehicleProps),  plate, garage))
        end
    end
end




GetPlayer = function(source)
    if Config.Framework == "esx" then
        local xPlayer = Framework.GetPlayerFromId(source)
        return xPlayer
    elseif Config.Framework == "new-qb" or Config.Framework == "old-qb" then
        local xPlayer = Framework.Functions.GetPlayer(source)
        return xPlayer
    end
end

function GeneratePlate()
    local tableName = 'player_vehicles'
    local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)

    if Config.Framework == 'esx' or Config.Framework == 'newesx' then
        tableName = 'owned_vehicles'
		plate = RandomStr(3) .. ' ' .. RandomInt(3)
    end
    plate = plate:upper()
    local result =  ExecuteSql(string.format("SELECT plate FROM %s WHERE plate = '%s'", tableName, plate))
    if result[1] then
        return GeneratePlate()
    else
        return plate:upper()
    end
end


local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do NumberCharset[#NumberCharset+1] = string.char(i) end
for i = 65,  90 do StringCharset[#StringCharset+1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset+1] = string.char(i) end

function RandomStr(length)
    if length <= 0 then return '' end
    return RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

function RandomInt(length)
    if length <= 0 then return '' end
    return RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end


function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

function GetVehicleProperties(name, plate)
    local extras = {}
    for i=1, 12 do
        extras[i] = false
    end
    if Config.Framework == 'esx' or Config.Framework == 'newesx' then
        return {
			model             = GetHashKey(name),
			plate             = plate,
			plateIndex        = 0,

			bodyHealth        = Round(1000, 1),
			engineHealth      = Round(1000, 1),
			tankHealth        = Round(1000, 1),

			fuelLevel         = Round(100, 1),
			dirtLevel         = Round(0, 1),
			color1            = 0,
            color1Custom =      {255, 255, 255},

			color2            = 0,
		    color2Custom      = {255, 255, 255},

            color1Type = 0,
            color2Type = 0,
			customPrimaryColor = {255, 255, 255},
			customSecondaryColor = {255, 255, 255},

			pearlescentColor  = 111,
			wheelColor        = 156,

			wheels            = 0,
			windowTint        = -1,
			xenonColor        = 255,

			neonEnabled       = {
				false,
				false,
				false,
				false
			},

			neonColor         = {255,0,255},
			extras            = extras,
			tyreSmokeColor    = {255,255,255},
            dashboardColor    = 0,
            interiorColor     = 0,
			modSpoilers       = -1,
			modFrontBumper    = -1,
			modRearBumper     = -1,
			modSideSkirt      = -1,
			modExhaust        = -1,
			modFrame          = -1,
			modGrille         = -1,
			modHood           = -1,
			modFender         = -1,
			modRightFender    = -1,
			modRoof           = -1,

			modEngine         = -1,
			modBrakes         = -1,
			modTransmission   = -1,
			modHorns          = -1,
			modSuspension     = -1,
			modArmor          = -1,

			modTurbo          = false,
			modSmokeEnabled   = false,
			modXenon          = false,

			modFrontWheels    = -1,
			modBackWheels     = -1,

			modPlateHolder    = -1,
			modVanityPlate    = -1,
			modTrimA          = -1,
			modOrnaments      = -1,
			modDashboard      = -1,
			modDial           = -1,
			modDoorSpeaker    = -1,
			modSeats          = -1,
			modSteeringWheel  = -1,
			modShifterLeavers = -1,
			modAPlate         = -1,
			modSpeakers       = -1,
			modTrunk          = -1,
			modHydrolic       = -1,
			modEngineBlock    = -1,
			modAirFilter      = -1,
			modStruts         = -1,
			modArchCover      = -1,
			modAerials        = -1,
			modTrimB          = -1,
			modTank           = -1,
			modWindows        = -1,
			modDoorR          = -1,
			modLivery         = -1,
			modLightbar       = -1,
            livery            = -1,
		}
    else
        return {
            model = GetHashKey(name),
            plate = plate,
			plateIndex        = 0,
			bodyHealth        = Round(1000,  0.1),
			engineHealth      = Round(1000,  0.1),
			tankHealth        = Round(1000,  0.1),
			fuelLevel         = Round(100, 0.1),
			dirtLevel         = Round(0, 0.1),

			color1            = 0,
			color2            = 0,

			pearlescentColor  = 111,
			wheelColor        = 156,
            dashboardColor    = 0,
            interiorColor     = 0,
			wheels            = 0,
			windowTint        = -1,
			xenonColor        = 255,
            neonEnabled = {
                false,
                false,
                false,
                false
            },
			neonColor         = {255,0,255},
			extras            = extras,
			tyreSmokeColor    = {255,255,255},
            modSpoilers = -1,
            modFrontBumper = -1,
            modRearBumper = -1,
            modSideSkirt = -1,
            modExhaust = -1,
            modFrame = -1,
            modGrille =-1,
            modHood = -1,
            modFender = -1,
            modRightFender = -1,
            modRoof =-1,
            modEngine = -1,
            modBrakes = -1,
            modTransmission = -1,
            modHorns = -1,
            modSuspension = -1,
            modArmor = -1,
            modTurbo = false,
            modSmokeEnabled = false,
            modXenon = false,
            modFrontWheels = -1,
            modBackWheels =-1,
            modCustomTiresF = false,
            modCustomTiresR = false,
            modPlateHolder = -1,
            modVanityPlate = -1,
            modTrimA = -1,
            modOrnaments = -1,
            modDashboard = -1,
            modDial = -1,
            modDoorSpeaker = -1,
            modSeats = -1,
            modSteeringWheel = -1,
            modShifterLeavers = -1,
            modAPlate = -1,
            modSpeakers = -1,
            modTrunk = -1,
            modHydrolic = -1,
            modEngineBlock = -1,
            modAirFilter = -1,
            modStruts = -1,
            modArchCover = -1,
            modAerials = -1,
            modTrimB = -1,
            modTank = -1,
            modWindows = -1,
            modLivery = 0,
        }
    end
end














































































local Caches = {
    Avatars = {}
}

local FormattedToken = "Bot " .. bot_Token
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest(
        "https://discordapp.com/api/" .. endpoint,
        function(errorCode, resultData, resultHeaders)
            data = { data = resultData, code = errorCode, headers = resultHeaders }
        end,
        method,
        #jsondata > 0 and json.encode(jsondata) or "",
        { ["Content-Type"] = "application/json", ["Authorization"] = FormattedToken }
    )

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

function GetDiscordAvatar(user)
    local discordId = nil
    local imgURL = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordId then
        if Caches.Avatars[discordId] == nil then
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})

            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".gif"
                    else
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            end
            Caches.Avatars[discordId] = imgURL
        else
            imgURL = Caches.Avatars[discordId]
        end
    end
    if imgURL == nil then
        imgURL = Config.DefaultPicture
    end
    return imgURL
end


function GetSteamPP(source)
    local idf =  nil
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            idf = v
        end
    end
    local avatar = Config.DefaultPicture
    if idf == nil then
        return avatar
    end
    local callback = promise:new()
    PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', idf), 16) .. '/?xml=1', function(Error, Content, Head)
        local SteamProfileSplitted = stringsplit(Content, '\n')
        if SteamProfileSplitted ~= nil and next(SteamProfileSplitted) ~= nil then
            for i, Line in ipairs(SteamProfileSplitted) do
                if Line:find('<avatarFull>') then
                    callback:resolve(Line:gsub('<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''))
                    for k,v in pairs(callback) do
                        return callback.value
                    end
                    break
                end
            end
        end
    end)
    return Citizen.Await(callback)
end

function GetIDFromSource(Type, CurrentID) 
    local ID = stringsplit(CurrentID, ':')
    if (ID[1]:lower() == string.lower(Type)) then
        return ID[2]:lower()
    end

    return nil
end

function stringsplit(input, seperator)
    if seperator == nil then
        seperator = '%s'
    end

    local t={} ; i=1
    if input ~= nil then
        for str in string.gmatch(input, '([^'..seperator..']+)') do
            t[i] = str
            i = i + 1
        end
        return t
    end
end