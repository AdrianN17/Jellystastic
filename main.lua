io.stdout:setvbuf("no")

Gamestate = require "libs.hump.gamestate" 
local Game = require "gamestates.game_conf"
Inspect  = require "libs.inspect.inspect"

map_index = require "assets.map.index"
orden = require "entities.orden"
img_index = require "assets/img/index"

require "libs.gooi"

function love.load()
  Gamestate.registerEvents()
	Gamestate.switch(Game,1)
end
