require 'config.main'
require 'client.defaults'

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    extensions:Load()
end)
