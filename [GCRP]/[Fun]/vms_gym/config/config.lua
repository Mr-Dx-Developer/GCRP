Config = {}

Config.Core = "QB-Core" -- "ESX" / "QB-Core"
Config.CoreExport = function()
    --return exports['es_extended']:getSharedObject()
    return exports['qb-core']:GetCoreObject()
end

Config.Notification = function(title, message, time, icon, type)
    if type == "success" then
        -- ESX.ShowNotification(message)
		QBCore.Functions.Notify(message, "success", 5000)
    elseif type == "info" then
        -- ESX.ShowNotification(message)
		 QBCore.Functions.Notify(message, "inform", 5000)
    elseif type == "error" then
        -- ESX.ShowNotification(message)
		QBCore.Functions.Notify(message, "error", 5000)
    end
end

Config.TextUI = {
    Enabled = false,
    Open = function(msg)
        --exports["interact"]:Open("E", msg) -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['okokTextUI']:Open('[E] '..msg, 'darkgreen', 'right')
         exports['qb-core']:DrawText(msg, 'right')
    end,
    Close = function(msg)
        --exports["interact"]:Close() -- Here you can use your TextUI or use my free one - https://github.com/vames-dev/interact
        -- exports['okokTextUI']:Close()
         exports['qb-core']:HideText()
    end,
}

--@AutoExecuteQuery: Will automatically add the 'statistics' column to your ESX: `users` / QB-Core: `players` table if it doesn't already exist.
Config.AutoExecuteQuery = true

-- @PlayerLoaded: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = "QBCore:Client:OnPlayerLoaded"

-- @PlayerLoaded: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Server:OnPlayerLoaded"
Config.PlayerLoadedServer = "QBCore:Server:OnPlayerLoaded"

-- @PlayerLogoutServer: ESX: "esx:playerLogout" / QB-Core: "playerDropped"
Config.PlayerLogoutServer = "playerDropped"

-- @JobUpdated: ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.JobUpdated = 'QBCore:Client:OnJobUpdate'

-- @SavingTimeout: Every how long the player's statistics will be saved to the database - recommended 10 or 15 minutes
Config.SavingTimeout = 60 * 10 * 1000 -- 10 minutes

Config.Menu = 'ox_lib' -- 'esx_menu_default' / 'esx_context' / 'qb-menu' / 'ox_lib'
Config.ESXMenuDefault_Align = 'right'

Config.SendNotificationWhenSkillIncrase = false
Config.SendNotificationWhenSkillDecrease = false

Config.DistanceView = 2.25
Config.DistanceAccess = 0.5
Config.UseMarkers = true
Config.Use3DText = false
Config.UseHelpNotify = true

-- @UseTarget: If you use a target, markers for gym activities will not be displayed - the marker will remain for the boss menu
Config.UseTarget = false
Config.TargetResource = 'ox_target'
Config.Target = function(data, func)
    if Config.TargetResource == 'ox_target' then
        exports[Config.TargetResource]:addBoxZone({
            coords = data.activityCoord,
            size = vec(2.0, 2.0, 4.3),
            debug = false,
            useZ = true,
            rotation = data.activityCoord.w,
            distance = 0.7,
            options = {
                {
                    name = 'gym-'..data.name,
                    icon = 'fa-solid fa-dumbbell',
                    label = Config.Translate[Config.Language]['action.'..data.name],
                    onSelect = func
                }
            }
        })
    elseif Config.TargetResource == 'qb-target' then
        exports['qb-target']:AddBoxZone('gym-'..data.name, data.activityCoord, 2.0, 2.0, {
            name = 'gym-'..data.name,
            heading = data.activityCoord.w,
            debugPoly = false,
            minZ = data.activityCoord.z,
            maxZ = data.activityCoord.z+3.5,
        }, {
            options = {
                {
                    num = 1,
                    icon = 'fas fa-example',
                    label = Config.Translate[Config.Language]['action.'..data.name],
                    targeticon = 'fa-solid fa-dumbbell',
                    action = func,
                    drawDistance = 10.0,
                    drawColor = {255, 255, 255, 255},
                    successDrawColor = {30, 144, 255, 255},
                }
            },
            distance = 0.7,
        })
    else
        -- If you are using a target system other than ox_target and qb-target, add your target usability logging function here
    end
end


-- @EnableMemberships: If you use in any gym the required membership, run it then it will work correctly reading memberships
Config.EnableMemberships = true

-- @EnableGiveMembership: Allows employees to give gym memberships.
Config.EnableGiveMembership = true
Config.GetClosestPlayersFunction = function()
    --local playerInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 10.0) -- For ESX
     local playerInArea = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0) -- For QB-CORE
    return playerInArea
end


-- @EnableStrenghtModifier: In the config.client.lua file, you can modify the player's hitting power with certain power stats.
-- !!! IF YOUR ANTI-CHEAT BANS FOR STRENGHT MODIFICATION YOU NEED TO SET THIS OPTION TO FALSE OR MAKE A CHANGE IN THE ANTI-CHEAT !!!
Config.EnableStrenghtModifier = true


-- @EnableRunSpeedModifier: In the config.client.lua file, you can modify the player's running speed with certain condition stats.
-- !!! IF YOUR ANTI-CHEAT BANS FOR RUN MODIFICATION YOU NEED TO SET THIS OPTION TO FALSE OR MAKE A CHANGE IN THE ANTI-CHEAT !!!
Config.EnableRunSpeedModifier = true

-- @EnableStaminaModifier: In the config.client.lua file, you can modify the player's stamina level with certain condition stats.
Config.EnableStaminaModifier = true


-- @AutoMembershipForEmployees: Every gym employee will have a gym membership with no requirement to buy one
Config.AutoMembershipForEmployees = true


-- @UseCustomQuestionMenu: if you want to use for example vms_notify Question Menu, set it true, if you want to use Config.Menu to accept / reject of buying membership
Config.UseCustomQuestionMenu = false
Config.CustomQuestionMenu = function(sellerId, membershipName, days, price)
    local question = exports['vms_notify']:Question(Config.Translate[Config.Language]["question.title.buy_membership"], Config.Translate[Config.Language]["question.description.buy_membership"]:format(price, days), '#4f64ff', 'fa-solid fa-people-arrows')
    Citizen.Await(question)
    if question == 'y' then -- vms_notify question export return 'y' when player accept and 'n' when player reject
        TriggerServerEvent("vms_gym:sv:acceptMembership", sellerId, membershipName, days, price)
    elseif question == 'n' then
        TriggerServerEvent("vms_gym:sv:rejectMembership", sellerId)
    end
end


-- @UseProgressbar: If you want to use a progress-bar for the exercises you are doing, you can do so below.
Config.UseProgressbar = false
Config.Progressbar = function(actionName, time)
    exports['progressbar']:Progress({
        name = actionName,
        label = Config.Translate[Config.Language]["progressbar."..actionName],
        duration = time,
        canCancel = false,
        controlDisables = {
            disableMouse = false,
            disableMovement = true,
            disableCarMovement = true,
            disableCombat = true,
        }
    })
end

-- @UseSkillbar: If you want to use a skill-bar for the exercises you are doing, you can do so below.
Config.UseSkillbar = false
Config.Skillbar = function(actionName, cb)
    local finished = exports["qb-skillbar"]:taskBar(3000)
    cb(finished)
end

Config.BossMenu = function(jobName)
    if Config.Core == "ESX" then
        TriggerEvent('esx_society:openBossMenu', jobName, function(data, menu) -- esx_society
            menu.close()
        end, {wash = false})
    elseif Config.Core == "QB-Core" then
        TriggerEvent('qb-bossmenu:client:OpenMenu') -- qb-management
    end
end

Config.StatisticCommand = '+statistique'
Config.StatisticKey = ''
Config.StatisticDescription = 'Open statistics menu'

Config.StatisticsMenu = {
    ['strenght'] = true,
    ['condition'] = true,
    ['shooting'] = true,
    ['driving'] = true,
}

Config.Blip = { -- https://docs.fivem.net/docs/game-references/blips/
    ["Sprite"] = 311,
    ["Scale"] = 0.85,
    ["Color"] = 46,
    ["Display"] = 4
}

Config.Keys = { -- https://docs.fivem.net/docs/game-references/controls/
    enter = 38, -- E
    train = 22, -- SPACE
    stop = 73-- X
}

Config.Markers = {
	['BossMenu'] = {
		id = 29,
		color = {95, 255, 95, 125},
		size = vec(0.33, 0.33, 0.33),
		bobUpAndDown = false,
		rotate = true
	},
	['FreeSeat'] = {
		id = 20,
        color = {59, 227, 137, 125},
        rotation = {180.0, 0.0, 0.0},
		size = vec(0.15, 0.15, 0.15),
		bobUpAndDown = false,
		rotate = true
	},
}

Config.Animations = {
    ['pull-up'] = {
        enter = {'amb@prop_human_muscle_chin_ups@male@enter', 'enter', 1800},
        idle = {'amb@prop_human_muscle_chin_ups@male@idle_a', 'idle_a', -1},
        training = {'amb@prop_human_muscle_chin_ups@male@base', 'base', 2900},
        exit = {'amb@prop_human_muscle_chin_ups@male@exit', 'exit', 2000},
    },
    ['bench'] = {
        enter = {'amb@prop_human_seat_muscle_bench_press@enter', 'enter', 0},
        idle = {'amb@prop_human_seat_muscle_bench_press@base', 'base', -1},
        training = {'amb@prop_human_seat_muscle_bench_press@idle_a', 'idle_a', 2350},
        exit = {'amb@prop_human_seat_muscle_bench_press@exit', 'exit', 2500},
    },
    ['barbell'] = {
        idle = {'amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a', -1},
        training = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 4500},
    },
    ['push-up'] = {
        enter = {'amb@world_human_push_ups@male@enter', 'enter', 3500},
        idle = {'amb@world_human_push_ups@male@idle_a', 'idle_a', -1},
        training = {'amb@world_human_push_ups@male@base', 'base', 1100},
        exit = {'amb@world_human_push_ups@male@exit', 'exit', 4050},
    },
    ['dumbbells'] = {
        idle = {'amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a', -1},
        training = {'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 4500},
    },
    ['treadmill'] = {
        idle = {'move_m@hurry@c', 'walk', -1},
        training = {'move_m@brave@a', 'run', 4000},
    },
}

-- @RefreshTimeAddStats: Time every how much the statistic will add up for different activities e.g. swimming, running etc.
Config.RefreshTimeAddStats = 10000 -- 10 seconds
Config.AddStatsValues = {
    -- Condition:
    ['Running'] = 3,
    ['Swimming'] = {5, 8},
    ['Cycling'] = {minimumSpeed = 15, value = {6, 8}},
    
    -- Shooting:
    ['Shooting'] = {1, 2},

    -- Driving:
    ['Driving'] = {minimumSpeed = 140, value = {2, 3}},
}

-- @RefreshTimeRemoveStats: 
Config.RefreshTimeRemoveStats = 960000 -- 16 min
Config.RemoveStatsValues = {
    -- Condition:
    ['RemoveCondition'] = 1,
}

Config.Gyms = {
    [1] = {
        business = nil, -- true/false
        ownerJob = nil,
        jobMenuPos = vector3(-1195.35, -1577.57, 4.5),
        blipson = true,
        blips = {    
            ["Sprite"] = 311,
            ["Scale"] = 0.85,
            ["Color"] = 46,
            ["Display"] = 4
        },
        menuGrades = nil, -- nil: any player with this job | string: 'boss' | table: {'boss', 'manager'}
        bossMenuGrades = 'boss', -- string: 'boss' or table: {'boss', 'manager'}
        blipCoords = vector3(-1203.47, -1564.67, 4.02),
        blipName = 'Gym Vespucci',
        requiredMembership = 'plaza_gym', -- false or name of membership like: 'plaza_gym'
        memberships = {
            {days = 1, price = 100},
            {days = 7, price = 550},
            {days = 14, price = 1000},
            {days = 24, price = 2000},
            {days = 31, price = 2500},
        },
        points = {
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1200.64, -1562.11, 3.10, 125.29),
                position = vec(-1201.55, -1562.81, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1207.11, -1560.81, 3.10, 212.49),
                position = vec(-1206.53, -1561.62, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1201.3, -1575.02, 3.10, 216.27),
                position = vec(-1200.68, -1575.89, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'bench',
                prop = {name = 'prop_barbell_60kg', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1197.96, -1568.22, 3.10, 305.69),
                position = vec(-1197.13, -1567.6, 4.5),
                removeStamina = 8,
                addSkill = {skill = "strenght", value = {2, 4}}, -- this value is divided by 10 - this means that setting {2, 4} it will be 0.2, 0.4
            },
            {
                name = 'pull-up',
                activityCoord = vector4(-1204.74, -1564.35, 3.585, 35.88),
                position = vec(-1204.74, -1564.35, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'pull-up',
                activityCoord = vector4(-1200.02, -1571.14, 3.585, 213.62),
                position = vec(-1200.19, -1570.93, 4.5),
                removeStamina = 6,
                addSkill = {skill = "strenght", value = {1, 3}}, -- this value is divided by 10 - this means that setting {1, 3} it will be 0.1, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1199.03, -1574.59, 3.61, 215.48),
                position = vec(-1198.97, -1574.5, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1197.01, -1572.9, 3.61, 214.71),
                position = vec(-1197.01, -1572.9, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1202.67, -1565.53, 3.61, 32.46),
                position = vec(-1202.67, -1565.53, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'barbell',
                prop = {name = 'prop_curl_bar_01', attachBone = 28422, placement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}},
                activityCoord = vector4(-1210.31, -1561.34, 3.61, 77.1),
                position = vec(-1210.31, -1561.34, 4.5),
                removeStamina = 7,
                addSkill = {skill = "strenght", value = {2, 3}}, -- this value is divided by 10 - this means that setting {2, 3} it will be 0.2, 0.3
            },
            {
                name = 'push-up',
                activityCoord = vector4(-1204.48, -1561.15, 3.61, 29.36),
                position = vec(-1204.48, -1561.15, 4.5),
                removeStamina = 3,
                addSkill = {skill = "strenght", value = 1}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1202.6, -1572.78, 3.61, 127.31),
                position = vec(-1202.6, -1572.78, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1209.33, -1559.18, 3.61, 48.95),
                position = vec(-1209.33, -1559.18, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1198.32, -1565.38, 3.62, 240.3),
                position = vector3(-1198.32, -1565.41, 4.5),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
        },
    },
    [2] = {
        business = true,
        ownerJob = 'police',
        jobMenuPos = vector3(-398.1144, -335.8492, 43.5974),
        menuGrades = nil, -- nil: any player with this job | string: 'boss' | table: {'boss', 'manager'}
        blipson = false,
        blips = {    
            ["Sprite"] = 311,
            ["Scale"] = 0.85,
            ["Color"] = 46,
            ["Display"] = 4
        },
        bossMenuGrades = 'boss', -- string: 'boss' or table: {'boss', 'manager'}
        blipCoords = vector(-394.1770, -333.7708, 43.5974),
        blipName = 'Gym Police',
        requiredMembership = 'false', -- false or name of membership like: 'pump_and_run'
        memberships = {
            {days = 1, price = 1000},
            {days = 7, price = 5500},
            {days = 14, price = 10000},
            {days = 24, price = 20000},
            {days = 31, price = 25000},
        },
        points = {
            {
                name = 'treadmill',
                activityCoord = vector4(-391.3869, -326.3692, 41.2, 341.3410),
                position = vector3(-391.8715, -327.5160, 42.0761),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'treadmill',
                activityCoord = vector4(-390.2995, -327.0701, 41.2, 341.1237),
                position = vector3(-390.6702, -328.1393, 42.0761),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'treadmill',
                activityCoord = vector4(-386.4366, -329.5710, 41.2, 342.1955),
                position = vector3(-386.8532, -330.8807, 42.0755),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'treadmill',
                activityCoord = vector4(-385.3017, -330.7067, 41.2, 343.0991),
                position = vector3(-385.7185, -331.6349, 42.0761),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'treadmill',
                activityCoord = vector4(-384.2708, -331.5937, 41.2, 341.3134),
                position = vector3(-384.6055, -332.5249, 42.0761),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'treadmill',
                activityCoord = vector4(-382.3198, -332.9682, 41.2, 340.8182),
                position = vector3(-382.6832, -334.0469, 42.0761),
                removeStamina = 1,
                addSkill = {skill = "condition", value = {4, 5}}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },

            {
                name = 'push-up',
                activityCoord = vector4(-388.7486, -327.8879, 41.2, 327.7173),
                position = vector3(-388.7486, -327.8879, 42.0761),
                removeStamina = 3,
                addSkill = {skill = "strenght", value = 1}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            {
                name = 'push-up',
                activityCoord = vector4(-387.8680, -328.5701, 41.2, 334.9362),
                position = vector3(-387.8680, -328.5701, 42.0761),
                removeStamina = 3,
                addSkill = {skill = "strenght", value = 1}, -- this value is divided by 10 - this means that setting 1 it will be 0.1
            },
            --[[{
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1261.55, -353.61, 35.96, 293.97),
                position = vector3(-1261.55, -353.61, 36.96),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1268.76, -357.8, 35.96, 298.89),
                position = vector3(-1268.7, -357.75, 36.96),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },
            {
                name = 'dumbbells',
                prop = {name = 'prop_barbell_01', attachBone = 28422, placement = {-0.24, 0.0, -0.03, 0.0, -50.0, 0.0}},
                prop2 = {name = 'prop_barbell_01', attachBone = 60309, placement = {0.05, 0.0, 0.0, 0.0, -90.0, 120.0}},
                activityCoord = vector4(-1266.69, -356.9, 35.96, 118.72),
                position = vector3(-1266.69, -356.9, 36.96),
                removeStamina = 4,
                addSkill = {skill = "strenght", value = {1, 2}}, -- this value is divided by 10 - this means that setting {1, 2} it will be 0.1, 0.2
            },]]--d
        },
    },
}