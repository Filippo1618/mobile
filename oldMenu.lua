-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require( "composer" )
local widget = require("widget")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local mainGroup
 local backGroup
 local uiGroup
 
  -- Function to handle button events
local function giocaRelease( event )
 
    if ( "ended" == event.phase ) then
        print( "si gioca" )
        composer.gotoScene("timeLineScrollView",{effect ="fade", time= 200})
    end
end

 -- Function to handle button events
local function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
     
    local sceneGroup = self.view
 
    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)
    
    mainGroup = display.newGroup()
    sceneGroup:insert(mainGroup)
    
    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)
    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local background = display.newImageRect(backGroup,"img/sfondo480-320.png",480*1.2,320*1.2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    
-- Create the widget
local button1 = widget.newButton(
    {
        fontSize = 40,
        emboss = true,
        id = "button1",
        label = "GIOCA",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        onRelease = giocaRelease
    }
) 
-- Center the button
button1.x = display.contentCenterX
button1.y = display.contentCenterY -30
 
uiGroup:insert(button1)

-- Create the widget
local button2 = widget.newButton(
    {
        fontSize = 30,
        emboss = true,
        id = "button2",
        label = "Tutorial",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        onEvent = handleButtonEvent
    }
) 
-- Center the button
button2.x = button1.x
button2.y = button1.y + button1.height + 10
 
uiGroup:insert(button2)

-- Create the widget
local button3 = widget.newButton(
    {
        fontSize = 30,
        emboss = true,
        id = "button3",
        label = "Impostazioni",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        onEvent = handleButtonEvent
    }
) 
-- Center the button
button3.x = button2.x
button3.y = button2.y + button2.height
 
uiGroup:insert(button3)


local character = display.newImageRect(mainGroup,"img/IllustratorSX.png",45,70)
character.x = display.contentWidth*4/5
character.y = display.contentHeight*2/3


end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
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