---@diagnostic disable: undefined-global


require("spots")
require("character")
require("skillsBar")
require("turnTable")
require("background")

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()

local backGroup
local enemySpotsGroup
local allySpotsGroup
local enemyTeamGroup
local allyTeamGroup
local skillsBarGroup
local spellGroup
local uiGroup
local listenerTable = {} --necessaria?
local turnTable = {}
local spotsTable = {} --?
local charsTable = {} --?
local playerOnTurn = {}
local battlePhase = "starting..."

local allySpotsCoord = {
    blt = {
        x = 40 ,
        y = 100,
    },
    blm = {
        x =  60,
        y = 170,
    },
    blb = {
        x = 80 ,
        y = 240,
    },
    flt = {
        x = 130 ,
        y = 100,
    },
    flm = {
        x = 150 ,
        y = 170,
    },
    flb = {
        x = 170 ,
        y = 240,
    },
}
local enemySpotsCoord = {
    blt = {
        x = 390 ,
        y = 100,
    },
    blm = {
        x = 410 ,
        y = 170,
    },
    blb = {
        x = 430 ,
        y = 240,
    },
    flt = {
        x = 300 ,
        y = 100,
    },
    flm = {
        x = 320 ,
        y = 170,
    },
    flb = {
        x = 340 ,
        y = 240,
    },
}

local gameOver = false

local chars = composer.getVariable("characters")
--local lvlChars ={chars[3],chars[4],chars[3]} --mandato come proprieta
local lvlChars = composer.getVariable("vsTeamTable")
local enemySpotsProperties = {
    isEnemy = true,
    type = {"blt","blm","blb","flt","flm","flb"},
    -- ecc ecc
}

local allySpotsProperties = {
    isEnemy = false,
    type = {"blt","blm","blb","flt","flm","flb"},
    -- ecc ecc
}

-----------------------------------------------------------------------------------------

local function getRandomSpots(n) --DA SPOSTARE IN SPOTS.LUA
    local rndArray ={}
    local sortArray = {}
    local i = 1
    for j = 1 , enemySpotsGroup.totalObj do
        sortArray[j] = j
        print("sortArray["..j.."] = " .. j)
    end
    while i <= n do
    local rnd = math.random(1,6)
        if sortArray[rnd] ~= nil then
            rndArray[i] = sortArray[rnd]
            table.remove(sortArray,rnd)
            i = i+1
        end
    end
    for j = 1 , n do
        print("rndArray["..j.."] = " .. rndArray[j])
    end
    return rndArray
end

local function getSpotOn(x,y) --DA SPOSTARE IN SPOTS.LUA
    for i = 1, allySpotsGroup.totalObj do
        if (x >= allySpotsGroup[i].contentBounds.xMin) 
        and (x <=  allySpotsGroup[i].contentBounds.xMax) 
        and (y >=  allySpotsGroup[i].contentBounds.yMin) 
        and (y<= allySpotsGroup[i].contentBounds.yMax) then
            return allySpotsGroup[i]
        end
    end
    return nil
end

function GetCharOn(x,y) --DA SPOSTARE IN character.LUA ??
    for i = 1, allyTeamGroup.totalObj do
        if (x >= allyTeamGroup[i].contentBounds.xMin) 
        and (x <=  allyTeamGroup[i].contentBounds.xMax) 
        and (y >=  allyTeamGroup[i].contentBounds.yMin) 
        and (y<= allyTeamGroup[i].contentBounds.yMax) then
            return allyTeamGroup[i]
        end
    end
    for i = 1, enemyTeamGroup.totalObj do
        if (x >= enemyTeamGroup[i].contentBounds.xMin) 
        and (x <=  enemyTeamGroup[i].contentBounds.xMax) 
        and (y >=  enemyTeamGroup[i].contentBounds.yMin) 
        and (y<= enemyTeamGroup[i].contentBounds.yMax) then
            return enemyTeamGroup[i]
        end
    end
    return nil
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
        --turnTable:updateTurnDisplay()
        display.getCurrentStage():setFocus( nil )
    end
    return true
end

local function addDragListener(teamGroup)
    for i=1 , teamGroup.numChildren do
        teamGroup[i]:addEventListener( "touch",dragListener)
    end
end
local function removeDragListener(teamGroup)
    for i=1 , teamGroup.numChildren do
        teamGroup[i]:removeEventListener( "touch",dragListener)
    end

end

local function makeEnemyTeam(lvlChars)
    local tempGroup = display.newGroup()
    local isEnemy = true
    local rndSpots = getRandomSpots(#lvlChars)
    for i=1 , #lvlChars do
        local tempAvatar = NewFightCharacter(lvlChars[i], isEnemy)
        tempAvatar:setOnSpot(enemySpotsGroup[rndSpots[i]])
        tempAvatar:initHPBar()
        tempAvatar:initManaBar()
        tempGroup:insert(tempAvatar)
    end
    tempGroup.totalObj = #lvlChars
    return tempGroup
end

local function makeAllyTeam(selectedTeam)
    local tempGroup = display.newGroup()
    local isEnemy = false
    local num = #selectedTeam
    local rndSpots = getRandomSpots(num)
    for i=1 , num do
        local tempAvatar = NewFightCharacter(selectedTeam[i], isEnemy)
        tempAvatar:setOnSpot(allySpotsGroup[rndSpots[i]])
        tempAvatar:initHPBar()
        tempAvatar:initManaBar()
        tempGroup:insert(tempAvatar)
    end
    tempGroup.totalObj = num
    return tempGroup
end

local function initCharsTable(allys, enemys)
    local chars = {}
    for i = 1, allys.totalObj do
        table.insert(chars,allys[i])
    end
    for i = 1 ,enemys.totalObj do
        table.insert(chars,enemys[i])
    end
   return chars
end

local function isGameOver()
    while not gameOver do
       for i = 1, allyTeamGroup.totalObj do
       end 
    end
    return gameOver
end

local function getPlayerOnTurn()
    local player = turnTable:getPlayerOnTurn()
    if player == nil then
        print("errore: nessun personaggio settato per il turno corrente ?!?!")
    end
    return player
end

local function gameLoop()
    --?? da fare in una funzione 
    turnTable.roundCount = 1

    turnTable:makeNewTurn()
    playerOnTurn = turnTable:getPlayerOnTurn()
    skillsBarGroup:setPlayerOnTurn(playerOnTurn)
    skillsBarGroup:setSkills(playerOnTurn)

end

local function handleStartFightButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released,\nStart the Fight!!!" )
        removeDragListener(allyTeamGroup)
        event.target:removeSelf()
        gameLoop()
    end
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    backGroup = NewBackground("img/sfondo.png")
    
    skillsBarGroup = NewSkillsBar()
    
    spellGroup = display.newGroup()
    
    uiGroup = display.newGroup()
    --creo gli spots (sono group object)
    enemySpotsGroup = NewGridSpots(enemySpotsProperties,enemySpotsCoord)
    allySpotsGroup = NewGridSpots(allySpotsProperties,allySpotsCoord)
    --aggiungo i listener agli spot
    enemySpotsGroup:addSpotListener()
    allySpotsGroup:addSpotListener()
    --creo i chars di ogni squadra e li metto nei rispettivi group object
    enemyTeamGroup = makeEnemyTeam(lvlChars)
    allyTeamGroup = makeAllyTeam(CharactersCollection)
    --inizio a creare i turni
    turnTable = NewTurnTable(uiGroup)
    charsTable = initCharsTable(enemyTeamGroup,allyTeamGroup)
    turnTable:initTurnTable(charsTable)
    turnTable:displayTurnPrevision()

    
    
    --skillsBarGroup:clearSkills()

    sceneGroup:insert(backGroup)
    sceneGroup:insert(enemySpotsGroup)
    sceneGroup:insert(allySpotsGroup)
    sceneGroup:insert(enemyTeamGroup)
    sceneGroup:insert(allyTeamGroup)
    sceneGroup:insert(spellGroup)
    sceneGroup:insert(skillsBarGroup)
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        --fightLoop()
        AddCharListener(enemyTeamGroup)
        addDragListener(allyTeamGroup) --NON POSSO SPOSTARLO PERCHE MI SERVE IL TEAMGROUP 
        
        local startFightButton = widget.newButton(
            {   -- pulsante di prova, provvisorio
                label = "Start Fight!",
                onEvent = handleStartFightButtonEvent,
                emboss = false,
                -- Properties for a rounded rectangle button
                shape = "roundedRect",
                width =80,
                height = 30,
                cornerRadius = 1,
                fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
                strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
                strokeWidth = 3,
                x = 0,
                y = 230,
                alpha = 0.6
            }
        )
        startFightButton:setFillColor(0.6,0.6,0.6)
        uiGroup:insert(startFightButton)
        
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
