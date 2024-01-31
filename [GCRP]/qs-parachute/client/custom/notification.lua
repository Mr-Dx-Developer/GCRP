function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

TriggerEvent('chat:addSuggestion', '/resetparachute', 'Remove the parachute currently in place', {
    { name = 'color', help = 'Select the color of the parachute to remove, example "red"' },
})
