-----------------------------------------------------------------------------------------
--
-- gameNuovo.lua
--
-----------------------------------------------------------------------------------------
--
-- Your code here

local composer = require( "composer" )
local widget = require("widget")
 
local scene = composer.newScene()

local lvl_charTable = composer.getVariable("lvl_charTable")
--local lvl_selected = composer.getVariable("lvl_selected")
local lvl_selected = "medioevo"
local personaggi = composer.getVariable("personaggi")
local player = composer.getVariable("player")
local vsTeamList = lvl_charTable[lvl_selected]
local vsTeamTable = {}
local vsSpotTable = {}
local ourSpotTable = {}
local lvl_teamTable = composer.getVariable("lvl_teamTable")
local preTeamTable = lvl_teamTable[lvl_selected]
local ourTeamTable = {}
local uiTable = {}
local secondi = 0
local minuti = 0
local decimi = 0
local t
local timeDisplay
local plyerOnTurn
local playerForTurn = {}
local isOver = false
local fightSpots = {} -- matrice 2x3x2 -> [squadra: 1/2 sinistra/destra][riga][colonna]
local mainGroup
local backGroup
local vsTeamGroup
local ourTeamGroup
local ourSpotGroup
local vsSpotGroup
local battleTable = {}
local turnTable = {}
local timeTable ={}
local uiGroup
local tableTargetList = {}

local function calcolaFrequenzaAttacco(vel)
    return 4 * (1 - vel/200)
end
--
local function checkIfInSpot(x,y)
  
 for r = 1, 3,1 do
   for c = 1,2,1 do
      if (x >= fightSpots[1][r][c].contentBounds.xMin) and (x <= fightSpots[1][r][c].contentBounds.xMax) and (y >= fightSpots[1][r][c].contentBounds.yMin) and (y<=fightSpots[1][r][c].contentBounds.yMax) then
        return fightSpots[1][r][c]
      end
    end
  end
  return nil
end
--
local function getSpotForSkill(x,y)
  
  for t = 1, 2,1 do
    for r = 1,3,1 do
      for c = 1,2,1 do
        if (x >= fightSpots[t][r][c].contentBounds.xMin) and (x <= fightSpots[t][r][c].contentBounds.xMax) and (y >= fightSpots[t][r][c].contentBounds.yMin) and (y<=fightSpots[t][r][c].contentBounds.yMax) then
          return fightSpots[t][r][c]
        end
      end
    end
  end
  return nil
end
--
local function attivaSpotDisponibiliPlayer()
  
  local occuped
  
  for r= 1,3,1 do
    for c=1,2,1 do
      occuped = fightSpots[1][r][c].isOccuped()
      if not occuped then
        fightSpots[1][r][c]:setStrokeColor(0,1,0)
      end
    end
  end
end
--
local function disattivaSpotDisponibili()
   
   for r = 1,3,1 do
     for c= 1,2,1 do
      fightSpots[1][r][c]:setStrokeColor(0.2, 0.2, 0.2)
    end
  end
end 
--
local function resettaColoreSpot()
    for t = 1, 2,1 do
      for r = 1,3,1 do
        for c=1,2,1 do
          fightSpots[t][r][c]:setFillColor(0.7, 0.7, 0.7)
          
        end
      end
    end
end

local function resettaTempColoreSpot()
    for t = 1, 2,1 do
      for r = 1,3,1 do
        for c=1,2,1 do
          fightSpots[t][r][c]:setFillColor(0.7, 0.7, 0.7)
          if fightSpots[t][r][c] == playerOnTurn.spot then
            fightSpots[t][r][c]:setFillColor(0.2, 0.2, 0.7)
          end
        end
      end
    end
end

--
local function resettaStrokeColorSpot()
    for t = 1, 2,1 do
      for r = 1,3,1 do
        for c=1,2,1 do
          fightSpots[t][r][c]:setStrokeColor( 0.2, 0.2, 0.2 )
        end
      end
    end
end
--
local function calcolo_danni()
    
end
--
local function attivaTuttiSpot(activableSpot)
  for t = 1, 2, 1 do
    for r = 1 , 3 , 1 do 
      for c = 1 , 2 , 1 do
        activableSpot[t][r][c] = true
      end
    end
  end
end
--
local function attivaPotentialSpotSkill(potentialSpot,color)
  
    for i = 1, #potentialSpot , 1 do
      potentialSpot[i]:setFillColor(unpack(color))
    end
    
end
--
local function attivaRealSpotSkill(realSpot)
  
  for i = 1 , #realSpot, 1 do
    
    local target = display.newImageRect(mainGroup,"img/frecce-convergenti-trasparenti.png",60,60)
    target.x = realSpot[i].x
    target.y = realSpot[i].y
    table.insert(tableTargetList,target)
    
  end

end
--
local function dragListener( event )
    
    local charTouched = event.target
    local playerTouched = charTouched.player
    local spotIniziale = playerTouched.spot
    
    if ( event.phase == "began" ) then
        event.target.alpha = 0.5
        -- Set focus on object
        display.getCurrentStage():setFocus( event.target )
        --set initial coordinates
        charTouched.startX = charTouched.x
        charTouched.startY = charTouched.y
        
        --attiva spot di partenza
        spotIniziale:setStrokeColor(0,0,1)
        
    elseif (event.phase  == "moved") then
      charTouched.x = (event.x - event.xStart) + charTouched.startX
      charTouched.y = (event.y - event.yStart) + charTouched.startY
      attivaSpotDisponibiliPlayer()

      spot = checkIfInSpot(event.x,event.y)
      
      if(spot ~= nil and (spot.isOccuped() == false)) then
        spot:setStrokeColor(1,0,0)
      end
      
   elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        
        event.target.alpha = 1
        
        spot = checkIfInSpot(event.x,event.y)        
        
        if(spot ~= nil and (spot.isOccuped() == false)) then
          charTouched.x = spot.x
          charTouched.y = spot.y- 20
          
          playerTouched.spot.occupedBy = nil
          
          charTouched.player.spot = spot
          spot.occupedBy = playerTouched
          
        else
          charTouched.x = charTouched.startX
          charTouched.y = charTouched.startY
        end
        -- Release focus on object
        display.getCurrentStage():setFocus( nil )
        disattivaSpotDisponibili()
    end
    return true
end
--
local function handleEnemyTouch( event )
   
   local enemyClicked = event.target
    display.getCurrentStage():setFocus( event.target )
    
    if ( "ended" == event.phase ) then
        print(enemyClicked.id .." pressed" )
        if(enemyClicked.player ~= nil) then
          print (enemyClicked.player.nome)
        end
    
    display.getCurrentStage():setFocus( nil )
    end
    return true
end
--
local function getIndicePrimaPassivaAttiva(player)
  
  local indicePassivaAttiva = 0
  
  for i = 1, #player.mosse.passive,1 do
    if player.mosse.passive[i].attiva then
      indicePassivaAttiva = i
    end
  end
  if indicePassivaAttiva == 0 then
    print "errore mossa passiva attiva = 0"
  end
  return indicePassivaAttiva
end
--
local function getPassivaAttiva(player)
  return player.passivaAttiva
end
--
local function setPassiva(player,numPassiva)
    
    player.mosse.passive[getPassivaAttiva(player)].attiva = false
    
    player.mosse.passive[numPassiva].attiva = true
    player.passivaAttiva = numPassiva
end
--
local function handleMossaPassivaTouch(event)
   
   if (event.phase == "ended") then      
      for i = 1, 3,1 do
        battleTable[i].strokeWidth = 0
      end
      event.target.strokeWidth = 3
      setPassiva(playerOnTurn, event.target.id)
    end
   return true
end
--
local function getNextTurnPlayer()
  
    local nPlayer
    local tPlayer
    local tempPlayer 
    
    local turn = 1
    local taMin
    local i = 1
    -- cero un valore non selezionato di ta min e imposto anche nP e tP
    while(playerForTurn[i].turno[turn].selected ) do
      turn = turn + 1
      if turn > 5 then
        turn = 1
        i = i + 1
      end
    end
      taMin = playerForTurn[i].turno[turn].tempo
      nPlayer = playerForTurn[i].indicePlayer
      tPlayer = turn    
      tempPlayer = playerForTurn[i]
    --cerco il minore tra tutti partendo dal primo tempo disponibile
    for p = 1 , #playerForTurn, 1 do
      local pturn = 1
      while(playerForTurn[p].turno[pturn].selected) do
        pturn = pturn + 1
      end
      if((pturn < 6) and (playerForTurn[p].turno[pturn].tempo < taMin) ) then
        taMin = playerForTurn[p].turno[pturn].tempo
        nPlayer = p
        tPlayer = pturn
        tempPlayer = playerForTurn[p]
      else
        print("errore piu di 5 turni selezionati")
      end
    end
  
  tempPlayer.turno[tPlayer].selected = true
  return tempPlayer
end
--
local function aggiornaTurnBar()
    
    --transazioni primo char
    transition.moveTo(turnTable[1],{ time=600 , x = 20})
    transition.fadeOut(turnTable[1],{ time=500 })
        
    for i = 2, #turnTable, 1 do
        transition.moveTo(turnTable[i],{time = 700, y =  turnTable[i-1].y})
    end
    
    turnTable[1] = nil

    for i = 2 , 5 , 1 do      
      turnTable[i-1] = turnTable[i]
      turnTable[i] = nil
    end
    turnTable[5] = nil
    
    local tempPlayer
    
    local nPlayer
    local tPlayer
    local img
    local turn = 1
    local taMin
    local i = 1
    
    -- cero un valore non selezionato di ta min e imposto anche nP e tP
    while(playerForTurn[i].turno[turn].selected ) do
      turn = turn + 1
      if turn > 5 then
        turn = 1
        i = i + 1
      end
    end
    taMin = playerForTurn[i].turno[turn].tempo
    nPlayer = playerForTurn[i].indicePlayer
    tPlayer = turn    
    
    --cerco il minore tra tutti partendo dal primo tempo disponibile
    for p = 1 , #playerForTurn, 1 do
      local pturn = 1
      while(playerForTurn[p].turno[pturn].selected) do
        pturn = pturn + 1
      end
      if((pturn < 6) and (playerForTurn[p].turno[pturn].tempo < taMin) ) then
        taMin = playerForTurn[p].turno[pturn].tempo
        nPlayer = p
        tPlayer = pturn
      end
    end
    
    playerForTurn[nPlayer].turno[tPlayer].selected = true
    tempPlayer = playerForTurn[nPlayer]
    
    if(tempPlayer.isEnemy) then
      img = tempPlayer.imgSX
    else
      img = tempPlayer.img
    end
    
    local newChar = display.newImageRect(uiGroup,img,20,35)
    newChar.alpha = 0
    newChar.x = uiTable[2].x -30
    newChar.y = 40
    --assegno all' immagine un attributo che è il player di riferimento
    newChar.player = tempPlayer

    turnTable[5] = newChar
    
    turnTable[5].indicePlayer = nPlayer
    turnTable[5].player = playerForTurn[nPlayer]
    turnTable[5].turno = playerForTurn[nPlayer].turno[tPlayer].numeroTurno
    turnTable[5].tempo = playerForTurn[nPlayer].turno[tPlayer].tempo

    
    print("aggiornaTurnBar()")
    print("playerVelocita minore : ".. tempPlayer.nome)
    transition.fadeIn(turnTable[5],{ time=500 })
    transition.moveTo(turnTable[5],{ time=850 , x = uiTable[2].x})
end
--
local function aggiornaTempiPlayer(player)
    
    player.turno[1] = nil
    
    for t = 2,5,1 do
      player.turno[t-1] =  player.turno[t]
      player.turno[t] = nil
    end
    player.turno[5] = {}
    player.turno[5].selected = false
    player.turno[5].tempo = player.turno[4].tempo + player.frequenzaAttacco
    player.turno[5].numeroTurno = player.turno[4].numeroTurno + 1
    player.nextTurn = player.frequenzaAttacco  
    player.turnD.remainingTime = player.frequenzaAttacco
    
end
--
local function rimuoviSkillListener()
  
  if (#battleTable ~= 0)then
    for i = 4 , #battleTable , 1 do
      battleTable[i]:removeEventListener("touch",handleMossaAttivaTouch)
    end
  end
end
--
local function resettaRealSpot()
 
 for i=1 , #tableTargetList, 1 do
    display.remove(tableTargetList[i])
    table.remove(tableTargetList[i])
    tableTargetList[i] = nil
  end
  
end
local function castSkillSpotPlayer(skill,spot,playerTarget)
   
  playerOnTurn.manaD.manaNow = playerOnTurn.manaD.manaNow - skill.manaCost
  playerOnTurn.manaD.text.text = playerOnTurn.manaD.manaNow .." / ".. playerOnTurn.manaD.manaMax
  skill.onCast(skill,spot,playerTarget)
    
end
local function getPlayerOnSpot(spot)
    return spot.occupedBy
end
local function matchWithRealTarget(spot,realTargetSpots)
  
  for i = 1, #realTargetSpots,1 do
    if realTargetSpots[i] == spot then
      return true
    end
  end
  
  return false
end

local function canCastSkill(skill,player)
  
  if skill.manaCost <= player.manaD.manaNow then 
    print ("posso lanciare")
    return true
  else
    print("i need more mana")
    return false
  end
end
local function aggiornaTurnBarAfterDead(playerDead)
  
  --rimuovo le imgTurn del giocatore morto 
  for i = 1 , #turnTable, 1 do

    if turnTable[i].player == playerDead then
      --rimuovo dal display
      display.remove(turnTable[i])
      --rimuovo dalla turnTable
      table.remove(turnTable,i)
      
    end
  end
  --aggiorno la disposizione delle restanti imgTurn
 
  --aggiungo le imgTurn mancanti in base al nextPlayer
  local imageDeleted = 5-#turnTable
  local imgPos = #turnTable
  if imageDeleted ~= 0 then
    local indiceAltezzaImgTurn = #turnTable
    for i = 1, imageDeleted, 1 do
      local nextPlayer = getNextTurnPlayer()
      local img
      
      if(tempPlayer.isEnemy) then
        img = tempPlayer.imgSX
      else
        img = tempPlayer.img
      end
      
      local turnImage = display.newImageRect(uiGroup,img,20,35)
      turnImage.alpha = 0
      turnImage.x = uiTable[2].x -30
      turnImage.y = uiTable[2].y + uiTable[2].height/2 - 30 - 43*(i+imgPos)
      --assegno all' immagine un attributo che è il player di riferimento
      turnImage.player = nextPlayer

      turnTable[5] = turnImage
      
      turnTable[5].indicePlayer = tempPlayer.indicePlayer
      turnTable[5].player = tempPlayer
      --turnTable[5].turno = playerForTurn[nPlayer].turno[tPlayer].numeroTurno
      --turnTable[5].tempo = playerForTurn[nPlayer].turno[tPlayer].tempo

    end
  end
end
--
local function removeDeadPlayer(playerTarget)
  
  display.remove(playerTarget.playerImage)
  display.remove(playerTarget.displayGroup)

  playerTarget.spot.occupedBy = nil
  playerTarget.spot = nil
  playerTarget.playerImage = nil
  
  aggiornaTurnBarAfterDead(playerTarget)
  --table.remove(playerForTurn,table.indexOf(playerForTurn,playerTarget))
end
--GLOBAL FUNCTION
function calcolaDannoStandard(playerCaster,skill,playerTarget)
  local dmg
  local moltiplicatore
  local atkCaster  = playerCaster.atk
  local defTarget = playerTarget.def
  local differenzaAtkDel = atkCaster - defTarget
  
  if differenzaAtkDel > 100 then
    differenzaAtkDel = 100
  elseif differenzaAtkDel < -90 then
    differenzaAtkDel = -90
  end
  
  if differenzaAtkDel == 0 then
    moltiplicatore = 1
  elseif differenzaAtkDel > 0 then
    moltiplicatore =  1 + differenzaAtkDel/100 
  elseif differenzaAtkDel < 0 then
    moltiplicatore = 1 - differenzaAtkDel/100
  end
  
  dmg = math.floor(skill.dmg * moltiplicatore)
  
  return dmg
end
function dealDmgPlayer(playerTarget,skill)
   
   local dmg = calcolaDannoStandard(playerOnTurn,skill,playerTarget)
   
   playerTarget.hpD.hpNow  = playerTarget.hpD.hpNow - dmg
   
    if playerTarget.hpD.hpNow <= 0 then
      playerTarget.hpD.hpNow = 0
      playerTarget.hpD.text.text = playerTarget.hpD.hpNow .." / " ..playerTarget.hpD.hpMax

      playerTarget.isDead = true
      removeDeadPlayer(playerTarget)
    else
      playerTarget.hpD.text.text = playerTarget.hpD.hpNow .." / " ..playerTarget.hpD.hpMax
    end
end

function healPlayer(playerTarget,skill)
    playerTarget.hpD.hpNow  = playerTarget.hpD.hpNow + heal
    if playerTarget.hpD.hpNow >= playerTarget.hpD.hpMax then
      playerTarget.hpD.hpNow = playerTarget.hpD.hpMax
    end
    playerTarget.hpD.text.text = playerTarget.hpD.hpNow .." / " ..playerTarget.hpD.hpMax

end

--END GLOBAL FUNCTION
local function handleMossaAttivaTouch(event)
  local phase = event.phase
  local rectSkill = event.target
  local skill = rectSkill.skill
  local spotTarget
  local playerTarget
  
  if(phase == "began") then
    display.getCurrentStage():setFocus( event.target )
    attivaPotentialSpotSkill(rectSkill.potentialTargetSpots,rectSkill.color)
    
  elseif (event.phase  == "moved") then
    attivaRealSpotSkill(rectSkill.realTargetSpots)
    
  elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
    local casted = false
    spotTarget = getSpotForSkill(event.x,event.y)
    
    if canCastSkill(skill,playerOnTurn) then
      if spotTarget ~= nil then
        if matchWithRealTarget(spotTarget,rectSkill.realTargetSpots) then
          playerTarget = getPlayerOnSpot(spotTarget)
          if playerTarget ~= nil then
           
            resettaStrokeColorSpot()
            resettaStrokeColorSpot()
            
            castSkillSpotPlayer(skill,spotTarget,playerTarget)
            
            aggiornaTempiPlayer(playerOnTurn)
            
            aggiornaTurnBar()
            casted = true
            timer.resume(t)
            
          end
        end
      end
    end
  
    resettaTempColoreSpot()
    resettaRealSpot()
    display.getCurrentStage():setFocus( nil )
    
    if casted then
      resettaColoreSpot()
    end
  end
  return true
end

local function compareVel(char1,char2)
  return char1.vel > char2.vel
end

local function compareFA(player1,player2)
  return player1.frequenzaAttacco < player2.frequenzaAttacco
end

local function makeTeams()
    
    for i = 1 ,#preTeamTable,1 do
      
      local playerImage = display.newImageRect(ourTeamGroup,preTeamTable[i].img,35,65)
      --riempie l aray che andra a gestire i players in gioco
      --playerForTurn[i] = preTeamTable[i]
      table.insert(playerForTurn,preTeamTable[i])
      playerForTurn[i].playerImage = playerImage
      playerForTurn[i].isEnemy = false
      playerForTurn[i].spot = fightSpots[1][i][1]
      playerForTurn[i].spot.occupedBy = playerForTurn[i]
      
      --assegna gli attribti alla playerImage
      playerImage.player = playerForTurn[i]
      playerImage.id = i
      playerImage.x = playerForTurn[i].spot.x-3
      playerImage.y = playerForTurn[i].spot.y-28
           
      playerImage:addEventListener("touch",dragListener)
      
    end
    local j  = #playerForTurn
    for i = 1,#vsTeamList,1 do
      local r,c
      local occupato = true
      
      --aumnetare la complessita della scelta della posizione nelle difficolta maggiori
      while occupato do
        r = math.random(3)
        c = math.random(2)
        if  not fightSpots[2][r][c].isOccuped() then
          occupato = false
        end
      end
      
      local playerImage = display.newImageRect(vsTeamGroup,vsTeamList[i].imgSX,35,65)
      --continuo a riempire playerForTurn
      --playerForTurn[j] = vsTeamList[i]
      table.insert(playerForTurn,vsTeamList[i])
      playerForTurn[j+i].playerImage = playerImage
      playerForTurn[j+i].isEnemy = true
      playerForTurn[j+i].spot = fightSpots[2][r][c]
      playerForTurn[j+i].spot.occupedBy = playerForTurn[j+i]
      
      playerImage.player = playerForTurn[j+i]
      playerImage.id = j+i
      playerImage.x = playerForTurn[j+i].spot.x
      playerImage.y = playerForTurn[j+i].spot.y-20      
  
      playerImage:addEventListener("touch", handleEnemyTouch)
    end
end
-- Function to handle spot events
local function spotTouched( event )
  
    local spotClicked = event.target
    display.getCurrentStage():setFocus( event.target )

    if ( "ended" == event.phase ) then
        print( spotClicked.id)
        print("fightTable["..spotClicked.t.."]["..spotClicked.r.."]["..spotClicked.c.."]")
        if(spotClicked.occupedBy ~= nil) then
          print (spotClicked.occupedBy.nome)
        else
          print("empty spot")
        end
        display.getCurrentStage():setFocus( nil )
    end
    return true
end


--1 crea gli oggetti display spot del nostro team, e li assegna a ourSpotTable
local function makeFightSpots()
  local vertices = {40,20 , 20,-20 , -40,-20, -20,20 }

  -- Crea i poligoni che saranno gli spot per i personaggi
  for t = 1,2,1 do
    local n = 1
    local riga = {}
    for r = 1, 3,1 do
      local colonna = {}
      for c = 1,2,1 do
        local spotGroup
        
        if t == 1 then
          spotGroup = ourSpotGroup
        else
          spotGroup = vsSpotGroup
        end
        
        local spot = display.newPolygon( spotGroup,0, 0, vertices )
        spot.strokeWidth = 2
        spot:setFillColor(0.7, 0.7, 0.7  )
        spot:setStrokeColor( 0.2, 0.2, 0.2 )
        spot.alpha = 0.5
        
        spot.occupedBy = nil
        spot.isOccuped = function () return spot.occupedBy ~= nil end
        spot:addEventListener("touch",spotTouched)
        
        colonna[c] = spot
        colonna[c].id = "spot n.".. n
        colonna[c].t = t
        colonna[c].r = r
        colonna[c].c = c
        colonna[c].bonus = "nessuno per ora"
        
        n = n + 1
      end
      riga[r] = colonna
    end
    fightSpots[t] = riga
  end
  --ourSpot
  --colonna 1
  fightSpots[1][1][1].x = 150
  fightSpots[1][2][1].x = 170
  fightSpots[1][3][1].x = 190
 
  fightSpots[1][1][1].y = 80
  fightSpots[1][2][1].y = 150
  fightSpots[1][3][1].y = 220
  --colonna 2
  fightSpots[1][1][2].x = 60
  fightSpots[1][2][2].x = 80
  fightSpots[1][3][2].x = 100
 
  fightSpots[1][1][2].y = 80
  fightSpots[1][2][2].y = 150
  fightSpots[1][3][2].y = 220
  -- vsSpot
  --colonna 1
  fightSpots[2][1][1].x = 260
  fightSpots[2][2][1].x = 280
  fightSpots[2][3][1].x = 300
 
  fightSpots[2][1][1].y = 80
  fightSpots[2][2][1].y = 150
  fightSpots[2][3][1].y = 220
  --colonna 2
  fightSpots[2][1][2].x = 350
  fightSpots[2][2][2].x = 370
  fightSpots[2][3][2].x = 390
 
  fightSpots[2][1][2].y = 80
  fightSpots[2][2][2].y = 150
  fightSpots[2][3][2].y = 220
    
end

local function makeTurnTable()
  
  local imgPath 
  local turnImg
  local tempChar
  local nPlayer 
  local tPlayer 
  local taMin 
  local tempN
  local tempT
  local j
  
  for i=1,5,1 do
    local turn = 1
    j = 1
    taMin = nil
    
    while(playerForTurn[j].turno[turn].selected) do
      turn = turn + 1
      if turn > 5 then
        j = j +1
      end
    end
    taMin = playerForTurn[j].turno[turn].tempo
    nPlayer = j
    tempN = j
    tempT = turn
    tPlayer = turn
    playerForTurn[j].turno[turn].selected = true
    
    for p = 1 , #playerForTurn, 1 do
      local pturn = 1
      while(playerForTurn[p].turno[pturn].selected) do
        pturn = pturn + 1
      end
      if((pturn < 6) and (playerForTurn[p].turno[pturn].tempo < taMin) ) then
        taMin = playerForTurn[p].turno[pturn].tempo
        nPlayer = p
        tPlayer = pturn
        playerForTurn[j].turno[tempT].selected = false
        playerForTurn[p].turno[pturn].selected = true
      end
    end
  
    --devo avere taMin e nPlayer assegnati
    --creo il display obj turnChar
    tempChar = playerForTurn[nPlayer]
    
    
    if(tempChar.isEnemy )then
      imgPath = tempChar.imgSX
    else
      imgPath = tempChar.img
    end
    
    turnImg =  display.newImageRect(uiGroup,imgPath,20,35)
    turnImg.x = uiTable[2].x
    turnImg.y = uiTable[2].y + uiTable[2].height/2 - 30 - 43*(i-1)
    turnTable[i] = turnImg
    turnTable[i].player = playerForTurn[nPlayer]
    --assegno al turno i il tempo del prossimo turno in base al tempo del prossimo attacco del player che lo giocherà
    --aumento il tempo del prossimo attacco della velocita d'attacco del player
    --assegno l'indice del player che deve attaccare il turno i
    
    turnTable[i].turno = playerForTurn[nPlayer].turno[tPlayer].numeroTurno
    turnTable[i].tempo = playerForTurn[nPlayer].turno[tPlayer].tempo
  end
end
local function makePlayerForTrun()
  
  for i = 1, #playerForTurn, 1 do
    
    local taFloat = calcolaFrequenzaAttacco(playerForTurn[i].vel)
   
    playerForTurn[i].frequenzaAttacco = taFloat
    playerForTurn[i].turno = {}
    playerForTurn[i].indicePlayer = i
    playerForTurn[i].nextTurn = playerForTurn[i].frequenzaAttacco
    playerForTurn[i].isDead = false
    playerForTurn[i].passivaAttiva = getIndicePrimaPassivaAttiva(playerForTurn[i])
        
    for j = 1, 5, 1 do
      playerForTurn[i].turno[j] = {}
      playerForTurn[i].turno[j].numeroTurno = j
      playerForTurn[i].turno[j].tempo = playerForTurn[i].frequenzaAttacco * j
      playerForTurn[i].turno[j].selected = false
    end

    local displayGroup = display.newGroup()
    displayGroup.x = playerForTurn[i].spot.x
    displayGroup.y = playerForTurn[i].spot.y + playerForTurn[i].spot.height*2/5
    playerForTurn[i].displayGroup = displayGroup
    
    local xPosHp = -10
    if(playerForTurn[i].isEnemy)then
      xPosHp = 10
    end
   
    local hpD = display.newRoundedRect(displayGroup,xPosHp,0,40,7,5)
    
    local xPosTurn = hpD.width-10
    if(playerForTurn[i].isEnemy)then
      xPosTurn = - hpD.width +10
    end
   
    local manaD = display.newRoundedRect(displayGroup,hpD.x,10 ,40,7,5)
   
    local turnD = display.newCircle(displayGroup,xPosTurn,hpD.y + 5,10)
    turnD.remainingTime = playerForTurn[i].frequenzaAttacco
    hpD:setFillColor(1,0,0)
    hpD.hpMax = playerForTurn[i].hp
    hpD.hpNow = playerForTurn[i].hp
    local hpText = display.newText(displayGroup, hpD.hpNow.." / "..hpD.hpMax,hpD.x,hpD.y,native.systemFont,hpD.height)
    manaD.manaMax = 100
    manaD.manaNow = 100
    local manaText = display.newText(displayGroup, manaD.manaNow.." / "..manaD.manaMax,manaD.x,manaD.y,native.systemFont,hpD.height)
    manaD.text = manaText
    hpD.text = hpText
    local turnText = display.newText(displayGroup,turnD.remainingTime,turnD.x,turnD.y,native.systemFont,hpD.height)
    turnD.text = turnText
    turnText:setFillColor(0,0,0)
    manaD:setFillColor(0,0,1)
    turnD:setFillColor(0.2,1,1)
    
    playerForTurn[i].hpD = hpD
    playerForTurn[i].manaD = manaD
    playerForTurn[i].turnD = turnD
  
  end

end
local function clearBattleUI()
   if (#battleTable ~= 0)then
   
   for i = 1 , #battleTable, 1 do
      display.remove(battleTable[i])
      battleTable[i] = nil
    end
  end
end
--TODO
local function getSpecialTarget(skill)
end


local function getPotentialTarget(skill)
  local potentialSpot = {}
  
  if skill.bersaglio == "special" then
    potentialSpot = getSpecialTarget(skill)
  elseif skill.bersaglio == "all" then
    potentialSpot  = attivaTuttiSpot()
  else
    
    local playerTeam = 0
    local vsTeam = 0
    
    if skill.team == "both" then
      --TODO
      playerTeam = 1
      vsTeam = 2
    elseif skill.team == "self" then
      playerTeam = 2
      vsTeam = 1
    elseif skill.team == "vs" then
      playerTeam = 1
      vsTeam = 2
    end
    
    local temp
    if playerOnTurn.isEnemy then
      temp = playerTeam
      playerTeam = vsTeam
      vsTeam = temp
    end
    
    if skill.bersaglio == "primaFila" then
      for r = 1, 3, 1 do
            --potentialSpot[n] = fightSpots[vsTeam][r][1]
            table.insert(potentialSpot,fightSpots[vsTeam][r][1])
      end
    elseif skill.bersaglio == "secondaFila" then
      for r = 1, 3, 1 do
        --potentialSpot[r] = fightSpots[vsTeam][r][2] 
        table.insert(potentialSpot,fightSpots[vsTeam][r][2])
      end
    elseif skill.bersaglio == "singolo" then
      for r = 1, 3, 1 do
        for c = 1, 2, 1 do
          if fightSpots[vsTeam][r][c].isOccuped() then
          --  potentialSpot[n] = fightSpots[vsTeam][r][c]
            table.insert(potentialSpot,fightSpots[vsTeam][r][c])
    
          end
        end
      end
    end
    return potentialSpot
  end 
end

local function getPotentialTarget1(skill)
  
  local activableSpot = {}
  
  for t = 1,2,1 do
    local team = {}
    for r = 1, 3, 1 do
      local riga = {}
      for c = 1, 2, 1 do 
        riga [c] = false
      end
      team[r] = riga
    end
    activableSpot[t] = team
  end

  if skill.bersaglio == "special" then
    activableSpot = getSpecialTarget(skill)
  elseif skill.bersaglio == "all" then
    activableSpot  = attivaTuttiSpot()
  else
    
    local playerTeam = 0
    local vsTeam = 0
    
    if skill.team == "both" then
      --TODO
      playerTeam = 1
      vsTeam = 2
    elseif skill.team == "self" then
      playerTeam = 2
      vsTeam = 1
    elseif skill.team == "vs" then
      playerTeam = 1
      vsTeam = 2
    end
    
    if playerOnTurn.isEnemy then
      local temp
      temp = playerTeam
      playerTeam = vsTeam
      vsTeam = temp
    end
    

    if skill.bersaglio == "primaFila" then
      for r = 1, 3, 1 do
            activableSpot[vsTeam][r][1] = true
      end
    elseif skill.bersaglio == "secondaFila" then
      for r = 1, 3, 1 do
        activableSpot[vsTeam][r][2] = true      
      end
    elseif skill.bersaglio == "singolo" then
      for r = 1, 3, 1 do
        for c = 1, 2, 1 do
          if fightSpots[vsTeam][r][c].isOccuped then
            activableSpot[vsTeam][r][c] = true
          end
        end
      end
    end
    return activableSpot
  end 
end
local function getRealTarget(potentialSpots)
  
  local realTargetSpots = {}
  
  for i = 1 , #potentialSpots, 1 do
    if potentialSpots[i].isOccuped()  then
     -- realTargetSpots[i] = potentialSpots[i]
     table.insert(realTargetSpots, potentialSpots[i])
    end
  end
  return realTargetSpots
end

local function getSpotColorSkill(tipo)
  local colorTable = {}
  if tipo == "dmg" then
    colorTable = {1,0,0,1}
  elseif tipo == "stato" then
    colorTable= {0,0,1,1}
  elseif tipo =="heal" then
    colorTable = {0,1,0,1}
  end
  return colorTable
end
local function makeBattleUI(player)
  
 clearBattleUI()
  
  for i = 1,#player.mosse.passive,1 do
    
    local rectPassiva = display.newImageRect(uiGroup,player.mosse.passive[i].imgPath,40,40)
    rectPassiva.x = 10 + 60*(i-1)
    rectPassiva.y = uiTable[1].y
    rectPassiva.id = i
    rectPassiva.skill = player.mosse.passive[i]
    rectPassiva:addEventListener("touch",handleMossaPassivaTouch)
    table.insert(battleTable,rectPassiva)
    rectPassiva:setStrokeColor(1,0,0)
    --attivo la passiva
    if(player.passivaAttiva == i) then
      rectPassiva.strokeWidth = 3
    end
  end
  
  for i = 1,#player.mosse.attive, 1 do
    local rectAttiva = display.newRect(uiGroup,20 + 60*(3) + 60*(i-1) ,uiTable[1].y,40,40)
    rectAttiva:setFillColor(0.4,0.4,1)
    rectAttiva.skill = player.mosse.attive[i]
    
    rectAttiva.potentialTargetSpots = getPotentialTarget(rectAttiva.skill)
    rectAttiva.realTargetSpots = getRealTarget(rectAttiva.potentialTargetSpots)
    rectAttiva.color = getSpotColorSkill(rectAttiva.skill.tipo)
    
    rectAttiva:addEventListener("touch",handleMossaAttivaTouch)
    table.insert(battleTable,rectAttiva)
  end
end
local function checkPlayerOnTurn()
  
    print("toccq a qualcuno ? ")
    
    if(turnTable[1].tempo == tonumber(secondi.."."..decimi) ) then
        timer.pause( t )
        return true 
    end
  return false
end
 
local function aggiornaTimerDisplayPlayers()

  for i = 1 , #playerForTurn,1 do
    playerForTurn[i].turnD.remainingTime = playerForTurn[i].turnD.remainingTime - 0.1
    if playerForTurn[i].turnD.remainingTime < 0.1 then
      playerForTurn[i].turnD.remainingTime = 0
    end
    playerForTurn[i].turnD.text.text = playerForTurn[i].turnD.remainingTime
  end
  
end
local function isGameOver()
  return isOver
end

local function updateTime(event)
  if isGameOver() then
    print("GAME OVER")
  end
  
  -- cerco se tocca a qualcuno, in quel caso blocco il timer
  if (checkPlayerOnTurn())then
    playerOnTurn = turnTable[1].player

    -- attivo il bordo dello spot del PlayerOnTurn
    print("a me :"..playerOnTurn.nome)
    print("velocita attacco: ".. playerOnTurn.frequenzaAttacco)

    playerOnTurn.spot:setStrokeColor(0,1,1)
    playerOnTurn.spot:setFillColor(0.2, 0.2, 0.7)
    --carico mosse e aspetto che si esegua una mossa
    makeBattleUI(playerOnTurn) -- attendo che si esegua una mossa tramite listener mosse
    
  else --se non tocca a nessuno incremento il tempo e rilancio
    
    decimi = decimi + 1
    if(decimi >= 10) then
      decimi = 0
      secondi = secondi +1
    
    elseif (secondi >= 59) then
      secondi = 0
      minuti = minuti +1
    end
    --se non vinci entro un minuto perdi
    if (minuti == 1) then 
      local endMessage = display.newText(uiGroup,"Game Over",display.contentCenterX,display.contentCenterY)
      decimi = 0
      secondi = 0
      minuti = 0
      timer.cancel(t)
      t = nil
     -- composer.gotoScene("menu", {effect = "fade",time =8000})
    end
    aggiornaTimerDisplayPlayers()
    --mostra timer aggiornato
    timeDisplay.text = string.format(minuti..":"..secondi.."."..decimi)
    
    --fine else
    
    --se non hai perso/vinto ed è finito il turno di qualcuno ripeti
  end
end


local function battleLoop()

  t = timer.performWithDelay(100, updateTime, -1)
  
end


local function setBattle()
    
      local rectMosse = display.newRoundedRect(uiGroup,display.contentCenterX,290,display.contentWidth * 1.1,60, 10)
      rectMosse:setFillColor(gray)
      rectMosse.alpha = 0.5
      
      table.insert(uiTable,rectMosse)

      local rectTurn = display.newRoundedRect(uiGroup,-10,display.contentCenterY - 30,40,display.contentHeight * 0.7, 10)
      rectTurn.alpha = 0.5
      
      table.insert(uiTable,rectTurn)

      timeDisplay  = display.newText("0",display.contentWidth -20,20,native.systemFrontBold,30)
      uiGroup:insert(timeDisplay)
      
      table.insert(uiTable, timeDisplay)
            
end

local function startBattle(event)
  
  print("Che la battaglia inizi")
  
  if (event.phase == "ended") then
    for r = 1, 3,1 do
      for c = 1,2,1 do
        if fightSpots[1][r][c].playerOn ~= nil then
          fightSpots[1][r][c]:removeEventListener("touch" , dragListener)
        end
      end
    end
  end
  --rimuove il pulsante play
  display.remove(event.target)
  event.target = nil
  
  --creo i display per le mosse e le info dei player
  setBattle()--<--
  
  --creo una tabella di tutti i player (playerForTurn)
  --calcolo la loro frequenza di attacco in base alla loro velocita
  --ordino la tabella in base alla frequenza e calcolo il tempo del prossimo attacco
  --playerForTurn -> playerForTurn[i].frequenzaAttacco
  --playerForTurn -> playerForTurn[i].tempoProssimoAttacco
  makePlayerForTrun()--<--
    
  --creo una tabella dei turni ordinata in base al tempo del prossimo attacco dei player
  --assegno il player che deve giocare e il tempo del prossimo turno, poi incremento il tempoProssimoTurno del player
  makeTurnTable()--<--
  -- inizio il ciclo della battaglia
  battleLoop()--><--
  
end





-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
     -- Code here runs when the scene is first created but has not yet appeared on screen

    local sceneGroup = self.view
 
    backGroup = display.newGroup()
    sceneGroup:insert(backGroup)
    
    ourSpotGroup = display.newGroup()
    sceneGroup:insert(ourSpotGroup)
    
    vsSpotGroup = display.newGroup()
    sceneGroup:insert(vsSpotGroup)
    
    ourTeamGroup = display.newGroup()
    sceneGroup:insert(ourTeamGroup)
    
    vsTeamGroup = display.newGroup()
    sceneGroup:insert(vsTeamGroup)
    
    mainGroup = display.newGroup()
    sceneGroup:insert(mainGroup)
    
    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)
    
    local background = display.newImageRect(backGroup,"img/sfondo480-320.png",480*1.2,320*1.2)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

local startButton = widget.newButton(
  {
    label = "Inizia!",
    onRelease = startBattle,
    emboss = true,
    labelColor = { default={ 1, 1, 1 }, over={ 1, 0, 0, 0.5 } },
    -- Properties for a rounded rectangle button
    shape = "roundedRect",
    width = 40,
    height = 30,
    cornerRadius = 10,
    fillColor = { default={0.8,0.4,0.8,0.8}, over={0.6,0.2,0.4,0.6} },
    strokeColor = { default={0.6,0.2,0.4,0.8}, over={0.8,0.8,1,1} },
    strokeWidth = 4
  }
)

startButton.y = display.contentHeight - startButton.height
startButton.x = display.contentWidth
sceneGroup:insert(startButton)
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
             --1
    
    makeFightSpots()
    
    makeTeams()
  
    elseif ( phase == "did" ) then
    
    
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene