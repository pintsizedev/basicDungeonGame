Entity = {}
Entity.__index = Entity

setmetatable(Entity, {
	__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

function Entity:_init(x, y, image)
	self.tileSet = love.graphics.newImage("assets/images/dungeon_sheet_0.png")
	self.x = x
	self.y = y
	self.xTile = (x / 16) + 1
	self.yTile = (y / 16) + 1
	self.image = image
end

function Entity:draw()
	love.graphics.draw(self.tileSet, self.image, self.x, self.y)
end

function Entity:collision(xTile, yTile)
	if self.xTile == xTile and self.yTile == yTile then
		return true 
	else
		return false
	end
end

function Entity:getTiles()
	return self.xTile, self.yTile
end