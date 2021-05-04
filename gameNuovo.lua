-----------------------------------------------------------------------------------------
--
-- gameNuovo.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
     -- Code here runs when the scene is first created but has not yet appeared on screen

    local sceneGroup = self.view

    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)

    vsTeamGroup = display.newGroup()
    sceneGroup:insert(vsTeamGroup)

    ourTeamGroup = display.newGroup()
    sceneGroup:insert(ourTeamGroup)

    mainGroup = display.newGroup()
    sceneGroup:insert(mainGroup)

    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)

    local background = display.newImageRect(backGroup,"img/sfondo480-320.png",480*1.2,320*1.2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
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
        composer.removeScene("menu")
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
