function love.load()
    target = {}
    target.x = love.graphics.getWidth()*.5
    target.y = love.graphics.getHeight()*.5

    target.radius = 50

    --Score, timer, etc
    score = 0
    timer = 10 --seconds


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
    if timer > 0 then
        timer = timer - dt;
    end
    --lock the timer at 0 once below
    if timer < 0 then
        timer = 0;
    end
end

function love.draw()
    --draw background
    love.graphics.draw(sprites.background,0,0)

    -- draw the score
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(40)
    love.graphics.print(score, 0,0)

    -- draw timer
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(40)
    love.graphics.print(math.ceil(timer),love.graphics.getWidth()/2,0)

    ---- draw target
    love.graphics.draw(sprites.target,target.x-target.radius,target.y-target.radius)


    ----crosshairs
    love.graphics.draw(sprites.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20)
end

function love.mousepressed(x,y,button,istouch,presses)
    if button == 1 then
        local mouseToTarget = distanceToTarget(x,y,target.x,target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius,love.graphics.getWidth()-target.radius)
            target.y = math.random(target.radius,love.graphics.getHeight()-target.radius)
        end
    end
end


function distanceToTarget(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end