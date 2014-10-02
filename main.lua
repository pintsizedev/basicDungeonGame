require("classes/Mob")
require("classes/Mobs")

local sti = require("sti")
local Font = love.graphics.newFont("fonts/Orbitron-Regular.ttf", 18)
love.graphics.setFont(Font)
WIDTH = 896
HEIGHT = 640
-- Set up proper random numbers
math.randomseed(os.time())
math.random() math.random() math.random()

function entitySetup()
	map:addCustomLayer("Entities", 2)
	entityLayer = map.layers["Entities"]
	entityLayer.Player = require("classes/Player")
	entityLayer.Mobs = Mobs(collision, 3)
	Player, Mobs = entityLayer.Player, entityLayer.Mobs
	function entityLayer:update(dt)
	end
	function entityLayer:draw()
		Player:draw()
		Mobs:draw()
	end 
end

function love.load()
	love.graphics.setBackgroundColor(47, 40, 58)
	love.window.setTitle("Dungeon Game")
	map = sti.new("maps/basic")
	collision = map:getCollisionMap("Collision")
	love.window.setMode(WIDTH, HEIGHT)
	entitySetup()
end

function love.update(dt)

end

function love.keypressed(key)
	if key == "left" and not Player:collision(collision, -1, 0) then
		Player.x = Player.x - 16
		Player.tileX = Player.tileX - 1
		Mobs:update(collision)
	end
	if key == "right" and not Player:collision(collision, 1, 0) then
		Player.x = Player.x + 16
		Player.tileX = Player.tileX + 1
		Mobs:update(collision)
	end
	if key == "up" and not Player:collision(collision, 0, -1) then 
		Player.y = Player.y - 16
		Player.tileY = Player.tileY - 1
		Mobs:update(collision)
	end
	if key == "down" and not Player:collision(collision, 0, 1) then 
		Player.y = Player.y + 16
		Player.tileY = Player.tileY + 1
		Mobs:update(collision)
	end
	if key == "u" then
		Mobs:update(collision)
	end
end

function love.draw()
	map:draw(2, 2)
	love.graphics.print("Player Tiles: " .. Player.tileX .. "," .. Player.tileY, 650, 10)
	Mobs:location()
end