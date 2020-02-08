local Class = require "libs.hump.class"
local game_conf = require "gamestates.game_conf"

local map_index = require "assets.map.index"

require "libs.gooi"

local joy_disparo;
local joy_movimiento;

local game = Class{
    __includes = {game_conf}
}

function game:init()
  game_conf.init(self,map_index.multiplayer[1])
  
  joy_movimiento = gooi.newJoy({size = 100*self.scale,  x = 80*self.scale,y = self.screen_y - 150*self.scale}):setDigital()
  joy_disparo = gooi.newJoy({size = 100*self.scale, x = self.camera_x_ui - 150*self.scale,y = self.screen_y - 150*self.scale}):setStyle({showBorder = true})
  
  
  
end

function game:update(dt)
  dt = math.min (dt, 1/30)
  gooi.update(dt)
  
  local dir = joy_movimiento:direction()
  
  if self.gameobject.player[1] and love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
    self.gameobject.player[1]:joystick(dir)
  end
  
  self:update_conf(dt)
end

function game:draw()
  love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
   
  self:draw_conf()

 
  gooi.draw()
  
end

function game:keypressed(key)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[1] then
      self.gameobject.player[1]:keypressed(key)
    end
  end
end

function game:keyreleased(key)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[1] then
      self.gameobject.player[1]:keyreleased(key)
    end
  end
end

function game:mousepressed(x,y,button)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    local cx,cy = self.cam:toWorld(x,y)
    if self.gameobject.player[1] then
      
      self.gameobject.player[1]:mousepressed(cx,cy,button)
    end
  end
end



function game:mousereleased(x,y,button)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[1] then
      self.gameobject.player[1]:mousereleased(x,y,button)
    end
  end
  
  
end

function game:touchpressed( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
    
    gooi.pressed()
    
    --if self.gameobject.player[1] then
    --  self.gameobject.player[1]:touchpressed( id, x, y, dx, dy, pressure )
    --end
  end
end

function game:touchreleased( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    
    
    gooi.released()
    --if self.gameobject.player[1] then
    --  self.gameobject.player[1]:touchreleased( id, x, y, dx, dy, pressure )
    --end
  end
end

function game:touchmoved( id, x, y, dx, dy, pressure )
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    --if self.gameobject.player[1] then
    --  self.gameobject.player[1]:touchmoved( id, x, y, dx, dy, pressure )
    --end
  end
end

function game:analogico()
  return joy_disparo:xValue(),joy_disparo:yValue()
end

return game