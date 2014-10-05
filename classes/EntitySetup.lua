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