

function love.load()

    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0

    gameState = 1

    --set a default font with a size of 40
    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.crosshairs = love.graphics.newImage("sprites/crosshairs.png")
    sprites.sky = love.graphics.newImage("sprites/sky.png")
    sprites.target = love.graphics.newImage("sprites/target.png")

    love.mouse.setVisible(false)

end

function love.update(dt)
    --si Partie en cours
    if gameState == 2 then
        --Si Timer Audessus de zero, alors poursuite du compte à rebours
        if timer > 0 then
            timer = timer - dt
        end
        --Si Timer < 0 alors reset Timer et switch de la scène à celle du GameMenu. Le score n'est pas reset.
        if timer < 0 then
            timer = 0
            gameState = 1
        end
    end
    
end

function love.draw()

    love.graphics.draw(sprites.sky, 0, 0)
    
    
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: "..score, 5, 5)
    --math.ceil = number rounded and truncated to the superior value 
    --math.floor = number rounded and truncated to the inferior value 
    love.graphics.print("Time: "..math.ceil(timer), 300, 5)
    if gameState == 1 then
        --text, x, y, limit (en px avant wrapping), align, r, sx, sy, ox, oy, kx, ky
        love.graphics.printf("Click anywhere to begin !", 0, 250, love.graphics.getWidth(), "center")
    end

    --Si PArtie en cours...
    if gameState==2 then
        --Affichage targets
        love.graphics.draw(sprites.target, target.x, target.y, 0, 1, 1, sprites.target:getWidth()/2, sprites.target:getHeight()/2)
    end

    --Affichage du Pointeur
    love.graphics.draw(sprites.crosshairs, love.mouse.getX(), love.mouse.getY(), 0, 1, 1, sprites.crosshairs:getWidth()/2, sprites.crosshairs:getHeight()/2)

end

function love.mousepressed( x, y, button, istouch, presses )
    --Left Click ET partie en cours (gamestate == 2)
    if button == 1 and gameState == 2 then 
        --CHECK DISTANCE
        local mouseToTarget = distanceBetween(target.x, target.y, x, y)
        if mouseToTarget < target.radius then
            score = score + 1
            -- Random Position  (min, max). Include Target radius for targets uncted by the window border
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end
    end

    --Si clic gauche et MEnu de départ
    if button == 1 and gameState == 1 then
        gameState = 2 --Scène set à scène de jeu
        timer = 10--reset timer
        score = 0--reset score
    end
end

function distanceBetween(x1, y1, x2, y2)
    -- Formule de calcul de la distance entre deux points dans un repère orthonormé
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end