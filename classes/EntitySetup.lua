function entitySetup(collision)
	map:addCustomLayer("Entities", 2)
	entityLayer = map.layers["Entities"]
	local entityInfo = {mobs = 2, chests = 2}
	entityLayer.Manager = EntityManager(entityInfo, collision)
	Player, Entities = entityLayer.Manager.Player, entityLayer.Manager
	function entityLayer:update(dt)
		Entities:updateChests(dt)
	end
	function entityLayer:draw()
		Entities:draw()
	end 
end