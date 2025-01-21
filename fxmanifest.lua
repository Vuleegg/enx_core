fx_version 'cerulean'
game 'gta5'
description 'ENX CORE'
version '0.0.1'

shared_scripts {
  '@ox_lib/init.lua',
  'config/main.lua',
  'config/permissions.lua',
  'shared/locale.lua',
}  

client_scripts {
  'client/main.lua',
  'client/player_groups.lua',
  'client/functions.lua',
  'client/events.lua',
  'client/defaults.lua',
  'client/utils/callbacks.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'modules/init.lua',
  'server/identifiers.lua',
  'server/player_groups.lua',
  'server/functions.lua',
  'server/events.lua',
  'server/paycheck.lua',
  'server/utils/callbacks.lua',
  'server/utils/logs.lua',
}

files {
  'shared/gangs.lua',
  'shared/items.lua',
  'shared/jobs.lua',
  'shared/main.lua',
  'shared/weapons.lua',
  'locales/*.json'
}

dependencies {
  '/server:10731',
  '/onesync',
  'ox_lib',
  'oxmysql',
}

provide 'es_extended'
lua54 'yes'
use_experimental_fxv2_oal 'yes'