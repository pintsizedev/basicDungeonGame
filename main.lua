require("classes/Animation")
require("classes/Chest")
require("classes/Mob")
require("classes/MobManager")

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
	entityLayer.Mobs = MobManager(collision, 5)
	entityLayer.Chest = Chest(32, 32)
	Player, Mobs, Chest = entityLayer.Player, entityLayer.Mobs, entityLayer.Chest
	function entityLayer:update(dt)
		Chest:update(dt)
	end 
	function entityLayer:getCollisionInfo()
		local collisionTiles = {}
		table.insert(collisionTiles, {x = Player.tileX, y = Player.tileY})
		for _, mob in ipairs(Mobs.MobManager) do
			table.insert(collisionTiles, {x = mob.xTile, y = mob.yTile})
		end
		table.insert(collisionTiles, {x = Chest.xTile, y = Chest.yTile})
		return collisionTiles
	end
	function entityLayer:checkCollision(x, y)
		for _, entity in ipairs(entityLayer:getCollisionInfo()) do
			if entity.x == x and entity.y == y then
				return true
			end
		end
		return false
	end	
	function entityLayer:draw()
		Player:draw()
		Mobs:draw()
		Chest:draw()
	end 
end

function newGame()
	map = sti.new("maps/basic")
	collision = map:getCollisionMap("Collision")
	entitySetup()
	playing = true
end

function love.load()
	love.graphics.setBackgroundColor(47, 40, 58)
	love.window.setTitle("Dungeon Game")
	love.window.setMode(WIDTH, HEIGHT)
end

function love.update(dt)
	if playing then 
		map:update(dt)
	end
end

function love.keypressed(key)
	if not playing and (key == "enter" or key =="return") then
		newGame()
	elseif playing then
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
end

function love.draw()
	if playing then
		map:draw(2, 2)
		love.graphics.print("Player Tiles: " .. Player.tileX .. "," .. Player.tileY, 650, 10)
		Player:printHealth(650, 30)
	else
		message = "Press ENTER to begin."
		width = Font:getWidth(message)
		love.graphics.print(message, (WIDTH/2)-(width/2), HEIGHT/2)
	end
end