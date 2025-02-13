local server = require 'server.main'

GlobalState.MaximumSlots = GetConvarInt('sv_maxclients', 48)

---@param source number The players source ID.
---@return table|nil The players last known location.
getCoords = function(source)
    if not source or source == 0 then return nil end
    
    local player = server.enx.Cache.getUser(tonumber(source))
    return player.charinfo.last_location or nil
end

exports('getCoords', getCoords)

---@param source number The players source ID.
---@return string|nil The players full name.
getCharName = function(source)
    if not source or source == 0 then return nil end
    
    local player = server.enx.Cache.getUser(tonumber(source))
    return player.charinfo.first_name .. " " .. player.charinfo.last_name or nil
end

exports('getCharName', getCharName)
