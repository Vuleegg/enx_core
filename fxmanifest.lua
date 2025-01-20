fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'ENX CORE'
version '0.0.1'

shared_scripts {
  '@ox_lib/init.lua',
  'shared/locale.lua',
  'bridge/esx/shared/*.lua',
}  

client_scripts {
  'client/main.lua',
  'client/player_groups.lua',
  'client/functions.lua',
  'client/events.lua',
  'client/utils/callbacks.lua',
  'bridge/esx/client/main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'server/identifiers.lua',
  'server/player_groups.lua',
  'server/functions.lua',
  'server/events.lua',
  'server/paycheck.lua',
  'server/utils/callbacks.lua',
  'server/utils/logs.lua',
  'bridge/esx/server/main.lua',
}

files {
  'shared/gangs.lua',
  'shared/items.lua',
  'shared/jobs.lua',
  'shared/permissions.lua',
  'shared/main.lua',
  'shared/weapons.lua',
  'locales/*.json'
}

dependency 'ox_lib'