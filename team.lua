-----------------------------------------------------------------------------------------
--
-- team.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

local personaggiBase = composer.getVariable("personaggiBase")


--Container scrollView
local container

--Vari gruppi
local backGroup
local mainGroup
local uiGroup
local teamGroup

--Table per oggetti dentro scrollView
local scrollTable = {}

--Table del team
local teamTable = {}

--Table delle posizioni
local spotTable = {}


local function onTouchEvent( event )
  
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. event.target.id )
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
    return true
end


	-- scrollView listener
	local function scrollListener( event )
		local phase = event.phase
		local direction = event.direction

		if "began" == phase then
			print( "Began.scrollListener" )
		elseif "moved" == phase then
			print( "Moved.scrollListener" )
		elseif "ended" == phase then
			print( "Ended.scrollListener" )
		end

		-- If the scrollView has reached its scroll limit
		if event.limitReached then
			if "up" == direction then
				print( "Reached Top Limit" )
			elseif "down" == direction then
				print( "Reached Bottom Limit" )
			elseif "left" == direction then
				print( "Reached Left Limit" )
			elseif "right" == direction then
				print( "Reached Right Limit" )
			end
		end
		return true
	end


-- Custom function for resuming the game (from pause state/overlay scene)
function scene:resumeGame()
    -- Code to resume game
end

-- Options table for the overlay scene "pause.lua"

local function clearScrollTable()
       if(#scrollTable ~= 0) then
      
        local obj
        
        for i = #scrollTable,1,-1 do
          obj = scrollTable[i]
          table.remove(scrollTable,i)
          display.remove(obj)
          obj = nil
        end
      end

  end
   
local function rimuoviChar(char)
  
  char:removeEventListener("touch",onCharTap)
  mainGroup:remove(char)
  scrollTable:remove(char)
  char.x = spotTable[#teamTable].x
  char.y = spotTable[#teamTable].y
  teamGroup:insert(char)
  

end

local function onUsaTap(event)
  
    local char = event.target.char
    local prevXchar = char.x
    local prevYchar = char.y
    local selectedSpot
   
    clearScrollTable()
    
    table.insert(teamTable,char)
    
    rimuoviChar(char)
    
    print(char.infoChar.nome)
    
    return true
end
 
local function onInfoTap(event)
  local char = event.target.char
  print(char.infoChar.nome)
    composer.showOverlay("infoChar",{effect = "fade",time = 200, isModal = true, params = char})
    return true
end


local function onCharTap(event)
    
    if ( event.phase == "began" ) then
         clearScrollTable()

        print( "Touch event began on: " .. event.target.infoChar.nome )
        
        --Sfondo di selezione: scuro, trasparente, dietro il char
        local popUpBox = display.newRoundedRect(mainGroup,event.target.x ,event.target.y + 18,50,120,20)
        popUpBox:setFillColor(0,0,0)
        popUpBox.alpha = 0.5
        popUpBox:toBack()
        
        --inserisco nella scrollTable per pulire dopo
        table.insert(scrollTable,popUpBox)
        
        local infoButton = widget.newButton(
            {
                label = "info",
                onRelease = onInfoTap,
                emboss = false,
                -- Properties for a rounded rectangle button
                shape = "roundedRect",
                width = 60,
                height = 30,
                cornerRadius = 15,
                fillColor = { default={0,0,1,1}, over={0,0.1,0.7,0.4} },
                strokeColor = { default={0.3,0.4,1,1}, over={0.5,0.5,1,0.8} },
                strokeWidth = 4,
                --char = {}
            }
        )  
        infoButton.x = event.target.x 
        infoButton.y = event.target.y + 30
        infoButton.char = event.target
        table.insert(scrollTable,infoButton)
        mainGroup:insert(infoButton)
        
        local usaButton = widget.newButton(
            {
                label = "Usa",
                onRelease = onUsaTap,
                emboss = false,
                -- Properties for a rounded rectangle button
                shape = "roundedRect",
                width = 60,
                height = 30,
                cornerRadius = 15,
                fillColor = { default={0,0,1,1}, over={0,0.1,0.7,0.4} },
                strokeColor = { default={0.3,0.4,1,1}, over={0.5,0.5,1,0.8} },
                strokeWidth = 4,
                infoChar = {}
            }
        )  
        table.insert(scrollTable,usaButton)
        usaButton.x = event.target.x 
        usaButton.y = event.target.y + 63
        usaButton.char = event.target
        mainGroup:insert(usaButton)
      end
    return true

end

 local function creaScrollableView()
    --3 personaggi per riga
  
    local xPrimoChar =  40
    local yPrimoChar =  50
    
    local j = 1
    --seleziona un personaggio alla volta
    for i = #personaggiBase,1,-1 do
      
      --se è disponibile lo inserisco nella scrollView
        if(personaggiBase[i].isDisponibile == true) then
          
          local char = display.newImageRect(mainGroup,personaggiBase[i].img,45,70)
          char.infoChar =personaggiBase[i]
          char.x = xPrimoChar + 70*(j-1)
          char.y = yPrimoChar 
          
          char:addEventListener("touch",onCharTap)
        
          local charText = display.newText(mainGroup,char.infoChar.nome,char.x,char.y+45, native.systemFontBold,12)
        
          if(j%3 == 0) then
            j = 0
            yPrimoChar = yPrimoChar+ 100
          end
          j = j+1
        end
    end
  end



function scene:create( event )

    -- Assign "self.view" to local variable "sceneGroup" for easy reference
    local sceneGroup = self.view
    
    
    -- Set up display groups
    backGroup = display.newGroup()  -- Display group for the background image
    sceneGroup:insert( backGroup )  -- Insert into the scene's view group
 
    
    mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
    sceneGroup:insert( mainGroup )  -- Insert into the scene's view group
    
    popUpGroup = display.newGroup()
    sceneGroup:insert(popUpGroup)
    
    teamGroup = display.newGroup()
    sceneGroup:insert(teamGroup)
    
    uiGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
    


    local background  = display.newImageRect(backGroup,"img/sfondoMenu1.png",1920 , 1080 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    
    --container per i personaggi
    container = display.newContainer(display.contentWidth/2 ,display.contentHeight)
    
    --local bgContainer = display.newRect(display.contentCenterX,display.contentCenterY,container.width,container.height)
    --bgContainer.strokeWidth = 5
    --bgContainer:setStrokeColor(red)
    --container:insert(bgContainer,true)
    container:translate( display.contentWidth*0.9, display.contentHeight*0.5 )
    
  
  
    --titolo della schermata (da rimuovere)
    local titolo = display.newText( backGroup,"Team",100, 100, native.systemFont,30)
    titolo.x = display.contentCenterX
    titolo.y = display.contentCenterY *0.3
    
    
        	-- Create a scrollView
	 local scrollView = widget.newScrollView {
		width = container.width,
    left = -container.width/2,
		height = container.hieght,
    top = -container.height/2,
    --scrollHeight = parent.height,
    --backgroundColor = {1,0,0},
		--isBounceEnabled = false,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		hideBackground = true,
		listener = scrollListener
	}
  container:insert(scrollView)

    
    local halfW = display.contentWidth * 0.5
    local halfH = display.contentHeight * 0.5
 
 
    -- vertici per le shape : x,y dispetto il centro dello spot
    local vertices = {40,20 , 20,-20 , -40,-20, -20,20 }
     
    -- creo gli spot
    --spot centro-sinistra
    local spot21 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot21.strokeWidth = 2
    spot21:setFillColor(0.7, 0.7, 0.7  )
    spot21:setStrokeColor( 0.2, 0.2, 0.2 )
    spot21.x = 40
    spot21.y = 180
    spot21.alpha = 0.8
    spot21.id = "middle-left spot"
    table.insert(spotTable,3,spot21)
    spot21:addEventListener("touch",onTouchEvent)
    
    --spot centro-destra
    local spot22 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot22.strokeWidth = 2
    spot22:setFillColor(0.5, 0.5, 0.5 )
    spot22:setStrokeColor( 0.2, 0.2, 0.2 )
    spot22.x = spot21.x + 100
    spot22.y = spot21.y
    spot22.alpha = 0.8
    table.insert(spotTable,4,spot22)



    --spot alto-sinistra
    local spot11 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot11.strokeWidth = 2
    spot11:setFillColor(0.7, 0.7, 0.7  )
    spot11:setStrokeColor( 0.2, 0.2, 0.2 )
    spot11.x = spot21.x - 20
    spot11.y  = spot21.y - 70
    spot11.alpha = 0.8
    table.insert(spotTable, 1,spot11)

    
    --spot alto-destra
    local spot12 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot12.strokeWidth = 2
    spot12:setFillColor(0.5, 0.5, 0.5  )
    spot12:setStrokeColor( 0.2, 0.2, 0.2 )
    spot12.x =  spot22.x - 20 
    spot12.y = spot11.y
    spot12.alpha = 0.8
    table.insert(spotTable,2,spot12)

    --spot basso-sinistra
    local spot31 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot31.strokeWidth = 2
    spot31:setFillColor(0.7, 0.7, 0.7  )
    spot31:setStrokeColor( 0.2, 0.2, 0.2 )
    spot31.x = spot21.x + 20
    spot31.y = spot21.y + 70
    spot31.alpha = 0.8
    table.insert(spotTable,5,spot31)

    --spot basso-destra
    local spot32 = display.newPolygon( backGroup,halfW, halfH, vertices )
    spot32.strokeWidth = 2
    spot32:setFillColor(0.5, 0.5, 0.5  )
    spot32:setStrokeColor( 0.2, 0.2, 0.2 )
    spot32.x = spot22.x + 20
    spot32.y = spot22.y + 70
    spot32.alpha = 0.8
    table.insert(spotTable,6,spot32)
    
  
  

    creaScrollableView()

    scrollView:insert(mainGroup)

    sceneGroup:insert(container)
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        print("... scene:show from will to -> did")
        clearScrollTable()
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
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
