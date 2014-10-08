require("classes/Animation")
require("classes/Chest")
require("classes/Entity")
require("classes/EntitySetup")
require("classes/Mob")
require("classes/MobManager")
require("classes/Player")
local sti = require("sti")

local Font = love.graphics.newFont("assets/fonts/Orbitron-Regular.ttf", 18)
love.graphics.setFont(Font)

WIDTH = 896
HEIGHT = 640
-- Set up proper random numbers
math.randomseed(os.time())
math.random() math.random() math.random()

function newGame()
	map = sti.new("assets/maps/basic")
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
			Player.xTile = Player.xTile - 1
			Mobs:update(collision)
		end
		if key == "right" and not Player:collision(collision, 1, 0) then
			Player.x = Player.x + 16
			Player.xTile = Player.xTile + 1
			Mobs:update(collision)
		end
		if key == "up" and not Player:collision(collision, 0, -1) then 
			Player.y = Player.y - 16
			Player.yTile = Player.yTile - 1
			Mobs:update(collision)
		end
		if key == "down" and not Player:collision(collision, 0, 1) then 
			Player.y = Player.y + 16
			Player.yTile = Player.yTile + 1
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
		love.graphics.print(tostring(Player.x), 650, 10)
		Player:printHealth(650, 30)
		local pX, pY = Player:getTiles()
		love.graphics.print("Player Tiles: "..pX.." , "..pY, 650, 50)
	else
		message = "Press ENTER to begin."
		width = Font:getWidth(message)
		love.graphics.print(message, (WIDTH/2)-(width/2), HEIGHT/2)
	end
end