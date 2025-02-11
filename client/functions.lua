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