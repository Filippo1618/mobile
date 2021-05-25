---@diagnostic disable: undefined-global

require("spots")
local widget = require "widget"

local function onCharInfo (event)
    local tempChar = event.target
    print("Char Listener: ")
    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus( tempChar )
        print( "Touch event began on: " .. tempChar.infoChar.name )
        print("myTurn: ".. tempChar.myTurn)
        --print("is enemy spot: ", tempChar.isEnemy)
        --print("is occuped: " , tempChar.isOccuped())
        for k,v in pairs(tempChar.infoChar.baseStat) do
            print(k .." = " .. v )
        end
    elseif event.phase == "moved" then
        print("moved ")
    elseif event.phase == "ended" or event.phase == "cancelled" then
        print( "Touch event ended on: " .. tempChar.infoChar.name )
        display.getCurrentStage():setFocus( nil )
    end
    return true
end

local function dragListener( event )
    local charTouched = event.target
    local initialSpot = charTouched.spot
    local spotOn = {}

    if ( event.phase == "began" ) then
        event.target.alpha = 0.5
        display.getCurrentStage():setFocus( event.target )
        print("initial spot = ".. initialSpot.id)
        --set initial coordinates
        charTouched.startX = charTouched.x
        charTouched.startY = charTouched.y

        --attiva spot di partenza
        initialSpot:setStrokeColor(0,0,1)
        allySpotsGroup:colorFreeSpots()

    elseif ( event.phase == "moved" ) then
        --charTouched.x = (event.x - event.xStart) + charTouched.startX
        --charTouched.y = (event.y - event.yStart) + charTouched.startY
        charTouched.x = event.x
        charTouched.y = event.y
        allySpotsGroup:resetSpotsColor()
        allySpotsGroup:colorFreeSpots()
        spotOn = getSpotOn(event.x,event.y)
        
        if(spotOn ~= nil) then
            if spotOn.isOccuped() then
                spotOn:setFillColor(1,0,0)
            else
                spotOn:setFillColor(0,0,1)
            end
        end

    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        
        charTouched.alpha = 1
        spotOn = getSpotOn(event.x,event.y)
        if(spotOn ~= nil and not spotOn.isOccuped() ) then
            charTouched:leaveFromSpot()
            charTouched:setOnSpot(spotOn)
            
          else
            charTouched.x = charTouched.startX
            charTouched.y = charTouched.startY
          end
  
        allySpotsGroup:resetSpotsColor()
        display.getCurrentStage():setFocus( nil )
    end
    return true
end

function AddCharListener(charGroup)
    for i = 1 , charGroup.numChildren do
        charGroup[i]:addEventListener("touch",onCharInfo)
    end
end
function RemoveCharListener(charGroup)
    for i = 1 , charGroup.numChildren do
        charGroup[i]:removeEventListener("touch",onCharInfo)
    end
end
function AddDragListener(charGroup)
    for i = 1 , charGroup.numChildren do
        charGroup[i]:addEventListener("touch",dragListener)
    end
end
function RemoveDragListener(charGroup)
    for i = 1 , charGroup.numChildren do
        charGroup[i]:removeEventListener("touch",dragListener)
    end
end

local standardColorView = {0.6,0.6,0.6}
local playerOnTurnColorView = {0,0.9,0}
local nextPlayerColorView = {0,0,1}

function NewFightCharacter ( properties, isEnemy )

    local self

    if isEnemy
        then  self = display.newImageRect( properties.imgSX, 35, 65)
        else  self = display.newImageRect( properties.img, 35, 65)
    end
    self.isEnemy = isEnemy
    self.isAlive = true
    self.infoChar = properties
    self.passiveSkillActive = 1
    self.spot = nil
    self.hpBar = {}
    self.manaBar = {}
    self.turnView = {}
    self.turnText = {}
    self.heAttacked = false
    self.nextToAttack = false
    self.passiveSkill = {}
    self.activeSkill = {}

    
    function self:changeSpotColor(color)
        self.spot:setFillColor(color)
    end

    function self:makeActiveSkills()
        local skills = self.infoChar.skills.active
        print("[character.makeSkills] chiamo newSkill ".. #skills .. " volte" )
        for i=1 , #skills do
            local skill = NewSkill(skills[i])
            print("[character.makeSkills]"..skill.name)
            print("[character.makeSkills]"..skill.desc)
            self.activeSkill[i] = skill
        end
    end

    
    function self:makeTurnDisplay()
        
        print("[char:makeTurnDisplay]creo turn display ".. self.infoChar.name.. " = " .. self.myTurn)
        self.turnView = display.newCircle(self.x + 40,self.y + 45, 12)
        self.turnView.alpha = 0.5
        self.turnView:setFillColor(0.6,0.6,0.6)
        
        self.turnText = display.newText(self.myTurn,self.x+ 40,self.y + 45,native.systemFont)
        self.turnText:setFillColor(1,1,1) --unpack(color)
        
        if self.isEnemy then
            self.turnView.x = self.x - 40
            self.turnView.y = self.y + 45
            self.turnText.x = self.x - 40
            self.turnText.y = self.y + 45
        end
    end
    
    function self:colorTurnDisplay(color)
        self.turnView:setFillColor(unpack(color))
    end
    
    function self:moveBars(spot) -- da settare in base a char non spot
        self.hpBar.x = spot.x
        self.hpBar.y = spot.y + 10
        self.manaBar.x = spot.x
        self.manaBar.y = spot.y + 20
    end
    
    function self:moveDisplayTurn()
        if self.isEnemy then 
            self.turnView.x = self.x - 40
            self.turnView.y = self.y + 45
            self.turnText.x = self.x - 40
            self.turnText.y = self.y + 45
        else
            self.turnView.x = self.x + 40
            self.turnView.y = self.y + 45
            self.turnText.x = self.x + 40
            self.turnText.y = self.y + 45
        end
    end

    function self:setOnSpot(spot)
        self.spot = spot
        self.x = spot.x
        self.y = spot.y - 30
        spot.occupedBy = self
        self:moveBars(spot)
        self:moveDisplayTurn()
    end

    function self:leaveFromSpot()
        self.spot.occupedBy = nil
        self.spot = nil
    end

    -- Set the progress to 100%
    function self:initHPBar()
        self.hpBar = widget.newProgressView(
            {
                left = 50,
                top = 200,
                width = 50,
                isAnimated = true
            }
        )
        self.hpBar:setProgress( 1 )
        self.hpBar.x = self.spot.x
        self.hpBar.y = self.spot.y + 10
        self.hpBar.alpha = 0.7
    end

    function self:initManaBar()
        self.manaBar = widget.newProgressView(
            {
                left = 50,
                top = 200,
                width = 50,
                isAnimated = true
            }
        )
        self.manaBar:setProgress( 1 )
        self.manaBar.x = self.spot.x
        self.manaBar.y = self.spot.y + 20
        self.manaBar.alpha = 0.7
    end

    function self:castSkill(skill,skillTargets)
    end

    function self:updateStat()
    end

    return self
end