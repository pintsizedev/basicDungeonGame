EntityManager = {}
EntityManager.__index = EntityManager

setmetatable(EntityManager, {
	__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

-- @param entityTable = Table containing how many of each entity
function EntityManager:_init(entityTable, collision)
	self.Player = nil
	self.Mobs = {}
	self.Chests = {}
	self.Booty = {}
	self:populate(entityTable, collision)
end

local function get_free_spaces(collision)
	local freeSpaces = {}
	for i, row in ipairs(collision.data) do
		for j, col in ipairs(row) do
			if col == 0 then
				table.insert(freeSpaces, {y= i, x=j})
			end
		end
	end
	return freeSpaces
end

function EntityManager:populate(entityTable, collision)
	local freeSpaces = get_free_spaces(collision) 
	local tileIndex = math.random(1, (#freeSpaces))
	local playerTile = freeSpaces[tileIndex]
	self.Player = Player(playerTile.x, playerTile.y)
	table.remove(freeSpaces, tileIndex)
	for i = 1, entityTable.mobs, 1 do
		local tileIndex = math.random(1, (#freeSpaces))
		local mobTile = freeSpaces[tileIndex]
		table.insert(self.Mobs, Mob(mobTile.x, mobTile.y))
		table.remove(freeSpaces, tileIndex)
	end
	for i = 1, entityTable.chests, 1 do
		local tileIndex = math.random(1, (#freeSpaces))
		local chestTile = freeSpaces[tileIndex]
		table.insert(self.Chests, Chest(chestTile.x, chestTile.y))
		table.remove(freeSpaces, tileIndex)
	end
end

function EntityManager:occupiedTiles()
	local collisionTiles = {}
	table.insert(collisionTiles, self.Player:getTiles())
	for _, mob in ipairs(self.Mobs) do
		table.insert(collisionTiles, mob:getTiles())
	end
	for _, chest in ipairs(self.Chests) do
		table.insert(collisionTiles, chest:getTiles())
	end
	return collisionTiles
end

function EntityManager:hasCollided(xTile, yTile)
	local occupiedTiles = self:occupiedTiles()
	for _, entity in ipairs(occupiedTiles) do
		if entity.x == xTile and entity.y == yTile then
			return true
		end
	end
	return false
end 

function EntityManager:draw()
	self.Player:draw()
	for _, mob in ipairs(self.Mobs) do
		mob:draw()
	end
	for _, chest in ipairs(self.Chests) do
		chest:draw()
	end
	for _, booty in ipairs(self.Booty) do
		booty:draw()
	end
end

function EntityManager:updateMobs(collision)
	for _, mob in ipairs(self.Mobs) do 
		mob:update(collision)
	end 
end

function EntityManager:getChests()
	return self.Chests 
end 

function EntityManager:getEntity(xTile, yTile)
	if self.Player.xTile == xTile and self.Player.yTile == yTile then
		return self.Player
	end
	for _, mob in ipairs(self.Mobs) do
		if mob.xTile == xTile and mob.yTile == yTile then
			return mob
		end
	end
	for _, chest in ipairs(self.Chests) do
		if chest.xTile == xTile and chest.yTile == yTile then
			return chest
		end
	end
	for _, booty in ipairs(self.Booty) do
		if booty.xTile == xTile and booty.yTile == yTile then
			return booty
		end
	end
	return nil
end

function EntityManager:addBooty(chest)
	local booty = chest:dropBooty()
	table.insert(self.Booty, booty)
end

function EntityManager:update(dt)
	self.Player:checkForBooty(self.Booty)
	for i, chest in ipairs(self.Chests) do
		if not chest.animation.hasRun then
			chest:update(dt)
		else
			self:addBooty(chest)
			table.remove(self.Chests, i)
		end
	end 
	for i, booty in ipairs(self.Booty) do
		if not booty.animation.hasRun then
			booty:update(dt)
		end
		if booty.pickedUp then
			table.remove(self.Booty, i) 
		end
	end
end