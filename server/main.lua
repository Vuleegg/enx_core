enx = {}
Cache = {}
local metadata = require 'server.metadata' 

exports("loadCore", enx)

enx.Cache.getUser = function(source)
    return Cache[source]
end

exports('getUser', enx.Cache.getUser)

createUserId = function()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local userId = ""
    for i = 1, 7 do
        local randomIndex = math.random(1, #charset)
        userId = userId .. charset:sub(randomIndex, randomIndex)
    end
    return userId
end

enx.Cache.loadUserMeta = function(source)
    local player = enx.Cache.getUser(source) 
    
    if not player.userId then return end
    
    exports.oxmysql:execute('SELECT * FROM users_metadata WHERE userId = ?', {player.userId}, function(result)
        if result and result[1] then
            Cache[source].metadata = {
                charinfo = json.decode(result[1].charinfo),
                money = json.decode(result[1].money),
                job = json.decode(result[1].job),
                gang = json.decode(result[1].gang),
                inventory = json.decode(result[1].inventory),
                skin = json.decode(result[1].skin),
                status = json.decode(result[1].status), 
                addictions = json.decode(result[1].addictions)
            }
        else
            Cache[source].metadata = metadata
        end
    end)
end

exports('loadUserMeta', enx.Cache.loadUserMeta)