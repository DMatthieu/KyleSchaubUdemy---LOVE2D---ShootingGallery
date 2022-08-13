

function love.load()

    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 10

    --set a default font with a size of 40
    gameFont = love.graphics.newFont(40)

end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
    end
    

end

function love.draw()
    love.graphics.setColor(1,0,0) -- Red
    love.graphics.circle("fill", target.x, target.y, target.radius)

    love.graphics.setColor(1,1,1) --White
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0, 0)
    --math.ceil = number rounded and truncated to the superior value 
    --math.floor = number rounded and truncated to the inferior value 
    love.graphics.print(math.ceil(timer), 300, 0)
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 then --Left Click
        --CHECK DISTANCE
        local mouseToTarget = distanceBetween(target.x, target.y, x, y)
        if mouseToTarget < target.radius then
            score = score + 1
            -- Random Position  (min, max). Include Target radius for targets uncted by the window border
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end
    end
end

function distanceBetween(x1, y1, x2, y2)
    -- Formule de calcul de la distance entre deux points dans un repère orthonormé
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end