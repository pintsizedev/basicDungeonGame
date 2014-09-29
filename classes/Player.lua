local TileSet = love.graphics.newImage('images/dungeon_sheet_0.png')
TileSet:setFilter('nearest','nearest')

local Player = {
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

function Player:collision(collisionMap ,dX, dY)
	if collisionMap.data[self.tileY + dY][self.tileX + dX ] == 1 then
		return true
	else
		return false
	end
end

return Player