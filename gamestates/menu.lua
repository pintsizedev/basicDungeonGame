local menu = {}

function menu:draw()
	message = "Press ENTER to begin."
	width = Font:getWidth(message)
	love.graphics.print(message, (WIDTH/2)-(width/2), HEIGHT/2)
end

function menu:keypressed(key)
    if key == 'enter' or key == 'return' then
       	Gamestate.switch(game)
    end
end

return menu