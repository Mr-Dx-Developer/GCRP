fx_version 'adamant'
game 'gta5'
author "MenanAk47 (MenanAk47#3129)"
description 'MenanAk47 - Optimized NPC Drugdealer'
version '2.7'
lua54 'yes'

shared_scripts {
    'config.lua'
}

server_scripts {
    'server/utils.lua',
    'server/main.lua',
    'locales/en.lua',
}

client_scripts {
    'client/utils.lua',
    'client/main.lua',
    'locales/en.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config*.lua',
    'server/utils.lua',
    'client/utils.lua',
    'INSTALL ME FIRST/**/*',
}

lua54 'yes'

dependencies {
    '/server:5181', -- requires at least server build 5181
}

dependency '/assetpacks'