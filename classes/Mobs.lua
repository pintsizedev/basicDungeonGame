Mobs = {}
Mobs.__index = Mobs
setmetatable(Mobs, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function Mobs.new()
	local self = setmetatable({}, Mobs)
	self.Mobs = {} -- A table of Mob objects
	self:populate()
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

function Mobs:populate()
	self.Mobs[1] = Mob(32, 32)
	self.Mobs[2] = Mob(48, 32)
	self.Mobs[3] = Mob(32, 48)
end

function Mobs:draw()
	for _, mob in ipairs(self.Mobs) do
		mob:draw()
	end
end

function Mobs:printTiles()
	height = 30
	for i, mob in ipairs(self.Mobs) do
		love.graphics.print("Mob "..i.." : "..mob.xTile.." , "..mob.yTile, 650, height)
		height = height + 20
	end
end 