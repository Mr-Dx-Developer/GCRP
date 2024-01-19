Citizen.CreateThread(function()
    if Config.UsableItem == "" or Config.UsableItem == false then
        if Config.EnableRegisterKeyMapping then
            RegisterCommand('openbillingmenu', function()
                while Core == nil do
                    Citizen.Wait(0)
                end
                if not nuiLoaded then
                    return
                end
                openBillingMenu()
            end)
            RegisterKeyMapping('openbillingmenu', 'Billing Menu', 'keyboard', Config.EnableRegisterKeyMappingKey)
        else
            CreateThread(function()
                while true do
                    if IsControlJustPressed(0, Config.OpenBillMenu) then
                        openBillingMenu()
                    end
    
                    Citizen.Wait(1)
                end
            end)
        end
    end

end)
