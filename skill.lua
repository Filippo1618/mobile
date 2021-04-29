
function NewSkill( primary )
    local self = {}

    self.primary = {}
    self.secondary = {}

    print ("proprietà primarie:")
    for string ,value in pairs(primary) do
        self.primary[string] = value
        print("proprieta ".. string .. "aggiunta alla skill")
    end
--[[
    print ("proprietà secondarie:")
    for string ,value in pairs(secondary) do
        self.secondary[string] = value
        print("proprieta ".. string .. "aggiunta alla skill")
    end
]]
    function self:castSkill(caster,targets)
        for key, value in pairs(self.primary) do
            print(key)
            value()
        end
    end

    return self
end