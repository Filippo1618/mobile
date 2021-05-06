local composer = require("composer")

local characters = composer.getVariable("charsCollection")

local levels = {}
levels["nessuno"] =
{
    img = "img/sfondo_menu.png",
    enemies = { characters[1] }
}
levels["medioevo"] =
{
    img = "img/sfondo_medioevo.png",
    enemies = { characters[3],characters[3],characters[4] }
}
levels["rinascimento"] =
{
    img = "img/sfondo_rinascimento.png",
    enemies = { characters[4],characters[4],characters[2] }
}
levels["risorgimento"] =
{
    img = "img/sfondo_risorgimento.png",
    enemies = { characters[4],characters[4],characters[5] }
}

local lvl_selected = levels["nessuno"]

composer.setVariable("levels", levels)
composer.setVariable("lvl_selected", lvl_selected)

