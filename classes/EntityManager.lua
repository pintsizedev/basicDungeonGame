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
	self.Player = Player(2, 3)
	self.Mobs = {}
	self.Chests = {}
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
	for i = 1, entityTable.mobs, 1 do
		local tileIndex = math.random(0, (#freeSpaces))
		local mobTile = freeSpaces[tileIndex]
		table.insert(self.Mobs, Mob(mobTile.x, mobTile.y))
		table.remove(freeSpaces, tileIndex)
	end
	for i = 1, entityTable.chests, 1 do
		local tileIndex = math.random(0, (#freeSpaces))
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
end

function EntityManager:updateMobs(collision)
	for _, mob in ipairs(self.Mobs) do 
		mob:update(collision)
	end 
end

function EntityManager:updateChests(dt)
	for _, chest in ipairs(self.Chests) do
		chest:update(dt)
	end 
end