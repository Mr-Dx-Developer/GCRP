Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)
Config.PauseMapText = 'Golden City Roleplay' -- Text shown above the map when ESC is pressed. If left empty 'FiveM' will appear
Config.HarnessUses = 200
Config.DamageNeeded = 0.0 -- amount of damage till you can push your vehicle. 0-1000

Config.AFK = {
    ignoredGroups = {
        ['mod'] = true,
        ['admin'] = true,
        ['god'] = true
    },
    secondsUntilKick = 180000000, -- AFK Kick Time Limit (in seconds)
    kickInCharMenu = false -- Set to true if you want to kick players for being AFK even when they are in the character menu.
}

Config.HandsUp = {
    command = 'hu',
    keybind = 'x',
    controls = {24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264}
}

Config.Binoculars = {
    zoomSpeed = 10.0, -- camera zoom speed
    storeBinocularsKey = 177 -- backspace by default
}

Config.AIResponse = {
    wantedLevels = false, -- if true, you will recieve wanted levels
    dispatchServices = { -- AI dispatch services
        [1] = false, -- Police Vehicles
        [2] = false, -- Police Helicopters
        [3] = false, -- Fire Department Vehicles
        [4] = false, -- Swat Vehicles
        [5] = false, -- Ambulance Vehicles
        [6] = false, -- Police Motorcycles
        [7] = false, -- Police Backup
        [8] = false, -- Police Roadblocks
        [9] = false, -- PoliceAutomobileWaitPulledOver
        [10] = false, -- PoliceAutomobileWaitCruising
        [11] = false, -- Gang Members
        [12] = false, -- Swat Helicopters
        [13] = false, -- Police Boats
        [14] = false, -- Army Vehicles
        [15] = false -- Biker Backup
    }
}

-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
Config.Discord = {
    isEnabled = true, -- If set to true, then discord rich presence will be enabled
    applicationId = '1200269885377351721', -- The discord application id
    iconLarge = 'logo', -- The name of the large icon
    iconLargeHoverText = 'Golden City Roleplay', -- The hover text of the large icon
    iconSmall = 'verified', -- The name of the small icon
    iconSmallHoverText = 'Golden City Roleplay', -- The hover text of the small icon
    updateRate = 60000, -- How often the player count should be updated
    showPlayerCount = true, -- If set to true the player count will be displayed in the rich presence
    maxPlayers = 64, -- Maximum amount of players
    buttons = {
        {
            text = 'Connect!',
            url = 'cfx.re/join/43omoq'
        },
        {
            text = 'Discord!',
            url = 'https://discord.gg/goldencity'
        }
    }
}

Config.Density = {
    parked = 0.2,
    vehicle = 0.2,
    multiplier = 0.5,
    peds = 1.0,
    scenario = 0.5
}

Config.Disable = {
    hudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    controls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true, -- false disables ammo display
    ambience = false, -- disables distance sirens, distance car alarms, flight music, etc
    idleCamera = true, -- disables the idle cinematic camera
    vestDrawable = false, -- disables the vest equipped when using heavy armor
    pistolWhipping = true, -- disables pistol whipping
}

Config.Consumables = { --paknami kora dorker nai
    eat = { -- default food items
        ['sandwich'] = math.random(7, 12),
        ['tosti'] = math.random(7, 12),
        ['twerks_candy'] = math.random(7, 12),
        ['kacchi'] = math.random(25, 30),
        ['pantailish'] = math.random(25, 30),
        ['shorshe_ilish'] = math.random(25, 30),
        ['kalabhuna'] = math.random(25, 30),
        ['roshmalai'] = math.random(25, 30),
        ['bhunakhichuri'] = math.random(15, 20),
        ['morogpolao'] = math.random(15, 20),
        ['fuchka'] = math.random(10, 15),
        ['chinesse_noodles'] = math.random(20, 25),
        ['pad_thai_noodles'] = math.random(25, 30),
        ['ramen'] = math.random(25, 30),
        ['vitesnamese_pho'] = math.random(20, 25),
        ['snikkel_candy'] = math.random(7, 12),
        ["taco"] = math.random(25, 34),

    ["bigmac"] = math.random(15, 20),
    ["mcchicken"] = math.random(15, 20),--
    ["quarterpounder"] = math.random(15, 20),
    ["dquarterpounder"] = math.random(15, 20),--
    ["filet-o-fish"] = math.random(15, 20),--
    ["cheeseburger"] = math.random(15, 20),--
    ["bigmac_meal"] = math.random(25, 40),--
    ["mcchicken_meal"] = math.random(25, 40),
    ["quarterpounder_meal"] = math.random(25, 40),
    ["dquarterpounder_meal"] = math.random(25, 40),
    ["filet-o-fish_meal"] = math.random(25, 40),
    ["cheeseburger_meal"] = math.random(25, 40),
    ["dcheeseburger"] = math.random(15, 20),
    ["tcheeseburger"] = math.random(15, 20),
    ["6pnuggets"] = math.random(15, 20),
    ["10pnuggets"] = math.random(15, 20),
    ["20pnuggets"] = math.random(15, 20),
    ["dcheeseburger_meal"] = math.random(25, 40),
    ["tcheeseburger_meal"] = math.random(25, 40),
    ["6pnuggets_meal"] = math.random(25, 40),
    ["10pnuggets_meal"] = math.random(25, 40),
    ["20pnuggets_meal"] = math.random(25, 40),
    ["sfries"] = math.random(5, 10),
    ["mfries"] = math.random(15, 20),
    ["lfries"] = math.random(20, 25),
    ["hotapplepie"] = math.random(15, 20)
    },
    drink = { -- default drink items
        ['water_bottle'] = math.random(7, 12),
        ['kurkakola'] = math.random(7, 12),
        ['sake'] = math.random(25, 30),
        ['mangojuice'] = math.random(8, 10),
        ['borhani'] = math.random(20, 25),
        ['coffee'] = math.random(7, 12),

       
    ["ssconef"] = math.random(15, 20),
    ["sscone"] = math.random(15, 20),
    ["mflurryo"] = math.random(15, 20),
    ["mflurrym"] = math.random(15, 20),
    ["cocacola"] = math.random(20, 30)
    },
    alcohol = { -- default alcohol items
        ['whiskey'] = math.random(7, 12),
        ['beer'] = math.random(7, 12),
        ['vodka'] = math.random(7, 12),
    },

    custom = { -- put any custom items here
    -- ['newitem'] = {
    --     progress = {
    --         label = 'Using Item...',
    --         time = 5000
    --     },
    --     animation = {
    --         animDict = 'amb@prop_human_bbq@male@base',
    --         anim = 'base',
    --         flags = 8,
    --     },
    --     prop = {
    --         model = false,
    --         bone = false,
    --         coords = false, -- vector 3 format
    --         rotation = false, -- vector 3 format
    --     },
    --     replenish = {'''
    --         type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
    --         replenish = math.random(20, 40),
    --         isAlcohol = false, -- if you want it to add alcohol count
    --         event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
    --         server = false -- if the event above is a server event
    --     }
    -- }
    }
}

Config.Fireworks = {
    delay = 8, -- time in s till it goes off
    items = { -- firework items
        'firework1',
        'firework2',
        'firework3',
        'firework4'
    }
}

Config.BlacklistedScenarios = {
    types = {
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE_BIKE'
    },
    groups = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`
    }
}

Config.BlacklistedVehs = {
    [`shamal`] = true,
    [`luxor`] = true,
    [`luxor2`] = true,
    [`jet`] = true,
    [`lazer`] = true,
    [`buzzard`] = true,
    [`buzzard2`] = true,
    [`annihilator`] = true,
    [`savage`] = true,
    [`titan`] = true,
    [`rhino`] = true,
    [`firetruck`] = true,
    [`mule`] = true,
    [`maverick`] = true,
    [`blimp`] = true,
    [`airtug`] = true,
    [`camper`] = true,
    [`hydra`] = true,
    [`oppressor`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`cargoplane2`] = true,
    [`voltic2`] = true
}

Config.BlacklistedWeapons = {
    [`WEAPON_RAILGUN`] = true,
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true
}

Config.WeapDraw = {
    variants = {130, 122, 3, 6, 8},
    weapons = {
        --'WEAPON_STUNGUN',
        'WEAPON_KNIFE',
        'WEAPON_NIGHTSTICK',
        'WEAPON_BREAD',
        'WEAPON_FLASHLIGHT',
        'WEAPON_HAMMER',
        'WEAPON_BAT',
        'WEAPON_GOLFCLUB',
        'WEAPON_CROWBAR',
        'WEAPON_BOTTLE',
        'WEAPON_DAGGER',
        'WEAPON_HATCHET',
        'WEAPON_MACHETE',
        'WEAPON_SWITCHBLADE',
        'WEAPON_BATTLEAXE',
        'WEAPON_POOLCUE',
        'WEAPON_WRENCH',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL_MK2',
        'WEAPON_COMBATPISTOL',
        'WEAPON_APPISTOL',
        'WEAPON_PISTOL50',
        'WEAPON_REVOLVER',
        'WEAPON_SNSPISTOL',
        'WEAPON_HEAVYPISTOL',
        'WEAPON_VINTAGEPISTOL',
        'WEAPON_MICROSMG',
        'WEAPON_SMG',
        'WEAPON_ASSAULTSMG',
        'WEAPON_MINISMG',
        'WEAPON_MACHINEPISTOL',
        'WEAPON_COMBATPDW',
        'WEAPON_PUMPSHOTGUN',
        'WEAPON_SAWNOFFSHOTGUN',
        'WEAPON_ASSAULTSHOTGUN',
        'WEAPON_BULLPUPSHOTGUN',
        'WEAPON_HEAVYSHOTGUN',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
        'WEAPON_ADVANCEDRIFLE',
        'WEAPON_SPECIALCARBINE',
        'WEAPON_BULLPUPRIFLE',
        'WEAPON_COMPACTRIFLE',
        'WEAPON_MG',
        'WEAPON_COMBATMG',
        'WEAPON_GUSENBERG',
        'WEAPON_SNIPERRIFLE',
        'WEAPON_HEAVYSNIPER',
        'WEAPON_MARKSMANRIFLE',
        'WEAPON_GRENADELAUNCHER',
        'WEAPON_RPG',
        'WEAPON_STINGER',
        'WEAPON_MINIGUN',       
        'WEAPON_GRENADE',
        'WEAPON_STICKYBOMB',
        'WEAPON_SMOKEGRENADE',
        'WEAPON_BZGAS',
        'WEAPON_MOLOTOV',
        'WEAPON_DIGISCANNER',
        'WEAPON_FIREWORK',
        'WEAPON_MUSKET',
        'WEAPON_STUNGUN',
        'WEAPON_HOMINGLAUNCHER',
        'WEAPON_PROXMINE',
        'WEAPON_FLAREGUN',
        'WEAPON_MARKSMANPISTOL',
        'WEAPON_RAILGUN',
        'WEAPON_DBSHOTGUN',
        'WEAPON_AUTOSHOTGUN',
        'WEAPON_COMPACTLAUNCHER',
        'WEAPON_PIPEBOMB',
        'WEAPON_DOUBLEACTION',
        'WEAPON_SNOWBALL',
        'WEAPON_PISTOLXM3',
        'WEAPON_CANDYCANE',
        'WEAPON_CERAMICPISTOL',
        'WEAPON_NAVYREVOLVER',
        'WEAPON_GADGETPISTOL',
        'WEAPON_PISTOLXM3',
        'WEAPON_TECPISTOL',
        'WEAPON_HEAVYRIFLE',
        'WEAPON_MILITARYRIFLE',
        'WEAPON_TACTICALRIFLE',
        'WEAPON_SWEEPERSHOTGUN',
        'WEAPON_ASSAULTRIFLE_MK2',
        'WEAPON_BULLPUPRIFLE_MK2',
        'WEAPON_CARBINERIFLE_MK2',
        'WEAPON_COMBATMG_MK2',
        'WEAPON_HEAVYSNIPER_MK2',
        'WEAPON_KNUCKLE',
        'WEAPON_MARKSMANRIFLE_MK2',
        'WEAPON_PRECISIONRIFLE',
        'WEAPON_PETROLCAN',
        'WEAPON_PUMPSHOTGUN_MK2',
        'WEAPON_RAYCARBINE',
        'WEAPON_RAYMINIGUN',
        'WEAPON_RAYPISTOL',
        'WEAPON_REVOLVER_MK2',
        'WEAPON_SMG_MK2',
        'WEAPON_SNSPISTOL_MK2',
        'WEAPON_SPECIALCARBINE_MK2',
        'WEAPON_STONE_HATCHET',
    
        -- normal add ons
        'WEAPON_GLOCK22',
        'WEAPON_M9',
         --ADD ONS
        'WEAPON_L85_CHRISTMAS',
        'WEAPON_NVRIFLE_PURPLE',
        'WEAPON_FAMAS_YELLOW',
        'WEAPON_AKPUV2',
        'WEAPON_M4A5V2',
        'WEAPON_FOOLV2_RED',
        'WEAPON_FOOLV2',
        'WEAPON_GALILARV2',
        'WEAPON_HK516V2',
        'WEAPON_HFSMGV2',
        'WEAPON_GRU2',
        'WEAPON_GRAUV2',
        'WEAPON_GYSV2',
        'WEAPON_NEVAV2',
        'WEAPON_MODULAR_RIFLE',
        'WEAPON_NVRIFLE',
        'WEAPON_M4_T_NEON',
        'WEAPON_M27S',
        'WEAPON_HKUSP',
        'WEAPON_M270D',
        'WEAPON_M4_HALLOWEEN',
        'WEAPON_FAMAS',
        'WEAPON_M4_A_W',
        'WEAPON_L85',
        'WEAPON_UMP',
        'WEAPON_MP5',
        'WEAPON_VECTOR',
        'WEAPON_BAS_P_RED',
        'WEAPON_SCEVO',
        'WEAPON_R90',
        'WEAPON_M133V3',
        'WEAPON_GAU_5A',
        'WEAPON_M82V2',
        'WEAPON_SCARH',
        'WEAPON_M47V2',
        'WEAPON_HOWAT20',
        'WEAPON_ISYV2',
        'WEAPON_M4A1_MOD',
        'WEAPON_BERYL_762',
        'WEAPON_M4_TACTICAL_RED',
        'WEAPON_AK47_NIGHTWISH',
        'WEAPON_XM7_6_8',
        'WEAPON_DESERT_EAGLE',
        'WEAPON_SCAR-L',
        'WEAPON_AWP_ASIIMOV',
        'WEAPON_P250_ASIIMOV',
        'WEAPON_P20_ASIIMOV',
        'WEAPON_AK47_ASIIMOV',
        'WEAPON_M4ASIIMOV',
        'WEAPON_LMTM4R',
        'WEAPON_BULLPUP_SMG'
    }
}

Config.Objects = { -- for object removal
    {coords = vector3(266.09, -349.35, 44.74), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02b'},
    {coords = vector3(285.28, -355.78, 45.13), heading = 0, length = 200, width = 200, model = 'prop_sec_barier_02a'},
}

-- You may add more than 2 selections and it will bring up a menu for the player to select which floor be sure to label each section though
Config.Teleports = {
    [1] = { -- Elevator @ labs
        [1] = { -- up
            poly = {coords = vector3(3540.74, 3675.59, 20.99), heading = 167.5, length = 2, width = 2},
            allowVeh = false, -- whether or not to allow use in vehicle
            label = false -- set this to a string for a custom label or leave it false to keep the default. if more than 2 options, label all options

        },
        [2] = { -- down
            poly = {coords = vector3(3540.74, 3675.59, 28.11), heading = 172.5, length = 2, width = 2},
            allowVeh = false,
            label = false
        }
    },
   --[[ [2] = { --Coke Processing Enter/Exit
        [1] = {
            poly = {coords = vector3(909.49, -1589.22, 30.51), heading = 92.24, length = 2, width = 2},
            allowVeh = false,
            label = '[E] Enter Coke Processing'
        },
        [2] = {
            poly = {coords = vector3(1088.81, -3187.57, -38.99), heading = 181.7, length = 2, width = 2},
            allowVeh = false,
            label = '[E] Leave'
        }
    }]]
}

Config.CarWash = {
    dirtLevel = 0.0, -- threshold for the dirt level to be counted as dirty
    defaultPrice = 500, -- default price for the carwash
    locations = {
         [1] = {coords = vector3(174.81, -1736.77, 28.87), length = 7.0, width = 8.8, heading = 359}, -- South Los Santos Carson Avenue
         [2] = {coords = vector3(25.2, -1391.98, 28.91), length = 6.6, width = 8.2, heading = 0}, -- South Los Santos Innocence Boulevard
         [3] = {coords = vector3(-74.27, 6427.72, 31.02), length = 9.4, width = 8, heading = 315}, -- Paleto Bay Boulevard
         [4] = {coords = vector3(1362.69, 3591.81, 34.5), length = 6.4, width = 8, heading = 21}, -- Sandy Shores
         [5] = {coords = vector3(-699.84, -932.68, 18.59), length = 11.8, width = 5.2, heading = 0} -- Little Seoul Gas Station
    }
}