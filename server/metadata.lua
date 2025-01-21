require 'config.main'

return {
    ['charinfo'] = {
        ['DOB'] = "DD/MM/YYYY",
        ['first_name'] = "FirstName",
        ['last_name'] = "LastName",
        ['isNew'] = true,
        ['group'] = "user",
        ['sex'] = "m",
    },
    ['job'] = {
        ['name'] = defaultJob['name'],
        ['label'] =  defaultJob['label']
        ['grade'] = {
            ['name'] =  defaultJob['grade']['name'],
            ['level'] = defaultJob['grade']['level'], 
        }, 
    },
    ['gang'] = {},
    ['inventory'] = {},
    ['player_skin'] = {},
    ['last_location'] = vec3(0, 0, 0),
    ['status'] = {},
    ['money'] = { 
        ['bank'] = 0, 
        ['cash'] = 0, 
        ['black_money'] = 0
    },
}
