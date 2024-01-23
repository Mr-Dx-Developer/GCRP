QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

Citizen.CreateThread(function()
    while QBCore.Functions == nil do
        Citizen.Wait(1000)
    end
    while QBCore.Functions.GetPlayerData() == nil do
        Citizen.Wait(1000)
    end
    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(1000)
    end
    PlayerData = QBCore.Functions.GetPlayerData()

    LocalPlayer.state:set('cDead', false, true)
    LocalPlayer.state:set('cBind', false, true)
    LocalPlayer.state:set('cCuffed', false, true)
    LocalPlayer.state:set('cTrunk', false, true)
    LocalPlayer.state:set('cDrugged', false, true)
    LocalPlayer.state:set('cDruggedBy', false, true)
    LocalPlayer.state:set('cBlind', false, true)
end)

RegisterNetEvent('ak47_qb_crime:notify')
AddEventHandler('ak47_qb_crime:notify', function(msg)
    QBCore.Functions.Notify(msg)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

AddEventHandler('ak47_qb_crime:minimap:off', function()
    -- you can add your hud trigger to hide the minimap when blindfolded (optional)

end)

AddEventHandler('ak47_qb_crime:minimap:on', function()
    -- you can add your hud trigger to show the minimap when not blindfolded (optional)

end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim = data[1]
        if NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(victim) then
            LocalPlayer.state:set('cDead', true, true)
        end
    end
end)

RegisterNetEvent('hospital:client:Revive', function()
    LocalPlayer.state:set('cDead', false, true)
end)

AddEventHandler('ak47_qb_ambulancejob:onPlayerRevive', function()
    LocalPlayer.state:set('cDead', false, true)
end)

function isPlayerFree(notify)
    if IsPedInAnyVehicle(PlayerPedId()) then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vehicle'))
        end
        return false
    end
    if isPlayerCarrying() then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_carry'))
        end
        return false
    end
    if isPlayerCarried() then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_carried'))
        end
        return false
    end
    if LocalPlayer.state.cCuffed then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_cuffed'))
        end
        return false
    end
    if LocalPlayer.state.cTrunk then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_trunk'))
        end
        return false
    end
    if LocalPlayer.state.cDrugged then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_drugged'))
        end
        return
    end
    if LocalPlayer.state.cBind then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_bind'))
        end
        return false
    end
    if LocalPlayer.state.cBlind then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_blind'))
        end
        return false
    end
    return true
end

function isPlayerCarrying()
    if IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 3) then
        return true
    end
    return false
end

function isPlayerCarried()
    if IsEntityPlayingAnim(PlayerPedId(), 'nm', 'firemans_carry', 3) then
        return true
    end
    return false
end

function isPlayerHandsup()
    local ped = PlayerPedId()
    if IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3)
    or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)
    or IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then
        return true
    end
    return false
end

function cancelHandsUp()
    local ped = PlayerPedId()
    if IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3) then
        StopAnimTask(ped, 'missminuteman_1ig_2', 'handsup_base', 3)
    elseif IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3) then
        StopAnimTask(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)
    elseif IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then
        StopAnimTask(ped, 'random@mugging3', 'handsup_standing_base', 3)
    end
end

function isTargetFree(id, notify)
    if IsPedInAnyVehicle(GetPlayerPed(GetPlayerFromServerId(id))) then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vvehicle'))
        end
        return false
    end
    if isTatgetCarrying(GetPlayerPed(GetPlayerFromServerId(id))) then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vcarry'))
        end
        return false
    end
    if isTatgetCarried(GetPlayerPed(GetPlayerFromServerId(id))) then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vcarried'))
        end
        return false
    end
    if Player(id).state.cCuffed then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vcuffed'))
        end
        return false
    end
    if Player(id).state.cTrunk then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vtrunk'))
        end
        return false
    end
    if Player(id).state.cDrugged then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vdrugged'))
        end
        return false
    end
    if Player(id).state.cBind then
        if notify then
            TriggerEvent('ak47_qb_crime:notify', _U('noaction_vbind'))
        end
        return false
    end
    return true
end

function isTatgetHandsup(id)
    local targetped = GetPlayerPed(GetPlayerFromServerId(id))
    if IsEntityPlayingAnim(targetped, 'missminuteman_1ig_2', 'handsup_base', 3)
    or IsEntityPlayingAnim(targetped, 'missminuteman_1ig_2', 'handsup_enter', 3)
    or IsEntityPlayingAnim(targetped, 'random@mugging3', 'handsup_standing_base', 3) then
        return true
    end
    return false
end

function isTatgetCarrying(targetped)
    if IsEntityPlayingAnim(targetped, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 3) then
        return true
    end
    return false
end

function isTatgetCarried(targetped)
    if IsEntityPlayingAnim(targetped, 'nm', 'firemans_carry', 3) then
        return true
    end
    return false
end

function playAnim(dir, anim, blendIn, blendOut, duration, flag, playbackRate)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(dir)
    while not HasAnimDictLoaded(dir) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, dir, anim, blendIn + 0.0, blendOut + 0.0, duration, flag, playbackRate, 0, 0, 0)
end

function disableControls(dir, anim, flag)
    local playerPed = PlayerPedId()
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 22, true) -- Jump
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 23, true) -- Also 'enter'?
    DisableControlAction(0, 288,  true) -- Disable phone
    DisableControlAction(0, 289, true) -- Inventory
    DisableControlAction(0, 170, true) -- Animations
    DisableControlAction(0, 167, true) -- Job
    DisableControlAction(0, 0, true) -- Disable changing view
    DisableControlAction(0, 26, true) -- Disable looking behind
    DisableControlAction(0, 73, true) -- Disable clearing animation
    DisableControlAction(2, 199, true) -- Disable pause screen
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(2, 36, true) -- Disable going stealth
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(0, 21, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
    if not IsEntityPlayingAnim(playerPed, dir, anim, 3) and not IsPedInAnyVehicle(playerPed, false) and not isDead then
        TaskPlayAnim(playerPed, dir, anim, 8.0, -8, -1, flag, 0.0, false, false, false)
    end
end

function disableControlsTied()
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 22, true) -- Jump
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 23, true) -- Also 'enter'?
    DisableControlAction(0, 288,  true) -- Disable phone
    DisableControlAction(0, 289, true) -- Inventory
    DisableControlAction(0, 170, true) -- Animations
    DisableControlAction(0, 167, true) -- Job
    DisableControlAction(0, 0, true) -- Disable changing view
    DisableControlAction(0, 26, true) -- Disable looking behind
    DisableControlAction(0, 73, true) -- Disable clearing animation
    DisableControlAction(2, 199, true) -- Disable pause screen
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(2, 36, true) -- Disable going stealth
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(0, 21, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
end

ShowHelpNotification = function(msg, thisFrame, beep, duration)
    AddTextEntry('CrimeHelpNotification', msg)
    if thisFrame then
        DisplayHelpTextThisFrame('CrimeHelpNotification', false)
    else
        if beep == nil then beep = true end
        BeginTextCommandDisplayHelp('CrimeHelpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end