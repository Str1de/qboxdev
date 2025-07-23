-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/s_config.lua',
	'server/functions.lua',
	'server/core.lua',
	'server/commands.lua',
	'server/handlers.lua',
	'server/editable.lua',
	'server/discord.lua',
}

-- Client files
client_scripts {
	'client/main.lua',
}


ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/css/*.css",
	"html/script.js",
	"html/images/*.png",
}

escrow_ignore {
    'server/s_config.lua',
	'server/editable.lua',
}

lua54 'yes'


dependency '/assetpacks'