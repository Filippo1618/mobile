
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
        print("turni restanti :\n")
        for i = 1, #self.queued do
            self.queued[i].myTurn = i + self.turnCount
            print("[".. (i+self.turnCount) .. "] : ".. self.queued[i].infoChar.name)
        end
    end

    function self:updateRoundTurnText()
        self.roundText.text ="Round: ".. self.roundString()
        self.turnText.text = "Turn: "..self.turnString()
    end

    function self:searchByTurn(turn)
        for i = 1 , #self.queued do
            if self.queued[i].myTurn == turn then
                print("giocatore trovato: "..self.queued[i].infoChar.name)
                return self.queued[i]
            end
        end
        print("giocatore non trovato")
        return nil
    end

    function self:getPlayerOnTurn()
        return self.playerOnTurn
    end

    function self:setPlayerOnTurn(player)
        self.playerOnTurn = player
        print("playerOnTurn setted: ".. self.playerOnTurn.infoChar.name )
    end

    function self:displayTurnPrevision()
        for i = 1 , #self.queued do
            self.queued[i]:showTurnDisplay(self.turnCount)
        end
    end

    function self:nextTurn()
        --prendo il primo in coda e lo setto player on turn
        local nextPlayer = self:getFirstQueued() --questo lo rimuove dalla coda
        self:setPlayerOnTurn(nextPlayer)
        print("player on turn setted on "..nextPlayer.infoChar.name)
        --imposto la sua skill bar

        --TODO
    end
    
    function self:makeNewTurn()
        --aggiorna stat turn based,dot,hot,regen,passive ecc?
        --setto il playerOnTurn
        local nextPlayer = self:getFirstQueued()
        if nextPlayer == nil then
            print("errore makeNewTurn , creo nuovo round.")
            self:makeNewRound()
        else
            self:setPlayerOnTurn(nextPlayer)
            print("setto nuovo playerOnTurn: ".. nextPlayer.infoChar.name)
        end
    end
    
    function self:makeNewRound()
        self:newQueue(self.attacked)
    end
    
    function self:initTurnTable(allCharsInFight)
        --TODO Aggiungere spot bonus / malus
        self:newQueue(allCharsInFight)
    end
    return self
end