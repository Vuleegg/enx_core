local server = require 'server.main' 
local config = require 'config.main'
local func = require 'server.functions'

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    TriggerEvent("enx:onPlayerJoinQueue")
    TriggerClienEvent("enx:onPlayerJoinQueue", source, source)
end)

RegisterNetEvent('enx_core:server:onPlayerReady', function()
    Player(source).state:set('PlayerReady', true, true)
    local player = enx.Cache.getUser(source)
    enx.Cache.setGroup(source, player.charinfo.group)
    if config.AdminGroups[player.charinfo.grou].hiddenDuty then
        func.toggleHiddenDuty(source, true)
    else
        func.toggleHiddenDuty(source, false)
    end
    func.toggleDuty(source, false)
    TriggerClientEvent("enx_core:client:onPlayerReady", source, player.userId, player)
    if player.charinfo.isNew then 
        TriggerClientEvent("enx_core:client:openRegisterMenu", source)
    end
end)