local Intervals = {}

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

GlobalState.MaximumSlots = GetConvarInt('sv_maxclients', 48)