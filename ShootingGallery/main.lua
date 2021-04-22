function love.load()
    target = {}
    target.x = love.graphics.getWidth()*.5
    target.y = love.graphics.getHeight()*.5

    target.radius = 50

    --Score, timer, etc
    score = 0
    timer = 0

    --set the game font
    gameFont = love.graphics.newFont(40)


end


function love.update(dt)
    -- update score uppon target click


end

function love.draw()
    --draw the target
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    -- draw the score and timer
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0,0)

end

-- we have to add our own code to the mousepressed function (makes sense)
function love.mousepressed(x,y,button,istouch,presses)
    if button == 1 then
        score = score + 1
    end
end