enx = {}
Cache = {}

exports("loadCore", enx)

PlayerReady = false 

enx.PlayerReady = function(boolean)
    PlayerReady = boolean
end

AddStateBagChangeHandler('PlayerReady', ('player:%s'):format(cache.serverId), function(_, _, value)
    if not value then 
      enx.PlayerReady(value) 
    end
end)

onPlayerReady = function(func)
     if not PlayerReady then return print("[ENX-ERROR] : Player not ready.") end 
     func()
end

exports('onPlayerReady', onPlayerReady)

--[[
    exports.enx_core.PlayerReady = function(boolean)
        PlayerReady = boolean
    end
]]