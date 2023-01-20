local Coffee = Button:extend("Coffee")

function Coffee:init(x, y)
    Button.init(
        self, 
        x, 
        y, 
        168,
        64,
        "Coffee",
        love.graphics.newImage('assets/pic/button.png'),
        {e=2,ef=2,c=10},
        "Costs 10$\nGives 2 energy"
    )

   
end

function Coffee:draw()
   
    if playerState.state == playerState.states.poiresolution and playerState.state ~= playerState.states.progressing then
        love.graphics.draw(self.img, self.x, self.y)
        love.graphics.print(self.name, self.x + 25, self.y + 25)
    end

    
    if self.hovered then
        love.graphics.print(self.hovertext, GLOBALS.mX + 100, GLOBALS.mY)
    end

end

function Coffee:action()
 

    print("drinking coffee..")
 
    if player.money >= 5 then
        gameWorldTimeAdjust(1)
        Button:progressBar(0.1)
      
           
                player:showResolution(1)
                player.energy = player.energy + self.prices.e
      
                player.money = player.money - self.prices.c

   
    else
        player:showCant()
    end
    




    

end

return Coffee