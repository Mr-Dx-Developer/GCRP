RegisterCommand('scuff', function()
    TriggerEvent('ak47_qb_crime:cuff:soft')
end)
TriggerEvent('chat:addSuggestion', '/scuff', 'Soft cuff a player', {})

RegisterCommand('hcuff', function()
    TriggerEvent('ak47_qb_crime:cuff:hard')
end)
TriggerEvent('chat:addSuggestion', '/hcuff', 'Hard cuff a player', {})

RegisterCommand('uncuff', function()
    TriggerEvent('ak47_qb_crime:cuff:uncuff')
end)
TriggerEvent('chat:addSuggestion', '/uncuff', 'Uncuff a player', {})


RegisterCommand('tie', function()
    TriggerEvent('ak47_qb_crime:bind:call')
end)
TriggerEvent('chat:addSuggestion', '/tie', 'Tie a player', {})

RegisterCommand('untie', function()
    TriggerEvent('ak47_qb_crime:unbind:call')
end)
TriggerEvent('chat:addSuggestion', '/untie', 'Untie a player', {})


RegisterCommand('drag', function()
    TriggerEvent('ak47_qb_crime:drag:action')
end)
TriggerEvent('chat:addSuggestion', '/drag', 'Drag a player', {})