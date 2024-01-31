fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_scripts {
    'config/*.lua',
    'locales/*.lua'
}

client_script {
    'client/*.lua',
    'client/custom/*.lua'
}

server_script {
    'server/*.lua'
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'client/custom/*.lua'
}

dependencies {
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
    'progressbar'   -- Required.
}

dependency '/assetpacks'