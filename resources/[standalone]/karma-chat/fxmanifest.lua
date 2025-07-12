fx_version "cerulean"
game "gta5"
author "ANTUNES"
description "Karma Developments Chat System 4.0"
version "2.0.0"
lua54 "yes"

ui_page 'nui/dist/index.html'

files {
    "nui/dist/**/*",
}

client_scripts {
  "client/*.lua"
}

server_scripts {
  "server/*.lua",
  "server/sv_open.lua"
}

shared_script {
  "shared/*.lua"
}

escrow_ignore {
  "shared/*.lua",
  "server/sv_open.lua",
  "server/sv_chat.lua"
}
dependency '/assetpacks'