fx_version 'cerulean'
game 'gta5'
version '1.1'
lua54 'yes'

file 'gen_w_am_metaldetector.ytyp'

ui_page 'html/main.html'

files {
    "html/*"
}

client_scripts {
    '@menuv/menuv.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

    'config.lua',
    'client/utils.lua',
    'client/main.lua',
    'client/sell.lua',

    "locales/locale.lua",
    "locales/en.lua",
}

server_scripts {
    'config.lua',
    'server/utils.lua',
    'server/main.lua',
    'server/sell.lua',

    "locales/locale.lua",
    "locales/en.lua",
} 

dependencies {
    '/onesync',
    'qb-core',
    'menuv',
}

escrow_ignore {
    "INSTALL ME FIRST/**/*",
    "config.lua",
    "locales/*.lua",
    "server/utils.lua",
    "server/sell.lua",
    "client/utils.lua",
    "client/sell.lua",
}



dependency '/assetpacks'