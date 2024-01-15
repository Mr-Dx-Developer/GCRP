fx_version 'cerulean'
game 'gta5'

author '⚔SawitDeDon™#0275'
description 'McDonalds System Rewrite To QB by ⚔SawitDeDon™#0275 '
version '1.0.0'

this_is_a_map 'yes'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/*.html',
    'html/css/*.css',
    'html/js/*.js',
}

data_file 'DLC_ITYP_REQUEST' 'stream/ch_dlc_int_02_ch.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/mcd2'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_backarea.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_main.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ch_prop_ch_casino_vault.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/h4_dlc_int_05_h4.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/h4_prop_h4_island_02.ytyp'
