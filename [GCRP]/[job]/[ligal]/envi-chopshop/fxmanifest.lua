
fx_version 'cerulean'
author 'Envi-Scripts'
description 'Envi-ChopShop'
version '2.0.7'

game 'gta5'
lua54 'yes'
 
client_scripts {
    'bridge/bridge.lua',
	'client/*.lua',
}
 
server_scripts {
    'bridge/bridge.lua',
	'server/*.lua',
}

shared_scripts {
	'config.lua',
    '@ox_lib/init.lua',
}

escrow_ignore {
    'bridge/database/oxmysql/*.lua',
    'bridge/framework/esx/*.lua',
    'bridge/framework/qb/*.lua',
    'bridge/framework/qbox/*.lua',
    'bridge/framework/vrp/*.lua',
    'bridge/inventory/ox_inventory/*.lua',
    'bridge/inventory/qb-inventory/*.lua',
    'bridge/inventory/qs-inventory/*.lua',
    'bridge/shared/*.lua',
    'bridge/utils/*.lua',
    'bridge/*.lua',
    'bridge/zone/ox_lib/*.lua',
    'bridge/zone/polyzone/*.lua',
    'bridge/target/qb-target/*.lua',
    'bridge/target/ox_target/*.lua',
    'bridge/target/qtarget/*.lua',
	'config.lua',
    'install/*/*',
    'server/server_edit.lua',
    'ui/**',

}

 
files {
    'bridge/**/**/client.lua',
    'bridge/**/*.lua',
    'ui/**'
}

ui_page 'ui/index.html'
dependency '/assetpacks'