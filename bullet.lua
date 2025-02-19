-- bullet.lua
local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, speed, direction)
    local instance = setmetatable({}, Bullet)
    instance.x = x
    instance.y = y
    instance.speed = speed
    instance.direction = direction
    instance.width = 5
    instance.height = 5
    return instance -- Ensure it returns the instance
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt * math.cos(self.direction)
    self.y = self.y + self.speed * dt * math.sin(self.direction)
end

function Bullet:draw()
    love.graphics.setColor(1, 1, 0) -- Yellow color
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Bullet:isOffScreen()
    return self.x < 0 or self.x > love.graphics.getWidth() or self.y < 0 or self.y > love.graphics.getHeight()
end

return Bullet