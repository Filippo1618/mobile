-----------------------------------------------------------------------------------------
--
-- lvlCharTable.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

local characters = composer.getVariable("characters")

local lvlCharTable = {}
lvlCharTable["nessuno"] = { characters[1] }
lvlCharTable["medioevo"] = { characters[2],characters[2],characters[3] }
lvlCharTable["rinascimento"] = { characters[3],characters[3],characters[4] }
lvlCharTable["risorgimento"] = { characters[4],characters[4],characters[5] }
lvlCharTable["eta_moderna"] = { characters[5],characters[5],characters[5] }

local startLvl = lvlCharTable["nessuno"]

composer.setVariable("lvlCharTable", lvlCharTable)
composer.setVariable("startLvl", startLvl)
