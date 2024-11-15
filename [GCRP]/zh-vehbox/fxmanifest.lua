fx_version 'cerulean'
game 'gta5'


shared_scripts {
	'config.lua',
	'shared.lua',
	'@ox_lib/init.lua',
	-- '@qb-garages/config.lua' -- Uncoment if use qb-garages
	-- '@esx_garages/config.lua' -- Uncoment if use esx_garages
	-- '@cd_garage/configs/config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'@oxmysql/lib/MySQL.lua'
}

lua54 'yes'
