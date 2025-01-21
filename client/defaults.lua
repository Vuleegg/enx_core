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
                    SetPedIntoVehicle(cache.ped, cache.vehicle, seat)
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

