
local vertices = {40,20 , 20,-20 , -40,-20, -20,20 }
local function onTouchInfo (event)
    local tempSpot = event.target

    if ( event.phase == "began" ) then
        print("Spot Listener: ")
        display.getCurrentStage():setFocus( tempSpot )
        print( "Touch event began on: " .. tempSpot.id )
        print("is enemy spot: ", tempSpot.isEnemy)
        print("is occuped: " , tempSpot.isOccuped())
        if tempSpot.isOccuped() then
            print("occupedBy: " .. tempSpot.occupedBy.infoChar.name) 
        end
    elseif event.phase == "ended" or event.phase == "cancelled" then
        print( "Touch event ended on: " .. event.target.id )
        display.getCurrentStage():setFocus( nil )
    end
    return true
end

function NewGridSpots(properties,spotsCoord)

    local self = display.newGroup()
    self.totalObj = #properties.type

    for n=1, self.totalObj do
        local tempSpot = display.newPolygon( 0, 0 , vertices) --in futuro imgRect
        tempSpot.id = properties.type[n] --properties.type = lista di tipi "blt","flb"
        tempSpot.strokeWidth = 2
        tempSpot:setFillColor(0.7, 0.7, 0.7  )
        tempSpot:setStrokeColor( 0.2, 0.2, 0.2 )
        tempSpot.alpha = 0.4
        tempSpot.occupedBy = nil
        tempSpot.x = spotsCoord[tempSpot.id].x
        tempSpot.y = spotsCoord[tempSpot.id].y
        tempSpot.isEnemy = properties.isEnemy
        --funzione di ogni spot
        function tempSpot:isOccuped()
            return tempSpot.occupedBy ~= nil
        end
        self:insert(tempSpot)
    end
    --funzioni di gridSpots
    function self:getPlayersOnSpots(type)
        local spot = self:getSpot(type)
        local player = spot.occupedBy
        if player == nil then
            print("nessun personaggio sullo spot ".. spot.type)
        end
    end
    
    function self:getSpots(types)
        local spots = {}
        local tempSpot
        for i = 1 , #types do
            tempSpot = self:getSpot(types[i])
            if tempSpot ~= nil then
                table.insert(spots, tempSpot)
            end
        end
        return spots
    end
    
    function self:getSpot(type)
        for i , spot in ipairs(self) do
            if spot.type == type then
                return spot
            end
        end
        print("spot: ".. type  .. " non trovato")
        return nil
    end
    
    function self:addSpotListener()
        for i = 1, self.totalObj do
            self[i]:addEventListener("touch", onTouchInfo)
        end
    end
    
    function self:getFreeSpots()
        local freeSpots = {}
        for i = 1, self.totalObj do
            if not self[i].isOccuped() then
                 table.insert(freeSpots,self[i])
            end
        end
        return freeSpots
    end
    
    function self:colorFreeSpots()
        for i = 1, self.totalObj do
            if not self[i].isOccuped() then
                self[i]:setFillColor(0,1,0)
            end
        end
    end

    function self:resetSpotsColor()
        for i = 1, self.totalObj do
            self[i]:setStrokeColor(0.2, 0.2, 0.2)
            self[i]:setFillColor(0.7, 0.7, 0.7  )
            self[i].alpha = 0.5
            self[i].strokeWidth = 2
        end
    end

    return self
end

