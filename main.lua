-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--baseStatusBar setted to hide
display.setStatusBar( display.HiddenStatusBar )

local composer = require ("composer")

-- Start at menu
composer.gotoScene( "menu", {effect = "fade", time = 200} )