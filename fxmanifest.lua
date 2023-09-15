fx_version 'adamant'
game 'gta5'
description 'BBV STORE ROBBERY'
version '1.0.0'


client_scripts {
	'client/main.lua',
	'wrapper/cl_wrapper.lua',
	'wrapper/cl_wp_callback.lua',
}

server_scripts {
	'wrapper/sv_wrapper.lua',
	'wrapper/sv_wp_callback.lua',
	'server/main.lua',
}

shared_scripts {
	'config.lua',
}

escrow_ignore {
    'config.lua', 
}

lua54 'yes'