local Gamestate = require "libs.gamestate"
local menu = Gamestate.new()
local level_1_1= require "gamestate.level_1_1"

function menu:init()

end

function menu:enter()
	
end

function menu:update(dt)
	
end

function menu:draw()
	love.graphics.print("Presione E para iniciar",300,300)
end

function menu:keypressed(key)
	if key=="e" then
		Gamestate.switch(level_1_1)
	end
end

function menu:__tostring()
	return menu
end

return menu