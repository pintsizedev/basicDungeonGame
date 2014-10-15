local game = {}

local function entitySetup(collision)
	map:addCustomLayer("Entities", 2)
	entityLayer = map.layers["Entities"]
	local entityInfo = {mobs = 2, chests = 2}
	entityLayer.Manager = EntityManager(entityInfo, collision)
	Player, Entities = entityLayer.Manager.Player, entityLayer.Manager
	function entityLayer:update(dt)
		Entities:update(dt)
	end
	function entityLayer:draw()
		Entities:draw()
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
	map:draw(2, 2)
	Player:printInfo(10)
end

return game