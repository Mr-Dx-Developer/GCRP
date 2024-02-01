Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

-- To make this simple. Everything you need is in the config, except for discord, weapon drops, vehicle classes for cruise, hands up disabled keys, and recoil

Config.HandsUp = {
    command = 'hu',
    keybind = '',
}

Config.Binoculars = {
    fov_max = 70.0,
    fov_min = 5.0, -- max zoom level (smaller fov is more zoom)
    zoomspeed = 10.0, -- camera zoom speed
    speed_lr = 8.0, -- speed by which the camera pans left-right
    speed_ud = 8.0, -- speed by which the camera pans up-down
    storeBinoclarKey = 177
}

-- Whether to enable or disable dispatch services
Config.DispatchServices = {
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
    [15] = false, -- Biker Backup
}

Config.AmountOfItems = 10 --how many times the script will loop
Config.OpenTime = 3000 --how long you want it to take to open the gift (in ms)
Config.Joingiftitem = {
    [1] =  {item = "joint", minAmount = 1,  maxAmount = 3},
    [2] =  {item = "bandage", minAmount = 1,  maxAmount = 1},
    [3] =  {item = "pistol_ammo", minAmount = 1,  maxAmount = 1},
    [4] =  {item = "armor", minAmount = 1,  maxAmount = 1},
    [5] =  {item = "lockpick", minAmount = 1,  maxAmount = 2},
}

-- Enable or disable the wanted level
Config.EnableWantedLevel = false

-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
Config.Discord = {
    isEnabled = true,                                     -- If set to true, then discord rich presence will be enabled
    applicationId = '1200269885377351721',                   -- The discord application id
    iconLarge = 'logo',                               -- The name of the large icon
    iconLargeHoverText = 'Golden City Roleplay', -- The hover text of the large icon
    iconSmall = 'logo',                         -- The name of the small icon
    iconSmallHoverText = 'Golden City Roleplay', -- The hover text of the small icon
    updateRate = 60000,                                    -- How often the player count should be updated
    showPlayerCount = true,                                -- If set to true the player count will be displayed in the rich presence
    maxPlayers = 64,                                       -- Maximum amount of players
    buttons = {
        {
            text = 'Connect!',
            url = 'fivem://connect/43omoq'
        },
        {
            text = 'Discord!',
            url = 'https://discord.gg/goldencity'
        }
    }
}

Config.Density = {
    ['parked'] = 0.0,
    ['vehicle'] = 0.3,
    ['multiplier'] = 0.1,
    ['peds'] = 0.5,
    ['scenario'] = 0.3,
}

Config.Stun = {
    active = true,
    min = 4000,
    max = 9000
}

Config.Cruise = 'mp/h'
Config.IdleCamera = true
Config.disableHandsupControls = {24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264}
Config.DisableAmbience = false -- Disabled distance sirens, distance car alarms, etc
Config.HarnessUses = 20
Config.DamageNeeded = 100.0 -- vehiclepush 0-1000
Config.EnableProne = false -- prone isnt recomended at this time
Config.MapText = "Golden CIty Roleplay" -- This is the name / text shown above the map

Config.Disable = {
    disableHudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    disableControls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true -- false disables ammo display
}

Config.ConsumablesEat = {

    ["sandwich"] = math.random(10, 15),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),



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
    ["hotapplepie"] = math.random(15, 20),
}

Config.ConsumablesDrink = {
    ["water_bottle"] = math.random(10, 15),
    ["kurkakola"] = math.random(35, 54),
    


    ["coffee"] = math.random(40, 50),
    ["ssconef"] = math.random(15, 20),
    ["sscone"] = math.random(15, 20),
    ["mflurryo"] = math.random(15, 20),
    ["mflurrym"] = math.random(15, 20),
    ["cocacola"] = math.random(20, 30),
}

Config.ConsumablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

-- Custom Consumables hand bones
-- 18905 left hand
-- 57005 right hand
Config.ConsumablesCustom = {
    -- ['newitem'] = {
    --     ['progress'] = {
    --         label = 'Using Item...',
    --         time = 5000
    --     },
    --     ['animation'] = {
    --         animDict = "amb@prop_human_bbq@male@base",
    --         anim = "base",
    --         flags = 8,
    --     },
    --     ['prop'] = {
    --         model = false,
    --         bone = false,
    --         coords = false, -- vector 3 format
    --         rotation = false, -- vector 3 format
    --     },
    --     ['replenish'] = {
    --         type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
    --         replenish = math.random(20, 40),
    --         isAlcohol = false, -- if you want it to add alcohol count
    --         event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
    --         server = false -- if the event above is a server event
    --     }
    -- }
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`LUXOR`] = true,
    [`JET`] = true,
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`TITAN`] = true,
    [`RHINO`] = true,
    [`FIRETRUK`] = true,
    [`MAVERICK`] = true,
    [`BLIMP`] = true,
    [`Blimp2`] = true,
    [`AIRTUG`] = true,
    [`CAMPER`] = true,
    [`HYDRA`] = true,
    [`OPPRESSOR`] = true,
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
    [`voltic2`] = true,
    [`THRUSTER`] = true,
    [`polmav`] = true,
    [`swift`] = true,
    [`frogger`] = true,
    [`policeb`] = true,
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
    [`s_m_y_hwaycop_01`] = true,
}

Config.HolsterVariant = {156, 162, 163, 164, 165, 166, }
Config.HolsterableWeapons = {
    'WEAPON_STUNGUN',
    'WEAPON_PISTOL',
    'WEAPON_PISTOL_MK2',
    'WEAPON_COMBATPISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_REVOLVER',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL',
    --Custom Weapon
	'WEAPON_DE',
	'WEAPON_GLOCK17',
	'WEAPON_M9',
	'WEAPON_M1911',
	'WEAPON_FNX45',
	'WEAPON_GLOCK18C',
	'WEAPON_GLOCK22',
    'WEAPON_MODEL29',
    'WEAPON_FN502',
}

Config.Objects = { -- for object removal
    {coords = vector3(266.09,-349.35,44.74), heading = 0, length = 200, width = 200, model = "prop_sec_barier_02b"},
    {coords = vector3(285.28,-355.78,45.13), heading = 0, length = 200, width = 200, model = "prop_sec_barier_02a"},
}

-- You may add more than 2 selections and it will bring up a menu for the player to select which floor be sure to label each section though
Config.Teleports = {
    [1] = {
        [1] = {
            coords = vector4(1066.2, -3183.38, -39.16, 89.3),
            ["AllowVehicle"] = false,
            drawText = '[E] Exit Lab'
        },
        [2] = {
            coords = vector4(-66.95, -1312.37, 29.28, 180.95),
            ["AllowVehicle"] = false,
            drawText = '[E] Enter Lab'
        },
    },
}

Config.DefaultPrice = 20 -- Default price for the carwash
Config.DirtLevel = 0.1 -- Threshold for the dirt level to be counted as dirty
Config.CarWash = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["poly"] = {
            coords = vector3(174.81, -1736.77, 28.87),
            length = 7.0,
            width = 8.8,
            heading = 359
        }
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["poly"] = {
            coords = vector3(25.2, -1391.98, 28.91),
            length = 6.6,
            width = 8.2,
            heading = 0
        }
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["poly"] = {
            coords = vector3(-74.27, 6427.72, 31.02),
            length = 9.4,
            width = 8,
            heading = 315
        }
    },
    [4] = {
        ["label"] = "Hands Free Carwash",
        ["poly"] = {
            coords = vector3(1362.69, 3591.81, 34.5),
            length = 6.4,
            width = 8,
            heading = 21
        }
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["poly"] = {
            coords = vector3(-699.84, -932.68, 18.59),
            length = 11.8,
            width = 5.2,
            heading = 0
        }
    }
}

--- Evevators

Config.ElevatorWaitTime = 3					-- How many seconds until the player arrives at their floor

Config.Elevators = {

	PillboxElevatorNorth = {
		{
			coords = vector3(332.37, -595.56, 43.28), heading = 70.65, level = "Upper Pillbox", label = "Pillbox - Main Floor",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
			--[[ items = {
				"casino_pass_gold",
			}, ]]
		},
		{
			coords = vector3(344.31, -586.12, 28.79), heading = 252.84, level = "Lower Pillbox", label = "Pillbox - Lower Pillbox",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
		{
			coords = vector3(340.05, -584.98, 28.79), heading = 88.21, level = "Parking", label = "Pillbox - Parking Facilities",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
	},

	PillboxElevatorSouth = {
		{
			coords = vector3(330.45, -601.07, 43.28), heading = 67.64, level = "Upper Pillbox", label = "Pillbox - Main Floor",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
		{
			coords = vector3(345.68, -582.34, 28.79), heading = 248.30, level = "Lower Pillbox", label = "Pillbox - Lower Pillbox",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
		{
			coords = vector3(341.58, -580.88, 28.79), heading = 70.59, level = "Parking", label = "Pillbox - Parking Facilities",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
	},

	PillboxRoofTop = {
		{
			coords = vector3(338.52, -583.84, 74.16), heading = 254.13, level = "Rooftop", label = "Pillbox - HeliPad",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
		{
			coords = vector3(327.17, -603.87, 43.28), heading = 338.36, level = "Upper Pillbox", label = "Pillbox - Main Floor",
			jobs = {
				["police"] = 0,
				["ambulance"] = 0,
			},
		},
	},

    Hamim_in_city = {
		{
			coords = vector3(-288.24014282227, -722.60504150391, 125.47332000732), heading = 250.51852416992, level = "Rooftop", label = "Hamim - Rooftop",
		},
        {
			coords = vector3(-305.09515380859, -721.04510498047, 28.028614044189), heading = 160.57936096191, level = "Garage", label = "Hamim - Garage",
		},
	},
    Human_lab = {
		{
			coords = vector3(3540.8779296875, 3677.2312011719, 20.991775512695), heading = 262, level = "Elevator", label = "︾",
		},
        {
			coords = vector3(3540.8725585938, 3677.2546386719, 28.121156692505), heading = 260, level = "Elevator", label = "︽",
		},
	},
}

