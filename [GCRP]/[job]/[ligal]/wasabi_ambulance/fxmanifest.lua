-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Advanced Ambulance Job'
author 'wasabirobby'
version '1.9.8'

ui_page '/nui/index.html'
files { '/nui/index.html', '/nui/**/*' }

client_scripts { 'game/client/*.lua' }
server_scripts { '@mysql-async/lib/MySQL.lua', 'game/configuration/logs.lua', 'game/server/*.lua' }
shared_scripts { '@ox_lib/init.lua', 'game/configuration/strings.lua', 'game/data.lua', '@wasabi_bridge/import.lua', 'game/configuration/config.lua' }

dependencies { 'ox_lib', 'wasabi_bridge' }

provides { 'esx_ambulancejob', 'qb-ambulancejob' }

escrow_ignore {
  'game/configuration/**/*.lua',
  'game/data.lua',
  'game/client/client.lua',
  'game/client/cl_customize.lua',
  'game/client/radial.lua',
  'game/server/sv_customize.lua'
}

dependency '/assetpacks'