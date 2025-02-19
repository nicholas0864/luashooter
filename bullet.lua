-- bullet.lua
local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, speed, direction)
    local instance = setmetatable({}, Bullet)
    instance.x = x
    instance.y = y
    instance.speed = speed
    instance.direction = direction  -- Store direction here
    instance.width = 5
    instance.height = 5
    return instance
end

function Bullet:update(dt, blocks)
    -- Move the bullet
    self.x = self.x + math.cos(self.direction) * self.speed * dt  -- Use self.direction here
    self.y = self.y + math.sin(self.direction) * self.speed * dt  -- Use self.direction here

    -- Check collision with blocks
    local hitBlock = self:checkCollision(blocks)
    if hitBlock then
        -- Get normal direction (assumes rectangular blocks)
        local bulletDX = math.cos(self.direction)
        local bulletDY = math.sin(self.direction)

        -- Determine whether to reflect on X or Y
        local bulletCenterX = self.x + self.width / 2
        local bulletCenterY = self.y + self.height / 2
        local blockCenterX = hitBlock.x + hitBlock.width / 2
        local blockCenterY = hitBlock.y + hitBlock.height / 2

        local dx = bulletCenterX - blockCenterX
        local dy = bulletCenterY - blockCenterY

        if math.abs(dx) > math.abs(dy) then
            -- Hit from left/right, reverse X direction
            self.direction = math.atan2(bulletDY, -bulletDX)  -- Change self.angle to self.direction
        else
            -- Hit from top/bottom, reverse Y direction
            self.direction = math.atan2(-bulletDY, bulletDX)  -- Change self.angle to self.direction
        end
    end
end


function Bullet:draw()
    love.graphics.setColor(1, 1, 0) -- Yellow color
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Bullet:isOffScreen()
    return self.x < 0 or self.x > love.graphics.getWidth() or self.y < 0 or self.y > love.graphics.getHeight()
end

function Bullet:checkCollision(blocks)
    for _, block in ipairs(blocks) do
        if self.x < block.x + block.width and
           self.x + self.width > block.x and
           self.y < block.y + block.height and
           self.y + self.height > block.y then
            return block  -- Return the block the bullet collides with
        end
    end
    return nil
end



return Bullet