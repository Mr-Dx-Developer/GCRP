Framework = nil
Citizen.CreateThread(function()
    Framework = GetFrameworkObject()
end)
Citizen.CreateThread(function()
    while Config == nil or Framework == nil do
        Wait(0)
    end
    RegisterCommand(Config.Commands["open"], function(source)
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
            if Config.ProfilePicture == 'discord' then
                PlayerData[Player.PlayerData.citizenid].image = GetDiscordAvatar(src)
            elseif Config.ProfilePicture == 'steam' then 
                PlayerData[Player.PlayerData.citizenid].image = GetSteamPP(src)
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
                PlayerData[Player.identifier].image = GetDiscordAvatar(src)
            elseif Config.ProfilePicture == 'steam' then 
                PlayerData[Player.identifier].image = GetSteamPP(src)
            end
            TriggerClientEvent("mvip-client-Open", src, PlayerData[Player.identifier])
        end
    end)
    if Config.Framework == "new-qb" or Config.Framework == "old-qb" then
        Framework.Commands.Add(Config.Commands["addvcoin"], "Add V Coin (Admin Only)",{ { name = "id",   help = "Player ID" }, { name = "count", help = "Amount of VCoin" },}, false, function(source, args)
            local id = tonumber(args[1])
            local Player = Framework.Functions.GetPlayer(id)
            local amount = tonumber(args[2]) or 1
            if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
            AddCoin(Player.PlayerData.citizenid, amount)
            Config.SendMessage(Config.Translate["coinadd"], false, "server", source)
        end, "admin")

        Framework.Commands.Add(Config.Commands["removevcoin"], "Remove V Coin (Admin Only)",{ { name = "id",   help = "Player ID" }, { name = "count", help = "Amount of VCoin" },}, false, function(source, args)
            local id = tonumber(args[1])
            local Player = Framework.Functions.GetPlayer(id)
            local amount = tonumber(args[2]) or 1
            if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
            RemoveCoin(Player.PlayerData.citizenid, amount)
            Config.SendMessage(Config.Translate["coinremove"], false, "server", source)
        end, "admin")

        Framework.Commands.Add(Config.Commands["givepass"], "Give Pass (Admin Only)",{ { name = "id",   help = "Player ID" }, { name = "type", help = "Type of pass (golden - platinum - diamond)" },}, false, function(source, args)
            local id = tonumber(args[1])
            local Player = Framework.Functions.GetPlayer(id)
            local pass = tostring(args[2])
            if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
            GivePass(Player.PlayerData.source, pass)
            Config.SendMessage(Config.Translate["gavepass"], false, "server", source)
        end, "admin")

    elseif Config.Framework == "esx" then
        Citizen.CreateThread(function()
            Framework.RegisterCommand(Config.Commands["addvcoin"], 'admin', function(xPlayer, args, showError)
                local source = xPlayer.source
                local id = tonumber(args.playerId.source)
                local count = args.count
                local Player = Framework.GetPlayerFromId(id)
                if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
                AddCoin(Player.identifier, count)
                Config.SendMessage(Config.Translate["coinadd"], false, "server", source)
            end, true,
            {
                help = 'Add V Coin (Admin Only)',
                validate = true,
                arguments = {
                    { name = 'playerId', help = 'playerid', type = 'player' },
                    { name = 'count',    help = 'amount',   type = 'number' }
                }
            })
    
            Framework.RegisterCommand(Config.Commands["removevcoin"], 'admin', function(xPlayer, args, showError)
                local source = xPlayer.source
                local id = tonumber(args.playerId.source)
                local count = args.count
                local Player = Framework.GetPlayerFromId(id)
                if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
                RemoveCoin(Player.identifier, count)
                Config.SendMessage(Config.Translate["coinremove"], false, "server", source)
            end, true,
            {
                help = 'Remove V Coin (Admin Only)',
                validate = true,
                arguments = {
                    { name = 'playerId', help = 'playerid', type = 'player' },
                    { name = 'count',    help = 'amount',   type = 'number' }
                }
            })
    
            Framework.RegisterCommand(Config.Commands["givepass"], 'admin', function(xPlayer, args, showError)
                local source = xPlayer.source
                local id = tonumber(args.playerId.source)
                local Player = Framework.GetPlayerFromId(id)
                local pass = args.type
                if Player == nil then return Config.SendMessage(Config.Translate["playercantfind"], true, "server", source) end
                GivePass(Player.source, pass)
                Config.SendMessage(Config.Translate["gavepass"], false, "server", source)
            end, true,
            {
                help = 'Give Pass (Admin Only)',
                validate = true,
                arguments = {
                    { name = 'playerId', help = 'playerid', type = 'player' },
                    { name = 'type',    help = 'Type of pass (golden - platinum - diamond)',   type = 'string' }
                }
            })
        end)
    end
end)