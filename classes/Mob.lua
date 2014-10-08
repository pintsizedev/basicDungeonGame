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
end

function Mob:update(collision)
	local moved = false
	local directions = {1, 2, 3, 4}
	while not moved do
		local direction = directions[math.random(0, #directions)]
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
		if #directions <= 0 then
			moved = true
		end
	end
end