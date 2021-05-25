
function NewSkill( properties )
    local self = {}

    print ("[skill.NewSkill] proprietà skill:")
    for key ,value in pairs( properties ) do
        self[key] = value
    end

    function self:castSkill(caster,targets)
    end
    
    return self
end