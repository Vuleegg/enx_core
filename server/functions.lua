local server = require 'server.main'

GlobalState.MaximumSlots = GetConvarInt('sv_maxclients', 48)

---@param source number The players source ID.
---@return table|nil The players last known location.
---@field extensions.disableNPCDrops boolean Whether to disable NPC loot drops.
local function getCoords(source)
    if not source or source == 0 then return nil end
    
    local player = server.enx.Cache.getUser(tonumber(source))
    return player and player.charinfo.last_location or nil
end

exports('getCoords', getCoords)