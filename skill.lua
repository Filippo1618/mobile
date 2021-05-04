
function NewSkill( ... )
    local self = {}

    self.primary = {}
    self.secondary = {}

    print ("proprietà primarie:")
    for string ,value in pairs() do
        self.primary[string] = value
        print("proprieta ".. string .. "aggiunta alla skill")
    end

    function self:castSkill(caster,targets)
        for key, value in pairs(self.primary) do
            print(key)
            value()
        end
    end

    return self
end