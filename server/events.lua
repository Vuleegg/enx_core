local metadata = require 'server.metadata' 


AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    TriggerEvent("enx:onPlayerJoinQueue")
    TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)

RegisterNetEvent('enx_core:server:onPlayerReady', function()
    Player(source).state:set('PlayerReady', true, true)
end)