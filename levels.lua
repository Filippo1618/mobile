local composer = require("composer")

local characters = composer.getVariable("charsCollection")

local levels = {}
levels["nessuno"] = {characters[1],characters[2]}
levels["medioevo"] = {characters[3],characters[3],characters[4]}
levels["rinascimento"] = {characters[4],characters[4],characters[2]}
levels["risorgimento"] = {characters[4],characters[4],characters[5]}

local lvl_selected = levels["nessuno"]

composer.setVariable("levels", levels)
composer.setVariable("lvl_selected", lvl_selected)

