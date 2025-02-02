local extensions = require 'config.main'.extensions

local function removeHudComponents(components)
    for index, enabled in ipairs(components) do
        if enabled then
            if index ~= 16 then
                SetHudComponentSize(index, 0.0, 0.0)
                SetHudComponentPosition(index, 900, 900)
            end
        end
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
    local hudComponents = extensions.hudComponents

    local components = {
        hudComponents.wantedStars,     -- 1
        hudComponents.weaponIcon,      -- 2
        hudComponents.cash,            -- 3
        hudComponents.multiplayerCash, -- 4
        hudComponents.multiplayerMessage, -- 5
        hudComponents.vehicleName,     -- 6
        hudComponents.areaName,        -- 7
        hudComponents.vehicleClass,    -- 8
        hudComponents.streetName,      -- 9
        hudComponents.helpText,        -- 10
        hudComponents.floatingHelp1,   -- 11
        hudComponents.floatingHelp2,   -- 12
        hudComponents.cashChange,      -- 13
        hudComponents.reticle,         -- 14
        hudComponents.subtitleText,    -- 15
        hudComponents.radioStations,   -- 16
        hudComponents.savingGame,      -- 17
        hudComponents.gameStream,      -- 18
        hudComponents.weaponWheel,     -- 19
        hudComponents.weaponWheelStats,-- 20
        hudComponents.hudComponents,   -- 21
        hudComponents.hudWeapons,      -- 22
    }

    -- Call the function to remove HUD components if enabled
    removeHudComponents(components)

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
                SetPedconfigFlag(cache.ped, 184, true)
            end
        end)
    end

    if extensions.removeHudComponents and extensions.removeHudComponents.radioStation then
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
