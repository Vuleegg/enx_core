local Intervals = {}
local config = require 'config.main'

ENX.Thread = function(func)
    if type(func) ~= "function" then
        error("ENX.Thread expects a function as an argument")
    end

    local thread = coroutine.create(func)

    CreateThread(function()
        local status, err = coroutine.resume(thread)
        if not status then
            print("^1[ENX.Thread ERROR]^7: " .. err)
        end
    end)
end

ENX.SetInterval = function(id, msec, callback, onclear)
    if not Intervals[id] and msec then
        Intervals[id] = msec
        CreateThread(function()
            repeat
                local interval = Intervals[id]
                Wait(interval)
                callback(interval)
            until interval == -1 and (onclear and onclear() or true)
            Intervals[id] = nil
        end)
    elseif msec then Intervals[id] = msec end
end

ENX.ClearInterval = function(id)
    if Intervals[id] then Intervals[id] = -1 end
end

ENX.SendAlert = function(data)
  if not data then return print("Data information is missing") end 
    exports['enx-notify']:SendAlert({
        title = data.title,
        description = data.description,
        position = data.position,
        icon = data.icon,
        type = data.type
    })
end

RegisterNetEvent("enx_core:client:Alert") 
 AddEventHandler("enx_core:client:Alert", function(data)
    ENX.SendAlert(data)
end)