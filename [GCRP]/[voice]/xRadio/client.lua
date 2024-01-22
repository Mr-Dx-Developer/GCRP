local Framework = nil


Framework = GetFramework()
CreateThread(function()
    while Framework == nil do Wait(750) end
    Wait(2500)
end)

-- Functions

SendReactMessage = function(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

Close = function()
    SetNuiFocus(false, false)
    toggleRadioAnimation(false)
    SendReactMessage('setOpen', {
        OpenClose = false,
        PlayerID = GetPlayerServerId(PlayerId()),
        Language = Settings.Language, 
    })
end

Open = function()
    SetNuiFocus(true, true)
    toggleRadioAnimation(true)
    SendReactMessage('setOpen', {
        OpenClose = true,
        PlayerID = GetPlayerServerId(PlayerId()),
        Language = Settings.Language, 
    })
end

LoadAnimDic = function(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

toggleRadioAnimation = function(pState)
	LoadAnimDic("cellphone@")
	if pState then
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	else
		StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())
		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
	end
end

-- Event

RegisterNetEvent("xRadio:OpenClose", function(data)
    if data then 
        Open()
    else 
        Close()
    end
end)

RegisterNetEvent("GetRadioPlayer", function(data)
    SendReactMessage('setPlayerID', data) 
end)

-- Command 

RegisterCommand(Settings.ResetCommad, function()
    SendReactMessage('setRadioReset') 
end)

-- NuiCallback 

RegisterNuiCallback("Close", function()
    TriggerEvent("xRadio:OpenClose", false)
end)

RegisterNuiCallback("RadioLeave", function()
    RadioLeave()
    ClientNotification(Settings.Language.leaved .. " " .. RadioCode, "error")
end)



RegisterNuiCallback("setVolume", function(data)
    setVolume(data)
end)

RegisterNUICallback('setRadio', function(data)
    local RadioCode = data
    local isJob = false
    local JobControl = false
    local PlayerData = (Settings.Framework == "ESX" or Settings.Framework == "NewESX") and Framework.GetPlayerData() or Framework.Functions.GetPlayerData()

    if RadioCode ~= nil then
        if Settings.MaxFrequency > RadioCode then 
            if Settings.OnlyJob[RadioCode] and Settings.OnlyJob[RadioCode].RadioCode then 
                JobControl = true
                local radioJobs = Settings.OnlyJob[RadioCode].Jobs
                for _, job in pairs(radioJobs) do
                    if job == PlayerData.job.name then
                        isJob = true
                        break
                    end
                end
            else
                ConnectRadio(RadioCode)
                ClientNotification(Settings.Language.joined .. " " .. RadioCode, "success")
            end
        end
    end

    if JobControl then 
        if isJob then
            ConnectRadio(RadioCode)
            ClientNotification(Settings.Language.joined .. " " .. RadioCode, "success")
        else
            ClientNotification(Settings.Language.encrypted, "error")
        end
    end
end)


-- Exports

exports('openxRadio', Open)
exports('closexRadio', Close)
isDead = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 

        local playerPed =	PlayerPedId()
        local health = GetEntityHealth(playerPed)

        if health < 1 and not isDead then
            RadioLeave()
            isDead = true
        end

        if health > 1 and isDead then
            isDead = false
        end
    end
end)
