require 'config.main'

local extensions = {}

extensions:removeHudComponents = function()
    for i = 1, #RemoveHudComponents do 
        if RemoveHudComponents[i] then
            SetHudComponentSize(i, 0.0, 0.0)
            SetHudComponentPosition(i, 900, 900)
        end
    end
end

extensions:DisableAimAssist = function()
    if DisableAimAssist then
        SetPlayerTargetingMode(3)
    end
end

extensions:DisableNPCDrops = function()
    if DisableNPCDrops then
        local weaponPickups = { `PICKUP_WEAPON_CARBINERIFLE`, `PICKUP_WEAPON_PISTOL`, `PICKUP_WEAPON_PUMPSHOTGUN` }
        for i = 1, #weaponPickups do
            ToggleUsePickupsForPlayer(cache.playerId, weaponPickups[i], false)
        end
    end
end

extensions:SeatShuffle = function()
    if DisableVehicleSeatShuff then
        lib.onCache('vehicle', function(value)
            if value then 
                if value.seat > -1 then
                    SetPedIntoVehicle(cache.ped, cache.vehicle, -1)
                    SetPedConfigFlag(cache, 184, true)
                end
            end
        end)
    end
end

extensions:DispatchServices = function()
    if DisableDispatchServices then
        for i = 1, 15 do
            EnableDispatchService(i, false)
        end
        SetAudioFlag('PoliceScannerDisabled', true)
    end
end

extensions:NPCScenarios = function()
    if DisableScenarios then
        local scenarios = {
            "WORLD_VEHICLE_ATTRACTOR",
            "WORLD_VEHICLE_AMBULANCE",
            "WORLD_VEHICLE_BICYCLE_BMX",
            "WORLD_VEHICLE_BICYCLE_BMX_BALLAS",
            "WORLD_VEHICLE_BICYCLE_BMX_FAMILY",
            "WORLD_VEHICLE_BICYCLE_BMX_HARMONY",
            "WORLD_VEHICLE_BICYCLE_BMX_VAGOS",
            "WORLD_VEHICLE_BICYCLE_MOUNTAIN",
            "WORLD_VEHICLE_BICYCLE_ROAD",
            "WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",
            "WORLD_VEHICLE_BIKER",
            "WORLD_VEHICLE_BOAT_IDLE",
            "WORLD_VEHICLE_BOAT_IDLE_ALAMO",
            "WORLD_VEHICLE_BOAT_IDLE_MARQUIS",
            "WORLD_VEHICLE_BOAT_IDLE_MARQUIS",
            "WORLD_VEHICLE_BROKEN_DOWN",
            "WORLD_VEHICLE_BUSINESSMEN",
            "WORLD_VEHICLE_HELI_LIFEGUARD",
            "WORLD_VEHICLE_CLUCKIN_BELL_TRAILER",
            "WORLD_VEHICLE_CONSTRUCTION_SOLO",
            "WORLD_VEHICLE_CONSTRUCTION_PASSENGERS",
            "WORLD_VEHICLE_DRIVE_PASSENGERS",
            "WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED",
            "WORLD_VEHICLE_DRIVE_SOLO",
            "WORLD_VEHICLE_FIRE_TRUCK",
            "WORLD_VEHICLE_EMPTY",
            "WORLD_VEHICLE_MARIACHI",
            "WORLD_VEHICLE_MECHANIC",
            "WORLD_VEHICLE_MILITARY_PLANES_BIG",
            "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
            "WORLD_VEHICLE_PARK_PARALLEL",
            "WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN",
            "WORLD_VEHICLE_PASSENGER_EXIT",
            "WORLD_VEHICLE_POLICE_BIKE",
            "WORLD_VEHICLE_POLICE_CAR",
            "WORLD_VEHICLE_POLICE",
            "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
            "WORLD_VEHICLE_QUARRY",
            "WORLD_VEHICLE_SALTON",
            "WORLD_VEHICLE_SALTON_DIRT_BIKE",
            "WORLD_VEHICLE_SECURITY_CAR",
            "WORLD_VEHICLE_STREETRACE",
            "WORLD_VEHICLE_TOURBUS",
            "WORLD_VEHICLE_TOURIST",
            "WORLD_VEHICLE_TANDL",
            "WORLD_VEHICLE_TRACTOR",
            "WORLD_VEHICLE_TRACTOR_BEACH",
            "WORLD_VEHICLE_TRUCK_LOGS",
            "WORLD_VEHICLE_TRUCKS_TRAILERS",
            "WORLD_VEHICLE_DISTANT_EMPTY_GROUND",
            "WORLD_HUMAN_PAPARAZZI",
        }

        for i=1, #scenarios do
            SetScenarioTypeEnabled(scenarios[i], false)
        end
    end
end

extensions:PresencePlaceholders = function()
    local presence = RichPresence['presence']

    for placeholder, cb in pairs(placeHolders) do
        local success, result = pcall(cb)

        if not success then
            error(("Failed to execute presence placeholder: ^5%s^7"):format(placeholder))
            error(result)
            return "Unknown"
        end

        presence = presence:gsub(("{%s}"):format(placeholder), result)
    end

    return presence
end

extensions:DiscordPresence = function()
    if enableRichPresence then
        CreateThread(function()
            while true do
                SetDiscordAppId(RichPresence['appId'])
                SetDiscordRichPresenceAsset(RichPresence['assetName'])
                SetDiscordRichPresenceAssetText(RichPresence['assetText'])

                for i = 1, #RichPresence['buttons'] do
                    local button = RichPresence['buttons'][i]
                    SetDiscordRichPresenceAction(i - 1, button['label'], button['url'])
                end

                SetRichPresence(self:PresencePlaceholders())
                Wait(RichPresence['refresh'])
            end
        end)
    end
end

extensions:WantedLevel = function()
    if not EnableWantedLevel then
        ClearPlayerWantedLevel(cache.playerId)
        SetMaxWantedLevel(0)
    end
end

extensions:DisableRadio = function()
    if RemoveHudComponents[16] then
        lib.onCache('vehicle', function(value)
            SetUserRadioControlEnabled(false)
            SetVehRadioStation(value,"OFF")
        end)
    end
end  

extensions:EnablePvP = function()
    if EnablePVP then
        SetCanAttackFriendly(cache.ped, true, false)
        NetworkSetFriendlyFireOption(true)
    end
end

extensions:HealthRegeneration = function()
    if DisableHealthRegeneration then
        SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
    end
end

extensions:AmmoAndVehicleRewards = function()
    CreateThread(function()
        while true do
            if DisableDisplayAmmo then
                DisplayAmmoThisFrame(false)
            end

            if DisableVehicleRewards then
                DisablePlayerVehicleRewards(ESX.playerId)
            end

            Wait(0)
        end
    end)
end

extensions:Load = function()
    self:RemoveHudComponents()
    self:DisableAimAssist()
    self:DisableNPCDrops()
    self:SeatShuffle()
    self:HealthRegeneration()
    self:AmmoAndVehicleRewards()
    self:EnablePvP()
    self:DispatchServices()
    self:NPCScenarios()
    self:DiscordPresence()
    self:WantedLevel()
    self:DisableRadio()
end
