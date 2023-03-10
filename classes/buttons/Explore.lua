local Explore = Button:extend("Explore")

function Explore:init(x, y)
    Button.init(
        self, 
        x, 
        y, 
        168,
        64,
        "Explore",
        love.graphics.newImage('assets/pic/button.png'),
        {e = 2, a = 0},
        "Look around.\nTakes 2 Energy"
    )

    self.levelup = 20

   
end

function Explore:draw()
    if playerState.state == playerState.states.city and playerState.state ~= playerState.states.progressing then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(self.img, self.x, self.y)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.name, self.x + 25, self.y + 25)
    end
    if self.hovered and playerState.state ~= playerState.states.progressing then
        love.graphics.setColor(GLOBALS.colors.darkgrey)
        love.graphics.rectangle("fill", GLOBALS.mX + 10, GLOBALS.mY - 60, 200,60)
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.print(self.hovertext, GLOBALS.mX + 15, GLOBALS.mY- 55)
        if player.energy - self.prices.e <= 0 or player.aliveness - self.prices.a <= 0 then
            love.graphics.setColor(1,1,0)
            love.graphics.print("You may die", self.x + 15, self.y + 38)
            love.graphics.setColor(1,1,1)
        end
    end

    for i = 1, self.levelup do
        love.graphics.setColor(GLOBALS.colors.white)
        love.graphics.rectangle("line", (GLOBALS.scrw - 330) + i * 10, 222, 10, 10)
    end
    if player.explorer >= 1 then
        for i = 1, player.explorer do
            love.graphics.setColor(GLOBALS.colors.yellow)
            love.graphics.rectangle("fill", (GLOBALS.scrw - 330) + i * 10, 222, 10, 10)
            love.graphics.setColor(GLOBALS.colors.white)
        end
    end

    love.graphics.print("Exploration", GLOBALS.scrw-320, 202)
    

end

function Explore:action()
    print("exploring..")

    Button:progressBar(2)
    

    gameWorldTimeAdjust(2)
    local s = Sounds.explore:play()
   

    player.explorer = player.explorer + 1
    if player.explorer == self.levelup then
        player.explorer = 0
        player.lvls.Explorer = player.lvls.Explorer + 1
    end

    if cityMap.explorationlevel < 100 and player.energy ~= 0 then
        cityMap.explorationlevel = cityMap.explorationlevel + 1 + player.lvls.Explorer
        player.energy = player.energy - self.prices.e
        if player.aliveness <= 0 or player.energy <= 0 then
            player:die("You got tired and stepped in front of a bus.")
        end
    end

    if cityMap.explorationlevel == 3 then
        local pos = love.math.random(#HOUSES)
        table.insert(POIs, Factory(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
        table.remove(HOUSES, pos)
        player:showResolution(1)
    end
    if cityMap.explorationlevel == 9 then
        local pos = love.math.random(#HOUSES)
        table.insert(POIs, Dealer(HOUSES[pos].x * 32, HOUSES[pos].y * 32))  
        table.remove(HOUSES, pos)
        player:showResolution(1)
    end
    if cityMap.explorationlevel == 18 then
        local pos = love.math.random(#HOUSES)
        table.insert(POIs, Pub(HOUSES[pos].x * 32, HOUSES[pos].y * 32))  
        table.remove(HOUSES, pos)
        player:showResolution(1)
    end

    if cityMap.explorationlevel >= 90 and player.foundbus ~= true then
        local pos = love.math.random(#HOUSES)
        table.insert(POIs, Busstop(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
        player.foundbus = true
        table.remove(HOUSES, pos)
        player:showResolution(1)
    end

    if cityMap.explorationlevel > 21 then
        
        local rnd = love.math.random(1,4)
        if rnd == 1 and not player.foundfriendlyhome then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, FriendlyHouse(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundfriendlyhome = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        elseif rnd == 2 and not player.foundcasino then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Casino(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundcasino = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
    end

    if cityMap.explorationlevel > 41 then
        local rnd = love.math.random(1,7)
        if rnd == 1  and not player.foundcafe then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Cafe(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundcafe = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        elseif rnd == 2 and not player.foundmovie then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Cinema(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundmovie = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        elseif rnd == 3 and not player.foundchurch then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Church(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundchurch = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        elseif rnd == 4 and not player.foundmeki then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, FastFood(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundmeki = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        elseif rnd == 5 and not player.foundgym then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Gym(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundgym = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
    end

    if cityMap.explorationlevel >= 100 then
        cityMap.explorationlevel = 100
        if player.foundcasino ~= true then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Casino(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundcasino = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
        if player.foundfriendlyhome ~= true then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, FriendlyHouse(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundfriendlyhome = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end

        if not player.foundcafe then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Cafe(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundcafe = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
        if not player.foundmovie then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Cinema(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundmovie = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
        if not player.foundchurch then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Church(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundchurch = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
        if not player.foundmeki then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, FastFood(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundmeki = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end
        if not player.foundgym then
            local pos = love.math.random(#HOUSES)
            table.insert(POIs, Gym(HOUSES[pos].x * 32, HOUSES[pos].y * 32))
            player.foundgym = true
            table.remove(HOUSES, pos)
            player:showResolution(1)
        end

    end

   
    

end

return Explore