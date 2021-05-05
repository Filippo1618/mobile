-----------------------------------------------------------------------------------------
--
-- option.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()

local group

local function turnBackRelease( event )
    if ( "ended" == event.phase ) then
        print( "menu, di nuovo" )
        composer.hideOverlay( {recycleOnly = true, effect = "fade", time = 200} )
    end
end


-- create()
function scene:create( event )

    local sceneGroup = self.view

    group = display.newGroup()
    sceneGroup:insert(group)

    local sfondo = display.newRect (display.contentCenterX,display.contentCenterY,display.contentWidth*1.2,display.contentHeight)
    sfondo: setFillColor(0,0,0,0.5)
    group: insert(sfondo)

    -- By some method such as a "resume" button, hide the overlay
    local resume = widget.newButton(
        {
            fontSize = 40,
            emboss = true,
            id = "buttonPlay",
            label = "indietro",
            onRelease = turnBackRelease
        }
    )
    resume.x = display.contentCenterX
    resume.y = display.contentCenterY
    group:insert(resume)

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
