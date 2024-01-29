Config = {}
Config.ServiceExtensionOnEscape	= 15

Config.ServiceLocation = vector3(4939.15, -1042.59, 3.47)

Config.ServiceLocations = {
	{ type = "gardening", coords = vector3(4926.0922851563, -1039.5977783203, 3.3668193817139) },
	{ type = "gardening", coords = vector3(4906.4672851563, -1016.7362670898, 3.8421936035156) },
	{ type = "gardening", coords = vector3(4891.6254882813, -1038.9708251953, 3.2483744621277) },
	{ type = "gardening", coords = vector3(4888.5366210938, -1073.2249755859, 3.3311440944672) },
	{ type = "gardening", coords = vector3(4888.9184570313, -1095.6068115234, 4.3174977302551) },
    { type = "gardening", coords = vector3(4924.5444335938, -1092.4488525391, 3.5111722946167) },
    { type = "gardening", coords = vector3(4907.9599609375, -1061.5997314453, 3.3597891330719) },
    { type = "gardening", coords = vector3(4934.3081054688, -1032.7062988281, 3.5089104175568) },
}

Config.Outfits = { -- Set their community service outfits when they go to community service
    enabled = false, -- If false, outfits wont change
    male = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 15, texture = 0 },
        jacket = { item = 139, texture = 0 },
        pants = { item = 125, texture = 3 },
        shoes = { item = 18, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
    female = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 2, texture = 0 },
        jacket = { item = 229, texture = 0 },
        pants = { item = 3, texture = 15 },
        shoes = { item = 72, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
}
