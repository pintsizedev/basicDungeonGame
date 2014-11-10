local menu = {}

function menu:enter()
	gui = require("classes/GUI/menu").new()
	setUpMenu()
	chestNumber = 5
	mobNumber = 5
end

function menu:draw()
	gui:draw(10, 10)
end

function menu:update(dt)
	gui:update(dt)
end

function menu:keypressed(key)
	gui:keypressed(key)
end

function setUpMenu()
	mobsUp = {name = "Increase mobs"}
	function mobsUp:action()
		mobNumber = mobNumber + 1
	end
	mobsDown = {name = "Decrease mobs"}
	function mobsDown:action()
		mobNumber = mobNumber - 1
	end
	chestsUp = {name = "Increase chests"}
	function chestsUp:action()
		chestNumber = chestNumber + 1
	end
	chestsDown = {name = "Decrease chests"}
	function chestsDown:action()
		chestNumber = chestNumber - 1		
	end
	play = {name = "Play game"}
	function play:action()
		Gamestate.switch(game)
	end
	gui:addItem(mobsUp)
	gui:addItem(mobsDown)
	gui:addItem(chestsUp)
	gui:addItem(chestsDown)
	gui:addItem(play)
end

return menu