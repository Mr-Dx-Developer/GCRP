local WebHooks = {
    ["exploit"] = "https://discord.com/api/webhooks/1202138148537376868/n5Yq_LIp12NvYyL8iFBpc9Ld2H74-TgathPOeVltBRgQfEymSvGln-9Usv3hWfFtb-Ah",
    ["triggered"] = "https://discord.com/api/webhooks/1202138213175529552/e8WowVr0VXRsfBQj2JjU0w1OxGseNX4DLJzvimksVV3xRgqxkGMCdbZu-lC_-8Jh2KA-",
    ["report"] = "https://discord.com/api/webhooks/1202138289134637086/eMgzt2B7u1iKbLLvMIsx7PIz1LC7z-pa2Fncp-Wy78IYMV1uJFLfJHVTMCP6HwjF-CLj",
    ["transcript"] = "https://discord.com/api/webhooks/1202138361217687583/BgdsWFcJdVSYduiNpoGQLrGPv0wusjPmk5S05oZaOIU4lfFo6epfD85sLpAf7RdenmEO",
    ["bans"] = "https://discord.com/api/webhooks/1202138427538292797/w98_hlmFqeEIatylyeeV9kk0ICbHJDQjr3hUwYskOd43l8SNILd3vV-PEVOCcYFyXWJz",
}

function SendLogs(source, type, message)
    local colorcode = 5763719
    if type == "exploit" then
        colorcode = 16711680
    end
    local description = ""
    if source == 0 then
        description = "**"..message.."**"
    else
        description = "**"..GetPlayerName(source).."** ("..source..")\n"..message
    end
    if type == "report" then
        description = "**"..GetPlayerName(source).."** ".. message
    end
    local embedData = {
        {
            ["title"] = "Admin Menu Logs" ,
            ["color"] = colorcode,
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = description,
            ["author"] = {
            ["name"] = 'Snipe Admin Menu Logs',
            },
        }
    }
    if type == "transcript" then
        embedData[1].title = "Chat Transcript (Closed by "..GetPlayerName(source)..")"
        embedData[1].footer.text = "Closed on "..os.date("%c")
        embedData[1].description = message
        description = ""
    end
    PerformHttpRequest(WebHooks[type], function(err, text, headers) end, 'POST', json.encode({ username = "Snipe Logs",embeds = embedData}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent("snipe-menu:server:sendLogs", function(type, message)
    if type == "exploit" then
        SendLogs(source, type, message)
    elseif type == "triggered" then
        SendLogs(source, type, message)
    end
end)