require("skill")
local widget = require "widget"

function NewSkillsBar()
    local self = display.newGroup()
    local skillsRect = display.newRoundedRect(display.contentCenterX,290,display.contentWidth * 1.1,50, 10)
    self:insert(skillsRect)
    skillsRect:setFillColor(grey)
    skillsRect.alpha = 0.3
    skillsRect.y = 290

    local playerOnTurn --= player
    local passive = {}
    local active = {}

    function self:setPlayerOnTurn(char)
        playerOnTurn = char
    end

    local function activeSkillListener(event)
        local skill = event.target
        if ( event.phase == "began" ) then
            display.getCurrentStage():setFocus( skill )
            print( "SkillTouch event began on: " .. skill.stat.name )
        elseif ( event.phase == "ended" ) then
            local char = GetCharOn(event.x,event.y)
            if(char == nil ) then 
                print("non hai lanciato la skill su un besaglio valido!")
            else
                print( "SkillTouch event ended on character: " .. char.infoChar.name )
                print( "Skill: " .. skill.stat.name .. "\nCasted on: ".. char.infoChar.name)

                display.getCurrentStage():setFocus( nil )
            end
        elseif ( event.phase == "cancelled" ) then
            display.getCurrentStage():setFocus( nil )
        end
        return true
    end
    
    local function passiveSkillListener( event )
        local skill = event.target
        if ( event.phase == "began" ) then
            display.getCurrentStage():setFocus( skill )
            print( "Touch event began on: " .. skill.stat.name )
        elseif ( event.phase == "ended" ) then
            print( "Touch event ended on: " .. skill.stat.name )
            if skill == self:getPassiveSkillOn(event.x,event.y) then
                self:setPassive( skill.id )
            end
            display.getCurrentStage():setFocus( nil )
        elseif ( event.phase == "cancelled" ) then
            display.getCurrentStage():setFocus( nil )
        end
        return true
    end
    
    function self:resetPassive()
        for i = 1 , #passive do
            passive[i].strokeWidth = 0
        end
    end
    function self:getPassiveSkillOn(x,y)
        for i = 1, #passive do
            if (x >= passive[i].contentBounds.xMin) 
            and (x <=  passive[i].contentBounds.xMax) 
            and (y >=  passive[i].contentBounds.yMin) 
            and (y<= passive[i].contentBounds.yMax) then
                return passive[i]
            end
        end
        return nil
    end

    function self:getActiveSkillOn(x,y)
        for i = 1, #active do
            if (x >= active[i].contentBounds.xMin) 
            and (x <=  active[i].contentBounds.xMax) 
            and (y >=  active[i].contentBounds.yMin) 
            and (y<= active[i].contentBounds.yMax) then
                return active[i]
            end
        end
        return nil
    end
    
    function self:setPassive(n)
        self:resetPassive()
        playerOnTurn.passiveSkillActive = n
        print("hai attivato la skill passiva: " ..playerOnTurn.infoChar.skills.passive[n].name )
        passive[n].strokeWidth = 2
        passive[n]:setStrokeColor(0,0,1)
        --return  self.player.skills.passive[n]
    end
    
    function self:setSkills(player)
        local passiveSkills = playerOnTurn.infoChar.skills.passive
        local activeSkills = playerOnTurn.infoChar.skills.active
        local startingPassiveX = 20
        local startingActiveX = 250
        local y = 290
        
        for i=1, #passiveSkills do
            print(passiveSkills[i].imgPath,y)
            passive[i] = display.newImageRect(passiveSkills[i].imgPath,40,40)
            passive[i].id =  i
            passive[i].x = startingPassiveX + ((i-1)*50)
            passive[i].y = y
            passive[i].stat = passiveSkills[i]
            self:insert(passive[i])
            passive[i]:addEventListener("touch", passiveSkillListener)
        end
        self:setPassive(playerOnTurn.passiveSkillActive)
        --passive[player.passiveSkillActive].strokeWidth = 2
        --passive[player.passiveSkillActive]:setStrokeColor(0,0,1)
        
        for i=1, #activeSkills do
            active[i] = display.newRoundedRect(0,0,40,40,10)
            active[i].id = i
            active[i].x = startingActiveX + ((i-1)*50)
            active[i].y = y
            active[i].stat = activeSkills[i]
            self:insert(active[i])
        end
        self:setActiveListener()
    end

    function self:setActiveListener()
        for i = 1 , #active do
            active[i]:addEventListener("touch",activeSkillListener)
        end
    end

    
    function self:clearSkills ()
        for i = 1, #passive do
            passive[i]:removeSelf()
        end
        for i = 1 , #active do
            active[i]:removeSelf()
        end
    end
    return self
end