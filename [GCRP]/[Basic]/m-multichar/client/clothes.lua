CodeM.SetClothes = function(citizenid, coord, animation, k, createdPeds) 
    if Config.Clothes == "default" then
        QBCore.Functions.TriggerCallback('m-multichar:server:getSkin', function(model, data)
            model = model ~= nil and tonumber(model) or false
            if model ~= nil then
                Citizen.CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    DeleteEntity(createdPeds[k])
                    DeletePed(createdPeds[k])
                    createdPeds[k] = nil
                    createdPeds[k] = CreatePed(2, model, coord.x, coord.y, coord.z - 0.98, coord.w, false, true)
                    SetPedComponentVariation(createdPeds[k], 0, 0, 0, 2)
                    FreezeEntityPosition(createdPeds[k], false)
                    SetEntityInvincible(createdPeds[k], true)
                    PlaceObjectOnGroundProperly(createdPeds[k])
                    SetBlockingOfNonTemporaryEvents(createdPeds[k], true)
                    data = json.decode(data)
                    TriggerEvent('qb-clothing:client:loadPlayerClothing', data, createdPeds[k])
                    TaskPlayAnim(createdPeds[k], animation[1], animation[2], 4.0, 4.0, -1, 50, 0, false, false, false)
                end)
            else
                Citizen.CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    createdPeds[k] = CreatePed(2, model, coord.x, coord.y, coord.z - 0.98, coord.w, false, true)
                    SetPedComponentVariation(createdPeds[k], 0, 0, 0, 2)
                    FreezeEntityPosition(createdPeds[k], false)
                    SetEntityInvincible(createdPeds[k], true)
                    PlaceObjectOnGroundProperly(createdPeds[k])
                    SetBlockingOfNonTemporaryEvents(createdPeds[k], true)
                    TaskPlayAnim(createdPeds[k], animation[1], animation[2], 4.0, 4.0, -1, 50, 0, false, false, false)
                end)
            end
        end, citizenid)
    elseif Config.Clothes == "illenium-appearance" then
        QBCore.Functions.TriggerCallback('m-multichar:server:getSkin', function(skindata)
            if skindata ~= nil then
                Citizen.CreateThread(function()
                    RequestModel(skindata.model)
                    while not HasModelLoaded(skindata.model) do
                        Citizen.Wait(0)
                    end
                    createdPeds[k] = CreatePed(2, skindata.model, coord.x, coord.y, coord.z - 0.98, coord.w, false, true)
                    SetPedComponentVariation(createdPeds[k], 0, 0, 0, 2)
                    FreezeEntityPosition(createdPeds[k], false)
                    SetEntityInvincible(createdPeds[k], true)
                    PlaceObjectOnGroundProperly(createdPeds[k])
                    SetBlockingOfNonTemporaryEvents(createdPeds[k], true)
                    exports['illenium-appearance']:setPedAppearance(createdPeds[k], skindata)
                    TaskPlayAnim(createdPeds[k], animation[1], animation[2], 4.0, 4.0, -1, 50, 0, false, false, false)
                end)
            else
                Citizen.CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    createdPeds[k] = CreatePed(2, model, coord.x, coord.y, coord.z - 0.98, coord.w, false, true)
                    SetPedComponentVariation(createdPeds[k], 0, 0, 0, 2)
                    FreezeEntityPosition(createdPeds[k], false)
                    SetEntityInvincible(createdPeds[k], true)
                    PlaceObjectOnGroundProperly(createdPeds[k])
                    SetBlockingOfNonTemporaryEvents(createdPeds[k], true)
                    TaskPlayAnim(createdPeds[k], animation[1], animation[2], 4.0, 4.0, -1, 50, 0, false, false, false)
                end)
            end
        end, citizenid)
    end
end


RegisterNetEvent("m-multichar-creatingFirstChar")
AddEventHandler("m-multichar-creatingFirstChar",function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    Wait(500)
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    TriggerEvent('qb-weathersync:client:EnableSync')
    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    FreezeEntityPosition(PlayerPedId(), false) -- fixed stuck
end)

