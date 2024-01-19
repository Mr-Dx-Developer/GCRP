function GetFrameworkObject()
    local object = nil
    if Config.QBCoreVersion == "newqb" then
        object = exports["qb-core"]:GetCoreObject()
    end
    if Config.QBCoreVersion == "oldqb" then
        while object == nil do
            TriggerEvent('QBCore:GetObject', function(obj) object = obj end)
            Citizen.Wait(200)
        end
    end
    return object
end