local config = require 'config.main'

enx.SendAlert = function(data)
  if not data then return print("Data information is missing") end 
    exports['enx-notify']:SendAlert({
        title = data.title,
        description = data.description,
        position = data.position,
        icon = data.icon,
        type = config.notifypos
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