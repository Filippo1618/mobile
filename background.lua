function NewBackground (pngPath)
    local self  = display.newGroup()
    local bg = display.newImageRect(self,pngPath,DisplayWidth*1.2,DisplayHeight*1.2)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    return self
end