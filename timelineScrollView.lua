-----------------------------------------------------------------------------------------
--
-- timelineScrollView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local lunghezzaLivelli = 161*1.3
local altezzaLivelli = 100*1.3

local characters = composer.getVariable("characters")
local lvlCharTable = composer.getVariable("lvlCharTable")
local lvlSelected = nil
local lvlCharsID

local backGroup
local mainGroup
local uiGroup
local vsTeamGroup
local vsTeamTable = {}
local buttonsTable = {}

-----------------------------------------------------------------------------------------

-- funzione per gestire la scrollView
local function scrollListener( event )
	local phase = event.phase
	local direction = event.direction

  if "began" == phase then
   	print( "Began.scrollListener" )
	elseif "moved" == phase then
		print( "Moved.scrollListener" )
	elseif "ended" == phase then
		print( "Ended.scrollListener" )
	end
  -- If the scrollView has reached its scroll limit
	if event.limitReached then
		if "up" == direction then
			print( "Reached Top Limit" )
		elseif "down" == direction then
			print( "Reached Bottom Limit" )
		elseif "left" == direction then
			print( "Reached Left Limit" )
		elseif "right" == direction then
			print( "Reached Right Limit" )
		end
	end
	return true
end

-- funzione per il set del livello e visualizzazione nemici
local function setLvlEnemies( event )
  print("settato livello : ",lvlSelected)
  if ( event.phase == "began" ) then
    print( "Touch event began on: " .. event.target.id )
  elseif ( event.phase == "ended" ) then
    print( "Touch event ended on: " .. event.target.id )
  end
  return true
end

-- crea la visualizzazione di vsTeamTable
local function createVsGroup(lvlCharsID)
  
  for i = 1 , #lvlCharsID do
    local char = display.newImageRect(vsTeamGroup,characters[lvlCharsID[i]].imgSX,45,80)
    print("i = " .. i .. " ID = ".. lvlCharsID[i])
    print(characters[lvlCharsID[i]].name)
    char.x = 50 +(90*(i-1))
    char.y = 15
    table.insert(vsTeamTable,char)
  end
end

-- pulisce vsTeamTable per la nuova visualizzazione
local function clearVsTeamTable()
  local char
  for i = #vsTeamTable,1,-1 do
    char = vsTeamTable[i]
    table.remove(vsTeamTable,i)
    display.remove(char)
    char = nil
  end

end

-- tap sulla selezione livello
local function onObjectTap( event )
  --se la vsTeamTable non è vuota allora la pulisco
  if(#vsTeamTable ~= 0) then
    clearVsTeamTable()
  end

  lvlSelected = event.target.lvl
  lvlCharsID = lvlCharTable[lvlSelected]
  composer.setVariable("lvlSelected",lvlSelected)
  composer.setVariable("lvlCharsID",lvlCharsID)

  createVsGroup(lvlCharsID)
  return true
end

-- Funzione per l'inizio della partita
local function letsPlay(event)
  local phase = event.phase

  if (phase == "began") then
    print("event.target.id = "..event.target.id)
    print("event.target.label = "..event.target.nome)
  elseif (phase == "ended") then
    if(lvlSelected == nil) then
      print("Nessun livello selezionato :(")
      print(lvlSelected)
    else
      print("Livello selezionato: "..lvlSelected.."!!\nSi giocaaaaa!")
      composer.gotoScene("fight",{effect ="fade",time = 400})
    end
  end
  return true
end

-- funzione per tornare al menu
local function previousPage()
  print("back to the menu")
  composer.gotoScene("menu",{effect = "fade", time = 200})
end

-----------------------------------------------------------------------------------------

-- Create scene
function scene:create( event )

  local sceneGroup = self.view

  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  mainGroup = display.newGroup()
  sceneGroup:insert(mainGroup)

  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  local background  = display.newImageRect("img/sfondo_spacecartoon.jpg", 480*1.2,320*1.2)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  backGroup:insert(background)

  vsTeamGroup = display.newGroup()
  vsTeamGroup.x = 100
  vsTeamGroup.y = 240
  sceneGroup:insert( vsTeamGroup )


  -- Create a scrollView
  local scrollView = widget.newScrollView (
    {
      width = display.contentWidth*1.2,
      height = display.contentHeight-100,
      left = -40,
      backgroundColor = backgroundColor,
      --isBounceEnabled = false,
      horizontalScrollDisabled = false,
      verticalScrollDisabled = true,
      hideBackground = true,
      rightPadding = 100,
      listener = scrollListener
    }
  )
  backGroup:insert( scrollView )

  --pulsantiLivelli
  local buttonMedioevo = widget.newButton(
    {
        width = lunghezzaLivelli,
        height = altezzaLivelli,
        label = "Medioevo 1000 D.C.",
        textAllign ="center",
        labelColor = { default={ 255,140,0 }, over={ 75,0,130 } },
        labelYOffset = altezzaLivelli/2 + 20,
        top = 20,
        left = 20,
        defaultFile ="img/sfondo_medioevo.png",
      }
  )
  buttonMedioevo.lvl = "medioevo"
  buttonMedioevo:addEventListener( "tap", onObjectTap )

  local buttonRinascimento = widget.newButton(
    {
      width = lunghezzaLivelli,
      height = altezzaLivelli,
      label = "Rinascimento 1500 D.C.",
      textAllign ="center",
      labelColor = { default={ 255,140,0 }, over={ 75,0,130 } },
      labelYOffset = altezzaLivelli/2 + 20,
      top = 20,
      left = 20,
      defaultFile ="img/sfondo_rinascimento.png",
    }
  )
  buttonRinascimento.lvl = "rinascimento"
  buttonRinascimento:addEventListener( "tap", onObjectTap )


  local buttonRisorgimento = widget.newButton(
    {
      width = lunghezzaLivelli,
      height = altezzaLivelli,
      label = "Risorgimento 1700 D.C.",
      textAllign ="center",
      labelColor = { default={ 255,140,0 }, over={ 75,0,130 } },
      labelYOffset = altezzaLivelli/2 + 20,
      top = 20,
      left = 20,
      defaultFile ="img/sfondo_risorgimento.png",
    }
  )
  buttonRisorgimento.lvl = "risorgimento"
  buttonRisorgimento:addEventListener( "tap", onObjectTap )

  local button1900 = widget.newButton(
   {
     width = lunghezzaLivelli,
     height = altezzaLivelli,
     label = "Età Moderna 1900 D.C.",
     textAllign ="center",
     labelColor = { default={ 255,140,0 }, over={ 75,0,130 } },
     labelYOffset = altezzaLivelli/2 + 20,
     top = 20,
     left = 20,
     defaultFile ="img/sfondo_1900.png",
   }
  )
  button1900.lvl = "eta_moderna"
  button1900:addEventListener( "tap", onObjectTap )


  --inserimetno pulsanti livelli nella Buttons Table
  table.insert( buttonsTable, buttonMedioevo )
  table.insert( buttonsTable, buttonRinascimento )
  table.insert( buttonsTable, buttonRisorgimento )
  table.insert( buttonsTable, button1900 )

  -- inserimento dei pulsanti nella scrollView
  for i=1,table.maxn( buttonsTable ) do
    buttonsTable[i].x = i*lunghezzaLivelli + (i-1)*100
    scrollView:insert(buttonsTable[i])
  end

  -- Pulsante play
  local playButton = widget.newButton(
      {
          id = "playButton",
          label = "Play",
          numero = 3,
          emboss = false,
          labelColor = { default={ 1, 1, 1 }, over={ 255,140,0 } },
          -- Properties for a rounded rectangle button
          shape = "roundedRect",
          width = 70,
          height = 70,
          cornerRadius = 20,
          fillColor = { default={0.1,0.4,0.8,0.8}, over={0.1,0.2,0.4,0.6} },
          strokeColor = { default={0,0.2,0.4,0.8}, over={0.8,0.8,1,1} },
          strokeWidth = 4,
          onRelease = letsPlay
      }
  )
  playButton.x = display.contentWidth-20
  playButton.y = display.contentHeight-60
  uiGroup:insert(playButton)

  -- Pulsante back
  local backButton = widget.newButton(
    {
      label = "Back",
      emboss = false,
      labelColor = { default={ 1, 1, 1 }, over={ 255,140,0  } },
      -- Properties for a rounded rectangle button
      shape = "roundedRect",
      width = 70,
      height = 70,
      cornerRadius = 20,
      fillColor = { default={0.1,0.4,0.8,0.8}, over={0.1,0.2,0.4,0.6} },
      strokeColor = { default={0,0.2,0.4,0.8}, over={0.8,0.8,1,1} },
      strokeWidth = 4,
      onRelease = previousPage
    }
  )
  backButton.x = 20
  backButton.y = playButton.y
  uiGroup:insert(backButton)

end


-- show()
function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase
  if ( phase == "will" ) then
      -- Code here runs when the scene is still off screen (but is about to come on screen)

  elseif ( phase == "did" ) then
      -- Code here runs when the scene is entirely on screen
      --print("lvl selected = "..lvlSelected.."\n numero di personaggi = ".. #lvlCharTable[lvlSelected])
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
