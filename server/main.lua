enx = {}
Cache = {}
local metadata = require 'server.metadata'
local config = require 'config.main'
local indexes = require 'server.identifiers'

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

end

RegisterNetEvent("enx:onPlayerJoinQueue")
AddEventHandler("enx:onPlayerJoinQueue", function()
    local src = source
    enx.StartLogin(src)
end)
