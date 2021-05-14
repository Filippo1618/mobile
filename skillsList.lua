-----------------------------------------------------------------------------------------
--
-- skillsList.lua
--
-----------------------------------------------------------------------------------------

local skills = {

    ["passiva"] = {
        --1
        {
            name = "superArmatura",
            description = "il team ha un bonus armatura",
            value = 10,
        },
        --2
        {
            name = "superVelocita",
            description = "il team ha un bonus velocita",
            value = 10,
        },
        --3
        {
            name = "superAttacco",
            description = "il team ha un bonus attacco",
            value = 10,
        },
    },
    ["attacco"] =
        --1
        {
            name = "spadata",
            description = "attacco di spada",
            value = 20,
        },
        --2
        {
            name = "pallaDiFuoco",
            description = "attacco magico di fuoco",
            value = 30,
        },
    ["difesa"] =
        --1
        {
            name = "armaturaSingolo",
            description = "aumenta la propria difesa",
            value = 15,
        },
        --2
        {
            name = "armaturaMultipla",
            description = "aumenta la difesa del team",
            value = 5,
        },
        --3
        {
            name = "curaSingolo",
            description = "cura un personaggio",
            value = 50,
        },
        --4
        {
            name = "curaMultipla",
            description = "cura il team",
            value = 20,
        },
        --5
        {
            name = "velocitaSingolo",
            description = "aumenta la propria velocita",
            value = 15,
        },
        --6
        {
            name = "velocitamultipla",
            description = "aumenta la velocita del team",
            value = 5,
        },
        ["speciale"] =
        --1
        {
            name = "attaccoFrontline",
            description = "attacca la frontline nemica",
            value = 10,
        },
        --2
        {
            name = "attaccoBackline",
            description = "attacca la backline nemica",
            value = 10,
        },
        --3
        {
            name = "attacco121",
            description = "attacca il primo e il terzo in frontline, il secondo in backline",
            value = 10,
        },
        --4
        {
            name = "attacco212",
            description = "attacca il primo e il terzo in backline, il secondo in frontline",
            value = 10,
        },
        --5
        {
            name = "attaccoPrimaRiga",
            description = "attacca la prima riga",
            value = 10,
        },
        --6
        {
            name = "attaccoSecondaRiga",
            description = "attacca la seconda riga",
            value = 10,
        },
        --7
        {
            name = "attaccoterzaRiga",
            description = "attacca la terza riga",
            value = 10,
        },
}