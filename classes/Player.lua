local image = love.graphics.newQuad(320, 112, 16, 16, 384, 160)

Player = {}
Player.__index = Player
setmetatable(Player, {
	__index = Entity,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

function Player:_init(x, y)
	Entity._init(self, x, y, image)
	self.stats = {
		Hp = 100,
		Strength = 1,
		Defence = 1,
	}
end

function Player:collision(collisionMap ,dX, dY)
	if collisionMap.data[self.yTile + dY][self.xTile + dX ] == 1 or 
		entityLayer:checkCollision(self.xTile + dX, self.yTile + dY) then
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