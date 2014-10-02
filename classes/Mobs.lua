Mobs = {}
Mobs.__index = Mobs
setmetatable(Mobs, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function Mobs.new(collision, amount)
	local self = setmetatable({}, Mobs)
	self.Mobs = {} -- A table of Mob objects
	self:populate(collision, amount)
	return self
end

function Mobs:update(collision)
	for _, mob in ipairs(self.Mobs) do
		mob:move(collision)
	end
end

function Mobs:moveUp(collision)
	for _, mob in ipairs(self.Mobs) do
		mob:moveUp(collision)
	end
end 

function Mobs:collision(newX, newY)
	collided = false
	for _, mob in ipairs(self.Mobs) do
		collided = mob:collision(newX, newY)
		if collided == true then
			break
		end
	end
	return collided
end

function Mobs:populate(collision, number)
	-- get vacant spaces
	local freeSpaces = {}
	local mobsToAdd = {}
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
		table.insert(mobsToAdd, Mob(mobX, mobY))
		table.remove(freeSpaces, index)
	end
	for _, mob in ipairs(mobsToAdd) do
		table.insert(self.Mobs, mob)
	end
end

function Mobs:draw()
	for _, mob in ipairs(self.Mobs) do
		mob:draw()
	end
end

function Mobs:location()
	i = 30
	for _, mob in ipairs(self.Mobs) do
		love.graphics.print("Mob ".._..": "..mob.x..","..mob.y, 650, i)
		i = i + 20
	end
end