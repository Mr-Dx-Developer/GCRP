

fx_version 'adamant'

version '2.0.1'
description 'devix-mmenu'
author 'zhonnz'

game 'gta5'


client_scripts {
    'server/sv_converter.lua',
    'client/functions.lua',
}

server_scripts {
    'sql.lua',
    'server/sv_converter.lua',
    'server/main.lua',
}

shared_scripts {
    'rules.lua',
    'locales.lua',
    'config.lua',
}


ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/*.ttf',
    'nui/*.png',
    'nui/*.jpg',
    'nui/*.css',
    'stream/*.ytd',
    'nui/*.js',
    'nui/*.min.js',
    'nui/*.mp3',
    'nui/img/itemimage/*.png',
    'nui/img/itemimage/*.jpg',
    'nui/img/*.png',
    'nui/img/*.jpg',
    'nui/img/*.avi',
    'nui/img/*.mp4',
    'nui/img/item/*.png',
    'nui/img/item/*.jpg',
    'nui/img/item/*.avi',
    'nui/img/item/*.mp4',
    'nui/font/*.ttf',
    'nui/font/*.otf',
    'nui/sounds/*.ogg',
    'nui/sounds/*.mp3',

    -- case
    'nui/img/case/*.png',
    'nui/img/case/*.jpg',
    'nui/img/case/items/*.png',
    'nui/img/case/items/*.jpg',
}


escrow_ignore {
    'rules.lua',
    'config.lua',
    'locales.lua',
    'sql.lua',
}

lua54 'yes'