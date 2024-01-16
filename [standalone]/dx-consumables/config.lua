-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {
	Debug = false,
	Core = "qb-core",

	Inv = "qb", -- set to "ox" if using ox_inventory
	Notify = "qb",  -- set to "ox" if using ox_lib

	UseProgbar = true,
	ProgressBar = "qb", -- set to "ox" if using ox_lib

	Consumables = {
		-- Default QB food and drink item override

		--Effects can be applied here, like stamina on coffee for example
		-- ["vodka"] = { 			emote = "vodkab", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
		["beer"] = { 			emote = "beer", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
		["whiskey"] = { 		emote = "whiskey",  	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},

		["sandwich"] = { 		emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["twerks_candy"] = { 	emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
		["snikkel_candy"] = { 	emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
		["tosti"] = { 			emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(4,6), }},

		["coffee"] = { 			emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
		["water_bottle"] = { 	emote = "drink", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,15), }},
		["kurkakola"] = { 		emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(25,30), }},

	--[[ 	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Items that effect status changes, like bleeding can cause problems as they are all handled in their own scripts
		-- Testing these but they may be best left handled by default scripts
		["ifaks"] = { 			emote = "oxy", 		time = math.random(5000, 6000), stress = math.random(25, 40), heal = 10, armor = 0, type = "drug", stats = { effect = "heal", amount = 6, widepupils = false, canOD = false } },
		["bandage"] = { 		emote = "oxy", 		time = math.random(5000, 6000), stress = 0, heal = 25, armor = 0, type = "drug", stats = { effect = "heal", amount = 3, widepupils = false, canOD = false } },
		
 ]]
		--[[  --Testing effects & armor with small functionality to drugs - This may be another one left to default scripts
		["joint"] = { 			emote = "smoke3",	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 10, type = "drug", stats = { screen = "weed", effect = "armor", widepupils = false, canOD = false } },

		["cokebaggy"] = { 		emote = "coke",		time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drug", stats = { screen = "focus", effect = "stamina", widepupils = false, canOD = true } },
		--["crackbaggy"] = { 		emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { effect = "heal", widepupils = false, canOD = true } },
		["xtcbaggy"] = { 		emote = "oxy",		time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 10, type = "drug", stats = { effect = "strength", widepupils = true, canOD = true } },
		["oxy"] = { 			emote = "oxy",		time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drug", stats = { effect = "heal", widepupils = false, canOD = false } },
		["meth"] = { 			emote = "coke",		time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 10, type = "drug", stats = { effect = "stamina", widepupils = false, canOD = true } }, ]]
		----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--[[Example item
		["heartstopper"] = {
			emote = "burger", 							-- Select an emote from below, it has to be in here
			time = math.random(5000, 6000),				-- Amount of time it takes to consume the item
			stress = math.random(1,2),					-- Amount of stress relief, can be 0
			heal = 0, 									-- Set amount to heal by after consuming
			armor = 5,									-- Amount of armor to add
			type = "food",								-- Type: "alcohol" / "drink" / "food"

			stats = {
				screen = "thermal",						-- The screen effect to be played when after consuming the item "rampage" "turbo" "focus" "weed" "trevor" "nightvision" "thermal"
				effect = "heal", 						-- The status effect given by the item, "heal" / "stamina"
														-- This supports ps-buffs effects "armor" "stress" "swimming" "hacking" "intelligence" "luck" "strength"
				time = 10000,							-- How long the effect should last (if not added it will default to 10000)
				amount = 6,								-- How much the value is changed by per second
				hunger = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
				thirst = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
			},
			--Reward Items Variables
														-- These can be the only thing in a consumable table and the item will still work
			amounttogive = 3,							-- Used for "RewardItems", tells the script how many to give
			rewards = {
				[1] = {
					item = "plastic", 					-- prize item name
					max = 10,							-- max amount to give (this is put into math.random(1, max) )
					rarity = 1,							-- the rarity system, 1 being rarest, 4 being most common
				},
			},
		},]]
		["margherita"] = { 		emote = "pizzaslice", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,18), }},
		["vegetariana"] = { emote = "pizzas", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(45,55), }},
		["capricciosa"] = { emote = "pizzas2", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(60, 65), }},
		["marinara"] = { emote = "pizzas3", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,35), }},
		["prosciuttio"] = { emote = "pizzas4", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(45,55), }},
		["diavola"] = { emote = "pizzas5", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},



		--Jim-BurgerShot-Drinks
		["bscoffee"] = { emote = "bscoffee", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(35,40), }},
		--Jim-BurgerShot-Food
		["heartstopper"] = { emote = "burger", canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(70,80), }},
		["torpedo"] = {	emote = "torpedo", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(50,60), }},
		["shotfries"] = { emote = "bsfries", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["meatfree"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,35), }},
		["shotnuggets"] = {	emote = "bsfries", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["shotrings"] = { emote = "bsfries", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["moneyshot"] = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(45,55), }},
		["bleeder"] = {	emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(40,50), }},
		["rimjob"] = { emote = "donut", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(15,25), }},
		["creampie"] = { emote = "donut", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(35,45), }},
		["cheesewrap"] = { emote = "sandwich", canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(15,20), }},
		["chickenwrap"] = {	emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(15,25), }},


		-- Atoms Food (UtshoBoy)

		["friedbeef"] = {	emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(0,5), }},
		["saltedveg"] = {	emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(0,5), }},
		["friedrice"] = {	emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(0,5), }},
		["bbqchicken"] = {	emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(0,5), }},

		["shawarmaehabibi"] = {	emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(45,50), }},
		["vegshawarma"] = {	emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,30), }},
		["arabianshawarma"] = {	emote = "burger", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(55,60), }},

		["alkebsa"] = {	emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(70,75), }},
		["alpilaf"] = {	emote = "foodbowl", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(75,85), }},

		-- Atoms Drink (UtshoBoy)
		["mohito"]      = {	emote = "glass", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(65,75), }},
		["blueocean"]    = { emote = "glass", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(45,55), }},
		["orangehawaii"] = { emote = "glass", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(55,65), }},

		-- Bean Machine  (UtshoBoy)
		["cookies"]       = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},
		["darkchocolate"] = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(3,5), }},
		["donuts"]        = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["pestry"]        = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
		["sandwichbm"]    = { emote = "sandwich", canRun = false, time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(15,20), }},

		["americano"]        = { emote = "coffee", canRun = false, time = math.random(5000, 6000),stress = 25, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(50,60), }},
		["cappuccino"]       = { emote = "coffee", canRun = false, time = math.random(5000, 6000),stress = 20, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,40), }},
		["espresso"]         = { emote = "coffee", canRun = false, time = math.random(5000, 6000),stress = 30, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(60,70), }},
		["blackfantasy"]     = { emote = "coffee", canRun = false, time = math.random(5000, 6000), stress = 15, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,30), }},
		-- ["chocolatefrappe"]  = { emote = "glass", canRun = false, time = math.random(5000, 6000),stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(20,25), }},
		-- ["milkfrape"]        = { emote = "glass", canRun = false, time = math.random(5000, 6000),stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,7), }},

		["casino_beer"] = { 		emote = "beer", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["casino_coke"] = { 		emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["casino_sprite"] = { 		emote = "bscoke", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["casino_luckypotion"] = { 		emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
		["casino_coffee"] = { 		emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},


	
		--Bahamas
		--Raw Food
		-- ["chocolate"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(2,5), }},
		-- ["orange"] = { 		        emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(2,5), }},
		-- ["peach"] = { 		        emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(2,5), }},
		-- ["strawberry"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(2,5), }},

		--Raw Drink
		["cranberry"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},
		["gin"] = { 		        emote = "ginb", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["rum"] = { 		        emote = "rumb", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["amaretto"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["vodka"] = { 		        emote = "ginb", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["midori"] = { 		        emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["pinejuice"] = { 		    emote = "beer3", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},
		["prosecco"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["tequila"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["triplsec"] = { 		    emote = "beer4", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(3, 7), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,8), }},
		["sprunk"] = { 		        emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},
		["sprunklight"] = { 	    emote = "ecola", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},
		["ecola"] = { 		        emote = "sprunk", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},
		["ecolalight"] = { 		    emote = "sprunk", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(5,8), }},

		--Make Drink
		["amarettosour"] = { 		emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(9, 17), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,15), }},
		["bellini"] = { 		    emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(8, 15), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,15), }},
		["cosmopolitan"] = { 		emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(15, 20), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(5,10), }},
		["longisland"] = { 		    emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(25, 30), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(20,30), }},
		["margarita"] = { 		    emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(10, 18), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(13,26), }},
		["pinacolada"] = { 		    emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(10, 18), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(8,15), }},
		["sangria"] = { 		    emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(10, 18), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(14,17), }},
		["screwdriver"] = { 		emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(15, 18), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,17), }},
		["strawdaquiri"] = { 		emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(8, 18), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,15), }},
		["strawmargarita"] = { 		emote = "whiskey", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 15), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,12), }},

		--Food(Bahama)
		["tots"] = { 		        emote = "crisps", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(2,5), }},
		["crisps"] = { 		        emote = "crisps", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,5), }},
		["nachos"] = { 		        emote = "crisps", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(0, 0), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,5), }},

		--!  Koi (Utsho)
		["californiarol"] = {    	emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(25,28), }},
		["philadelphiaroll"] = {  	emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(25,26), }},
		["rainbowsushi"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(70,75),}},
		["spicytuna"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = {  hunger = math.random(25,28),}},
		["vegetableroll"] = {      	emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = {  hunger = math.random(25,27),}},
		["smokedsalmon"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(50,55), }},
		["tempurashrimp"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(20,30), }},


		--!  pearls (Utsho)
		["coconutcurrymussels"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(15,20), }},
		["crispycalamari"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(10,15), }},
		["grilledsalmonsupreme"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(25,30), }},
		["lobstertempura"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(25,30), }},
		["oceandelightplatter"] = {  	    emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(75,80), }},
		["redsnappergrill"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(50,60), }},
		["shrimpparadise"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(15,20), }},
		["tunaloittafusion"] = {  	        emote = "burger",       canRun = false,     time = math.random(5000, 6000),     stress = 0,    heal = 0,    armor = 0,    type = "food",    stats = { hunger = math.random(25,35), }},

	},
	Emotes = {
		["drink"] = {"mp_player_intdrink", "loop_bottle", "Drink", AnimationOptions =
			{ Prop = "prop_ld_flow_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
			{ Prop = 'p_amb_coffeecup_01', PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["burger"] = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger",	AnimationOptions =
			{ Prop = 'prop_cs_burger_01', PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0},
				EmoteMoving = true }},
		["beer"] = {"amb@world_human_drinking@beer@male@idle_a", "idle_c", "Beer", AnimationOptions =
			{ Prop = 'prop_amb_beer_bottle', PropBone = 28422, PropPlacement = {0.0,0.0,0.06,0.0,15.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger","Ego Bar", AnimationOptions =
			{ Prop = 'prop_choc_ego', PropBone = 60309, PropPlacement ={0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteMoving = true }},
		["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
			{ Prop = 'prop_sandwich_01', PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0},
				EmoteMoving = true }},
		["smoke3"] = { "amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
			{ Prop = 'prop_cs_ciggy_01', PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true }},
		["whiskey"] = { "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
			{ Prop = 'prop_drink_whisky', PropBone = 28422, PropPlacement = {0.01,-0.01,-0.06,0.0,0.0,0.0},
				EmoteLoop = true, EmoteMoving = true } },
		["vodkab"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle", AnimationOptions =
			{ Prop = 'prop_vodka_bottle', PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true }},
		["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
			{ Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
			{ Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
				EmoteLoop = true, EmoteMoving = true, }},
		["pizzas2"] = { "mp_player_inteat@burger","mp_player_int_eat_burger","Pizza Slice - Tomato And Pesto",AnimationOptions =
			{ Prop = 'knjgh_pizzaslice2', PropBone = 60309,PropPlacement = {0.0500,-0.0200,-0.0200,73.6928,-66.7427,68.3677},
			    EmoteLoop = true, EmoteMoving = true}},
		--Drugs
		["coke"] = { "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", "Coke", AnimationOptions =
			{ EmoteLoop = true, EmoteMoving = true, }},
		["oxy"] = { "mp_suicide", "pill", "Oxy", AnimationOptions =
			{ EmoteLoop = true, EmoteMoving = true, }},
				["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
			{ Prop = 'prop_cigar_02', PropBone = 47419, PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
			{ Prop = 'prop_cigar_01', PropBone = 47419, PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
			{ Prop = 'p_cs_joint_02', PropBone = 47419, PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
				EmoteMoving = true, EmoteDuration = 2600 }},
		["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
			{ Prop = 'prop_amb_ciggy_01', PropBone = 47419, PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
			EmoteMoving = true, EmoteDuration = 2600 }},
			["bscoke"] = {"mp_player_intdrink", "loop_bottle", "BS Coke", AnimationOptions =
			{    Prop = "prop_food_bs_juice01", PropBone = 18905, PropPlacement = {0.04, -0.10, 0.10, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["bscoffee"] = {"mp_player_intdrink", "loop_bottle", "BS Coffee", AnimationOptions =
			{    Prop = "prop_food_bs_coffee", PropBone = 18905, PropPlacement = {0.08, -0.10, 0.10, 240.0, -60.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["glass"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tall Glass", AnimationOptions =
			{   Prop = 'prop_wheat_grass_glass', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
			EmoteLoop = true, EmoteMoving = true, }},

		["torpedo"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Torpedo", AnimationOptions =
			{    Prop = "prop_food_bs_burger2", PropBone = 18905, PropPlacement = {0.10, -0.07, 0.091, 15.0, 135.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["bsfries"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Fries", AnimationOptions =
			{    Prop = "prop_food_bs_chips", PropBone = 18905, PropPlacement = {0.09, -0.06, 0.05, 300.0, 150.0},
				EmoteMoving = true, EmoteLoop = true, }},
		["donut2"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut2", AnimationOptions =
			{   Prop = 'prop_donut_02', PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 100.0, 270.0},
			EmoteMoving = true, EmoteLoop = true, }},
		["foodbowl"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "bowl", AnimationOptions = { Prop = "prop_cs_bowl_01", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.050, 0.0, 0.0, 0.0}, EmoteMoving = true, EmoteLoop = true, }},

		--Bahama
	["whiskeyb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Whiskey Bottle", AnimationOptions =
	{    Prop = "prop_cs_whiskey_bottle", PropBone = 60309, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteMoving = true, EmoteLoop = true }},
	["rumb"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Rum Bottle", AnimationOptions =
	{    Prop = "prop_rum_bottle", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["icream"] = {"mp_player_intdrink", "loop_bottle", "Irish Cream Bottle", AnimationOptions =
	{    Prop = "prop_bottle_brandy", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["ginb"] =  {"mp_player_intdrink", "loop_bottle", "(Don't Use) Gin Bottle", AnimationOptions =
	{    Prop = "prop_tequila_bottle", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},
	["vodkab"] = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle", AnimationOptions =
	{   Prop = 'prop_vodka_bottle', PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
		EmoteMoving = true, EmoteLoop = true }},

   ["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
   {   Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["beer1"] = {"mp_player_intdrink", "loop_bottle", "Dusche", AnimationOptions =
   {    Prop = "prop_beerdusche", PropBone = 18905, PropPlacement = {0.04, -0.14, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer2"] = {"mp_player_intdrink", "loop_bottle", "Logger", AnimationOptions =
   {    Prop = "prop_beer_logopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer3"] = {"mp_player_intdrink", "loop_bottle", "AM Beer", AnimationOptions =
   {    Prop = "prop_beer_amopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer4"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser1", AnimationOptions =
   {    Prop = "prop_beer_pissh", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer5"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser2", AnimationOptions =
   {    Prop = "prop_amb_beer_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer6"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser3", AnimationOptions =
   {    Prop = "prop_cs_beer_bot_02", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
   {    Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["sprunk"] = {"mp_player_intdrink", "loop_bottle", "Sprunk", AnimationOptions =
   {    Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
	},
}
