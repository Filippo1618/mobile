-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--require ("mobdebug").start()
local composer = require "composer"
--display.setStatusBar( display.HiddenStatusBar )
display.setStatusBar( display.HiddenStatusBar )

local lunghezzaSchermo = display.contentWidth
local altezzaSchermo = display.contentHeight

local lvl_selected = "nessuno"
composer.setVariable("lvl_selected", lvl_selected)

composer.setVariable( "lunghezzaSchermo", lunghezzaSchermo )
composer.setVariable( "altezzaSchermo", altezzaSchermo )

local player =
  {
    img = "img/IllustratorDX.png",
    imgSX = "img/IllustratorSX.png",
    nome = "player",
    lvl = 1,
    hp = 100,
    atk = 100,
    def = 20,
    vel = 100,
    bonusHeal = 0,
    isDisponibile = false,
    mosse = 
    { passive =
      {
        {nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg"
          },
        {nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"
        },
        {nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg"
          },
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 50,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          manaCost = 10,
          --calcolaDanni = calcolaDannoStandard(playerCaster,skill,playerTarget)
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 50,
          manaCost = 70,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end        },
        {
          nome = "A3",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "vs",
          dmg = 120,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
          }
        }
      }
  }

composer.setVariable("player",player)

local personaggi = 
{ 
  --1
  {
    img = "img/personaggio_ignoto_DX.png",
    imgSX = "img/personaggio_ignoto_SX.png",
    nome = "father",
    lvl = 1,
    hp = 100,
    atk = 10,
    def = 10,
    pos = 1,
    vel = 20,
    bonusHeal = 0,
    isDisponibile = true,
    mosse = 
        { 
          passive =
          {
            {
              nome = "furia",
              effetti = "incremento attacco di 10",
              atk = 10,
              attiva = true,
              imgPath = "img/sword.jpg"
              },
            {nome = "fermezza",
              effetti = "incremento difesa di 10",
              def = 10,
              attiva = false,
              imgPath = "img/shield.jpg"
            },
            {nome = "paura",
              effetti = "incremento velocita di 10",
              vel = 10,
              attiva = false,
              imgPath = "img/helmet.jpg"
              }
          },
          attive = 
          {
            {
              nome = "A1",
              tipo = "dmg",
              team = "vs",
              dmg = 20,
              manaCost = 20,
              desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
              bersaglio = "primaFila",
            onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            {
              nome = "A2",
              tipo = "dmg",
              team = "vs",
              dmg = 20,
              manaCost = 20,
              desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
              bersaglio = "secondaFila",
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            {
              nome = "A3",
              tipo = "stato",
              team = "vs",
              dmg = 20,
              manaCost = 20,
              bersaglio = "singolo",
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            {
              nome = "A4",
              tipo = "dmg",
              team = "both",
              dmg = 80,
              manaCost = 0,
              bersaglio = "singolo",
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
            },
            {
              nome = "A5",
              tipo = "dmg",
              team = "vs",
              dmg = 120,
              manaCost = 0,
              bersaglio = "singolo",
              onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
              }
            }
          }
      },
  --2
  {
    img = "img/Philosopher_DX.png",
    imgSX = "img/Philosopher_SX.png",
    nome = "philosopher",
    lvl = 1,
    hp = 110,
    atk = 10,
    def = 40,
    pos = 2,
    vel = 0,
    bonusHeal = 0,
    isDisponibile = true,
    mosse = 
    { passive =
      {
        {nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg"
          },
        {nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"

        },
        {nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg"
          }
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A3",
          tipo = "stato",
          team = "vs",
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) local dmg = 100; dealDmgPlayer(playerTarget,dmg) end

        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
          }
        }
      }
  },
  --3
  {
    img = "img/Socrates_DX.png",
    imgSX = "img/Socrates_SX.png",
    nome = "Socrate",
    lvl = 1,
    hp = 150,
    atk = 30,
    def = 10,
    vel = 50,
    bonusHeal = 0,
    isDisponibile = true,
        mosse = 
    { passive =
      {
        {nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg"
          },
        {nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"
        },
        {nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg"
          }
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A3",
          tipo = "stato",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "self",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "both",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
          }
        }
      }
  },
  --4
  {
    img = "img/Father_Time_DX.png",
    imgSX = "img/Father_Time_SX.png",
    nome = "father",
    lvl = 1,
    hp = 100,
    atk = 50,
    def = 50,
    vel = 0,
    bonusHeal = 0,
    isDisponibile = true, 
    mosse = 
    { passive =
      {
        {nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg"
          },
        {nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"
        },
        {nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg"
          }
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A3",
          tipo = "stato",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          bersaglio = "self",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "both",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

          }
        }
      }
  },
  --5
  {
    img = "img/Galileo_DX.png",
    imgSX = "img/Galileo_SX.png",
    nome = "Galileo",
    lvl = 1,
    hp = 80,
    atk = 10,
    def = 50,
    vel = 5,
    bonusHeal = 0,
    isDisponibile = true,  
    mosse = 
    { passive =
      {
        {nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = true,
          imgPath = "img/sword.jpg"
          },
        {nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"
        },
        {nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = false,
          imgPath = "img/helmet.jpg"
          }
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A3",
          tipo = "stato",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "both",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
          }
        }
      }
},

  --6
  {
    img = "img/Einstein_DX.png",
    imgSX = "img/Einstein_SX.png",
    nome = "einstein",
    lvl = 1,
    hp = 300,
    atk = 60,
    def = 60,
    vel = 100,
    bonusHeal = 0.5,
    isDisponibile = true,
        mosse = 
        { 
      passive =
      {
        {
          nome = "furia",
          effetti = "incremento attacco di 10",
          atk = 10,
          attiva = false,
          imgPath = "img/sword.jpg"
          },
        {
          nome = "fermezza",
          effetti = "incremento difesa di 10",
          def = 10,
          attiva = false,
          imgPath = "img/shield.jpg"
        },
        {
          nome = "paura",
          effetti = "incremento velocita di 10",
          vel = 10,
          attiva = true,
          imgPath = "img/helmet.jpg"
          }
      },
      attive = 
      {
        {
          nome = "A1",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la prima fila",
          bersaglio = "primaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A2",
          tipo = "dmg",
          team = "vs",
          dmg = 20,
          manaCost = 20,
          desc = "attacco a bersaglio singolo; puo attaccare un personaggio solo sulla la seconda fila",
          bersaglio = "secondaFila",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A3",
          tipo = "stato",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end

        },
        {
          nome = "A4",
          tipo = "dmg",
          team = "both",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
        },
        {
          nome = "A5",
          tipo = "heal",
          team = "self",
          dmg = 20,
          manaCost = 20,
          bersaglio = "singolo",
          onCast = function(skill,spot,playerTarget) dealDmgPlayer(playerTarget,skill) end
          }
        }
      }
    },
--7
  {
    img = "img/Vichingo_DX.png",
    imgSX = "img/Vichingo_SX.png",
    nome = "odino",
    lvl = 1,
    hp = 110,
    atk = 90,
    def = 20,
    bonusHeal = 0.2,
    vel = 4,
    isDisponibile = true
},
--8
{
    img = "img/Shogun_DX.png",
    imgSX = "img/Shogun_SX.png",
    nome = "shogun",
    lvl = 1,
    hp = 200,
    atk = 10,
    def = 20,
    bonusHeal = 0.5,
    pos = 7,
    vel = 3,
    isDisponibile = true
},
--9
{
    img = "img/Redcoat_Female_DX.png",
    imgSX = "img/Redcoat_Female_SX.png",
    nome = "RedCoat",
    lvl = 1,
    hp = 130,
    atk = 35,
    def = 30,
    bonusHeal = 0.3,
    pos = 8,
    vel = 2,
    isDisponibile = true
},
--10
  {
    img = "img/God_DX.png",
    imgSX = "img/God_SX.png",
    nome = "dio",
    lvl = 1,
    hp = 1000,
    atk = 100,
    def = 100,
    bonusHeal = 0.5,
    pos = 9,
    vel = 1,
    isDisponibile = true
},
--11
{
    img = "img/Shogun_DX.png",
    imgSX = "img/Shogun_SX.png",
    nome = "shogun",
    lvl = 1,
    hp = 140,
    atk = 30,
    def = 30,
    bonusHeal = 0.5,
    isDisponibile = true,
    pos = 10,
    vel = 11
},
--12
{
    img = "img/Redcoat_Female_DX.png",
    imgSX = "img/Redcoat_Female_SX.png",
    nome = "RedCoat",
    lvl = 1,
    hp = 100,
    atk = 10,
    def = 50,
    bonusHeal = 0.5,
    pos = 11,
    vel = 12,
    disponibile = false
},
--13
{
    img = "img/Thief_Male_DX.png",
    imgSX = "img/Thief_Male_SX.png",
    nome = "ladro",
    lvl = 1,
    hp = 100,
    atk = 10,
    def = 50,
    bonusHeal = 0.5,
    pos = 12,
    vel = 13,
    disponibile = false
  }
}

composer.setVariable("personaggi", personaggi)

local lvl_charTable = {}
lvl_charTable["nessuno"] = {personaggi[1],personaggi[1]}
lvl_charTable["medioevo"] = {personaggi[2],personaggi[3],personaggi[4]}
lvl_charTable["rinascimento"] = {personaggi[5],personaggi[11],personaggi[7]}
lvl_charTable["risorgimento"] = {personaggi[8],personaggi[9],personaggi[10]}
lvl_charTable["eta_moderna"] = {personaggi[1],personaggi[1],personaggi[13]}

composer.setVariable("lvl_charTable", lvl_charTable)

local lvl_teamTable = {}
lvl_teamTable["medioevo"] = {player, personaggi[6]}
lvl_teamTable["rinascimento"] = {player, personaggi[6]}
lvl_teamTable["risorgimento"] = {player, personaggi[6]}
lvl_teamTable["eta_moderna"] = {player, personaggi[6]}

composer.setVariable("lvl_teamTable", lvl_teamTable)

-- Start at tab1
composer.gotoScene( "menu",{effect = "fade", time = 200} )
