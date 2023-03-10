local Talk = Button:extend("Talk")

function Talk:init(x, y)
    Button.init(
        self, 
        x, 
        y, 
        168,
        64,
        "Talk",
        love.graphics.newImage('assets/pic/button.png'),
        {e = 1, a = 1},
        "Try to chit-chat.\nGives 1 energy on success.\nGives 1 aliveness on success.\nTakes 1 energy or aliveness on fail"
    )

   
end

function Talk:draw()
   
    if playerState.state == playerState.states.poiresolution  then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(self.img, self.x, self.y)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.name, self.x+25, self.y + 25)
    end
    if self.hovered and playerState.state ~= playerState.states.progressing then
        love.graphics.setColor(GLOBALS.colors.darkgrey)
        love.graphics.rectangle("fill", GLOBALS.mX + 10, GLOBALS.mY - 60, 300,100)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.hovertext, GLOBALS.mX + 15, GLOBALS.mY- 55)
        if player.energy - self.prices.e <= 0 or player.aliveness - self.prices.a <= 0 then
            love.graphics.setColor(1,1,0)
            love.graphics.print("You may die", self.x + 15, self.y + 38)
            love.graphics.setColor(GLOBALS.colors.white)
        end
    end

end

function Talk:action()
 

    print("talking with friend..")

  
    gameWorldTimeAdjust(4)
    Button:progressBar(4)
    local s = Sounds.talk:play()
    player.friendliness = player.friendliness + 1
    for k,v in ipairs(POIs) do
        if v.type == "FriendlyHome" then
            if player.friendliness == v.levelup then
                player.friendliness = 0
                player.lvls.Friendliness = player.lvls.Friendliness + 1
            end
        end
    end

    if love.math.random() > 0.5 then
        player:showResolution(1)
        player.energy = player.energy + self.prices.e
        player.aliveness = player.aliveness + self.prices.a
    else
        player:showResolution(0)
        if love.math.random() > 0.5 then
            player.energy = player.energy - self.prices.e
        else
            player.aliveness = player.aliveness - self.prices.a
        end
        if player.aliveness <= 0 or player.energy <= 0 then
            player:die("You had a fight with your friend\n and he accidentally stabbed you")
        end
    end
 
   
    




    

end

return Talk