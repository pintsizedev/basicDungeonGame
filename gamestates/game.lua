local game = {}
local printx = 0
local printy = 0
local contents = "nil"
local function entitySetup(collision)
	map:addCustomLayer("Entities", 2)
	entityLayer = map.layers["Entities"]
	local entityInfo = {mobs = 5, chests = 5}
	entityLayer.Manager = EntityManager(entityInfo, collision)
	Player, Entities = entityLayer.Manager.Player, entityLayer.Manager
	function entityLayer:update(dt)
		Entities:update(dt)
	end
	function entityLayer:draw()
		Entities:draw()
	end 
end

function game:convertMouseToTile(x, y)
	xTile = math.floor(x / (16 * MAP_SCALE_X)) + 1
	yTile = math.floor(y / (16 * MAP_SCALE_Y)) + 1
	return xTile, yTile
end

function game:drawSelectedtile()
	love.graphics.setColor(255, 255, 255)
	local x, y = love.mouse:getPosition()
	if x <= (320 * MAP_SCALE_X) and y <= (320 * MAP_SCALE_Y) then
		local x = x - (x % (16 * MAP_SCALE_X))
		local y = y - (y % (16 * MAP_SCALE_Y))
		love.graphics.rectangle("line", x, y, (16 * MAP_SCALE_X), (16 * MAP_SCALE_Y))
	end
end

function game:enter(previous)
	map = sti.new("assets/maps/basic")
	collision = map:getCollisionMap("Collision")
	BootyRegister = require("classes/BootyRegister")
	entitySetup(collision)
end


function game:update(dt)
	map:update(dt)
end

function game:mousepressed(x, y, button)
	if button == "l" then
		xTile, yTile = self:convertMouseToTile(x, y)
		-- Following two lines for debug reasons
		printx, printy = self:convertMouseToTile(x, y)
		contents = Entities:getEntity(xTile, yTile)
		if contents then 
			contents = contents:getType()
		end
		if Player:checkAdjacent(xTile, yTile) and Entities:getEntity(xTile, yTile) then
			local tileContents = Entities:getEntity(xTile, yTile)
			if tileContents:getType() == "chest" then
				tileContents:open()
			end
		end
	end
end

function game:keypressed(key)
	if key == "left" and not Player:collision(collision, -1, 0) then
			Player:move(-1, 0)
			Entities:updateMobs(collision)
		end
	if key == "right" and not Player:collision(collision, 1, 0) then
		Player:move(1, 0)
		Entities:updateMobs(collision)
	end
	if key == "up" and not Player:collision(collision, 0, -1) then 
		Player:move(0, -1)
		Entities:updateMobs(collision)
	end
	if key == "down" and not Player:collision(collision, 0, 1) then 
		Player:move(0, 1)
		Entities:updateMobs(collision)
	end
	if key == "e" then
		local chestLocations = Entities:getChests()
		if #chestLocations > 0 then
			Player:openChest(chestLocations)
		end
	end
	if key == "u" then
		Entities:updateMobs(collision)
	end
end

function game:draw()
	map:draw(MAP_SCALE_X, MAP_SCALE_Y)
	self:drawSelectedtile()
	love.graphics.print(printx .. ","..printy, 650, 10)
	love.graphics.print(tostring(contents), 650, 30)
	Player:printInfo(50)

end

return game