return {
    spawnLocation = vec4(0, 0, 0, 0),-- # works only if you're using our Default Register
    useDefaultRegister = true, 
    forceJobDuty = true, -- # from jobs data if you're logged on duty you will be on login again on duty beside that job dont have automatically dutyonDefault
    enableAdminDuty = true, -- # admin groups that dont have hiddenDuty enabled can join duty with this command and when this command is enabled  they can use commands only with duty enabled
   
    enableRichPresence = true, 
    RichPresence = {
        app_id = "984589564645852",
        server_name = "ENX Roleplay", 
        maxPlayers = 48,
        server_logo = "logo",
    }

    AdminGroups = {
        ['admin'] = { name = 'admin', label = 'Administrator', hiddenDuty = false },
        ['owner'] = { name = 'owner', label = 'Server Owner', hiddenDuty = true },
        ['superadmin'] = { name = 'superadmin', label = 'Super Administrator', hiddenDuty = false },
        ['headadmin'] = { name = 'headadmin', label = 'Head Administrator', hiddenDuty = false },
        ['developer'] = { name = 'developer', label = 'Server Developer', hiddenDuty = true },
    },

    RemoveHudComponents = {
        [1] = true,  --WANTED_STARS,
        [2] = true,  --WEAPON_ICON
        [3] = true,  --CASH
        [4] = true,  --MP_CASH
        [5] = true,  --MP_MESSAGE
        [6] = true,  --VEHICLE_NAME
        [7] = true,  -- AREA_NAME
        [8] = true,  -- VEHICLE_CLASS
        [9] = true,  --STREET_NAME
        [10] = false, --HELP_TEXT
        [11] = false, --FLOATING_HELP_TEXT_1
        [12] = false, --FLOATING_HELP_TEXT_2
        [13] = true,   --CASH_CHANGE
        [14] = false,  --RETICLE
        [15] = false,  --SUBTITLE_TEXT
        [16] = false,  --RADIO_STATIONS
        [17] = false,  --SAVING_GAME,
        [18] = false,  --GAME_STREAM
        [19] = true,   --WEAPON_WHEEL
        [20] = false,  --WEAPON_WHEEL_STATS
        [21] = true,   --HUD_COMPONENTS
        [22] = true, --HUD_WEAPONS
    },

    EnablePaycheck = true, -- enable paycheck
    DiscordLogs = false, -- Logs to a nominated Discord channel via webhook (default is false)
    EnableSocietyPayouts = true,   -- pay from the society account that the player is employed at? Requirement: none
    PaycheckInterval = 60 -- how often to recieve pay checks in minutes
    EnableDebug  = false -- Use Debug options?
    EnablePVP = true -- Allow Player to player combat
    EnableWantedLevel = false     -- Use Normal GTA wanted Level?
    Multichar = false, 

    DisableHealthRegeneration = true -- Player will no longer regenerate health
    DisableVehicleRewards = false -- Disables Player Recieving weapons from vehicles
    DisableNPCDrops = false -- stops NPCs from dropping weapons on death
    DisableDispatchServices = false -- Disable Dispatch services
    DisableScenarios = false -- Disable Scenarios
    DisableWeaponWheel = false -- Disables default weapon wheel
    DisableAimAssist = false -- disables AIM assist (mainly on controllers)
    DisableVehicleSeatShuff = false -- Disables vehicle seat shuff
    DisableDisplayAmmo = false -- Disable ammunition display
    SpawnVehMaxUpgrades = false       -- admin vehicles spawn with max vehcle settings
}