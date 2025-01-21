
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
