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

-----------------------------------------------------------------------------------------

-- funzione start
local function startRelease( event )
    if ( "ended" == event.phase ) then
        print( "scegli il livello" )
        composer.gotoScene("timeLineScrollView", {effect ="fade", time= 200})
    end
end

local function optionRelease( event )
    if ( "ended" == event.phase ) then
        print( "opzioni" )
        composer.showOverlay( "options", { isModal = true, effect = "slideRight", time = 200 } )
    end
end

-- funzione per verificare se funziona il pulsante
local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
    end
end

-- Custom function for resuming the game (from pause state)
function scene:resumeGame()
    -- Code to resume game
end

-----------------------------------------------------------------------------------------

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

    local background = display.newImageRect(backGroup,"img/sfondo_spacecartoon.jpg",480*1.2,320*1.2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local tlfText = display.newImage(backGroup, "img/tlf-1.png")
    tlfText.x = display.contentCenterX
    tlfText.y = display.contentCenterY-95

    local startButton = widget.newButton(
       {
            id = "startButton",
            defaultFile = "img/start.png",
            overFile = "img/startover.png",
            onRelease = startRelease
      }
    )
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY+10

    uiGroup:insert(startButton)

    local tutorialButton = widget.newButton(
        {
            id = "tutorialButton",
            defaultFile = "img/tutorial.png",
            overFile = "img/tutorialover.png",
            onEvent = handleButtonEvent
        }
    )
    tutorialButton.x = display.contentCenterX-180
    tutorialButton.y = display.contentCenterY+116

    uiGroup:insert(tutorialButton)

    local optionsButton = widget.newButton(
        {
            id = "optionsButton",
            defaultFile = "img/opt.png",
            overFile = "img/optover.png",
            width = 50,
            height = 50,
            onRelease = optionRelease
        }
    )
    optionsButton.x = display.contentCenterX+230
    optionsButton.y = display.contentCenterY+120

    uiGroup:insert(optionsButton)

    local character = display.newImageRect(mainGroup,"img/characters/illustratorSX.png",45,70)
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