Font = love.graphics.newFont("assets/fonts/Orbitron-Regular.ttf", 18)
love.graphics.setFont(Font)
require("classes/Animation")
require("classes/Booty")
require("classes/Chest")
require("classes/Entity")
require("classes/EntityManager")
require("classes/Mob")
require("classes/Player")
sti = require("sti")
Gamestate = require("hump.gamestate")
menu = require("gamestates/menu")
game = require("gamestates/game")

WIDTH = 896
HEIGHT = 640
-- Set up proper random numbers
math.randomseed(os.time())
math.random() math.random() math.random()

function love.load()
	love.graphics.setBackgroundColor(47, 40, 58)
	love.window.setTitle("Dungeon Game")
	love.window.setMode(WIDTH, HEIGHT)
	Gamestate.registerEvents()
    Gamestate.switch(menu)
end