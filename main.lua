local sti = require("sti")
WIDTH = 896
HEIGHT = 640

function playerSetup()
	love.window.setTitle("Dungeon Game")
	map:addCustomLayer("PlayerLayer", 2)
	playerLayer = map.layers["PlayerLayer"]
	playerLayer.Player = require("classes/Player")
	Player = playerLayer.Player
	function playerLayer:draw()
		Player:draw()
	end 
end


function love.load()
	map = sti.new("maps/test")
	collision = map:getCollisionMap("Collision")
	love.window.setMode(WIDTH, HEIGHT)
	playerSetup()
end

function love.update(dt)

end

function love.keypressed(key)
	if key == "left" and not Player:collision(collision, -1, 0) then
		Player.x = Player.x - 16
		Player.tileX = Player.tileX - 1
	end
	if key == "right" and not Player:collision(collision, 1, 0) then
		Player.x = Player.x + 16
		Player.tileX = Player.tileX + 1
	end
	if key == "up" and not Player:collision(collision, 0, -1) then 
		Player.y = Player.y - 16
		Player.tileY = Player.tileY - 1
	end
	if key == "down" and not Player:collision(collision, 0, 1) then 
		Player.y = Player.y + 16
		Player.tileY = Player.tileY + 1
	end
end

function love.draw()
	map:draw(4, 4)
	-- Player:draw()
end