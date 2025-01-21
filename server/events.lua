AddEventHandler("playerConnecting", function(name, setReason, deferrals)
        TriggerEvent("enx:onPlayerJoinQueue")
        TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)