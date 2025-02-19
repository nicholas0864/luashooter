-- block.lua
local Block = {}
Block.__index = Block

function Block:new(x, y, width, height, vx, vy)
    local instance = setmetatable({}, Block)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.vx = vx or 0  -- velocity in x direction
    instance.vy = vy or 0  -- velocity in y direction
    return instance
end

function Block:draw()
    love.graphics.setColor(0, 1, 0) -- green color
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Block:update(dt, player)
    local oldX, oldY = self.x, self.y  -- Store old position
    self:move(dt)  -- Move the block

    -- Ensure player exists before checking for collision
    if player and self:collidesWith(player) then
        -- If collision, push player in the same direction as the block
        local overlapX = math.min(self.x + self.width - player.x, player.x + player.width - self.x)
        local overlapY = math.min(self.y + self.height - player.y, player.y + player.height - self.y)

        if overlapX < overlapY then
            -- Horizontal collision
            if self.x > oldX then  -- Block moving right
                player.x = self.x + self.width
            elseif self.x < oldX then  -- Block moving left
                player.x = self.x - player.width
            end
        else
            -- Vertical collision
            if self.y > oldY then  -- Block moving down
                player.y = self.y + self.height
            elseif self.y < oldY then  -- Block moving up
                player.y = self.y - player.height
            end
        end
    end
end



function Block:move(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    -- Check for collisions with screen borders and reverse direction if needed
    if self.x < 0 or self.x + self.width > love.graphics.getWidth() then
        self.vx = -self.vx
    end
    if self.y < 0 or self.y + self.height > love.graphics.getHeight() then
        self.vy = -self.vy
    end
end


function Block:collidesWith(player)
    return self.x < player.x + player.width and
           self.x + self.width > player.x and
           self.y < player.y + player.height and
           self.y + self.height > player.y
end

return Block