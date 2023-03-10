local Burger = Button:extend("Burger")

function Burger:init(x, y)
    Button.init(
        self, 
        x, 
        y, 
        168,
        64,
        "Burger",
        love.graphics.newImage('assets/pic/button.png'),
        {e = 5, a = 5, c = 5},
        "Smells like worms and fish\nGives 5 energy on success.\nTakes 5 aliveness on fail\nCosts 5$"
    )

   
end

function Burger:draw()
   
    if playerState.state == playerState.states.poiresolution and playerState.state ~= playerState.states.progressing then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(self.img, self.x, self.y)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.name, self.x +25, self.y + 25)
    end
    if self.hovered and playerState.state ~= playerState.states.progressing then
        love.graphics.setColor(GLOBALS.colors.darkgrey)
        love.graphics.rectangle("fill", GLOBALS.mX + 10, GLOBALS.mY - 60, 300,80)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.hovertext, GLOBALS.mX + 15, GLOBALS.mY- 55)
        if  player.aliveness - self.prices.a <= 0 then
            love.graphics.setColor(1,1,0)
            love.graphics.print("You may die", self.x + 15, self.y + 38)
            love.graphics.setColor(1,1,1)
        end
    end
end

function Burger:action()
 

    print("eating Burger..")

    if player.money >= 5 then
        player.fat = player.fat + 3
        gameWorldTimeAdjust(1)
        Button:progressBar(1)
        local s = Sounds.burger:play()
        player.lvls.Fat = player.lvls.Fat + 1

        if player.lvls.Fat > 88 then
            print(player.maxenergy)
            if player.maxenergy > 1 then
                player.maxenergy = player.maxenergy - 1
            end
        end
      
        
        player.money = player.money - self.prices.c

        if love.math.random() > 0.5 then
            player:showResolution(1)
            player.energy = player.energy + self.prices.e
        else
            player:showResolution(0)
            player.aliveness = player.aliveness - self.prices.a
            if player.aliveness <= 0 or player.energy <= 0 then
                player:die("The rotten meat really hit you hard\nYou had diarrhea so explosive that your head exploded")
            end
        end
    else
        player:showCant()
    end
 
   
    




    

end

return Burger