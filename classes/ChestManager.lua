ChestManager = {}
ChestManager.__index = ChestManager
setmetatable(ChestManager, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function ChestManager.new()
	local self = {}
end