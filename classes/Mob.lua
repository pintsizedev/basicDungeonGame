local image = love.graphics.newQuad(320, 96, 16, 16, 384, 160)

Mob = {}
Mob.__index = Mob
setmetatable(Mob, {
	__index = Entity,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

function Mob:_init(xTile, yTile)
	Entity._init(self, xTile, yTile, image)
	self.hp = 20
end

function Mob:update(collision)
	local moved = false
	local directions = {1, 2, 3, 4}
	local attempt = 1
	while not moved do
		local direction = directions[math.random(1, #directions)]
		if direction == 1 then 
			if not self:collision(collision, 1, 0) then
				self:move(1, 0)
				moved = true 
			end
		elseif direction == 2 then
			if not self:collision(collision, -1, 0) then 
				self:move(-1, 0)
				moved = true
			end
		elseif direction == 3 then
			if not self:collision(collision, 0, 1) then
				self:move(0, 1)
				moved = true
			end
		elseif direction == 4 then
			if not self:collision(collision, 0, -1) then
				self:move(0, -1)
				moved = true
			end
		end
		table.remove(directions, direction)
		attempt = attempt + 1
		if attempt > 4 then 
			moved = true
		end
	end
end

function Mob:drawHealthBar()
	local hp = self.hp
	local barCoords = {x = self.x, y = self.y - 6}
	local barColour = {x = self.x + 1, y = self.y - 5, width = math.ceil((self.hp/20) *  14)}
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("line", barCoords.x, barCoords.y, 16, 4)
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", barColour.x, barColour.y, barColour.width, 2)
	love.graphics.setColor(255, 255, 255)
end

function Mob:getType()
	return "mob"
end