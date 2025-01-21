require 'config.main'
require 'client.defaults'

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    ENX.PlayerData = xPlayer

    if not Multichar then

    end

    while not DoesEntityExist(cache.ped) do
        Wait(20)
    end

    ENX.PlayerLoaded = true

    local timer = GetGameTimer()
    while not HaveAllStreamingRequestsCompleted(cache.ped) and (GetGameTimer() - timer) < 2000 do
        Wait(0)
    end

    extensions:Load()

    ClearPedTasksImmediately(cache.ped)

    if not Config.Multichar then
        Core.FreezePlayer(false)
    end

    if IsScreenFadedOut() then
        DoScreenFadeIn(500)
    end

    Actions:Init()
    StartPointsLoop()
    StartServerSyncLoops()
    NetworkSetLocalPlayerSyncLookAt(true)
end)
