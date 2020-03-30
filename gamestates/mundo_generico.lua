local Utils = require "gamestates.utils"

local mundoGenerico = Class{
  __includes = {Utils}
}

xg,yg = 0,0

function mundoGenerico:init(mapa)

  
  Utils.init(self)
  
  self.indexPlayer = 1

  self.gameobject = {}
  
  self.map = Sti(mapa)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)

  
  self.scaleDPI = 1
  self.scale = 1/self.scaleDPI
  
  local x,y=love.graphics.getDimensions( )
  
  self.map:resize(x/self.scale,y/self.scale)
  
  --self.cam = Camera.new(0, 0, self.scale, 0,0,0,x,y,0.5,0.5)
  self.cam = Gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x,y)
  self.cam:setScale(self.scale)
  
  
  self:create_objects(Entities_index)
  
  if self.gameobject.jugadores[self.indexPlayer] then
    local player = self.gameobject.jugadores[self.indexPlayer]
    player:setPlayerValues(_G.playerValues)
  end
  
  love.graphics.setLineWidth( 2 )
  
  
  
end

function mundoGenerico:enter()
  
end

function mundoGenerico:update(dt)
  self.world:update(dt)
  self.map:update(dt)
  
 
end

function mundoGenerico:draw()
  
  local cx,cy,cw,ch=self.cam:getVisible()
  
  self.map:draw(-cx,-cy,self.scale,self.scale)
  
  --self.cam:attach()

  self:drawBox2d()
  
  self.cam:draw(function(l,t,w,h)
    self:drawBox2d()
  end)
  
  --self.cam:detach()
end

function mundoGenerico:keypressed(key)
  if self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:keypressed(key)
  end
end

function mundoGenerico:keyreleased(key)
  if self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:keyreleased(key)
  end
end

function mundoGenerico:mousepressed(x,y,button)
  if self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:mousepressed(x,y,button)
  end
end

function mundoGenerico:mousereleased(x,y,button)
  if self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:mousereleased(x,y,button)
  end
end

return mundoGenerico