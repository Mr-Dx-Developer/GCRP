if Config.Framework ~= "esx" then
    return
end

debugprint("Loading ESX")
local export, obj = pcall(function()
    return exports.es_extended:getSharedObject()
end)

if export then
    ESX = obj
else
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
end
debugprint("ESX loaded")

--- @param source number
--- @return string | nil
function GetIdentifier(source)
    return ESX.GetPlayerFromId(source)?.identifier
end

---Check if a player has a phone with a specific number
---@param source any
---@param number string
---@return boolean
function HasPhoneItem(source, number)
    if not Config.Item.Require then
        return true
    end

    if Config.Item.Unique then
        return HasPhoneNumber(source, number)
    end

    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", Config.Item.Name) or 0) > 0
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    local hasItem = xPlayer.getInventoryItem(Config.Item.Name).count > 0
    if not hasItem then
        return false
    end

    return MySQL.Sync.fetchScalar("SELECT 1 FROM phone_phones WHERE id=@id AND phone_number=@number", {
        ["@id"] = GetIdentifier(source),
        ["@number"] = number
    }) ~= nil
end

---Get a player's character name
---@param source any
---@return string # Firstname
---@return string # Lastname
function GetCharacterName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local firstName, lastName
    if xPlayer.get and xPlayer.get("firstName") and xPlayer.get("lastName") then
        firstName = xPlayer.get("firstName")
        lastName = xPlayer.get("lastName")
    else
        local name = MySQL.Sync.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = GetIdentifier(source)})
        firstName, lastName = name[1]?.firstname or GetPlayerName(source), name[1]?.lastname or ""
    end

    return firstName, lastName
end

---Get an array of player sources with a specific job
---@param job string
---@return table # Player sources
function GetEmployees(job)
    local employees = {}
    if ESX.GetExtendedPlayers then
        local xPlayers = ESX.GetExtendedPlayers("job", job)
        for _, xPlayer in pairs(xPlayers) do
            employees[#employees+1] = xPlayer.source
        end
    else
        local xPlayers = ESX.GetPlayers()
        for _, source in pairs(xPlayers) do
            if ESX.GetPlayerFromId(source).job.name == job then
                employees[#employees+1] = source
            end
        end
    end
    return employees
end

---Get the bank balance of a player
---@param source any
---@return integer
function GetBalance(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return 0
    end
    return xPlayer.getAccount("bank")?.money or 0
end

---Add money to a player's bank account
---@param source any
---@param amount integer
---@return boolean # Success
function AddMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or amount < 0 then
        return false
    end

    xPlayer.addAccountMoney("bank", amount)
    return true
end

---Remove money from a player's bank account
---@param source any
---@param amount integer
---@return boolean # Success
function RemoveMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or amount < 0 or GetBalance(source) < amount then
        return false
    end

    xPlayer.removeAccountMoney("bank", amount)
    return true
end

---Send a message to a player
---@param source number
---@param message string
function Notify(source, message)
    TriggerClientEvent("esx:showNotification", source, message)
end

-- GARAGE APP

---@param source number
---@return VehicleData[] vehicles An array of vehicles that the player owns
function GetPlayerVehicles(source)
    local vehicles = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@owner", {
        ["@owner"] = GetIdentifier(source)
    })

    local toSend = {}

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if vehicle.stored == nil or GetResourceState("qs-advancedgarages") == "started" then
            vehicle.stored = vehicle.state
        end

        local impounded = false
        if type(vehicle.stored) ~= "boolean" then
            impounded = vehicle.stored == 2
            vehicle.stored = vehicle.stored == 1
        end

        if GetResourceState("cd_garage") == "started" then
            debugprint("Using cd_garage")
            impounded = vehicle.in_garage == 2
            vehicle.stored = vehicle.in_garage or vehicle.in_garage == 1
            vehicle.garage = vehicle.garage_id
            vehicle.type = vehicle.garage_type
        elseif GetResourceState("loaf_garage") == "started" then
            vehicle.stored = 1
        elseif GetResourceState("jg-advancedgarages") == "started" then
            debugprint("Using jg-advancedgarages")
            vehicle.stored = vehicle.in_garage
            vehicle.garage = vehicle.garage_id

            impounded = vehicle.impound == 1
            if impounded and vehicle.impound_data then
                vehicle.stored = false
                vehicle.pound = "Impound"

                local impoundInfo = json.decode(vehicle.impound_data)
                vehicle.impoundReason = impoundInfo and {
                    reason = impoundInfo.reason and #impoundInfo.reason > 0 and impoundInfo.reason or nil,
                    retrievable = ConvertJSTimestamp and ConvertJSTimestamp(impoundInfo.retrieval_date) or nil,
                    price = impoundInfo.retrieval_cost,
                    impounder = impoundInfo.charname
                }
            end
        end

        local location = vehicle.stored and (vehicle.garage or "Garage") or "out"
        if impounded and vehicle.pound then
            location = vehicle.pound
        end

        local newCar = {
            plate = vehicle.plate,
            type = vehicle.type,
            location = location,
            impounded = impounded,
            statistics = {},
            impoundReason = vehicle.impoundReason
        }

        if vehicle.damages then
            local damages = json.decode(vehicle.damages)
            if damages?.engineHealth then
                newCar.statistics.engine = math.floor(damages.engineHealth / 10 + 0.5)
            end

            if damages?.bodyHealth then
                newCar.statistics.body = math.floor(damages.bodyHealth / 10 + 0.5)
            end
        end

        local vehicleMods = json.decode(vehicle.vehicle)
        if vehicleMods.fuel then
            newCar.statistics.fuel = math.floor(vehicleMods.fuel + 0.5)
        end

        newCar.model = vehicleMods.model

        toSend[#toSend+1] = newCar
    end

    return toSend
end

---Get a specific vehicle
---@param source number
---@param plate string
---@return table? vehicleData
function GetVehicle(source, plate)
    local storedColumn, storedValue, outValue = "stored", 1, 0
    if GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
        storedColumn = "in_garage"
    elseif GetResourceState("qs-advancedgarages") == "started" then
        storedColumn = "state"
    end

    local res = MySQL.Sync.fetchAll(([[
        SELECT * FROM owned_vehicles
        WHERE owner=@owner AND plate=@plate AND `%s`=@stored
    ]]):format(storedColumn), {
        ["@owner"] = GetIdentifier(source),
        ["@plate"] = plate,
        ["@stored"] = storedValue
    })

    local vehicle = res[1]
    if not vehicle then
        return
    end

    MySQL.Async.execute(("UPDATE owned_vehicles SET `%s`=@outValue WHERE plate=@plate"):format(storedColumn), {
        ["@plate"] = plate,
        ["@outValue"] = outValue
    })

    vehicle.model = json.decode(vehicle.vehicle).model

    return vehicle
end

function IsAdmin(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isAdmin = xPlayer.getGroup() == "superadmin"

    if not isAdmin then
        return IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
    end

    return isAdmin
end

if ESX.RegisterCommand then
    ESX.RegisterCommand("toggleverified", "admin", function(xPlayer, args, showError)
        local app, username, verified = args.app:lower(), args.username, args.verified

        local allowedApps = {
            ["twitter"] = true,
            ["instagram"] = true,
            ["tiktok"] = true,
            ["birdy"] = true,
            ["trendy"] = true,
            ["instapic"] = true
        }

        if not allowedApps[app] then
            return showError("No such app " .. tostring(app))
        end

        if not username then
            return showError("No username provided")
        end

        if verified ~= 1 and verified ~= 0 then
            return showError("Verified must be 1 or 0")
        end

        ToggleVerified(app, username, verified == 1)
    end, false, {
        help = "Toggle verified for a user profile",
        arguments = {
            {
                name = "app",
                help = "The app: trendy, instapic or birdy",
                type = "any"
            },
            {
                name = "username",
                help = "The profile username",
                type = "any"
            },
            {
                name = "verified",
                help = "The verified state, 1 or 0",
                type = "number"
            }
        }
    })

    ESX.RegisterCommand("changepassword", "admin", function(xPlayer, args, showError)
        local app, username, password = args.app:lower(), args.username, args.password

        local allowedApps = {
            ["twitter"] = true,
            ["instagram"] = true,
            ["tiktok"] = true,
            ["birdy"] = true,
            ["trendy"] = true,
            ["instapic"] = true
        }

        if not allowedApps[app] then
            return showError("No such app " .. tostring(app))
        end

        if not username then
            return showError("No username provided")
        end

        if not password then
            return showError("No password provided")
        end

        ChangePassword(app, username, password)
    end, false, {
        help = "Change a user's password",
        arguments = {
            {
                name = "app",
                help = "The app: trendy, instapic or birdy",
                type = "any"
            },
            {
                name = "username",
                help = "The profile username",
                type = "any"
            },
            {
                name = "password",
                help = "The new password",
                type = "any"
            }
        }
    })
else
    print("^6[LB Phone] ^3[WARNING]^0: ESX.RegisterCommand not found, admin commands not registered. If you wish to use commands, update your ESX. The phone will still work.")
end

-- COMPANIES APP
function GetJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.job?.name
end

function RefreshCompanies()
    local openJobs = {}
    if ESX.GetExtendedPlayers then
        local xPlayers = ESX.GetExtendedPlayers()
        for _, xPlayer in pairs(xPlayers) do
            local job = xPlayer.job.name
            openJobs[job] = true
        end
    else
        local xPlayers = ESX.GetPlayers()
        for _, source in pairs(xPlayers) do
            local job = ESX.GetPlayerFromId(source).job.name
            openJobs[job] = true
        end
    end

    for i = 1, #Config.Companies.Services do
        local jobData = Config.Companies.Services[i]
        Config.Companies.Services[i].open = openJobs[jobData.job] or false
    end
end