enx = {}
Cache = {}
local metadata = require 'server.metadata'
local config = require 'config.main'

exports("loadCore", enx)

enx.Cache.getUser = function(source)
    return Cache[tonumber(source)].metadata or nil
end

exports('getUser', enx.Cache.getUser)

local function GetIdentifiers(source)
    local identifiers = {
        license = nil,
        license2 = nil,
        fivem = nil,
        discord = nil
    }

    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(id, 1, 8) == "license:" then
            if not identifiers.license then
                identifiers.license = string.sub(id, 9)
            else
                identifiers.license2 = string.sub(id, 9)
            end
        elseif string.sub(id, 1, 5) == "fivem:" then
            identifiers.fivem = string.sub(id, 6)
        elseif string.sub(id, 1, 8) == "discord:" then
            identifiers.discord = string.sub(id, 9)
        end
    end

    return identifiers
end

GetUserId = function(identifierValue)
    local mainIdentifier = config.main_identifier or "license"

    local query = string.format("SELECT userId FROM `users` WHERE `%s` = ?", mainIdentifier)
    local data = MySQL.query.await(query, { identifierValue })

    if data and #data > 0 then
        return data[1].userId 
    end

    return nil 
end

createUserId = function()
    local charset, userId = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", ""
    for _ = 1, 7 do
        userId = userId .. charset:sub(math.random(1, #charset), math.random(1, #charset))
    end
    return userId
end

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
    local identifiers = GetIdentifiers(source)
    local username = GetPlayerName(source) or "Unknown"

    if not identifiers.license then
        print("[ENX-CORE] License ID is missing for player: " .. username)
        return
    end

    local query = [[
        INSERT INTO users (userId, username, license, license2, fivem, discord) 
        VALUES (?, ?, ?, ?, ?, ?)
    ]]

    local success = exports.oxmysql:execute(query, { 
        createUserId(),
        username, 
        identifiers.license, 
        identifiers.license2 or "N/A", 
        identifiers.fivem or "N/A", 
        identifiers.discord or "N/A"
    })

    if success and success.affectedRows > 0 then
        print("[ENX-CORE] New user inserted: " .. username)
    end
end

enx.StartLogin = function(source)
    local identifiers = GetIdentifiers(source)
    local userId = GetUserId(identifiers.license) 

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
