fx_version 'cerulean'
game 'gta5'

name "um-spawn"
author "uyuyorum {um}"
version "2.0.0"
description 'A spawn menu beyond dreams'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'utils/*.lua',
	'bridge/**'
}

ui_page 'web/build/index.html'

files {
	'locales/*.json',
	'web/build/index.html',
	'web/build/**'
}

client_scripts {
	'main/modules/**',
	'main/client/**'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'main/server/*.lua'
}



escrow_ignore {
	'config.lua',
	'locales/*.json',
	'utils/*.lua',
	'bridge/**/**',
	'main/client/functions.lua',
	'main/client/spawn.lua',
	'main/client/bookmark.lua',
	'main/server/bookmark.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'

dependency '/assetpacks'