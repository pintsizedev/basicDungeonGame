Entity = {}
Entity.__index = Entity

setmetatable(Entity, {
	__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

function Entity:_init(xTile, yTile, image)
	self.tileSet = love.graphics.newImage("assets/images/dungeon_sheet_0.png")
	self.x = (xTile - 1) * 16
	self.y = (yTile - 1) * 16
	self.xTile = xTile
	self.yTile = yTile
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

function Entity:collision(collision, dX, dY)
	local newXTile, newYTile = self.xTile + dX, self.yTile + dY
	if collision.data[newYTile][newXTile] == 1 or Entities:hasCollided(newXTile, newYTile) then
		return true
	else
		return false
	end
end 

-- Returns a table containing the X and Y tile
function Entity:getTiles()
	return {x = self.xTile, y = self.yTile}
end

function Entity:move(dX, dY)
	self.x, self.y = self.x + (dX * 16), self.y + (dY * 16)
	self.xTile, self.yTile = self.xTile + dX, self.yTile + dY
end