fx_version 'cerulean'
game 'gta5'

description 'ps-fuel'

version '1.0.2'

author 'github.com/Project-Sloth'

shared_scripts {
	'@ox_lib/init.lua',
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'locales/*.lua',
	'shared/config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'client/client.lua',
	'client/utils.lua'
}

server_scripts {
	'server/server.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

lua54 'yes'