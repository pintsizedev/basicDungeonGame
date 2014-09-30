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
end

function Mobs:populate()
	self.Mobs[1] = Mob(32, 32)
	self.Mobs[2] = Mob(48, 32)
	self.Mobs[3] = Mob(32, 48)
end

function Mobs:draw()
	for mob in self.Mobs do
		mob:draw()
	end
end