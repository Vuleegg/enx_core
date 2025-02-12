local config = require 'config.main'

enx.SendAlert = function(data)
  if not data then return print("Data information is missing") end 
    exports['enx-notify']:SendAlert({
        title = data.title,
        description = data.description,
        position = config.notifypos,
        icon = config.default_notify_icon,
        type = data.type
    })
end

exports('SendAlert', enx.SendAlert)

RegisterNetEvent("enx_core:SendAlert") 
 AddEventHandler("enx_core:SendAlert", function(data)
    enx.SendAlert(data)
end)

enx.SetVehicleCustoms = function(data)
    if not data then return print("Data information is missing") end 
    
end

exports('SetVehicleCustoms', enx.SetVehicleCustoms)

enx.GetVehicleCustoms = function(entity)
    if not entity then return print("Entity is missing") end 
    
end

exports('GetVehicleCustoms', enx.GetVehicleCustoms)

enx.Trim = function(value)
    if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

exports('Trim', enx.Trim)

enx.getPlate(vehicle)
    if vehicle == 0 then return end
    return enx.Trim(GetVehicleNumberPlateText(vehicle))
end

exports('getPlate', enx.getPlate)

RegisterNetEvent('enx:Teleport', function()
    local blipMarker = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        enx.SendAlert({
            description = L('error.no_waypoint'), 
            type = 'error', 
            title = L('main_title') 
        })
        return 'marker'
    end

    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local coords = GetBlipInfoIdCoord(blipMarker)
    local oldCoords = GetEntityCoords(cache.ped)

    local x, y, groundZ = coords.x, coords.y, 850.0
    local Z_START = 950.0
    local found = false

    if cache.vehicle > 0 then
        FreezeEntityPosition(cache.vehicle, true)
    else
        FreezeEntityPosition(cache.ped, true)
    end

    for i = Z_START, 0, -25.0 do
        local z = (i % 2) ~= 0 and Z_START - i or i

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()

        SetPedCoordsKeepVehicle(cache.ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(cache.ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
        if found then
            SetPedCoordsKeepVehicle(cache.ped, x, y, groundZ)
            break
        end
        Wait(0)
    end

    DoScreenFadeIn(650)

    if cache.vehicle > 0 then
        FreezeEntityPosition(cache.vehicle, false)
    else
        FreezeEntityPosition(cache.ped, false)
    end

    if not found then
        SetPedCoordsKeepVehicle(cache.ped, oldCoords.x, oldCoords.y, oldCoords.z - 1.0)
        enx.SendAlert({
            description = L('error.tp_error'), 
            type = 'error', 
            title = L('main_title') 
        })
    else
        SetPedCoordsKeepVehicle(cache.ped, x, y, groundZ)
        enx.SendAlert({
            description = L('success.teleported_waypoint'), 
            type = 'success', 
            title = L('main_title') 
        })
    end
end)
