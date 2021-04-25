function love.load()
    target = {}
    target.x = love.graphics.getWidth()*.5
    target.y = love.graphics.getHeight()*.5

    target.radius = 50

    --Score, timer, etc
    score = 0
    timer = 0

    --set the game font

end


function love.update(dt)
    -- update score upon target click
end

function love.draw()
    --draw the target
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    -- draw the score and timer
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(score, 0,0)

end

-- we have to add our own code to the mousepressed function (makes sense)
function love.mousepressed(x,y,button,istouch,presses)
    if button == 1 then
        local mouseToTarget = distanceToTarget(x,y,target.x,target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(0+target.radius,love.graphics.getWidth()-target.radius)
            target.y = math.random(0+target.radius,love.graphics.getHeight()-target.radius)
        end
    end
end


function distanceToTarget(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end