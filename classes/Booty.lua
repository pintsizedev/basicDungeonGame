Booty = {}
Booty.__index = Booty
setmetatable(Booty, {
	__index = Entity,
	__call = function(cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end
})

function Booty:_init(itemDetails, xTile, yTile, image)
	Entity._init(self, xTile, yTile) 
	self.animation = self:newAnimation(image)
	self.animation:startRunning()
	self.details = itemDetails
	self.pickedUp = false
end

function Booty:newAnimation(image)
	local Animation = Animation(image, 0, 0, 10, 16, 16, 0.075)
	return Animation
end

function Booty:update(dt)
	if self.animation:isRunning() then
		self.animation:update(dt)
	end
end

function Booty:pickUp()
	self.pickedUp = true
end

function Booty:draw()
	self.animation:draw(self.x, self.y)
end