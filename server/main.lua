enx = {}
Cache = {}

exports("loadCore", enx)

RegisterServerEvent('enx_core:server:onPlayerReady')
AddEventHandler('enx_core:server:onPlayerReady', function()     
    Cache[source] = true
end)

exports('onPlayerReady', function(func)
    if not Cache[source] then return print("[ENX-ERROR] : Player not ready.") end 
    func()
end)

enx.Cache.getUser = function(source)
    return Cache[source]
end

exports('getUser', enx.Cache.getUser)

enx.Cache.loadUserMeta = function(index)
    
end