Config = {}
Config.QBCoreVersion = "newqb" -- newqb or oldqb || only working qbcore
Config.Clothes = "illenium-appearance" -- default - illenium-appearance 
Config.MySQL = "oxmysql" -- oxmysql , mysql-async , ghmattimysql
Config.UseQBApartments = false -- if you use qb-apartments you can change it true
Config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86) -- Default spawn coords if you have start apartments disabled
Config.HiddenCoords = vector4(-812.23, 182.54, 76.74, 156.5) -- 156.5 == heading
Config.EnableCamShake = true
Config.DefaultBucket = 0 -- (please don't change it if you don't know)
Config.ServerLogo = "mrp.png"
Config.EnableDeleteButton  = true
Config.UseMSpawnSelector = true -- if you use m-spawnselector you can change it true
Config.DateFormat = "en-BD" -- http://www.lingoes.net/en/translator/langcode.htm
Config.CodemInventory = false -- if you use codem-inventory you can change it true
Config.DefaultLogo = "https://www.gitbook.com/cdn-cgi/image/width=40,dpr=2,height=40,fit=contain,format=auto/https%3A%2F%2F3253843082-files.gitbook.io%2F~%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FMRUfpMzIuVWlJ1CkzDbb%252Ficon%252FD3wjQp0cCyS6MkqdCs1C%252Fimage_2022-09-06_182033969.png%3Falt%3Dmedia%26token%3D662e0ec6-bb96-40d2-87e0-3e74d4061566"
Config.Slots = {
    [1] = {tebex = false, id = 1},
    [2] = {tebex = false, id = 2},
    [3] = {tebex = true, id = 3},
    [4] = {tebex = true, id = 4},
    [5] = {tebex = true, id = 5},
    -- [6] = {tebex = false, id = 6},
    -- [7] = {tebex = true, id = 7},
    -- [8] = {tebex = true, id = 8},
    -- [9] = {tebex = true, id = 9},
    -- [10] = {tebex = true, id = 10},
}

Config.Animations = {
    ["unemployed"] = {
        camwiewcoord = {coord = vector3(-830.330, 167.9625, 70.294), rot = -25.0}, 
        car = {coord = vector4(-828.923, 173.1707, 70.511, 200.0), hash = "sultan"}, -- car hash
        Peds = {
            {
                coord = vector4(-829.995, 172.3521, 70.403, 170.0), -- npc coord 170.0 heading
                hash = "g_m_y_ballaorig_01", -- npc hash
                isPlayerPed = false,
                animation = {"missheist_jewelleadinout", "jh_int_outro_loop_a"},
            },
            {
                coord = vector4(-828.049, 170.8139, 70.291, 170.0),
                hash = "mp_m_famdd_01",
                isPlayerPed = false,
                animation = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a"},
            },
            {
                coord = vector4(-829.742, 169.4886, 70.007, 160.0),
                hash = nil,
                isPlayerPed = true, -- this ped have a player clothes
                animation = {"timetable@amanda@ig_2", "ig_2_base_amanda"},
            },
        }
    },
    ["police"] = {
        camwiewcoord = {coord = vector3(497.3135, -987.479, 27.969), rot = 88.0}, 
        car = {coord = vector4(492.0758, -987.542, 27.633, -90.0), hash = "police2"}, -- car hash
        Peds = {
            {
                coord = vector4(489.6207, -985.963, 27.628, -90.0),
                hash = "mp_m_securoguard_01",
                isPlayerPed = false,
                animation = {"missheist_jewelleadinout", "jh_int_outro_loop_a"},
            },
            {
                coord = vector4(489.7647, -989.271, 27.655, -90.0),
                hash = "s_m_m_armoured_02",
                isPlayerPed = false,
                animation = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a"},
            },
            {
                coord = vector4(494.9454, -987.481, 27.434, -90.0),
                hash = nil,
                isPlayerPed = true, -- this ped have a player clothes
                animation = {"timetable@amanda@ig_2", "ig_2_base_amanda"},
            },
        }
    },
    ["ambulance"] = {
        camwiewcoord = {coord = vector3(301.9914, -1439.41, 29.998), rot = 140.0}, 
        car = {coord = vector4(297.3335, -1444.75, 29.860, 0.0), hash = "ambulance"}, -- car hash
        Peds = {
            {
                coord = vector4(297.7074, -1441.08, 29.797, -40.0),
                hash = "s_m_m_doctor_01",
                isPlayerPed = false,
                animation = {"missheist_jewelleadinout", "jh_int_outro_loop_a"},
            },
            {
                coord = vector4(299.7201, -1445.90, 29.804, -40.0),
                hash = "s_m_m_paramedic_01",
                isPlayerPed = false,
                animation = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a"},
            },
            {
                coord = vector4(300.7377, -1440.94, 29.794, -40.0),
                hash = nil,
                isPlayerPed = true, -- this ped have a player clothes
                animation = {"timetable@amanda@ig_2", "ig_2_base_amanda"},
            },
        }
    }
}

Config.SetSpawnTrigger = function(src, plyData, isNew) -- when player create a new char isNew variaton getting true
    if Config.UseQBApartments then
        if isNew then
            TriggerClientEvent('apartments:client:setupSpawnUI', src, plyData) -- plyData.cid // plyData.charinfo
        else
            if Config.UseMSpawnSelector then
                TriggerClientEvent('m-spawnselector:client:display',src)
            else
                TriggerClientEvent('qb-spawn:client:setupSpawns',src, plyData, false, nil)
                TriggerClientEvent('qb-spawn:client:openUI',src , true)
            end
        end
    else
        if isNew then
            TriggerClientEvent('m-multichar-creatingFirstChar',src) -- instead your spawn trigger for create first character 
        else -- instead your spawn trigger for load player 
            if Config.UseMSpawnSelector then
                TriggerClientEvent('m-spawnselector:client:display',src)
            else
                TriggerClientEvent('qb-spawn:client:setupSpawns',src, plyData, false, nil)
                TriggerClientEvent('qb-spawn:client:openUI',src , true)
            end
        end 
    end
end

Config.Locales = {
    ["mainTitle"] = "CHARACTER SELECTION",
    -- TEBEX POPUP
    ["tebexPopUpTitle"] = "BUY NEW CHARACTER SLOT",
    ["tebexPopUpButton"] = "OPEN SLOT",
    -- DELETE POPUP
    ["deletePopUpTitle"] = "ARE YOU SURE TO DELETE",
    ["deletePopUpTitle2"] = "THIS CHARACTER ?",
    ["deleteTitle"] = "DELETE CHARACTER",
    -- Global
    ["hello"] = "Hello",
    ["selectchar"] = "Please select a character",
    ["cityAwait"] = "City awaits you!",
    ["createYourNow"] = "Create your character now!",
    ["selected"] = "SELECTED",
    ["noButton"] = "NO",
    ["yesButton"] = "YES",
    ["createNewTitle"] = "CREATE NEW CHARACTER",
    -- Main Page
    ["playButton"] = "PLAY",
    ["playNowText"] = "City awaits you! Play Now!",
    -- -- Current Character Data
    ["statisticsTitle"] = "Character Statistics",
    ["nationalityTitle"] = "NATIONALITY",
    ["numberTitle"] = "NUMBER",
    ["bankTitle"] = "BANK",
    ["cashTitle"] = "CASH",
    ["ageTitle"] = "AGE",
    -- Register Page
    ["registerTitle"] = "CHARACTER REGISTER",
    ["newCharacterTitle"] = "NEW CHARACTER",
    ["registerError"] = "Please fill the blanks correctly!",
    ["nameInput"] = "Name",
    ["surnameInput"] = "Surname",
    ["nationalityInput"] = "Nationality",
    ["birthdateInput"] = "Birthdate",
    ["heightInput"] = "Height",
    ["maleInput"] = "MALE",
    ["femaleInput"] = "FEMALE",
    ["createButton"] = "CREATE",
}

function SecondsToClock(seconds)
    if seconds ~= nil then
        local seconds = tonumber(seconds)

        if seconds <= 0 then
            return "0H 0M PLAYTIME"; -- you can change here //
        else
            hours = string.format("%0.f", math.floor(seconds/3600));
            mins = string.format("%0.f", math.floor(seconds/60 - (hours*60)));
            return hours.."H "..mins.."M PLAYTIME" -- you can change here //
        end
    end
end