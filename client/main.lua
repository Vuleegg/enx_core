enx = {}
Cache = {}

exports("loadCore", enx)

enx.Cache.setPlayerMeta = function(object, value)
    if type(object) ~= "string" or object == "" then return  end
    if value == nil then return end

    if type(value) == "table" then
        enx.Cache[object] = enx.Cache[object] or {} 
        for k, v in pairs(value) do
            enx.Cache[object][k] = v 
        end
    else
        enx.Cache[object] = value
    end
end

AddStateBagChangeHandler('PlayerReady', ('player:%s'):format(cache.serverId), function(...)
    local value = select(3, ...) 
    enx.Cache.setPlayerMeta("PlayerReady", value)
end)

enx.onPlayerReady = function(func)
    if type(func) ~= "function" then return end
    if not enx.Cache["PlayerReady"] then return end

    func()
end

exports('onPlayerReady', enx.onPlayerReady)

RegisterNetEvent("enx_core:client:onPlayerReady", function(playerId, Player)
    enx.Cache.setPlayerMeta("charinfo", Player.charinfo)
    enx.Cache.setPlayerMeta("userId", playerId)
end)

