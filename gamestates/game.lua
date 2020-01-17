local Class = require "libs.hump.class"
local game_conf = require "gamestates.game_conf"

local map_index = require "assets/map/index"
local Saliva = require "entities.bullet.saliva"

local game = Class{
    __includes = {game_conf}
}

function game:init()
  game_conf.init(self,map_index.multiplayer[1])
  
end

function game:update(dt)
  dt = math.min (dt, 1/30)
  self:update_conf(dt)
end

function game:draw()
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
  self:draw_conf()
end

function game:keypressed(key)
  if self.gameobject.player[1] then
    self.gameobject.player[1]:keypressed(key)
  end
end

function game:keyreleased(key)
  if self.gameobject.player[1] then
    self.gameobject.player[1]:keyreleased(key)
  end
end

function game:mousepressed(x,y,button)
  local cx,cy = self.cam:toWorld(x,y)
  if self.gameobject.player[1] then
    
    self.gameobject.player[1]:mousepressed(cx,cy,button)
  end
  
  
  --Saliva(self,img_index.baba,cx,cy,cx,cy,1)
  
  --dwdwself.gameobject.map_object[1]:hacer_hueco(1,self:poligono_para_destruir(cx,cy),cx,cy) 
  
  
  
  --self.cam:setPosition(cx, cy)
end

function game:mousereleased(x,y,button)
  if self.gameobject.player[1] then
    self.gameobject.player[1]:mousereleased(x,y,button)
  end
end

return game