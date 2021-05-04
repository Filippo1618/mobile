---@diagnostic disable: undefined-global


require ("character")

local function sortByVel(c1,c2)
    return c1.infoChar.baseStat.vel > c2.infoChar.baseStat.vel
end

function NewTurnTable(uiGroup)
    local self = {}
    self.totalChar = 0
    self.roundCount = 0
    self.turnCount = 0
    self.roundString = function ()return tostring(self.roundCount)end
    self.turnString = function ()return tostring(self.turnCount)end
    self.roundText = display.newText(uiGroup,"Round: ".. self.roundString(),180,40,native.systemFont)
    self.turnText = display.newText(uiGroup,"Turn: ".. self.turnString(),180,55,native.systemFont)
    self.playerOnTurn = {}
    self.queued = {}
    self.attacked = {}
    self.deadChars = {}
    
    function self:newQueue(charToQueue)
        for i = 1, #charToQueue do
            table.insert(self.queued,charToQueue[i])
        end
        self:sortQueueByVel()
    end

    function self:getFirstQueued()
        return table.remove(self.queued,1)
    end

    function self:setToAttacked(char)
        table.insert(self.attacked,char)
        char:colorTurnDisplay({0.6,0.6,0.6})
    end

    function self:fillQueueFromAttacked()
        local chars = {}
        for i = 1, #self.attacked do
             chars[i] = table.remove(self.attacked,i)
        end
        self:newQueue(chars)
    end

    function self:sortQueueByVel() --aggiorna myTurn ?
        table.sort(self.queued,sortByVel)
        print("[turnTable:sortByVel]ordine dei giocatori :\n")
        for i = 1, #self.queued do
            self.queued[i].myTurn = i + self.turnCount
            print("[".. (i+self.turnCount) .. "] : ".. self.queued[i].infoChar.name)
        end
    end

    function self:updateRoundTurnText()
        self.roundText.text ="Round: ".. self.roundString()
        self.turnText.text = "Turn: "..self.turnString()
    end

    function self:increaseRound()
        self.roundCount = self.roundCount + 1
        self:updateRoundTurnText()
    end
    function self:increaseTurn()
        self.turnCount = self.turnCount + 1
        self:updateRoundTurnText()
    end


    function self:searchByTurn(turn)
        for i = 1 , #self.queued do
            if self.queued[i].myTurn == turn then
                print("[turnTable:searchByTurn]giocatore trovato: "..self.queued[i].infoChar.name)
                return self.queued[i]
            end
        end
        print("[turnTable:searchByTurn]giocatore non trovato")
        return nil
    end

    function self:getPlayerOnTurn()
        return self.playerOnTurn
    end

    function self:setPlayerOnTurn(player)
        self.playerOnTurn = player
        print("[turnTable:setPlayerOnTurn]playerOnTurn setted: ".. self.playerOnTurn.infoChar.name )
    end

    function self:displayTurnPrevision()
        for i = 1 , #self.queued do
            self.queued[i]:makeTurnDisplay(self.turnCount)
        end
    end

    function self:nextTurn()
        --prendo il primo in coda e lo setto player on turn
        local nextPlayer = self:getFirstQueued() --questo lo rimuove dalla coda
        print("[turnTable:nextTurn]chiamo setPlayerOnTurn")
        self:setPlayerOnTurn(nextPlayer)
        --imposto la sua skill bar

        --TODO
    end

    --serve?
    function self:checkNext()
        return self.queued[1] ~= nil
    end

    function self:makeNewTurn()
        --aggiorno round e turn text
        self:increaseTurn()
        --aggiorna stat turn based,dot,hot,regen,passive ecc?
        --setto il playerOnTurn

        local nextPlayer = self:getFirstQueued()
        if nextPlayer == nil then
            print("[turnTable:makeNewTurn]errore makeNewTurn , creo nuovo round.")
            self:makeNewRound()
        else
            print("[turnTable:makeNewTurn] chiamo setPlayerOnTurn")
            self:setPlayerOnTurn(nextPlayer)
            print("[turnTable:makeNewTurn] setto il colore del turn display verde")
            self.playerOnTurn:colorTurnDisplay({0,0.8,0})
        end
    end

    --TODO da completare
    function self:makeNewRound()
        self:newQueue(self.attacked)
    end
    
    function self:initTurnTable(allCharsInFight)
        --TODO Aggiungere spot bonus / malus
        self:newQueue(allCharsInFight)
    end
    return self
end