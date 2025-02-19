local player = {}

function player.init(x, y, width, height, speed)
    player.x = x
    player.y = y
    player.width = width
    player.height = height
    player.speed = speed
end

function player.update(dt, blocks)
    local dx, dy = 0, 0
    if love.keyboard.isDown("left") then
        dx = -player.speed * dt
    elseif love.keyboard.isDown("right") then
        dx = player.speed * dt
    end
    if love.keyboard.isDown("up") then
        dy = -player.speed * dt
    elseif love.keyboard.isDown("down") then
        dy = player.speed * dt
    end

    -- Check collisions before moving
    local newX = player.x + dx
    local newY = player.y + dy

    for _, block in ipairs(blocks) do
        if checkCollision(newX, newY, player.width, player.height, block) then
            dx, dy = 0, 0  -- Stop movement on collision
            break
        end
    end

    player.x = player.x + dx
    player.y = player.y + dy
end

function player.draw()
    love.graphics.setColor(1, 0, 0) -- Red color
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

-- Collision function
function checkCollision(x, y, w, h, block)
    return x < block.x + block.width and
           x + w > block.x and
           y < block.y + block.height and
           y + h > block.y
end

return player
