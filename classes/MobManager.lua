MobManager = {}
MobManager.__index = MobManager
setmetatable(MobManager, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function MobManager.new(collision, amount)
	local self = setmetatable({}, MobManager)
	self.MobManager = {} -- A table of Mob objects
	self:populate(collision, amount)
	return self
end

function MobManager:update(collision)
	for _, mob in ipairs(self.MobManager) do
		mob:move(collision)
	end
end

function MobManager:moveUp(collision)
	for _, mob in ipairs(self.MobManager) do
		mob:moveUp(collision)
	end
end 

function MobManager:collision(newX, newY)
	collided = false
	for _, mob in ipairs(self.MobManager) do
		collided = mob:collision(newX, newY)
		if collided == true then
			break
		end
	end
	return collided
end

function MobManager:populate(collision, number)
	-- get vacant spaces
	local freeSpaces = {}
	local MobManagerToAdd = {}
	for i, row in ipairs(collision.data) do
		for j, col in ipairs(row) do
			if col == 0 then
				table.insert(freeSpaces, {y= i, x=j})
			end
		end
	end
	for i = 1, number, 1 do
		local tileIndex = math.random(0, (#freeSpaces+1))
		local mobTile = freeSpaces[tileIndex]
		local mobX, mobY = (mobTile.x - 1) * 16, (mobTile.y - 1) * 16
		table.insert(MobManagerToAdd, Mob(mobX, mobY))
		table.remove(freeSpaces, index)
	end
	for _, mob in ipairs(MobManagerToAdd) do
		table.insert(self.MobManager, mob)
	end
end

function MobManager:draw()
	for _, mob in ipairs(self.MobManager) do
		mob:draw()
	end
end

function MobManager:location()
	i = 30
	for _, mob in ipairs(self.MobManager) do
		love.graphics.print("Mob ".._..": "..mob.x..","..mob.y, 650, i)
		i = i + 20
	end
end