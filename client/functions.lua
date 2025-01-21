local Intervals = {}
local config = require 'config.main'

ENX.Thread = function(func)
    if type(func) ~= "function" then
        error("ENX.Thread expects a function as an argument")
    end

    local thread = coroutine.create(func)

    CreateThread(function()
        local status, err = coroutine.resume(thread)
        if not status then
            print("^1[ENX.Thread ERROR]^7: " .. err)
        end
    end)
end

ENX.SetInterval = function(id, msec, callback, onclear)
    if not Intervals[id] and msec then
        Intervals[id] = msec
        CreateThread(function()
            repeat
                local interval = Intervals[id]
                Wait(interval)
                callback(interval)
            until interval == -1 and (onclear and onclear() or true)
            Intervals[id] = nil
        end)
    elseif msec then Intervals[id] = msec end
end

ENX.ClearInterval = function(id)
    if Intervals[id] then Intervals[id] = -1 end
end

ENX.alertPlayer = function(data)
    if not data then return end

    local title, description
    local text = data.text or 'Placeholder'
    local subTitle = data.caption or nil

    -- If `data.text` is a table, extract the title and description
    if type(text) == 'table' then
        title = text.text or 'Placeholder'
        description = text.caption or nil
    elseif subTitle then
        title = text
        description = subTitle
    else
        title = text
        description = nil
    end

    -- Check if other parameters are defined and set defaults if not
    local position = config.notifypos or 'top-right' -- Default position
    local duration = data.duration or 5000 -- Default duration (5 seconds)
    local notifyType = data.type or 'info' -- Default notification type
    local notifyStyle = data.style or {} -- Default style
    local notifyIcon = data.icon or 'fa-info-circle' -- Default icon
    local notifyIconColor = data.iconColor or 'blue' -- Default icon color

    -- Display the notification
    lib.notify({
        id = title,
        title = title,
        description = description,
        duration = duration,
        type = notifyType,
        position = position,
        style = notifyStyle,
        icon = notifyIcon,
        iconColor = notifyIconColor
    })
end
