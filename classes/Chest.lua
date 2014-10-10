local TileSet = love.graphics.newImage('assets/images/dungeon_sheet_0.png')
TileSet:setFilter('nearest','nearest')

Chest = {}
Chest.__index = Chest
setmetatable(Chest, {
	__index = Entity,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})


function Chest:_init(xTile, yTile)
	Entity._init(self, xTile, yTile) 
	self.animation = self:newAnimation()
end

function Chest:open()
	self.animation:startRunning()
end

function Chest:newAnimation()
	local Animation = Animation(TileSet, 128, 112, 6, 16, 16, 0.1)
	return Animation
end


function Chest:update(dt)
	if self.animation:isRunning() then
		self.animation:update(dt)
	end
end

function Chest:getTiles()
	return {x = self.xTile, y = self.yTile}
end

function Chest:draw()
	self.animation:draw(self.x, self.y)
end

function Chest:getType()
	return "chest"
end