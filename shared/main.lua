ENX = {}

exports("loadCore", function()
    return ENX
end)

exports("getSharedObject", function()
    return ENX
end)

AddEventHandler("esx:getSharedObject", function(cb)
    if ENX.IsFunctionReference(cb) then
        cb(ENX)
    end
    local invokingResource = GetInvokingResource()
end)

