Gamestate = require "libs.hump.gamestate" 
local Game = require "gamestates.game"


function love.load()
  Gamestate.registerEvents()
	Gamestate.switch(Game)
end
