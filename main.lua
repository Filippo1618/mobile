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


local composer = require("composer")

-----------------------------------------------------------------------------------------
--
-- characters.lua
--
-----------------------------------------------------------------------------------------

local characters =
{
    --1 (player)
    { --properties
    img = "img/characters/illustratorDX.png",
    imgSX = "img/characters/illustratorSX.png",
    name = "player",
    type = "neutral",
    isAvailable = true,
    baseStat = {
        lvl = 1,
        hp = 100,
        mana = 100,
        atk = 50,
        def = 50,
        vel = 100,
        bonusHeal = 0,
        bonusDmg = 0,
        manaRegen = 10,
        hpRegen = 5
    },
    skills =
    { passive =
      { --1
        {
            imgPath = "img/sword.jpg",
            name = "furia",
            description = "incremento attacco di 10",
            atk = 10,
            attiva = true,
            isActive = true,
          },
        --2
        {
            imgPath = "img/shield.jpg",
            name = "fermezza",
            effetti = "incremento difesa di 10",
            def = 10,
            attiva = false,
            isActive = false,
        },
        { --3
            imgPath = "img/helmet.jpg",
            name = "paura",
            effetti = "incremento velocita di 10",
            vel = 10,
            attiva = false,
            isActive = false,
          },
      },
      active =
      { --1
        {
          name = "A1",
          type = "dmg",
          desc = "attacco a target singolo; puo attaccare un Character solo sulla la prima fila",
          target = {"frontLine"},
          manaCost = 10,
          --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
          --onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        --2
        {
          name = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 50,
          manaCost = 70,
          desc = "attacco a target singolo, puo attaccare un Characters solo sulla la seconda fila",
          target = {1,"backLine"},
        },
        }
      }
    },
    --2
    {
    img = "img/characters/father_Time_DX.png",
    imgSX = "img/characters/father_Time_SX.png",
    name = "Father",
    type = "neutral",
    isAvailable = false,
    baseStat = {
        lvl = 1,
        hp = 100,
        mana = 100,
        atk = 100,
        def = 100,
        vel = 100,
        manaRegen = 10,
        hpRegen = 5,
        bonusHeal = 0,

    },
    skills =
    { passive =
      { --1
        {
          name = "furia",
          description = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg",
          isActive = true,
          },
        { --2
          name = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg",
          isActive = false,
        },
        { --3
          name = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg",
          isActive = false,
          },
      },
      active =
      { --1
        {
          name = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 50,
          desc = "attacco a target singolo; puo attaccare un Character solo sulla la prima fila",
          target = {"frontLine"},
          manaCost = 10,
          --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        --2
        {
          name = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 50,
          manaCost = 70,
          desc = "attacco a target singolo; puo attaccare un Character solo sulla la seconda fila",
          target = {"backLine"},
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        }
      },
    },
    --3
    {
        img = "img/characters/philosopher_DX.png",
        imgSX = "img/characters/philosopher_SX.png",
        name = "philosopher",
        type = "neutral",
        isAvailable = false,
        baseStat = {
            lvl = 1,
            hp = 100,
            mana = 100,
            atk = 100,
            def = 20,
            vel = 60,
            manaRegen = 10,
            hpRegen = 5,    
            bonusHeal = 0,
        },
        skills =
        { passive =
          { --1
            {
              name = "furia",
              description = "incremento attacco di 10",
              atk = 10,
              attiva = true,
              imgPath = "img/sword.jpg",
              isActive = true,
              },
            { --2
              name = "fermezza",
              effetti = "incremento difesa di 10",
              def = 10,
              attiva = false,
              imgPath = "img/shield.jpg",
              isActive = false,
            },
            { --3
              name = "paura",
              effetti = "incremento velocita di 10",
              vel = 10,
              attiva = false,
              imgPath = "img/helmet.jpg",
              isActive = false,
              },
          },
          active =
          { --1
            {
              name = "A1",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la prima fila",
              target = {"frontLine"},
              manaCost = 10,
              --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            --2
            {
              name = "A2",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              manaCost = 70,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la seconda fila",
              target = {"backLine"},
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end        
            },
            }
          }
    },
    --4
    {
        img = "img/characters/socrates_DX.png",
        imgSX = "img/characters/socrates_SX.png",
        name = "socrates",
        type = "neutral",
        isAvailable = true,
        baseStat = {
            lvl = 1,
            hp = 100,
            mana = 100,
            atk = 100,
            def = 20,
            vel = 80,
            bonusHeal = 0,
        },
        skills =
        { passive =
          { --1
            {
              name = "furia",
              description = "incremento attacco di 10",
              atk = 10,
              attiva = true,
              imgPath = "img/sword.jpg",
              isActive = true,
              },
            { --2
              name = "fermezza",
              effetti = "incremento difesa di 10",
              def = 10,
              attiva = false,
              imgPath = "img/shield.jpg",
              isActive = false,
            },
            { --3
              name = "paura",
              effetti = "incremento velocita di 10",
              vel = 10,
              attiva = false,
              imgPath = "img/helmet.jpg",
              isActive = false,
              },
          },
          active =
          { --1
            {
              name = "A1",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la prima fila",
              target = {"frontLine"},
              manaCost = 10,
              --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            --2
            {
              name = "A2",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              manaCost = 70,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la seconda fila",
              target = {"backLine"},
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end        
            },
            }
          }
    },
    --5
    {
        img = "img/characters/zeus_DX.png",
        imgSX = "img/characters/zeus_SX.png",
        name = "zeus",
        type = "neutral",
        isAvailable = true,
        baseStat = {
            lvl = 1,
            hp = 100,
            mana = 100,
            atk = 100,
            def = 20,
            vel = 100,
            bonusHeal = 0,
        },
        skills =
        { passive =
          { --1
            {
              name = "furia",
              description = "incremento attacco di 10",
              atk = 10,
              attiva = true,
              imgPath = "img/sword.jpg",
              isActive = true,
              },
            { --2
              name = "fermezza",
              effetti = "incremento difesa di 10",
              def = 10,
              attiva = false,
              imgPath = "img/shield.jpg",
              isActive = false,
            },
            { --3
              name = "paura",
              effetti = "incremento velocita di 10",
              vel = 10,
              attiva = false,
              imgPath = "img/helmet.jpg",
              isActive = false,
              },
          },
          active =
          { --1
            {
              name = "A1",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la prima fila",
              target = {"frontLine"},
              manaCost = 10,
              --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            --2
            {
              name = "A2",
              tipo = "dmg",
              team = "vs",
              dmg = 50,
              manaCost = 70,
              desc = "attacco a target singolo; puo attaccare un Character solo sulla la seconda fila",
              target = {"backLine"},
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end        
            },
            }
        }
    },
}

-- set the variable characters
--composer.setVariable("characters", characters)


local CharactersCollection = {}
  --Funzione per copiare tabelle in modo ricorsivo
local function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
          copy[deepcopy(orig_key)] = deepcopy(orig_value)
      end
      setmetatable(copy, deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
      copy = orig
  end
  return copy
end

--copia una tabella char in CharactersCollection
function AddCharToCollection (char)
 local newChar = deepcopy(char)
 table.insert(CharactersCollection, newChar)
end

AddCharToCollection(characters[1])
composer.setVariable("characters", charactersCollection)

-----------------------------------------------------------------------------------------
--
-- levels.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

--local characters = composer.getVariable("characters")

local lvl_charTable = {}
lvl_charTable["nessuno"] = { characters[1] }
lvl_charTable["medioevo"] = { characters[2],characters[2],characters[3] }
lvl_charTable["rinascimento"] = { characters[3],characters[3],characters[4] }
lvl_charTable["risorgimento"] = { characters[4],characters[4],characters[5] }
lvl_charTable["eta_moderna"] = { characters[5],characters[5],characters[5] }

local start_lvl = lvl_charTable["nessuno"]

composer.setVariable("lvl_charTable", lvl_charTable)
composer.setVariable("start_lvl", start_lvl)