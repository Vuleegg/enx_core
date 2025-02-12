enx = {}
Cache = {}

exports("loadCore", enx)

enx.Cache.setPlayerMeta = function(object, value)
    if type(object) ~= "string" or object == "" then return end
    if value == nil then return end

    enx.Cache[object] = value
end

AddStateBagChangeHandler('PlayerReady', ('player:%s'):format(cache.serverId), function(...)
    local value = select(3, ...) 
    enx.Cache.setPlayerMeta("PlayerReady", value)
end)

enx.onPlayerReady = function(func)
    if type(func) ~= "function" then
        return
    end

    if not enx.Cache["PlayerReady"] then return end

    func()
end

exports('onPlayerReady', enx.onPlayerReady)

