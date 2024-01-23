Config = {}
Config.Locale = 'en'

Config.Rob = true
Config.RobCommand = 'rob' 	--The command your invneotry uses to rob a player
							-- ak47_inventory = 'rob', ox_inventory = 'steal', qs-inventory = 'searchplayer'

Config.Cops = {
	['police'] = true,
	['sheriff'] = true,
}

Config.Ems = {
	['ambulance'] = true,
}

Config.DamageChance = {
	cuff = 70,  -- 70%
	key = 70,	-- 70%
	blindfold = 70, --70%
}

Config.UnTieWeapons = {
	[`weapon_dagger`] = true,
	[`weapon_knife`] = true,
	[`weapon_switchblade`] = true,
}

Config.BlindFold = { --only supported with qb-clothing & ak47_qb_clothing
	skinOn = {
		male = {
			['mask'] = {item = 62, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
		},
		female = {
			['mask'] = {item = 126, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
		},
	},
	skinOff = {
		male = {
			['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
		},
		female = {
			['mask'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}, -- Mask
		},
	},
}

