enx = {}
Cache = {}

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

enx.Cache.loadUserMeta = function(source, index)
    local src = source
    local userId = GetPlayerIdentifier(src, 0) 
    
    if not userId then return end
    
    Cache[src] = {
        name = GetPlayerName(src),
        source = src
    }

    exports.oxmysql:execute('SELECT * FROM users_metadata WHERE userId = ?', {userId}, function(result)
        if result and result[1] then
            Cache[src].metadata = {
                userId = result[1].userId,
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
            Cache[src].metadata = {
                charinfo = {
                    DOB = "DD/MM/YYYY",
                    first_name = "",
                    last_name = "",
                    isNew = true,
                    group = "user",
                    sex = "m",
                    last_location = vec4(0, 0, 0, 0),
                },
                job = {
                    name = "unemployed",
                    label = "Civilian",
                    grade = {
                        name = "Freelancer",
                        rank = 0,
                    },
                },
                gang = {
                    name = "none",
                    label = "No Gang",
                    grade = {
                        grade = "Unaffiliated",
                        rank = 0,
                    },
                },
                inventory = {},
                skin = {},
                status = { hunger = 100, thirst = 100, stress = 0, armour = 0, health = 200 },
                money = { bank = 0, cash = 0, black_money = 0 },
                addictions = { weed = 0, cocaine = 0, meth = 0, opium = 0, heroin = 0 }
            }
        end
    end)
end

exports('loadUserMeta', enx.Cache.loadUserMeta)