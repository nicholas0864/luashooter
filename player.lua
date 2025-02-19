local player = {}
local Bullet = require("bullet")

function player.init(x, y, width, height, speed)
    player.x = x
    player.y = y
    player.width = width
    player.height = height
    player.speed = speed
    player.bullets = {}
    player.shootCooldown = 0.2
    player.timeSinceLastShot = 0
end

function player.update(dt, blocks)
    local dx, dy = 0, 0
    if love.keyboard.isDown("a") then
        dx = -player.speed * dt
    elseif love.keyboard.isDown("d") then
        dx = player.speed * dt
    end
    if love.keyboard.isDown("w") then
        dy = -player.speed * dt
    elseif love.keyboard.isDown("s") then
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
    
    for i = #player.bullets, 1, -1 do
        local bullet = player.bullets[i]
        bullet:update(dt, blocks)  -- Pass the blocks list
        if bullet:isOffScreen() then
            table.remove(player.bullets, i)
        end
    end
    

    -- Handle shooting with mouse
    player.timeSinceLastShot = player.timeSinceLastShot + dt
    if love.mouse.isDown(1) and player.timeSinceLastShot >= player.shootCooldown then  -- Left mouse button
        local mouseX, mouseY = love.mouse.getPosition()
        player:shoot(mouseX, mouseY)
        player.timeSinceLastShot = 0
    end
end

function player.draw()
    love.graphics.setColor(1, 0, 0) -- Red color
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    -- Draw bullets
    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end
end

function player:shoot(targetX, targetY)
    -- Calculate the direction vector from player to target
    local dx = targetX - (self.x + self.width / 2)
    local dy = targetY - (self.y + self.height / 2)

    -- Normalize direction to make movement consistent
    local length = math.sqrt(dx * dx + dy * dy)
    if length > 0 then
        dx = dx / length
        dy = dy / length
    end

    print("Shooting at:", targetX, targetY, "Direction:", dx, dy)

    -- Calculate the angle for bullet movement
    local angle = math.atan2(dy, dx)
    
    -- Create and add the bullet
    local bullet = Bullet:new(self.x + self.width / 2, self.y + self.height / 2, 300, angle)
    table.insert(self.bullets, bullet)
end



-- Collision function
function checkCollision(x, y, w, h, block)
    return x < block.x + block.width and
           x + w > block.x and
           y < block.y + block.height and
           y + h > block.y
end

return player