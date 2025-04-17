-- load, update, draw

-- run immediately when the game loads - declare any variables here
function love.load()
   -- target config
   target = {}
   target.x = 300
   target.y = 300
   target.radius = 50

   score = 0
   timer = 0
    -- define game state to track in gaming (game state one mean main menu)
   gameState = 1

   -- font size
   gameFont = love.graphics.newFont(40)

   -- load sprites
   sprites = {}
   sprites.sky = love.graphics.newImage('sprites/sky.png')
   sprites.target = love.graphics.newImage('sprites/target.png')
   sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

   -- hide the mouse pointer
   love.mouse.setVisible(false)
end

-- game loop (call every frame that game is running) - 60 fps
function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 0
        gameState = 1
    end
end


-- drawing graphic to the screen(anything invole graphic and images)
function love.draw()
    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.circle("fill", target.x, target.y, target.radius)

    -- set window title
    love.window.setTitle( "DartBlitz" )
   
    -- set the background (need to draw first)
    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5, 5)

    -- timer (nearest integer)
    love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

    -- main menu
    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, 250, love.graphics.getWidth(), "center")
    end

    -- draw target
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    -- draw crosshair
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)


end  


function love.mousepressed( x, y, button, istouch, presses )
    if gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            if button == 1 then
                score = score + 1
            elseif button == 2 then
                score = score + 2
                timer = timer -1
            end
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)      
        elseif mouseToTarget > target.radius then
            if score > 0 then
                score = score - 1
            end
        end  
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

-- get target x, y postition value, radius and mouse x, y position value 
function distanceBetween(x1, y1, x2, y2)
   return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end