local BootyRegister = {}

local sword = {}
sword.image = love.graphics.newImage("assets/images/sword.png")
sword.details = {
	name = "Basic Sword",
	modifies = "strength",
	difference = 1,
	description = "Attack + 1"
}

local shield = {}
shield.image = love.graphics.newImage("assets/images/shield.png")
shield.details = {
	name = "Basic Shield",
	modifies = "defence",
	difference = 1,
	description = "Defence + 1"
}

table.insert(BootyRegister, sword)
table.insert(BootyRegister, shield)
return BootyRegister