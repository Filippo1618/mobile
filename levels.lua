local composer = require("composer")

local characters = composer.getVariable("charsCollection")

local levels = {}
levels["nessuno"] = { characters[1] }
levels["medioevo"] = { characters[2],characters[2],characters[3] }
levels["rinascimento"] = { characters[3],characters[3],characters[4] }
levels["risorgimento"] = { characters[4],characters[4],characters[5] }

local lvl_selected = levels["nessuno"]

composer.setVariable("levels", levels)
composer.setVariable("lvl_selected", lvl_selected)

