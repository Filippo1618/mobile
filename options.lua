-----------------------------------------------------------------------------------------
--
-- options.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

local group

-----------------------------------------------------------------------------------------

local function turnBackRelease( event )
    if ( "ended" == event.phase ) then
        print( "menu, di nuovo" )
        composer.hideOverlay( {recycleOnly = true, effect = "slideRight", time = 300} )
    end
end

-- Slider listener
local function sliderListener( event )
    print( "Slider at " .. event.value .. "%" )
end

-----------------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view

    group = display.newGroup()
    sceneGroup:insert(group)

    local sfondo = display.newRect (display.contentCenterX, display.contentCenterY, display.contentWidth*1.2, display.contentHeight)
    sfondo: setFillColor(0,0,0,0.5)
    group: insert(sfondo)

    local background = display.newImage("img/optmenu.png", display.contentCenterX, display.contentCenterY)
    background.width = display.contentWidth
    group: insert(background)

    local volumeText = display.newText(
        {
            fontSize = 30,
            text = "Volume",
            x = display.contentCenterX-140,
            y = display.contentCenterY,
        }
    )
    volumeText:setFillColor(255,140,0)
    group:insert(volumeText)

    local resumeButton = widget.newButton(
        {
            fontSize = 25,
            id = "resumeButton",
            label = "indietro",
            labelColor = { default={ 255,140,0 }, over={ 75,0,130 } },
            onRelease = turnBackRelease
        }
    )
    resumeButton.x = display.contentCenterX+165
    resumeButton.y = display.contentCenterY+90
    group:insert(resumeButton)

    local volumeSlider = widget.newSlider(
        {
            x = display.contentCenterX+60,
            y = display.contentCenterY,
            width = 200,
            value = 50,  -- Start slider at 50% (optional)
            listener = sliderListener
        }
    )
    group:insert(volumeSlider)

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
    local parent = event.parent  -- Reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        parent:resumeGame()
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