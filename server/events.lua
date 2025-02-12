local server = require 'server.main' 

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    TriggerEvent("enx:onPlayerJoinQueue")
    TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)

RegisterNetEvent('enx_core:server:onPlayerReady', function()
    Player(source).state:set('PlayerReady', true, true)
    local player = enx.Cache.getUser(source)
    TriggerClientEvent("enx_core:client:onPlayerReady", source, player.userId, player)
    if player.charinfo.isNew then 
        TriggerClientEvent("enx_core:client:openRegisterMenu", source)
    end
end)