-- Resource Metadata
-- Define the FX Server version and game type
fx_version "cerulean"
game "gta5"

-- Define the resource metadata
name "mr_dx_debadged_carpack"
description "Join to discord.gg/RgbBztr5XJ"
author "Mr_Dx"
version "1.3.1"


server_script "version_check.lua"

files {
    'data/**/*.meta',
    'data/**/*.xml',
    'data/**/*.dat',
    'data/**/*.ytyp'
}


data_file 'HANDLING_FILE'                   'data/**/handling*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'            'data/**/vehiclelayouts*.meta'
data_file 'VEHICLE_METADATA_FILE'           'data/**/vehicles*.meta'
data_file 'CARCOLS_FILE'                    'data/**/carcols*.meta'
data_file 'VEHICLE_VARIATION_FILE'          'data/**/carvariations*.meta'
data_file 'CONTENT_UNLOCKING_META_FILE'     'data/**/*unlocks.meta'
data_file 'PTFXASSETINFO_FILE'              'data/**/ptfxassetinfo.meta'

-- client_scripts {
--     'vehicle_names.lua',
-- }

-- server_script 'server.lua'