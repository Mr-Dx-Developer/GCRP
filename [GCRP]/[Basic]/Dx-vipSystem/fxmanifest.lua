fx_version 'cerulean'
game 'gta5'

shared_script {
	"config.lua",
}

client_scripts {
	-- 'config.lua',
	'client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	-- '@mysql-async/lib/MySQL.lua',
	'server_config.lua',
	-- 'config.lua',
	'server/main.lua',
	'server/admin_commands.lua',
	'server/editable_server.lua',
}

ui_page {
	'html/ui.html'
}

escrow_ignore {
	'client/main.lua',
	'server/main.lua',
	'config.lua',
	'server_config.lua',
	'server/admin_commands.lua',
	'server/editable_server.lua',
}  


files {
	'html/ui.html',
	'html/font/*.ttf',
	'html/font/*.otf',
	'html/css/*.css',
	'html/images/*.jpg',
	'html/images/*.png',
	'html/js/*.js',
}


lua54 'on'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'