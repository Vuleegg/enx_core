local metadata = require 'server.metadata' 

createUserId = function()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local userId = ""
    for i = 1, 7 do
        local randomIndex = math.random(1, #charset)
        userId = userId .. charset:sub(randomIndex, randomIndex)
    end
    return userId
end

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    TriggerEvent("enx:onPlayerJoinQueue")
    TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)

