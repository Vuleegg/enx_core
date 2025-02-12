RegisterNetEvent("enx_core:client:openRegisterMenu", function()
    local input = lib.inputDialog(L('register_title'), {
        {type = 'input', label = L('first_name'), description = 'Nicolas Cage', required = true},
        {type = 'input', label = L('last_name'), description = 'Some number description', required = true},
        {type = 'select', label = L('select-gender'), options = {
            { value = 'm', label = L('male') },
            { value = 'f', label = L('female') },
        }, required = true},
        {type = 'date', label = L('dob'), icon = {'far', 'calendar'}, default = true, format = "DD/MM/YYYY", required = true}
      })
       
      if not input then return end 
       
      local timestamp = math.floor(input[5] / 1000)
      local date = os.date('%Y-%m-%d %H:%M:%S', timestamp)
end)