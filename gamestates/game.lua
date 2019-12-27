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
  self.gameobject.player[1]:keypressed(key)
end

function game:keyreleased(key)
  self.gameobject.player[1]:keyreleased(key)
end

function game:mousepressed(x,y,button)
  
  local cx,cy = self.cam:toWorld(x,y)
  
  self.gameobject.map_object[1]:hacer_hueco(1,self:poligono_para_destruir(cx,cy)) 
  
  
  
  table.insert(self.gameobject.holes,{x=cx,y=cy})
  
  --self.cam:setPosition(cx, cy)
end

function game:mousereleased(x,y,button)
  
end

return game