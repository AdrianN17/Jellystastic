local Class = require "libs.hump.class"
local game_conf = require "gamestates.game_conf"

local map_index = require "assets/map/index"

local game = Class{
    __includes = {game_conf}
}

function game:init()
  game_conf.init(self,map_index.multiplayer[1])
  
end

function game:update(dt)
  self:update_conf(dt)
end

function game:draw()
  self:draw_conf()
end

function game:keypressed(key)
  
end

function game:keyreleased(key)
  
end

function game:mousepressed(x,y,button)
  
end

function game:mousereleased(x,y,button)
  
end

return game