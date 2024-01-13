fx_version 'cerulean'
game 'gta5'
author 'CODEM'
version '1.6.3'

client_scripts {
    'Core.lua',
    'config.lua',
    'client/client.lua',
    'client/clothes.lua',
}

server_scripts {
    -- '@mysql-async/lib/MySQL.lua', -- uncomment this if you want to use mysql-async
	'@oxmysql/lib/MySQL.lua', -- uncomment this if you want to use oxmysql
    'Core.lua',
    'config.lua',
    'server/server.lua',
    'server/sv_function.lua'
}

ui_page {
    'ui/ui.html',
}

files {
    'ui/ui.html',
    'ui/style.css',
    'ui/script.js',
    'ui/*.js',
    'ui/fonts/*.ttf',
    'ui/fonts/*.otf',
    'ui/images/*.*',
    'ui/config.js',
    'ui/click.MP3',
}

escrow_ignore {
	'config.lua',
    'server/sv_function.lua',
    'client/clothes.lua',
    'Core.lua',
}

lua54 'yes'
dependency '/assetpacks'