Mob = {}
Mob.__index = Mob
setmetatable(Mob, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function Mob.new(x, y)
	local self = setmetatable({}, Mob)
	self.TileSet = love.graphics.newImage("images/dungeon_sheet_0.png")
	self.TileSet:setFilter('nearest', 'nearest')
	self.img = love.graphics.newQuad(320, 96, 16, 16, 384, 160)
	self.x = x
	self.y = y
	self.xTile = (x / 16) + 1
	self.yTile = (y / 16) + 1
	return self
end

function Mob:draw()
	love.graphics.draw(self.TileSet, self.img, self.x, self.y)
end

function Mob:collision(xTile, yTile)
	if self.xTile == xTile and self.yTile == yTile then
		return true
	else
		return false
	end
end

function Mob:checkCollisions(collision, dX, dY)
	local pTileX, pTileY = entityLayer.Player:getTiles()
	local newXTile, newYTile = self.xTile + dX, self.yTile + dY
	if collision.data[newYTile][newXTile] == 1 or Player:collidedWith(newXTile, newYTile) or 
	  Mobs:collision(newXTile, newYTile) then 
		return true
	else
		return false
	end
end

function Mob:move(collision)
	local moved = false
	local directions = {1, 2, 3, 4}
	while not moved do
		local direction = directions[math.random(0, (#directions + 1))]
		-- local direction = 1
		if direction == 1 then 
			if not self:checkCollisions(collision, 1, 0) then
				self.x = self.x + 16
				self.xTile = self.xTile + 1
				moved = true 
			end
		elseif direction == 2 then
			if not self:checkCollisions(collision, -1, 0) then 
				self.x = self.x - 16
				self.xTile = self.xTile - 1
				moved = true
			end
		elseif direction == 3 then
			if not self:checkCollisions(collision, 0, 1) then
				self.y = self.y + 16
				self.yTile = self.yTile + 1
				moved = true
			end
		elseif direction == 4 then
			if not self:checkCollisions(collision, 0, -1) then
				self.y = self.y - 16
				self.yTile = self.yTile - 1
				moved = true
			end
		end
		table.remove(directions, direction)
		if #directions <= 0 then
			moved = true
		end
	end
end