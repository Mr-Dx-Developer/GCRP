fx_version 'adamant'
game 'gta5'

lua54 'yes'

client_script 'client.lu*'
server_script 'server.lu*'

shared_scripts {
	'@ox_lib/init.lua',
}

files {
	'*.html',
	'bootstrap/css/*.css',
	'css/*.css',
	'js/jquery-2.2.4.min.js',
	'bootstrap/js/bootstrap.min.js',
	'js/jquery.plugin.min.js',
	'js/jquery.mb.YTPlayer.min.js',
	'js/*.js',
	'fonts/*.*',
}

loadscreen 'index.html'
loadscreen_manual_shutdown 'yes'