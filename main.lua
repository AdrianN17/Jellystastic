io.stdout:setvbuf("no")

Gamestate = require "libs.hump.gamestate" 
local Game = require "gamestates.game_conf"
Inspect  = require "libs.inspect.inspect"

map_index = require "assets.map.index"
orden = require "entities.orden"
img_index = require "assets/img/index"
shader_index = require "assets/shader/index"

require "libs.gooi"

require "libs.utils"

function love.load()
  
  Gamestate.registerEvents()
	Gamestate.switch(Game,1)
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end