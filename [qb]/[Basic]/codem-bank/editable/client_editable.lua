Citizen.CreateThread(function()
    local blips = {}
    function createBlips()
        for k, v in pairs(Config.BankLocations) do
            blips[k] = AddBlipForCoord(tonumber(v.coords.x), tonumber(v.coords.y), tonumber(v.coords.z))
            SetBlipSprite(blips[k], Config.Blip.blipType)
            SetBlipDisplay(blips[k], 4)
            SetBlipScale(blips[k], Config.Blip.blipScale)
            SetBlipColour(blips[k], Config.Blip.blipColor)
            SetBlipAsShortRange(blips[k], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring(Config.Blip.blipName))
            EndTextCommandSetBlipName(blips[k])
        end
    end

    Config.OpenTrigger = function()
        if Config.InteractionHandler == "qb-target" then
            for _, v in pairs(Config.BankLocations) do
                exports['qb-target']:AddBoxZone("codembank" .. _, vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.5,
                    {
                        name = "codembank" .. _,
                        debugPoly = false,
                        heading = -20,
                        minZ = v.coords.z - 2,
                        maxZ = v.coords.z + 2,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "codem-bank:openBank",
                                icon = 'fas fa-credit-card',
                                label = "Open Bank",

                            },
                        },
                        distance = 8
                    })
            end
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k, v in pairs(Config.ATMModels) do
                        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v.prop))

                        local distance = #(coords - GetEntityCoords(obj))

                        if distance < 1.5 then
                            exports['qb-target']:AddBoxZone("codematm" .. k, GetEntityCoords(obj), 1.5, 1.5, {
                                name = "codematm" .. k,
                                debugPoly = false,
                                heading = -20,
                                minZ = GetEntityCoords(obj).z,
                                maxZ = GetEntityCoords(obj).z + 2.0,
                            }, {
                                options = {
                                    {
                                        type = "client",
                                        event = "codem-bank:openBankAtm",
                                        icon = 'fas fa-credit-card',
                                        label = "Open Atm",
                                        prop = obj

                                    },
                                },
                                distance = 8
                            })
                        end
                    end

                    Citizen.Wait(wait)
                end
            end)
        elseif Config.InteractionHandler == "ox-target" then
            for k, v in pairs(Config.BankLocations) do
                exports['ox_target']:addBoxZone({
                    coords = vector3(v.coords.x, v.coords.y, v.coords.z),
                    minZ = v.coords.z - 2,
                    maxZ = v.coords.z + 2,
                    heading = -20,
                    name = "codembank" .. k,
                    options = {
                        {
                            type = "client",
                            event = "codem-bank:openBank",
                            icon = 'fas fa-credit-card',
                            label = "Open Bank",


                        },
                    },
                })
            end

            for k, v in pairs(Config.ATMModels) do
                options = { {
                    icon = 'fas fa-credit-card',
                    label = Config.Locales['OPENATM'],
                    event = "codem-bank:openBankAtm",

                } }
                distance = 1.5
                exports['ox_target']:addModel(v.prop, options)
            end
        elseif Config.InteractionHandler == "bt-target" then
            for _, v in pairs(Config.BankLocations) do
                exports['bt-target']:AddBoxZone("codem-bank" .. _, v.coords, 1.25, 0.55, {
                    name = "codem-bank" .. _,
                    heading = 0.0,
                    debugPoly = false,
                    minZ = v.coords.z,
                    maxZ = v.coords.z + 2.0,
                }, {
                    options = {
                        {
                            event = "codem-bank:openBank",
                            icon = "fa-solid fa-bank",
                            label = "Open Bank",
                        },
                    },
                    distance = 3.0,
                    job = { "all" }
                })
            end
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500

                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k, v in pairs(Config.ATMModels) do
                        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v.prop))

                        local distance = #(coords - GetEntityCoords(obj))

                        if distance < 1.5 then
                            exports['bt-target']:AddBoxZone("codem-atm", GetEntityCoords(obj), 1.25, 0.55, {
                                name = "codem-atm",
                                heading = 0.0,
                                debugPoly = false,
                                minZ = GetEntityCoords(obj).z,
                                maxZ = GetEntityCoords(obj).z + 2.0,
                            }, {
                                options = {
                                    {
                                        event = "codem-bank:openBankAtm",
                                        icon = "fa-solid fa-bank",
                                        label = "Open Atm",
                                        prop = obj
                                    },
                                },
                                distance = 3.0,
                                job = { "all" }
                            })
                        end
                    end


                    Citizen.Wait(wait)
                end
            end)
        elseif Config.InteractionHandler == "qtarget" then
            for _, v in pairs(Config.BankLocations) do
                exports["qtarget"]:AddBoxZone("codem-bank" .. _, v.coords, 1.25, 0.55, {
                    name = "codem-bank" .. _,
                    heading = 0.0,
                    debugPoly = false,
                    minZ = v.coords.z,
                    maxZ = v.coords.z + 2.0,
                }, {
                    options = {
                        {
                            event = "codem-bank:openBank",
                            icon = "fa-solid fa-bank",
                            label = "Open Bank",
                        },
                    },
                    distance = 3.0,
                    job = { "all" }
                })
            end
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500

                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k, v in pairs(Config.ATMModels) do
                        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v.prop))

                        local distance = #(coords - GetEntityCoords(obj))

                        if distance < 1.5 then
                            exports["qtarget"]:AddBoxZone("codem-atm", GetEntityCoords(obj), 1.25, 0.55, {
                                name = "codem-atm",
                                heading = 0.0,
                                debugPoly = false,
                                minZ = GetEntityCoords(obj).z,
                                maxZ = GetEntityCoords(obj).z + 2.0,
                            }, {
                                options = {
                                    {
                                        event = "codem-bank:openBankAtm",
                                        icon = "fa-solid fa-bank",
                                        label = "Open Atm",
                                        prop = obj
                                    },
                                },
                                distance = 3.0,
                                job = { "all" }
                            })
                        end
                    end


                    Citizen.Wait(wait)
                end
            end)
        elseif Config.InteractionHandler == "drawtext" then
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500
                    --if response then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    for k, v in pairs(Config.ATMModels) do
                        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(v.prop))
                        local distance = #(coords - GetEntityCoords(obj))

                        if distance < 1.5 then
                            wait = 0
                            DrawText3D(coords.x - 0.5, coords.y - 0.5, coords.z + 0.5,
                                "Press [~g~E~s~] to access the atm")
                            if IsControlJustReleased(0, 38) then
                                exitATM(true, obj)

                                -- TriggerServerEvent("bank:open")
                            end
                        end
                    end

                    for l, s in pairs(Config.BankLocations) do
                        local distance2 = #(coords - s.coords)

                        if distance2 < 1.5 then
                            wait = 0
                            DrawText3D(s.coords.x, s.coords.y, s.coords.z, "Press [~g~E~s~] to access the bank")
                            if IsControlJustReleased(0, 38) then
                                TriggerEvent('codem-bank:openBank')
                            end
                        end
                    end

                    Citizen.Wait(wait)
                end
            end)
        end
    end
end)




RegisterNUICallback('payBill', function(data, cb)
    if data then
        local ChechMoney = TriggerCallback('codem-bank:server:payBilling', data)
        if ChechMoney then
            local payBill = TriggerCallback('codem-bank:server:payBill', data)
            if payBill then
                TriggerEvent('codem-bank:client:sendNotification', Config.Locales['paybill'])
                Wait(400)
                local newBill = TriggerCallback('codem-bank:server:getPlayerBilling')
                cb(newBill)
            end
        end
    end
end)
