lib = exports.loaf_lib:GetLib()

local function isResourceStartedOrStarting(resource)
    local state = GetResourceState(resource)
    return state == "started" or state == "starting"
end

if Config.HouseScript == "auto" then
    Config.HouseScript = false

    local houseScripts = {
        "loaf_housing",
        "qb-houses",
        "qs-housing"
    }

    for i = 1, #houseScripts do
        if isResourceStartedOrStarting(houseScripts[i]) then
            Config.HouseScript = houseScripts[i]
            break
        end
    end
end

if Config.Item.Unique and Config.Item.Inventory == "auto" then
    local inventoryScripts = {
        "ox_inventory",
        "qb-inventory",
        "lj-inventory",
        "core_inventory",
        "mf-inventory",
        "qs-inventory",
        "codem-inventory"
    }

    for i = 1, #inventoryScripts do
        if isResourceStartedOrStarting(inventoryScripts[i]) then
            Config.Item.Inventory = inventoryScripts[i]
            break
        end
    end
end

if Config.Framework == "auto" then
    if isResourceStartedOrStarting("es_extended") then
        Config.Framework = "esx"
    elseif isResourceStartedOrStarting("qb-core") then
        Config.Framework = "qb"
    elseif isResourceStartedOrStarting("ox_core") then
        Config.Framework = "ox"
    else
        Config.Framework = "standalone"
    end
end

function debugprint(...)
    if Config.Debug then
        local data = {...}
        local str = ""
        for i = 1, #data do
            if type(data[i]) == "table" then
                str = str .. json.encode(data[i])
            elseif type(data[i]) ~= "string" then
                str = str .. tostring(data[i])
            else
                str = str .. data[i]
            end
            if i ~= #data then
                str = str .. " "
            end
        end

        print("^6[LB Phone] ^3[Debug]^0: " .. str)
    end
end

function table.deep_clone(og)
    local copy = {}
    for k, v in pairs(og) do
        if type(v) == "table" then
            v = table.deep_clone(v)
        end
        copy[k] = v
    end
    return copy
end

function contains(t, v)
    for i = 1, #t do
        if t[i] == v then
            return true, i
        end
    end

    return false
end

local function GenerateLocales(localesFile)
    local tempLocals = {}
    local function formatLocales(localeTable, prefix)
        for k, v in pairs(localeTable) do
            if type(v) == "table" then
                formatLocales(v, prefix .. k .. ".")
            else
                tempLocals[prefix .. k] = v
            end
        end
    end

    formatLocales(localesFile, "")
    return tempLocals
end

local function loadLocales(locale)
    if not locale then
        return {}
    end

    local fileContent = LoadResourceFile(GetCurrentResourceName(), "config/locales/" .. locale .. ".json")
    if not fileContent then
        print("^6[LB Phone] ^1[ERROR]^7: Invalid locale '" .. locale .. "' (file not found)")
        return {}
    end

    local decoded = json.decode(fileContent)
    if not decoded then
        print("^6[LB Phone] ^1[ERROR]^7: Invalid locale '" .. locale .. "' (error in file)")
        return {}
    end

    return GenerateLocales(decoded)
end

local locales = loadLocales(Config.DefaultLocale or "en")
local defaultLocales
if Config.DefaultLocale ~= "en" then
    defaultLocales = loadLocales("en")
else
    defaultLocales = {}
end

function L(path, args)
    assert(type(path) == "string", "path must be a string")

    local translation = locales[path] or defaultLocales[path] or path

    if args then
        for k, v in pairs(args) do
            local safe_v = tostring(v):gsub("%%", "%%%%")  -- Escape % characters
            translation = translation:gsub("{" .. k .. "}", safe_v)
        end
    end

    return translation
end

if not IsDuplicityVersion() then
    local lastInteraction = 0
    function CanInteract()
        if lastInteraction + 500 > GetGameTimer() then
            return false
        end
        lastInteraction = GetGameTimer()
        return true
    end
end

function SeperateNumber(number)
    -- https://stackoverflow.com/questions/10989788/format-integer-in-lua
    local res = tostring(number):reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^ ", "")
    return res
end

function FormatNumber(number)
    if not number or type(number) ~= "string" then
        return ""
    end

    local format = Config.PhoneNumber.Format
    -- remove any non-numeric characters from the number
    number = number:gsub("%D", "")

    -- iterate through the format string
    local result = {}
    local i = 1
    while i <= #format do
        local c = format:sub(i, i)
        if c == "{" then
            -- get the number of digits specified in the format string
            local j = i + 1
            while j <= #format and format:sub(j, j) ~= "}" do
                j += 1
            end
            local n = tonumber(format:sub(i + 1, j - 1))

            -- add the next n digits from the number to the result
            for k = 1, n do
                local digit = number:sub(k, k)
                if not digit then
                    break
                end
                result[#result+1] = digit
            end
            number = number:sub(n + 1)
            i = j + 1
        else
            -- add the non-digit character to the result
            result[#result+1] = c
            i += 1
        end
    end
    return table.concat(result)
end
exports("FormatNumber", FormatNumber)

local months = { Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6, Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12 }
local pattern = "%a+%s+(%a+)%s+(%d+)%s+(%d+)%s+(%d+):(%d+):(%d+)"

function ConvertJSTimestamp(timestamp)
    local month, day, year, hour, min, sec = timestamp:match(pattern)
    local date = {
        year = tonumber(year),
        month = months[month],
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    }

    return os.time(date) * 1000
end