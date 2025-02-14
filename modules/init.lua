local config = require 'config.main'

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then

        MySQL.Sync.execute([[
            CREATE TABLE IF NOT EXISTS `users` (
            `userId` varchar(7) DEFAULT NULL,
            `username` varchar(255) DEFAULT NULL,
            `license` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
            `license2` varchar(50) DEFAULT NULL,
            `fivem` varchar(50) DEFAULT NULL,
            `discord` varchar(50) DEFAULT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ]])
        MySQL.Sync.execute([[
            CREATE TABLE IF NOT EXISTS `users_metadata` (
            `userId` varchar(7) DEFAULT NULL,
            `charinfo` text DEFAULT NULL,
            `money` text DEFAULT NULL,
            `job` text DEFAULT NULL,
            `gang` text DEFAULT NULL,
            `inventory` text DEFAULT NULL,
            `skin` text DEFAULT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
        ]])

        createPermissionsCfg()

    end
end)

function containsExecLine()
    local file = io.open("server.cfg", "r")
    if not file then return false end

    for line in file:lines() do
        if line:match("^exec%s+permissions%.cfg") then
            file:close()
            return true
        end
    end

    file:close()
    return false
end

function appendExecLine()
    local file = io.open("server.cfg", "a")
    if file then
        file:write("\nexec permissions.cfg\n")
        file:close()
    end
end

function createPermissionsCfg()
    local file = io.open("permissions.cfg", "r")
    if file then
        file:close()
        return
    end

    file = io.open("permissions.cfg", "w")
    if file then
        file:write("# Permissions configuration\n")
        file:close()
    end
end

if not containsExecLine() then
    appendExecLine()
end


