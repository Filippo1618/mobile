-----------------------------------------------------------------------------------------
--
-- levels.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

local characters = composer.getVariable("characters")

local lvl_charTable = {}
lvl_charTable["nessuno"] = { characters[1] }
lvl_charTable["medioevo"] = { characters[2],characters[2],characters[3] }
lvl_charTable["rinascimento"] = { characters[3],characters[3],characters[4] }
lvl_charTable["risorgimento"] = { characters[4],characters[4],characters[5] }
lvl_charTable["eta_moderna"] = { characters[5],characters[5],characters[5] }

local start_lvl = lvl_charTable["nessuno"]

composer.setVariable("lvl_charTable", lvl_charTable)
composer.setVariable("start_lvl", start_lvl)