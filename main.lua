require("classes/Mob")

local sti = require("sti")
local Font = love.graphics.newFont("fonts/Orbitron-Regular.ttf", 18)
love.graphics.setFont(Font)
WIDTH = 896
HEIGHT = 640

function playerSetup()
	map:addCustomLayer("PlayerLayer", 2)
	playerLayer = map.layers["PlayerLayer"]
	playerLayer.Player = require("classes/Player")
	Player = playerLayer.Player
	function playerLayer:draw()
		Player:draw()
	end 
end

function mobSetup()
	map:addCustomLayer("MobLayer", 3)
	mobLayer = map.layers["MobLayer"]
	mobLayer.Mob = Mob(32, 32)
	Mob = mobLayer.Mob
	function mobLayer:draw()
		Mob:draw()
	end
end


function love.load()
	love.graphics.setBackgroundColor(47, 40, 58)
	love.window.setTitle("Dungeon Game")
	map = sti.new("maps/basic")
	collision = map:getCollisionMap("Collision")
	love.window.setMode(WIDTH, HEIGHT)
	playerSetup()
	mobSetup()
end

function love.update(dt)
	
end

function love.keypressed(key)
	if key == "left" and not Player:collision(collision, -1, 0) then
		Player.x = Player.x - 16
		Player.tileX = Player.tileX - 1
		Mob:move(collision)
	end
	if key == "right" and not Player:collision(collision, 1, 0) then
		Player.x = Player.x + 16
		Player.tileX = Player.tileX + 1
		Mob:move(collision)
	end
	if key == "up" and not Player:collision(collision, 0, -1) then 
		Player.y = Player.y - 16
		Player.tileY = Player.tileY - 1
		Mob:move(collision)
	end
	if key == "down" and not Player:collision(collision, 0, 1) then 
		Player.y = Player.y + 16
		Player.tileY = Player.tileY + 1
		Mob:move(collision)
	end
end

function love.draw()
	map:draw(2, 2)
	love.graphics.print("Player Tiles: " .. Player.tileX .. "," .. Player.tileY, 650, 10)
	love.graphics.print("Mob tiles: " .. Mob.xTile .. "," .. Mob.yTile, 650, 30)
end