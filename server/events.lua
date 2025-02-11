local client = require 'client.main' 

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    TriggerEvent("enx:onPlayerJoinQueue")
    TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)

RegisterNetEvent('enx_core:server:onPlayerReady', function()
    Player(source).state:set('PlayerReady', true, true)

    client.Cache[source] = {  
        steamName = GetPlayerName(source),      
        source = source, 
    }
end)