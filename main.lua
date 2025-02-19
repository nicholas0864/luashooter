-- main.lua

-- Load the player module
local player = require("player")
local Block = require("block")

local blocks = {}

function love.load()
    -- Initialize the player here (optional if defaults are fine)
    player.init(400, 300, 50, 50, 200)  -- x, y, width, height, speed
    table.insert(blocks, Block:new(200, 200, 50, 50, 100, 0))  -- Moving block
    table.insert(blocks, Block:new(100, 100, 100, 100, 0, 100))  -- Moving block
    table.insert(blocks, Block:new(300, 300, 50, 50))  -- Static block
end

function love.update(dt)
    player.update(dt, blocks)  -- Update player position with collision detection
    for _, block in ipairs(blocks) do
        block:update(dt, player)  -- Pass player to block's update function
    end
end

function love.draw()
    player.draw()  -- Draw the player
    for _, block in ipairs(blocks) do
        block:draw()
    end
end