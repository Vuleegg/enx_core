require 'config.main'

return {
    ['charinfo'] = {
        ['DOB'] = "DD/MM/YYYY",
        ['first_name'] = "",
        ['last_name'] = "",
        ['isNew'] = true,
        ['group'] = "user",
        ['sex'] = "m",
    },
    ['job'] = defaultJob,
    ['gang'] = defaultGang,
    ['inventory'] = {},
    ['player_skin'] = {},
    ['last_location'] = vec3(0, 0, 0),
    ['status'] = { 
        ['hunger'] = 100, 
        ['thirst'] = 100,
        ['stress'] = 0,
        ['armour'] = 0, 
        ['health'] = 200, 
    },
    ['money'] = { 
        ['bank'] = 0, 
        ['cash'] = 0, 
        ['black_money'] = 0
    },
}
