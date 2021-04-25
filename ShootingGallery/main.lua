function love.load()
    target = {}
    target.x = love.graphics.getWidth()*.5
    target.y = love.graphics.getHeight()*.5

    target.radius = 50

    --Score, timer, etc
    score = 0
    timer = 10 --seconds

end


function love.update(dt)
    --start timer
    if timer > 0 then
        timer = timer - dt;
    end

    if timer < 0 then
        timer = 0;
    end
end

function love.draw()
    --draw the target
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    -- draw the score
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(40)
    love.graphics.print(score, 0,0)


    -- draw timer
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setNewFont(40)
    love.graphics.print(math.ceil(timer),love.graphics.getWidth()/2,0)

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