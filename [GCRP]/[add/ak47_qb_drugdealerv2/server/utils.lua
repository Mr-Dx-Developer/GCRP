QBCore = exports['qb-core']:GetCoreObject()

function GetItemLabel(item)
    if QBCore.Shared and QBCore.Shared.Items and QBCore.Shared.Items[item] then
       return QBCore.Shared.Items[item].label
    else
        print('^1Item: ^3['..item..']^1 missing in qb-core/shared/items.lua^0')
        return item
    end
end

function GetPlayerFromId(id)
    return QBCore.Functions.GetPlayer(id).Functions
end

function getInventoryItem(xPlayer, item)
    return xPlayer.GetItemByName(item)
end

function addMoney(source, money)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if Config.GiveBlack then
        local reward = money
        if Config.HasMetaData then
            for i, v in pairs(xPlayer.PlayerData.items) do
                if v.name == Config.Item then
                    xPlayer.Functions.RemoveItem(Config.Item, 1)
                    if v.info and v.info.worth then
                        reward = reward + v.info.worth
                    elseif v.metadata and v.metadata.worth then
                        reward = reward + v.metadata.worth
                    end
                    break
                end
            end
            xPlayer.Functions.AddItem(Config.Item, 1, false, {worth = reward})
        else
            xPlayer.Functions.AddItem(Config.Item, reward)
        end
    else
        xPlayer.Functions.AddMoney('cash', money)
    end
end

function removeItem(source, item, quantity)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(item, quantity)
end

function hasEnoughItem(source, item, quantity)
    local quantity = quantity or 1
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local inv = xPlayer.Functions.GetItemByName(item)
    if inv and ((inv.amount and inv.amount >= quantity) or (inv.count and inv.count >= quantity)) then
        return true
    end
    return false
end

Locales = {}

function _(str, ...)  -- Translate string
    if Locales[Config.Locale] ~= nil then
        if Locales[Config.Locale][str] ~= nil then
            return string.format(Locales[Config.Locale][str], ...)
        else
            return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.Locale .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub("^%l", string.upper))
end
