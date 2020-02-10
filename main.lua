io.stdout:setvbuf("no")

Gamestate = require "libs.hump.gamestate" 
local Game = require "gamestates.game"
Inspect  = require "libs.inspect.inspect"

function love.load()
  Gamestate.registerEvents()
	Gamestate.switch(Game)
end
