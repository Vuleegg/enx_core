require 'config.main'

RegisterNetEvent('enx_core:client:onPlayerReady', function()
    ENX.Thread(function()
        for i = 1, #RemoveHudComponents do 
            if RemoveHudComponents[i] then
                SetHudComponentSize(i, 0.0, 0.0)
                SetHudComponentPosition(i, 900, 900)
            end
        end

        if DisableAimAssist then
            SetPlayerTargetingMode(3)
        end

        if DisableNPCDrops then
            local weaponPickups = { `PICKUP_WEAPON_CARBINERIFLE`, `PICKUP_WEAPON_PISTOL`, `PICKUP_WEAPON_PUMPSHOTGUN` }
            for i = 1, #weaponPickups do
                ToggleUsePickupsForPlayer(cache.playerId, weaponPickups[i], false)
            end
        end

        if DisableDispatchServices then
            for i = 1, 15 do
                EnableDispatchService(i, false)
            end
            SetAudioFlag('PoliceScannerDisabled', true)
        end

        if DisableScenarios then
            local scenarios = {
                "WORLD_VEHICLE_ATTRACTOR",
                "WORLD_HUMAN_PAPARAZZI",
            }
            for i = 1, #scenarios do
                SetScenarioTypeEnabled(scenarios[i], false)
            end
        end

        if DisableHealthRegeneration then
            SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
        end

        if EnablePVP then
            SetCanAttackFriendly(cache.ped, true, false)
            NetworkSetFriendlyFireOption(true)
        end

        if not EnableWantedLevel then
            ClearPlayerWantedLevel(cache.playerId)
            SetMaxWantedLevel(0)
        end
    end)

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

    if RemoveHudComponents[16] then
        lib.onCache('vehicle', function(value)
            SetUserRadioControlEnabled(false)
            SetVehRadioStation(value, "OFF")
        end)
    end

    ENX.Thread(function()
        while true do
            if DisableDisplayAmmo then
                DisplayAmmoThisFrame(false)
            end

            if DisableVehicleRewards then
                DisablePlayerVehicleRewards(cache.playerId)
            end

            Wait(0)
        end
    end)
end)
