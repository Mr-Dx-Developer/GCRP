RegisterServerEvent('ak47_qb_prospecting:sell')
AddEventHandler('ak47_qb_prospecting:sell', function(id, itemName, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local price = Config.Shops[id].items[itemName].price
    local xItem = xPlayer.Functions.GetItemByName(itemName)
    if not price then
        return
    end
    if not xItem or xItem.amount < amount then
        TriggerClientEvent('ak47_qb_prospecting:notify', xPlayer.PlayerData.source, _U('not_enough'))
        return
    end
    price = math.ceil(price * amount)
    xPlayer.Functions.AddMoney('cash', price)
    xPlayer.Functions.RemoveItem(xItem.name, amount)
    TriggerClientEvent('ak47_qb_prospecting:notify', xPlayer.PlayerData.source, _U('sold', amount, xItem.label, price))
end)