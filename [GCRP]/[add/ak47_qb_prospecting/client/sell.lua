Citizen.CreateThread(function(...)
    if Config.UsePawnShop then
        local menuOpen = false
        local wasOpen = false
        local shopMenu = MenuV:CreateMenu(false, _U('pawnshop'), 'center', 155, 0, 0, 'size-125', 'none', 'menuv', 'pawnshop')

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local letSleep = true
                for i, v in pairs(Config.Shops) do
                    local distance = #(vector3(v.pos.x, v.pos.y, v.pos.z) - coords)
                    if distance < 3.5 then
                        letSleep = false
                        DrawTxt3D(vector3(v.pos.x, v.pos.y, v.pos.z + 1.0), i)
                        if distance < 2.0 and not menuOpen then
                            ShowHelpNotification(_U('etosell'))
                            if IsControlJustReleased(0, 38) then
                                OpenDrugShop(i, v.items, vector3(v.pos.x, v.pos.y, v.pos.z))
                            end
                        end
                    end
                end
                if letSleep then
                    Citizen.Wait(1000)
                end
            end
        end)

        shopMenu:On('close', function()
            menuOpen = false
        end)

        shopMenu:On('open', function()
            menuOpen = true
        end)

        function OpenDrugShop(id, items, coord)
            local id = id
            local items = items
            local coord = coord
            MenuV:CloseMenu(shopMenu)
            shopMenu:ClearItems()
            local elements = {}
            menuOpen = true
            Citizen.CreateThread(function(...)
                while menuOpen do
                    Citizen.Wait(0)
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    if GetDistanceBetweenCoords(coords, coord, true) > 2.0 then
                        menuOpen = false
                        MenuV:CloseMenu(shopMenu)
                    end
                end
            end)
            for i, v in pairs(items) do
                local shopMenuButton = shopMenu:AddButton({
                    label = i, data = i,
                    value = i,
                    select = function(btn)
                        MenuV:CloseMenu(shopMenu)
                        local value = LocalInput(_U('how_much'), 255, '')
                        if tonumber(value) and tonumber(value) > 0 then
                            TriggerServerEvent('ak47_qb_prospecting:sell', id, btn.Value, tonumber(value))
                            Citizen.Wait(1000)
                            OpenDrugShop(id, items, coord)
                        else
                            showNotification('Invalid Input!')
                        end
                    end
                })
            end
            MenuV:OpenMenu(shopMenu)
        end

        Citizen.CreateThread(function()
            for i, v in pairs(Config.Shops) do
                if v.blip.enable then
                    local blip = AddBlipForCoord(v.pos)
                    SetBlipHighDetail(blip, true)
                    SetBlipSprite (blip, v.blip.sprite)
                    SetBlipScale (blip, v.blip.size)
                    SetBlipColour (blip, v.blip.color)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.blip.name)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end)
    end
end)
