fx_version 'bodacious'
game 'gta5'
author 'FiveM Store'
description 'Pool for QBCore Framework'

version '1.2.0'

shared_script 'config.lua'

client_scripts {
    'client/*.lua',
}

server_scripts { 
    'server/code.lua',
    'server/run.lua',
}

ui_page('client/html/sound.html')

files {
    'client/html/sound.html',
    'client/html/*.ogg',
}