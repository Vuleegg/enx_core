require 'config.main'

local function removeHudComponents(components)
    for _, component in ipairs(components) do
        SetHudComponentSize(component, 0.0, 0.0)
        SetHudComponentPosition(component, 900, 900)
    end
end

local function disableScenarios(scenarios)
    for _, scenario in ipairs(scenarios) do
        SetScenarioTypeEnabled(scenario, false)
    end
end

local function disableWeaponPickups(pickups)
    for _, pickup in ipairs(pickups) do
        ToggleUsePickupsForPlayer(cache.playerId, pickup, false)
    end
end

RegisterNetEvent('enx_core:client:onPlayerReady', function()
    local extensions = Config.extensions

    if extensions.removeHudComponents then
        removeHudComponents(extensions.removeHudComponents)
    end

    if extensions.disableAimAssist then
        SetPlayerTargetingMode(3)
    end

    if extensions.disableNPCDrops then
        disableWeaponPickups({
            `PICKUP_WEAPON_CARBINERIFLE`,
            `PICKUP_WEAPON_PISTOL`,
            `PICKUP_WEAPON_PUMPSHOTGUN`
        })
    end

    if extensions.disableDispatchServices then
        for i = 1, 15 do
            EnableDispatchService(i, false)
        end
        SetAudioFlag('PoliceScannerDisabled', true)
    end

    if extensions.disableScenarios then
        disableScenarios({
            "WORLD_VEHICLE_ATTRACTOR",
            "WORLD_VEHICLE_BICYCLE_BMX",
            -- Add other scenarios here...
        })
    end

    if extensions.disableHealthRegeneration then
        SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
    end

    if extensions.enablePVP then
        SetCanAttackFriendly(cache.ped, true, false)
        NetworkSetFriendlyFireOption(true)
    end

    if not extensions.enableWantedLevel then
        ClearPlayerWantedLevel(cache.playerId)
        SetMaxWantedLevel(0)
    end

    if extensions.disableVehicleSeatShuff then
        lib.onCache('vehicle', function(value)
            if value and value.seat > -1 then
                SetPedIntoVehicle(cache.ped, cache.vehicle, -1)
                SetPedConfigFlag(cache.ped, 184, true)
            end
        end)
    end

    if extensions.removeHudComponents and extensions.removeHudComponents[16] then
        lib.onCache('vehicle', function(value)
            if value then
                SetUserRadioControlEnabled(false)
                SetVehRadioStation(value, "OFF")
            end
        end)
    end

    ENX.Thread(function()
        while true do
            if extensions.disableDisplayAmmo then
                DisplayAmmoThisFrame(false)
            end

            if extensions.disableVehicleRewards then
                DisablePlayerVehicleRewards(cache.playerId)
            end

            Wait(0)
        end
    end)
end)
