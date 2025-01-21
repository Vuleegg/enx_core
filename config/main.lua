---@param config table Configuration for the server settings.
---@field spawnLocation vec4 The default spawn location for players (x, y, z, heading).
---@field useDefaultRegister boolean Whether to enable the default player registration system.
---@field forceJobDuty boolean Whether to automatically put players on duty when they join their job.
---@field enableAdminDuty boolean Whether to enable admin duty functionality.
---@field enableGamerTag boolean Whether to display gamer tags above players' heads.
---@field DefaultLocale string The default language/locale for the server.

---@field AdminGroups table Configuration for admin groups and their permissions.
---@field AdminGroups[].name string The name of the admin group (e.g., "admin", "superadmin").
---@field AdminGroups[].label string The display label of the admin group (e.g., "Administrator").
---@field AdminGroups[].hiddenDuty boolean Whether the admin group's duty status is hidden.

---@field extensions table Extensions and optional features for the server.
---@field extensions.removeHudComponents table HUD components to remove (indexed by ID).
---@field extensions.removeHudComponents[].number boolean Whether a specific HUD component is removed (e.g., true or false).
---@field extensions.enablePaycheck boolean Whether to enable the paycheck system.
---@field extensions.discordLogs boolean Whether to enable Discord logging.
---@field extensions.enableSocietyPayouts boolean Whether society payouts are enabled.
---@field extensions.paycheckInterval number Interval in seconds for paycheck payouts.
---@field extensions.enableDebug boolean Whether debug mode is enabled.
---@field extensions.enablePVP boolean Whether player-versus-player combat is enabled.
---@field extensions.enableWantedLevel boolean Whether the wanted level system is enabled.
---@field extensions.multichar boolean Whether to enable the multi-character system.
---@field extensions.disableHealthRegeneration boolean Whether health regeneration is disabled.
---@field extensions.disableVehicleRewards boolean Whether to disable default vehicle rewards.
---@field extensions.disableNPCDrops boolean Whether to disable NPC loot drops.
---@field extensions.disableDispatchServices boolean Whether to disable police dispatch services.
---@field extensions.disableScenarios boolean Whether to disable random scenarios.
---@field extensions.disableWeaponWheel boolean Whether to disable the weapon wheel.
---@field extensions.disableAimAssist boolean Whether to disable aim assist.
---@field extensions.disableVehicleSeatShuff boolean Whether to disable vehicle seat shuffling.
---@field extensions.disableDisplayAmmo boolean Whether to disable the ammo display on the HUD.
---@field extensions.spawnVehMaxUpgrades boolean Whether vehicles spawn with maximum upgrades.

return {
    spawnLocation = vec4(0, 0, 0, 0),
    useDefaultRegister = true,
    forceJobDuty = true,
    enableAdminDuty = true,
    enableGamerTag = true,
    DefaultLocale = 'en',

    AdminGroups = {
        user = { name = 'user', label = 'User', hiddenDuty = false },
        admin = { name = 'admin', label = 'Administrator', hiddenDuty = false },
        owner = { name = 'owner', label = 'Server Owner', hiddenDuty = true },
        superadmin = { name = 'superadmin', label = 'Super Administrator', hiddenDuty = false },
        headadmin = { name = 'headadmin', label = 'Head Administrator', hiddenDuty = false },
        developer = { name = 'developer', label = 'Server Developer', hiddenDuty = true },
    },

    extensions = {
        removeHudComponents = {
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

        enablePaycheck = true,
        discordLogs = false,
        enableSocietyPayouts = true,
        paycheckInterval = 60,
        enableDebug = false,
        enablePVP = true,
        enableWantedLevel = false,
        multichar = false,
        disableHealthRegeneration = true,
        disableVehicleRewards = false,
        disableNPCDrops = false,
        disableDispatchServices = false,
        disableScenarios = false,
        disableWeaponWheel = false,
        disableAimAssist = false,
        disableVehicleSeatShuff = false,
        disableDisplayAmmo = false,
        spawnVehMaxUpgrades = false,
    }
}