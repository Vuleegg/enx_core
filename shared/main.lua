ESX = {}

exports("loadCore", function()
    return ESX
end)

exports("getSharedObject", function()
    return ESX
end)

AddEventHandler("esx:getSharedObject", function(cb)
    if ESX.IsFunctionReference(cb) then
        cb(ESX)
    end
    local invokingResource = GetInvokingResource()
end)

