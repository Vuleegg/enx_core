local slots = MaximumSlots
local config = require 'config.main'.extensions.discord

if not config.discordRPC then return end

AddStateBagChangeHandler('PlayerCount', '', function(bagName, _, value)
    if bagName == 'global' and value then
        SetRichPresence(('Players %s/%s'):format(value, slots))
    end
end)

ENX.Thread(function()
    SetDiscordAppId(config.app_id)
    SetDiscordRichPresenceAsset(config.largeIcon.icon)
    SetDiscordRichPresenceAssetText(config.largeIcon.text)
    SetDiscordRichPresenceAssetSmall(config.smallIcon.icon)
    SetDiscordRichPresenceAssetSmallText(config.smallIcon.text)
    SetDiscordRichPresenceAction(0, config.firstButton.text, config.firstButton.link)
    SetDiscordRichPresenceAction(1, config.secondButton.text, config.secondButton.link)
end)
