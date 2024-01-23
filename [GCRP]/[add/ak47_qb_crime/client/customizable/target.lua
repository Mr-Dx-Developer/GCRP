Citizen.CreateThread(function()
    if Config.Rob then
        if GetResourceState('ox_target') == 'started' then
            exports['ox_target']:addGlobalPlayer({
                {
                    icon = "fa-solid fa-people-robbery",
                    label = "Rob",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return isTatgetHandsup(targetId) or Player(targetId).state.cCuffed or Player(targetId).state.cBind or Player(targetId).state.cDead
                    end,
                    onSelect = function(data)
                        if lib.skillCheck({areaSize = 60, speedMultiplier = 1.2}, {'w', 'a', 's', 'd'}) then
                            Wait(10)
                            if lib.skillCheck({areaSize = 60, speedMultiplier = 1.3}, {'w', 'a', 's', 'd'}) then
                                ExecuteCommand(Config.RobCommand)
                            end
                        end
                    end,
                    distance = 2.5,
                },
            })
        else
            exports['qb-target']:AddGlobalPlayer({
                options = {
                    {
                        icon = "fa-solid fa-people-robbery",
                        label = "Rob",
                        canInteract = function(entity)
                            local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                            return isTatgetHandsup(targetId) or Player(targetId).state.cCuffed or Player(targetId).state.cBind or Player(targetId).state.cDead
                        end,
                        action = function(entity)
                            if lib.skillCheck({areaSize = 60, speedMultiplier = 1.2}, {'w', 'a', 's', 'd'}) then
                                Wait(10)
                                if lib.skillCheck({areaSize = 60, speedMultiplier = 1.3}, {'w', 'a', 's', 'd'}) then
                                    ExecuteCommand(Config.RobCommand)
                                end
                            end
                        end,
                    },
                },
                distance = 2.5
            })
        end
    end
    if GetResourceState('ox_target') == 'started' then
        exports['ox_target']:addGlobalPlayer({
            {
                icon = "fa-solid fa-handcuffs",
                label = "Soft Cuff",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return isTargetFree(targetId) and (isTatgetHandsup(targetId) or (Config.Cops[PlayerData.job.name]) or IsPedRagdoll(GetPlayerPed(GetPlayerFromServerId(targetId))))
                end,
                onSelect = function(entity)
                    TriggerEvent('ak47_qb_crime:cuff:soft', entity)
                end,
                distance = 2.5,
            },
            {
                icon = "fa-solid fa-handcuffs",
                label = "Hard Cuff",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return isTargetFree(targetId) and ((Config.Cops[PlayerData.job.name]) or IsPedRagdoll(GetPlayerPed(GetPlayerFromServerId(targetId))))
                end,
                onSelect = function(entity)
                    TriggerEvent('ak47_qb_crime:cuff:hard', entity)
                end,
                distance = 2.5,
            },
            {
                label = "Unuff",
                icon = "fa-solid fa-key",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return Player(targetId).state.cCuffed and isPlayerFree(false)
                end,
                onSelect = function(entity)
                    TriggerEvent('ak47_qb_crime:cuff:uncuff', entity)
                end,
                distance = 2.5,
            },
            {
                event = "ak47_qb_crime:drag:action",
                icon = "fas fa-people-pulling",
                label = "Drag",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return (Player(targetId).state.cCuffed or Player(targetId).state.cDead) and not Player(targetId).state.cDrugged and not Player(targetId).state.cDrugging
                end,
                distance = 2.5,
            },
            {
                label = "Tie",
                icon = "fa-solid fa-hand",
                event = "ak47_qb_crime:bind:call",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return not Config.Cops[PlayerData.job.name] and not Config.Ems[PlayerData.job.name] and isTargetFree(targetId) and isTatgetHandsup(targetId)
                end,
                distance = 2.5,
            },
            {
                label = "Untie",
                icon = "fa-solid fa-scissors",
                event = "ak47_qb_crime:unbind:call",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return isPlayerFree() and Player(targetId).state.cBind
                end,
                distance = 2.5,
            },
            {
                label = "Blindfold",
                icon = "fa-solid fa-ghost",
                event = "ak47_qb_crime:blindfold:use",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return isPlayerFree() and not Player(targetId).state.cBlind and (isTatgetHandsup(targetId) or Player(targetId).state.cCuffed or Player(targetId).state.cBind)
                end,
                distance = 2.5,
            },
            {
                label = "Blindfold Remove",
                icon = "fa-solid fa-eye",
                event = "ak47_qb_crime:blindfold:remove",
                canInteract = function(entity)
                    local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                    return Player(targetId).state.cBlind and isPlayerFree()
                end,
                distance = 2.5,
            },
        })
        exports['ox_target']:addGlobalVehicle({
            {
                icon = 'fa-solid fa-car',
                label = 'Put in Vehicle',
                canInteract = function(entity)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then
                        local targetId = GetPlayerServerId(closestPlayer)
                        if (Player(targetId).state.cCuffed or Player(targetId).state.cDead or Player(targetId).state.cDrugged) and 
                        not Player(targetId).state.cTrunk and 
                        not isTatgetCarrying(GetPlayerPed(closestPlayer)) and 
                        not isTatgetCarried(GetPlayerPed(closestPlayer)) and 
                        not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and
                        not LocalPlayer.state.cDead and 
                        not LocalPlayer.state.cDrugged and
                        not LocalPlayer.state.cTrunk and
                        not LocalPlayer.state.cCuffed and
                        not LocalPlayer.state.cBind and
                        not isPlayerCarried() and not isPlayerCarrying() then
                            return true
                        else
                            return false
                        end
                    end
                    return false
                end,
                onSelect = function(data)
                    TriggerEvent('ak47_qb_crime:putInVehicle:action', data.entity)
                end,
                distance = 3.0,
            },
            {
                type = "client",
                event = "ak47_qb_crime:OutVehicle:action",
                icon = 'fa-solid fa-car',
                label = 'Out the Vehicle',
                canInteract = function(entity)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 and IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
                        return true
                    end
                    return false
                end,
                distance = 5.0,
            },
            {
                icon = 'fa-solid fa-person-through-window',
                label = 'Hide In Trunk',
                bones = 'boot',
                canInteract = function(entity, distance, coords, name, boneId)
                    return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 and not isPlayerCarried() and not isPlayerCarrying()
                end,
                onSelect = function(data)
                    TriggerEvent('ak47_qb_crime:trunk:in', data.entity)
                end,
                distance = 5.0,
            },
            {
                icon = 'fa-solid fa-person-through-window',
                label = 'Put In Trunk',
                bones = 'boot',
                canInteract = function(entity, distance, coords, name, boneId)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then
                        local targetId = GetPlayerServerId(closestPlayer)
                        if (Player(targetId).state.cCuffed or Player(targetId).state.cDead or Player(targetId).state.cDrugged or Player(targetId).state.cBind) and 
                        not Player(targetId).state.cTrunk and 
                        not isTatgetCarrying(GetPlayerPed(closestPlayer)) and
                        not isTatgetCarried(GetPlayerPed(closestPlayer)) and
                        not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and
                        not LocalPlayer.state.cDead and 
                        not LocalPlayer.state.cDrugged and
                        not LocalPlayer.state.cTrunk and
                        not LocalPlayer.state.cCuffed and
                        not LocalPlayer.state.cBind and
                        not isPlayerCarried() and not isPlayerCarrying() and
                        #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 then
                            return true
                        else
                            return false
                        end
                    end
                    return false
                end,
                onSelect = function(data)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then
                        TriggerServerEvent('ak47_qb_crime:trunk:forcein', GetPlayerServerId(closestPlayer), VehToNet(data.entity))
                    end
                end,
                distance = 5.0,
            },
            {
                icon = 'fa-solid fa-person-through-window',
                label = 'Pull Out',
                bones = 'boot',
                canInteract = function(entity, distance, coords, name, boneId)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then
                        local targetId = GetPlayerServerId(closestPlayer)
                        if Player(targetId).state.cTrunk and
                        not LocalPlayer.state.cDead and 
                        not LocalPlayer.state.cDrugged and
                        not LocalPlayer.state.cTrunk and
                        not LocalPlayer.state.cCuffed and
                        not LocalPlayer.state.cBind and
                        not isPlayerCarried() and
                        #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 then
                            return true
                        else
                            return false
                        end
                    end
                    return false
                end,
                onSelect = function(data)
                    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 5.0 then
                        TriggerServerEvent('ak47_qb_crime:trunk:forceout', GetPlayerServerId(closestPlayer))
                    end
                end,
                distance = 5.0,
            },
        })
    else
        exports['qb-target']:AddGlobalPlayer({
            options = {
                {
                    icon = "fa-solid fa-handcuffs",
                    label = "Soft Cuff",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return isTargetFree(targetId) and (isTatgetHandsup(targetId) or (Config.Cops[PlayerData.job.name]) or IsPedRagdoll(GetPlayerPed(GetPlayerFromServerId(targetId))))
                    end,
                    action = function(entity)
                        TriggerEvent('ak47_qb_crime:cuff:soft', entity)
                    end,
                },
                {
                    icon = "fa-solid fa-handcuffs",
                    label = "Hard Cuff",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return isTargetFree(targetId) and ((Config.Cops[PlayerData.job.name]) or IsPedRagdoll(GetPlayerPed(GetPlayerFromServerId(targetId))))
                    end,
                    action = function(entity)
                        TriggerEvent('ak47_qb_crime:cuff:hard', entity)
                    end,
                },
                {
                    label = "Unuff",
                    icon = "fa-solid fa-key",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return Player(targetId).state.cCuffed and isPlayerFree(false)
                    end,
                    action = function(entity)
                        TriggerEvent('ak47_qb_crime:cuff:uncuff', entity)
                    end,
                },
                {
                    type = 'client',
                    event = "ak47_qb_crime:drag:action",
                    icon = "fas fa-people-pulling",
                    label = "Drag",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return (Player(targetId).state.cCuffed or Player(targetId).state.cDead) and not Player(targetId).state.cDrugged and not Player(targetId).state.cDrugging
                    end,
                },
                {
                    label = "Tie",
                    icon = "fa-solid fa-hand",
                    type = 'client',
                    event = "ak47_qb_crime:bind:call",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return not Config.Cops[PlayerData.job.name] and not Config.Ems[PlayerData.job.name] and isTargetFree(targetId) and isTatgetHandsup(targetId)
                    end,
                },
                {
                    label = "Untie",
                    icon = "fa-solid fa-scissors",
                    type = 'client',
                    event = "ak47_qb_crime:unbind:call",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return isPlayerFree() and Player(targetId).state.cBind
                    end,
                },
                {
                    label = "Blindfold",
                    icon = "fa-solid fa-ghost",
                    type = 'client',
                    event = "ak47_qb_crime:blindfold:use",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return isPlayerFree() and not Player(targetId).state.cBlind and (isTatgetHandsup(targetId) or Player(targetId).state.cCuffed or Player(targetId).state.cBind)
                    end,
                },
                {
                    label = "Blindfold Remove",
                    icon = "fa-solid fa-eye",
                    type = 'client',
                    event = "ak47_qb_crime:blindfold:remove",
                    canInteract = function(entity)
                        local targetId = GetPlayerServerId(GetNearestPlayerToEntity(entity))
                        return Player(targetId).state.cBlind and isPlayerFree()
                    end,
                },
            },
            distance = 2.5,
        })
        exports['qb-target']:AddGlobalVehicle({
            options = {
                {
                    icon = 'fa-solid fa-car',
                    label = 'Put in Vehicle',
                    canInteract = function(entity)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 then
                            local targetId = GetPlayerServerId(closestPlayer)
                            if (Player(targetId).state.cCuffed or Player(targetId).state.cDead or Player(targetId).state.cDrugged) and 
                            not Player(targetId).state.cTrunk and 
                            not isTatgetCarrying(GetPlayerPed(closestPlayer)) and 
                            not isTatgetCarried(GetPlayerPed(closestPlayer)) and 
                            not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and
                            not LocalPlayer.state.cDead and 
                            not LocalPlayer.state.cDrugged and
                            not LocalPlayer.state.cTrunk and
                            not LocalPlayer.state.cCuffed and
                            not LocalPlayer.state.cBind and
                            not isPlayerCarried() and not isPlayerCarrying() then
                                return true
                            else
                                return false
                            end
                        end
                        return true
                    end,
                    action = function(entity)
                        TriggerEvent('ak47_qb_crime:putInVehicle:action', entity)
                    end,
                },
                {
                    type = "client",
                    event = "ak47_qb_crime:OutVehicle:action",
                    icon = 'fa-solid fa-car',
                    label = 'Out the Vehicle',
                    canInteract = function(entity)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 and IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
                            return true
                        end
                        return false
                    end,
                },
                -- {
                --     icon = 'fa-solid fa-person-through-window',
                --     label = 'Hide In Trunk',
                --     bones = 'boot',
                --     canInteract = function(entity, distance, coords, name, boneId)
                --         return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 and not isPlayerCarried() and not isPlayerCarrying()
                --     end,
                --     action = function(entity)
                --         TriggerEvent('ak47_qb_crime:trunk:in', entity)
                --     end,
                -- },
                -- {
                --     icon = 'fa-solid fa-person-through-window',
                --     label = 'Put In Trunk',
                --     bones = 'boot',
                --     canInteract = function(entity, distance, coords, name, boneId)
                --         local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                --         if closestPlayer ~= -1 and closestDistance <= 5.0 then
                --             local targetId = GetPlayerServerId(closestPlayer)
                --             if (Player(targetId).state.cCuffed or Player(targetId).state.cDead or Player(targetId).state.cDrugged or Player(targetId).state.cBind) and 
                --             not Player(targetId).state.cTrunk and 
                --             not isTatgetCarrying(GetPlayerPed(closestPlayer)) and
                --             not isTatgetCarried(GetPlayerPed(closestPlayer)) and
                --             not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and
                --             not LocalPlayer.state.cDead and 
                --             not LocalPlayer.state.cDrugged and
                --             not LocalPlayer.state.cTrunk and
                --             not LocalPlayer.state.cCuffed and
                --             not LocalPlayer.state.cBind and
                --             not isPlayerCarried() and not isPlayerCarrying() and
                --             #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 then
                --                 return true
                --             else
                --                 return false
                --             end
                --         end
                --         return false
                --     end,
                --     action = function(entity)
                --         local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                --         if closestPlayer ~= -1 and closestDistance <= 5.0 then
                --             TriggerServerEvent('ak47_qb_crime:trunk:forcein', GetPlayerServerId(closestPlayer), VehToNet(entity))
                --         end
                --     end,
                -- },
                -- {
                --     icon = 'fa-solid fa-person-through-window',
                --     label = 'Pull Out',
                --     bones = 'boot',
                --     canInteract = function(entity, distance, coords, name, boneId)
                --         local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                --         if closestPlayer ~= -1 and closestDistance <= 5.0 then
                --             local targetId = GetPlayerServerId(closestPlayer)
                --             if Player(targetId).state.cTrunk and
                --             not LocalPlayer.state.cDead and 
                --             not LocalPlayer.state.cDrugged and
                --             not LocalPlayer.state.cTrunk and
                --             not LocalPlayer.state.cCuffed and
                --             not LocalPlayer.state.cBind and
                --             not isPlayerCarried() and
                --             #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9 then
                --                 return true
                --             else
                --                 return false
                --             end
                --         end
                --         return false
                --     end,
                --     action = function(data)
                --         local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                --         if closestPlayer ~= -1 and closestDistance <= 5.0 then
                --             TriggerServerEvent('ak47_qb_crime:trunk:forceout', GetPlayerServerId(closestPlayer))
                --         end
                --     end,
                -- },
            },
            distance = 5.0,
        }) 
        exports['qb-target']:AddTargetBone('boot', {
            options = {
                {
                    icon = 'fa-solid fa-person-through-window',
                    label = 'Hide In Trunk',
                    canInteract = function(entity)
                        return not isPlayerCarried() and not isPlayerCarrying()
                    end,
                    action = function(entity)
                        TriggerEvent('ak47_qb_crime:trunk:in', entity)
                    end,
                },
                {
                    icon = 'fa-solid fa-person-through-window',
                    label = 'Put In Trunk',
                    canInteract = function(entity, distance, coords, name, boneId)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 then
                            local targetId = GetPlayerServerId(closestPlayer)
                            if (Player(targetId).state.cCuffed or Player(targetId).state.cDead or Player(targetId).state.cDrugged or Player(targetId).state.cBind) and 
                            not Player(targetId).state.cTrunk and 
                            not isTatgetCarrying(GetPlayerPed(closestPlayer)) and
                            not isTatgetCarried(GetPlayerPed(closestPlayer)) and
                            not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and
                            not LocalPlayer.state.cDead and 
                            not LocalPlayer.state.cDrugged and
                            not LocalPlayer.state.cTrunk and
                            not LocalPlayer.state.cCuffed and
                            not LocalPlayer.state.cBind and
                            not isPlayerCarried() and not isPlayerCarrying() then
                                return true
                            else
                                return false
                            end
                        end
                        return false
                    end,
                    action = function(entity)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 then
                            TriggerServerEvent('ak47_qb_crime:trunk:forcein', GetPlayerServerId(closestPlayer), VehToNet(entity))
                        end
                    end,
                },
                {
                    icon = 'fa-solid fa-person-through-window',
                    label = 'Pull Out',
                    canInteract = function(entity, distance, coords, name, boneId)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 then
                            local targetId = GetPlayerServerId(closestPlayer)
                            if Player(targetId).state.cTrunk and
                            not LocalPlayer.state.cDead and 
                            not LocalPlayer.state.cDrugged and
                            not LocalPlayer.state.cTrunk and
                            not LocalPlayer.state.cCuffed and
                            not LocalPlayer.state.cBind and
                            not isPlayerCarried() then
                                return true
                            else
                                return false
                            end
                        end
                        return false
                    end,
                    action = function(data)
                        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 5.0 then
                            TriggerServerEvent('ak47_qb_crime:trunk:forceout', GetPlayerServerId(closestPlayer))
                        end
                    end,
                },
            },
            distance = 5.0,
        })
    end
end)