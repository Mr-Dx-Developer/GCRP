Config = {}
Config.ServiceExtensionOnEscape	= 5

Config.ServiceLocation = vector3(170.0552, -989.230, 30.091)

Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(3067.26, -4658.96, 15.26) },
	{ type = "cleaning", coords = vector3(3079.7, -4671.41, 15.26) },
	{ type = "cleaning", coords = vector3(3077.02, -4687.59, 15.26) },
	{ type = "cleaning", coords = vector3(3091.44, -4684.21, 15.26) },
	{ type = "cleaning", coords = vector3(3094.92, -4691.08, 15.26) },
	{ type = "cleaning", coords = vector3(3090.65, -4665.43, 15.26) },
	{ type = "cleaning", coords = vector3(3068.34, -4648.26, 15.26) },
	{ type = "cleaning", coords = vector3(3058.75, -4642.07, 15.26) }
	--[[ { type = "gardening", coords = vector3(190.5050, -1003.26, 29.291) },
	{ type = "gardening", coords = vector3(199.2376, -1007.25, 29.291) },
	{ type = "gardening", coords = vector3(189.8262, -1004.42, 29.291) },
	{ type = "gardening", coords = vector3(186.8539, -997.449, 29.289) },
	{ type = "gardening", coords = vector3(181.3150, -997.791, 29.291) } ]]
}

Config.Outfits = { -- Set their community service outfits when they go to community service
    enabled = true, -- If false, outfits wont change
    male = {
        mask = { item = 0, texture = 0 },
        arms = { item = 31, texture = 0 },
        shirt = { item = 15, texture = 0 },
        jacket = { item = 614, texture = 0 },
        pants = { item = 124, texture = 3 },
        shoes = { item = 66, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
    female = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 15, texture = 0 },
        jacket = { item = 503, texture = 0 },
        pants = { item = 27, texture = 15 },
        shoes = { item = 134, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
}
