return {
    ['spawnLocation'] = vec4(0, 0, 0, 0),
    ['useDefaultRegister'] = true,
    ['forceJobDuty'] = true,
    ['enableAdminDuty'] = true,
    ['enableGamerTag'] = true,
    ['DefaultLocale'] = 'en',

    AdminGroups = {
        ['user'] = { name = 'user', label = 'User', hiddenDuty = false },
        ['admin'] = { name = 'admin', label = 'Administrator', hiddenDuty = false },
        ['owner'] = { name = 'owner', label = 'Server Owner', hiddenDuty = true },
        ['superadmin'] = { name = 'superadmin', label = 'Super Administrator', hiddenDuty = false },
        ['headadmin'] = { name = 'headadmin', label = 'Head Administrator', hiddenDuty = false },
        ['developer'] = { name = 'developer', label = 'Server Developer', hiddenDuty = true },
    },

    ['extensions'] = {
        ['removeHudComponents'] = {
            [1] = true,  -- WANTED_STARS
            [2] = true,  -- WEAPON_ICON
            [3] = true,  -- CASH
            [4] = true,  -- MP_CASH
            [5] = true,  -- MP_MESSAGE
            [6] = true,  -- VEHICLE_NAME
            [7] = true,  -- AREA_NAME
            [8] = true,  -- VEHICLE_CLASS
            [9] = true,  -- STREET_NAME
            [10] = false, -- HELP_TEXT
            [11] = false, -- FLOATING_HELP_TEXT_1
            [12] = false, -- FLOATING_HELP_TEXT_2
            [13] = true,   -- CASH_CHANGE
            [14] = false,  -- RETICLE
            [15] = false,  -- SUBTITLE_TEXT
            [16] = false,  -- RADIO_STATIONS
            [17] = false,  -- SAVING_GAME
            [18] = false,  -- GAME_STREAM
            [19] = true,   -- WEAPON_WHEEL
            [20] = false,  -- WEAPON_WHEEL_STATS
            [21] = true,   -- HUD_COMPONENTS
            [22] = true,   -- HUD_WEAPONS
        },

        ['enablePaycheck'] = true,
        ['discordLogs'] = false,
        ['enableSocietyPayouts'] = true,
        ['paycheckInterval'] = 60,
        ['enableDebug'] = false,
        ['enablePVP'] = true,
        ['enableWantedLevel'] = false,
        ['multichar'] = false,
        ['disableHealthRegeneration'] = true,
        ['disableVehicleRewards'] = false,
        ['disableNPCDrops'] = false,
        ['disableDispatchServices'] = false,
        ['disableScenarios'] = false,
        ['disableWeaponWheel'] = false,
        ['disableAimAssist'] = false,
        ['disableVehicleSeatShuff'] = false,
        ['disableDisplayAmmo'] = false,
        ['spawnVehMaxUpgrades'] = false,
    }
}
