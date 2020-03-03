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

function math.round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function math.distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end