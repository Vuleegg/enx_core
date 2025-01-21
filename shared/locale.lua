require 'config.main'

local Locales = {}

function LoadLocale(locale)
    local file = ('locales/%s.json'):format(locale)
    local content = LoadResourceFile(GetCurrentResourceName(), file)
    if content then
        Locales[locale] = json.decode(content)
        return true
    else
        print(('[ERROR] Locale file %s not found!'):format(file))
        return false
    end
end

function L(key, ...)
    local localeData = Locales[DefaultLocale]
    if localeData and localeData[key] then
        return localeData[key]:format(...)
    end
    return ('[MISSING LOCALE]: %s'):format(key)
end

function SetLocale(locale)
    if LoadLocale(locale) then
        DefaultLocale = locale
        print(('[INFO] Locale set to %s'):format(locale))
    else
        print(('[ERROR] Failed to set locale to %s'):format(locale))
    end
end

LoadLocale(DefaultLocale)
