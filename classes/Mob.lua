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

function Mob:collision(collision, dX, dY)
	local pTileX, pTileY = Player:getTiles()
	if collision.data[self.yTile + dY][self.xTile + dX] == 1 or (pTileX == (self.xTile + dX) and (pTileY == (self.yTile + dY))) then 
		return true
	else
		return false
	end
end

function Mob:move(collision)
	local moved = false
	while not moved do
		local directions = {1, 2, 3, 4}
		local direction = math.random(0, (#directions + 1))
		-- local direction = 1
		if direction == 1 then 
			if not self:collision(collision, 1, 0) then
				self.x = self.x + 16
				self.xTile = self.xTile + 1
				moved = true 
			end
		elseif direction == 2 then
			if not self:collision(collision, -1, 0) then 
				self.x = self.x - 16
				self.xTile = self.xTile - 1
				moved = true
			end
		elseif direction == 3 then
			if not self:collision(collision, 0, 1) then
				self.y = self.y + 16
				self.yTile = self.yTile + 1
				moved = true
			end
		elseif direction == 4 then
			if not self:collision(collision, 0, -1) then
				self.y = self.y - 16
				self.yTile = self.yTile - 1
				moved = true
			end
		end
	end
end