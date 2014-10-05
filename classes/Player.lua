local TileSet = love.graphics.newImage('images/dungeon_sheet_0.png')
TileSet:setFilter('nearest','nearest')

local Player = {
	stats = {
		Hp = 100,
		Strength = 1,
		Defence = 1,
	},
	x = 16,
	y = 32,
	tileX = 2,
	tileY = 3,
	image = love.graphics.newQuad(320, 112, 16, 16, 384, 160),
}


function Player:draw()
	love.graphics.draw(TileSet, Player.image, Player.x, Player.y)
end

function Player:getTiles()
	return self.tileX, self.tileY
end

function Player:collidedWith(xTile, yTile)
	if self.tileX == xTile and self.tileY == yTile then 
		return true
	else
		return false
	end
end

function Player:collision(collisionMap ,dX, dY)
	if collisionMap.data[self.tileY + dY][self.tileX + dX ] == 1 or 
		entityLayer:checkCollision(self.tileX + dX, self.tileY + dY) then
		return true
	else
		return false
	end
end

function Player:printHealth(width, height)
	love.graphics.print("HP: "..self.stats.Hp, width, height)
end

function Player:damage(amount)
	self.stats.Hp = self.stats.Hp - amount
end

function Player:heal(amount)
	self.stats.Hp = self.stats.Hp + amount

end

return Player