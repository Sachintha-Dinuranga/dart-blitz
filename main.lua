-- load, update, draw

-- run immediately when the game loads - declare any variables here
function love.load()
   target = {}
   target.x = 300
   target.y = 300
   target.radius = 50

   score = 0
   timer = 0

   gameFont = love.graphics.newFont(40)
end

-- game loop (call every frame that game is running) - 60 fps
function love.update(dt)
    
end


-- drawing graphic to the screen(anything invole graphic and images)
function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0, 0)
end  


function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)      
        end
    end
end

-- get target x, y postition value, radius and mouse x, y position value 
function distanceBetween(x1, y1, x2, y2)
   return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end