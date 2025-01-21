ENX.DetectIdentifier = function(source)
    local identifiers = GetPlayerIdentifiers(source)
    local result = {}
    
    for _, identifier in pairs(identifiers) do
        if string.match(identifier, "discord:") then
            table.insert(result, { type = "discord", value = identifier })
        elseif string.match(identifier, "license:") then
            table.insert(result, { type = "license", value = identifier })
        elseif string.match(identifier, "license2:") then
            table.insert(result, { type = "license2", value = identifier })
        end
    end

    local hardware_id = nil
    local numTokens = GetNumPlayerTokens(source)
    for i = 0, numTokens - 1 do
        local token = GetPlayerToken(source, i)
        if string.match(token, "hardware:") then
            hardware_id = token
            break
        end
    end

    if hardware_id then
        table.insert(result, { type = "hardware", value = hardware_id })
    end

    return result, hardware_id
end
