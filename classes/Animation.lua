Animation = {}
Animation.__index = Animation
setmetatable(Animation, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function Animation.new(tileSet, startX, startY, frames, width, height, delay)
	self = setmetatable({}, Animation)
	self.tileSet = tileSet
	self.image = love.graphics.newQuad(startX, startY, width, height, tileSet:getWidth(), tileSet:getHeight())
	self.frames = frames
	self.currentFrame = 1
	self.imageX = startX
	self.imageY = startY
	self.dx = width
	self.height = height
	self.width = width
	self.delay = delay
	self.timer = 0
	self.running = false
	self.mode = 1
	return self
end

function Animation:update(dt)
	self.timer = self.timer + dt
	if self.timer >= self.delay then
		if self.mode == 1 then
			self:once()
		elseif self.mode == 2 then
			self:pingPong()
		end
		self.timer = self.timer - self.delay
	end	
end

function Animation:once()
	if self.currentFrame >= self.frames then
		self.running = false
	else
		self.currentFrame = self.currentFrame + 1
		self.imageX = self.imageX + self.dx
		self.image = love.graphics.newQuad(self.imageX, self.imageY, self.width, self.height, self.tileSet:getWidth(), self.tileSet:getHeight())
	end
end

function Animation:pingPong()
	if self.currentFrame >= self.frames then
		self.dx = self.dx * - 1 
		self.currentFrame = self.frames - 1
	elseif self.currentFrame <= 0 then
		self.dx = self.dx * -1
		self.currentFrame = 1
	end
	self.imageX = self.imageX + self.dx
	if self.dx < 0 then
		self.currentFrame = self.currentFrame - 1
		self.image = love.graphics.newQuad(self.imageX, self.imageY, self.width, self.height, self.tileSet:getWidth(), self.tileSet:getHeight())
	else  
		self.currentFrame = self.currentFrame + 1
		self.image = love.graphics.newQuad(self.imageX, self.imageY, self.width, self.height, self.tileSet:getWidth(), self.tileSet:getHeight())
	end
end

function Animation:startRunning()
	self.running = true
end

function Animation:isRunning()
	return self.running
end

function Animation:setMode(mode)
	self.mode = mode
end

function Animation:draw(x,y)
	love.graphics.draw(self.tileSet, self.image, x, y)
end

