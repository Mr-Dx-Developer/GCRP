fx_version 'cerulean'
game 'gta5'
author 'MenanAk47'
description 'Crime System'
version '2.3'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/assets/images/blindfold.png',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
}

server_scripts {
	'config.lua',
	'server/utils.lua',
	'server/cuff.lua',
	'server/drag.lua',
	'server/trunk.lua',
	'server/bind.lua',
	'server/blindfold.lua',

	'locales/locale.lua',
	'locales/en.lua',
}

client_scripts {
	"@ox_lib/init.lua",
	'config.lua',
	'client/utils.lua',
	'client/cuff.lua',
	'client/drag.lua',
	'client/trunk.lua',
	'client/bind.lua',
	'client/blindfold.lua',
	'client/customizable/*.lua',

	'locales/locale.lua',
	'locales/en.lua',
}

dependencies {
	'qb-core',
	'ox_lib',
	'qb-target',
	'/onesync',
}

escrow_ignore {
	'INSTALL ME FIRST/**/*',
    'locales/*.lua',
    'config.lua',
    'server/utils.lua',
    'client/utils.lua',
    'client/customizable/*.lua',
}

lua54 'yes'
dependency '/assetpacks'