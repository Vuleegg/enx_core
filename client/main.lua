enx = {}
Cache = {}

exports("loadCore", enx)

---@param object string The key under which the player metadata is stored.
---@param value any The value to be assigned (can be a table or any other type).
enx.Cache.setPlayerMeta = function(object, value)
    if type(object) ~= "string" or object == "" then return end
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

---@param func function The function to execute when the player is ready.
enx.Cache.onPlayerReady = function(func)
    if type(func) ~= "function" then return end
    if not enx.Cache["PlayerReady"] then return end

    func()
end

exports('onPlayerReady', enx.Cache.onPlayerReady)

---@param playerId number The players server ID.
---@param Player table The players data containing character info.
RegisterNetEvent("enx_core:client:onPlayerReady", function(playerId, Player)
    enx.Cache.setPlayerMeta("charinfo", Player.charinfo)
    enx.Cache.setPlayerMeta("userId", playerId)
end)

---@return table|nil The character information stored in the cache.
enx.Cache.getPlayerData = function()    
    return enx.Cache['charinfo']
end

exports('getPlayerData', enx.Cache.getPlayerData)