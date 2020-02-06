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
  love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
   
  self:draw_conf()

 
 
  
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
    
    
    
    if self.gameobject.player[1] then
      self.gameobject.player[1]:touchpressed( id, x, y, dx, dy, pressure )
    end
  end
end

function game:touchreleased( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    if self.gameobject.player[1] then
      self.gameobject.player[1]:touchreleased( id, x, y, dx, dy, pressure )
    end
  end
end

function game:touchmoved( id, x, y, dx, dy, pressure )
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    if self.gameobject.player[1] then
      self.gameobject.player[1]:touchmoved( id, x, y, dx, dy, pressure )
    end
  end
end


return game