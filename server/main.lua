enx = {}
Cache = {}
enx.Jobs = {}
enx.Gangs = {}

local metadata = require 'server.metadata'
local config = require 'config.main'
local indexes = require 'server.identifiers'
local ox_inventory = exports.ox_inventory
local jobs = require 'shared.jobs'
local gangs = require 'shared.gangs'

exports("loadCore", enx)

enx.Cache.getUser = function(source)
    return Cache[tonumber(source)].metadata or nil
end

exports('getUser', enx.Cache.getUser)

enx.Cache.loadUserMeta = function(source)
    local player = enx.Cache.getUser(source)
    if not player or not player.userId then return end 

    exports.oxmysql:execute('SELECT charinfo, money, job, gang FROM users_metadata WHERE userId = ?', {player.userId}, function(result)
        if result and result[1] then
            Cache[source].metadata = {
                charinfo = json.decode(result[1].charinfo),
                money = json.decode(result[1].money),
                job = json.decode(result[1].job),
                gang = json.decode(result[1].gang)
            }
        else
            return print(string.gsub("[ENX-CORE] No metadata found for player %s", source))
        end
    end)
end

exports('loadUserMeta', enx.Cache.loadUserMeta)

AddEventHandler('playerDropped', function()
    Cache[source] = nil
end)

local function InsertUserBasic(source)
    local identifiers = indexes.GetIdentifiers(source)
    local username = GetPlayerName(source) or "Unknown"

    if not identifiers.license then
        print("[ENX-CORE] License ID is missing for player: " .. username)
        return
    end

    local userId = indexes.createUserId()

    local query_users = [[
        INSERT INTO users (userId, username, license, license2, fivem, discord) 
        VALUES (?, ?, ?, ?, ?, ?)
    ]]

    local id = MySQL.insert.await(query_users, { 
        userId,
        username, 
        identifiers.license, 
        identifiers.license2 or "N/A", 
        identifiers.fivem or "N/A", 
        identifiers.discord or "N/A"
    })

    if id then
        print("[ENX-CORE] New user inserted: " .. username .. " (ID: " .. id .. ")")

        local query_metadata = [[
            INSERT INTO users_metadata (userId, charinfo, money, job, gang, inventory, skin) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ]]

        local meta_id = MySQL.insert.await(query_metadata, {
            userId,
            metadata.charinfo,
            metadata.money,
            metadata.job,
            metadata.gang,
            metadata.inventory,
            metadata.skin
        })

        if meta_id then
            print("[ENX-CORE] Metadata inserted for user: " .. username .. " (ID: " .. userId .. ")")
        else
            print("[ENX-CORE] Failed to insert metadata for user: " .. username)
        end
    else
        print("[ENX-CORE] Failed to insert user: " .. username)
    end
end

enx.StartLogin = function(source)
    local identifiers = indexes.GetIdentifiers(source)
    local userId = indexes.GetUserId(identifiers.license) 

    if not userId then
        InsertUserBasic(source)
    end

    local meta = enx.Cache.loadUserMeta(source)

    Cache[source].metadata = {  
        steamName = GetPlayerName(source),      
        source = source, 
    }

end

exports('StartLogin', enx.StartLogin)

RegisterNetEvent("enx:onPlayerJoinQueue")
AddEventHandler("enx:onPlayerJoinQueue", function()
    local src = source
    enx.StartLogin(src)
end)

---@param data table The data containing source, item, count, and optional metadata.
---@field source number The players source ID.
---@field item string The item name.
---@field count number The item quantity.
---@field metadata table|nil Optional metadata for the item.

enx.Cache.AddItem = function(data)
    if not data or not data.source or not data.item or not data.count then return end

    local source = tonumber(data.source)
    local item = tostring(data.item)
    local count = tonumber(data.count)
    local metadata = data.metadata or {}

    if not source or not item or not count or count <= 0 then return end

    local player = enx.Cache.getUser(source)
    if not player then return end

    ox_inventory.AddItem(source, item, count, metadata)
end

exports('AddItem', enx.Cache.AddItem)

---@param data table The data containing source, item, count, and optional metadata.
---@field source number The player's source ID.
---@field item string The item name.
---@field count number The item quantity.
---@field metadata table|nil Optional metadata for the item.

enx.Cache.RemoveItem = function(data)
    if not data or not data.source or not data.item or not data.count then return end

    local source = tonumber(data.source)
    local item = tostring(data.item)
    local count = tonumber(data.count)
    local metadata = data.metadata or {}

    if not source or not item or not count or count <= 0 then return end

    local player = enx.Cache.getUser(source)
    if not player then return end

    ox_inventory.RemoveItem(source, item, count, metadata)
end

exports('RemoveItem', enx.Cache.RemoveItem)

enx.Cache.LoadJobs = function()
    for k, v in pairs(jobs)do
        enx.Jobs[k] = v
    end
end

enx.Cache.LoadGangs = function()
    for k, v in pairs(gangs)do
        enx.Gangs[k] = v
    end
end

AddEventHandler("onServerResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        enx.Cache.LoadJobs()
        enx.Cache.LoadGangs()
    end
end)

---@param source number The players source ID.
---@param key string The metadata key to set.
---@param value any The value to assign to the metadata key.
enx.Cache.setPlayerMeta = function(source, key, value)
    if not source or source == 0 then return end
    if type(key) ~= "string" or key == "" then return end
    if value == nil then return end

    local s = tonumber(source)
    Cache[s] = Cache[s] or { metadata = {} }
    Cache[s].metadata = Cache[s].metadata or {}

    if type(value) == "table" then
        Cache[s].metadata[key] = Cache[s].metadata[key] or {}
        for k, v in pairs(value) do
            Cache[s].metadata[key][k] = v
        end
    else
        Cache[s].metadata[key] = value
    end
end

enx.Cache.setJob = function(source, job, rank)
    if not source or source == 0 then return end 

    local jobData = enx.Jobs[job]
    if not jobData then return end

    local gradeData = jobData.grades[rank] or jobData.grades[0] 

    enx.Cache.setPlayerMeta(source, "job", {
        name = job,
        label = jobData.label,
        grade = {
            name = gradeData.name,
            rank = rank
        }
    })
end

exports('setJob', enx.Cache.setJob)

enx.Cache.setGang = function(source, gang, rank)
    if not source or source == 0 then return end 

    local gangData = enx.Gangs[gang]
    if not gangData then return end

    local gradeData = gangData.grades[rank] or gangData.grades[0] 

    enx.Cache.setPlayerMeta(source, "gang", {
        name = gang,
        label = gangData.label,
        grade = {
            name = gradeData.name,
            rank = rank
        }
    }) 
end

exports('setGang', enx.Cache.setGang)

enx.Cache.setGroup = function(source, group)
    if not source or source == 0 then return end 

    local player = enx.Cache.getUser(source)
    if not player then return end 

    local identifier = player.charinfo.citizenid
    local lastGroup = player.charinfo.group

    if lastGroup and lastGroup ~= group then
        lib.removePrincipal('player.' .. source, 'group.' .. lastGroup)
        lib.removeAce('player.' .. source, 'group.' .. lastGroup)
    end

    player.charinfo.group = group
    enx.Cache.setPlayerMeta(source, "charinfo", player.charinfo)

    if not IsPlayerAceAllowed(source, group) then
        lib.addPrincipal('player.' .. source, 'group.' .. group)
        lib.addAce('player.' .. source, 'group.' .. group)
    end
end

