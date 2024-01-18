shared_script "@GM_AntiDump/shared/clientloader.lua"

fx_version 'cerulean'
game 'gta5'
description 'QB-SmallResources'
version '1.3.1'
--[[ shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
    '@qb-core/shared/locale.lua',
} --]]

client_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
    '@qb-core/shared/locale.lua',
    
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
}

reduce_clientloader {
    --Shared
    'config.lua',
    --Sahred

    'client/aimassist.lua',
    'client/binoculars.lua',
    'client/calmai.lua',
    'client/consumables.lua',
    'client/discord.lua',
    'client/editor.lua',
    'client/handsup.lua',
    'client/hudcomponents.lua',
    'client/ignore.lua',
    'client/lift.lua',
    'client/mapname.lua',
    'client/noshuff.lua',
    'client/point.lua',
    'client/removeentities.lua',
    'client/vehicletext.lua',
    'client/weapdrop.lua',
}

server_script {
     --Shared
     'config.lua',
     --Sahred

    'server/consumables.lua',
    'server/entities.lua',
    'server/logs.lua',
    'server/main.lua',
    'server/timedjobs.lua',
} 


data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'

files {
    'events.meta',
    'popgroups.ymt',
    'relationships.dat'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
