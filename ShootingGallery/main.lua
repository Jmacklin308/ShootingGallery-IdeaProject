function love.load()
    target = {}
    target.x = love.graphics.getWidth()*.5
    target.y = love.graphics.getHeight()*.5

    target.radius = 50

    --Game properties
    score = 0
    highScore = 0
    timer = 0 --in seconds
    gameState = 1 -- 1 = main menu, 2 = in session
    textFontSize = 40
    scorePenalty = 1 -- pts loss per miss


    --sprites
    sprites = {}
    sprites.background = love.graphics.newImage("res/sky.png")
    sprites.target = love.graphics.newImage("res/target.png")
    sprites.crosshairs = love.graphics.newImage("res/crosshairs.png")


    ----turn off mouse cursor
    love.mouse.setVisible(false)
end


function love.update(dt)
    --start timer
    if timer > 0 and gameState == 2 then
        timer = timer - dt;
    end
    --lock the timer at 0 once below
    if timer < 0 then
        timer = 0
        gameState = 1
        if score > highScore then
            highScore = score
        end
        score = 0
    end
end

function love.draw()
    --draw background
    love.graphics.draw(sprites.background,0,0)

    -- draw the score
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(textFontSize)
    love.graphics.print("Score :"..score, 0,0)


    -- draw the highScore
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(textFontSize)
    love.graphics.print("High Score: "..highScore, 0,textFontSize)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin",0,250,love.graphics.getWidth(),"center")
    elseif gameState == 2 then
        -- draw timer
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setNewFont(textFontSize)
        love.graphics.print(math.ceil(timer),love.graphics.getWidth()/2,0)
        ---- draw target
        love.graphics.draw(sprites.target,target.x-target.radius,target.y-target.radius)
    end



    ----crosshairs
    love.graphics.draw(sprites.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
end

function love.mousepressed(x,y,button,istouch,presses)
    if button == 1 and gameState == 2 then
        local mouseToTarget = distanceToTarget(x,y,target.x,target.y)
        if mouseToTarget < target.radius then -- count hit
            score = score + 1
            target.x = math.random(target.radius,love.graphics.getWidth()-target.radius)
            target.y = math.random(target.radius,love.graphics.getHeight()-target.radius)
        elseif mouseToTarget > target.radius and gameState == 2 then --count miss
            score = score - scorePenalty
            if score <= 0 then
                score = 0
                gameState = 1 -- end game
            end
        end
    elseif button == 1 and gameState == 1 then  -- Pause the game at first. Press shoot to start the game
        gameState = 2
        timer = 10
    end
end


function distanceToTarget(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end