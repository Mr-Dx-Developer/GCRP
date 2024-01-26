fx_version 'cerulean'	
game 'gta5'
version '1.2.4'
client_scripts {
	'GetFrameworkObject.lua',
	'shared/config.lua',
    'client/client.lua',
}

server_scripts {
	'GetFrameworkObject.lua',
	'shared/*.lua',
    'server/server.lua',
}
server_exports {
	'getPlayerVipMoney',
	'getPlayerActivePackage',
	'setPlayerCoin',
	'addPlayerCoin',
	'removePlayerCoin',
}


ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css/*.css',
	'html/fonts/*.TTF',
	'html/fonts/*.*',
	'html/template/*.png',
	'html/sound/*.ogg',
	'html/itemimages/*.png',
	'html/js/*.js',
	'html/js/**/*.js',
}

escrow_ignore { 'shared/*.lua', 'GetFrameworkObject.lua'}

lua54 'yes'
dependency '/assetpacks'