-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

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

-- create()
-- Code here runs when the scene is first created but has not yet appeared on screen
function scene:create( event )

    local sceneGroup = self.view

    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)

    mainGroup = display.newGroup()
    sceneGroup:insert(mainGroup)

    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)

    local background = display.newImageRect(backGroup,"img/spacecartoon.jpg",480*1.2,320*1.2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local tlfText = display.newImage(backGroup, "img/tlf-1.png")
    tlfText.x = display.contentCenterX
    tlfText.y = display.contentCenterY-95

    local buttonPlay = widget.newButton(
       {
            fontSize = 40,
            emboss = true,
            id = "buttonPlay",
            defaultFile = "img/start.png",
            overFile = "img/startover.png",
            onRelease = giocaRelease
      }
    )
    buttonPlay.x = display.contentCenterX
    buttonPlay.y = display.contentCenterY+10

    uiGroup:insert(buttonPlay)

    local buttonTutorial = widget.newButton(
        {
            emboss = true,
            id = "buttonTutorial",
            defaultFile = "img/tutorial.png",
            overFile = "img/tutorialover.png",
            onEvent = handleButtonEvent
        }
    )
    buttonTutorial.x = display.contentCenterX-180
    buttonTutorial.y = display.contentCenterY+120

    uiGroup:insert(buttonTutorial)

    local buttonOption = widget.newButton(
        {
            emboss = true,
            width = 50,
            height = 50,
            id = "buttonOption",
            defaultFile = "img/opt.png",
            overFile = "img/optover.png",
            onEvent = handleButtonEvent
        }
    )
    buttonOption.x = display.contentCenterX+230
    buttonOption.y = display.contentCenterY+120

    uiGroup:insert(buttonOption)

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