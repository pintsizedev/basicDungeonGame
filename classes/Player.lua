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

function Player:_init(xTile, yTile)
	Entity._init(self, xTile, yTile, image)
	self.stats = {
		Hp = 100,
		Strength = 1,
		Defence = 1,
	}
	self.inventory = {}
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

function Player:openChest(chests)
	local opened = false
	local i = 1
	while not opened do
		local chestTiles = chests[i]:getTiles()
		local isAdjacent = self:checkAdjacent(chestTiles.x, chestTiles.y)
		if isAdjacent and not chests[i].isOpen then
			chests[i]:open()
			opened = true
		end
		i = i + 1
		if i > #chests then
			opened = true
		end
	end
end

function Player:checkForBooty(Booty)
	for _, booty in ipairs(Booty) do
		if self.xTile == booty.xTile and self.yTile == booty.yTile then
			self:pickUpBooty(booty)
		end
	end
end

function Player:pickUpBooty(Booty)
	table.insert(self.inventory, Booty)
	Booty:pickUp()
	self:updateStats(Booty)
end

function Player:updateStats(booty)
	if booty.details.modifies == "defence" then
		self.stats.Defence = self.stats.Defence + booty.details.difference
	elseif booty.details.modifies == "strength" then
		self.stats.Strength = self.stats.Strength + booty.details.difference
	end
end

function Player:getType()
	return "player"
end

function Player:printInfo(startY)
	y = startY
	local heartImg = love.graphics.newImage("assets/images/heart.png")
	love.graphics.draw(heartImg, 650, y)
	love.graphics.print(tostring(self.stats.Hp), 670, y)
	y = y + 20
	for i=1,#self.inventory do
		local booty = self.inventory[i]
		love.graphics.print(booty.details.name.." : "..booty.details.description, 650, y)
		y = y + 20
	end
end