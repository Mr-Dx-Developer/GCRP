Config.Locations = Config.Locations or {}





Config.Locations[#Config.Locations+1] = { -- [[LS CUSTOMS ROUTE 68]] --
	Enabled = true,
	job = "mechanic",
	zones = {
		ec2(-365.6389465332, -154.74496459961),
			vec2(-352.03677368164, -180.19702148438),
			vec2(-309.43313598633, -167.66041564941),
			vec2(-304.82751464844, -160.89756774902),
			vec2(-297.51321411133, -120.27662658691),
			vec2(-289.28378295898, -96.42741394043),
			vec2(-346.78524780273, -78.421455383301),
			vec2(-374.47827148438, -68.597633361816),
			vec2(-385.23809814453, -99.778938293457),
			vec2(-357.98147583008, -110.18009185791),
			vec2(-367.24722290039, -137.92770385742)
	},
	autoClock = { enter = false, exit = false, },
	stash = {
		{ coords = vec4(-350.44, -132.11, 42.04, 162.55), w = 1.6, d = 0.6 },
	},
	store = {
		{ coords = vec4(-362.49597167969, -98.407241821289, 39.546619415283, 249.4010925293), w = 0.6, d = 0.5 },
	},
	crafting = {
		{ coords = vec4(-328.42184448242, -165.7989654541, 39.009510040283, 195.7785949707), w = 3.2, d = 1.0 },
	},
	clockin = {
		{ coords = vec4(-348.23, -130.22, 42.04, 341.41), prop = true, },
	},
	manualRepair = {
		{ coords = vec4(-341.30642700195, -164.86755371094, 39.009391784668, 340.96734619141), prop = true, },
	},
	carLift = {
		{ coords = vec4(1174.78, 2644.54, 37.75, 180.0), },
		{ coords = vec4(1182.22, 2644.75, 37.75, 180.0) },
	},
	garage = {
		spawn = vec4(-359.2473449707, -122.99184417725, 38.699180603027, 153.87454223633),
		out = vec4(-353.57632446289, -125.99276733398, 39.434448242188, 74.700416564941),
		list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
		prop = true,
	},
	payments = {
		img = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
		{ coords = vec4(-345.16, -128.24, 38.93, 65.46), prop = true, },
	},
	Restrictions = {
		Vehicle = { "Compacts", "Sedans", "SUVs", "Coupes", "Muscle", "Sports Classics", "Sports", "Super", "Motorcycles", "Off-road", "Industrial", "Utility", "Vans", "Cycles", "Service", "Emergency", "Commercial", },
		Allow = { "tools", "cosmetics", "repairs", "nos", "perform" },
	},
	blip = {
		coords = vec3(-336.84, -136.39, 39.01),
		label = "Los Santos Customs",
		color = 81,
		sprite = 446,
		disp = 6,
		scale = 0.7,
		cat = nil,
	},
	discord = {
		link = "",
		color = 2571775,
	}
}