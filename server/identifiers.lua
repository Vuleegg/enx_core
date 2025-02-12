return { 
    GetIdentifiers = function(source)
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
    end,

    GetUserId = function(identifierValue)
        local mainIdentifier = config.main_identifier or "license"

        local query = string.format("SELECT userId FROM `users` WHERE `%s` = ?", mainIdentifier)
        local data = MySQL.query.await(query, { identifierValue })

        if data and #data > 0 then
            return data[1].userId 
        end

        return nil 
    end,

    createUserId = function()
        local charset, userId = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", ""
        for _ = 1, 7 do
            userId = userId .. charset:sub(math.random(1, #charset), math.random(1, #charset))
        end
        return userId
    end,
}