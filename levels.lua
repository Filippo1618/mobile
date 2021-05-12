local composer = require("composer")

local characters = composer.getVariable("characters")

local levels = {}
levels["nessuno"] = { characters[1] }
levels["medioevo"] = { characters[2],characters[2],characters[3] }
levels["rinascimento"] = { characters[3],characters[3],characters[4] }
levels["risorgimento"] = { characters[4],characters[4],characters[5] }

local start_lvl = levels["nessuno"]

composer.setVariable("levels", levels)
composer.setVariable("start_lvl", start_lvl)