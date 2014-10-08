local TileSet = love.graphics.newImage('assets/images/dungeon_sheet_0.png')
TileSet:setFilter('nearest','nearest')

local Animation = Animation(TileSet, 128, 112, 6, 16, 16, 0.1)
Chest = {}
Chest.__index = Chest
setmetatable(Chest, {
	__index = Entity,
	__call = function(cls, ...)
		return cls.new(...)
	end
})


function Chest.new(x, y) 
	self = setmetatable({}, Chest)
	self.animation = Animation
	self.x = x
	self.y = y
	self.xTile = (x / 16) + 1
	self.yTile = (y / 16) + 1
	return self
end

function Chest:open()
	self.animation:startRunning()
end


function Chest:update(dt)
	if self.animation:isRunning() then
		self.animation:update(dt)
	end
end


function Chest:draw()
	self.animation:draw(self.x, self.y)
end