local composer = require("composer")

local characters =
{--1 (player)
    { --properties
    img = "img/illustratorDX.png",
    imgSX = "img/illustratorSX.png",
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
    img = "img/father_Time_DX.png",
    imgSX = "img/father_Time_SX.png",
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
        img = "img/philosopher_DX.png",
        imgSX = "img/philosopher_SX.png",
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
        img = "img/socrates_DX.png",
        imgSX = "img/socrates_SX.png",
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
        img = "img/zeus_DX.png",
        imgSX = "img/zeus_SX.png",
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
composer.setVariable("characters", characters)


--local CharactersCollection = {}
  --Funzione per copiare tabelle in modo ricorsivo
--local function deepcopy(orig)
  --local orig_type = type(orig)
  --local copy
  --if orig_type == 'table' then
      --copy = {}
      --for orig_key, orig_value in next, orig, nil do
          --copy[deepcopy(orig_key)] = deepcopy(orig_value)
      --end
      --setmetatable(copy, deepcopy(getmetatable(orig)))
  --else -- number, string, boolean, etc
      --copy = orig
  --end
  --return copy
--end

--copia una tabella char in CharactersCollection
--function AddCharToCollection (char)
 --local newChar = deepcopy(char)
 --table.insert(CharactersCollection, newChar)
--end

--AddCharToCollection(characters[1])
--composer.setVariable("charsCollection", charsCollection)

