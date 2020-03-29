local Utils = require "gamestates.utils"

local mundoGenerico = Class{
  __includes = {Utils}
}

xg,yg = 0,0

function mundoGenerico:init(mapa)

  Utils.init(self)

  self.gameobject = {}
  
  self.map = Sti(mapa)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)

  
  self.scaleDPI = 1
  self.scale = 1/self.scaleDPI
  
  local x,y=love.graphics.getDimensions( )
  
  self.map:resize(x/self.scale,y/self.scale)
  
  self.cam = Camera.new(0, 0, self.scale, 0,0,0,x,y,0.5,0.5)
  
  
  self:create_objects(Entities_index)
  
  love.graphics.setLineWidth( 2 )
  
end

function mundoGenerico:enter()
  
end

function mundoGenerico:update(dt)
  self.world:update(dt)
  self.map:update(dt)
  
 
end

function mundoGenerico:draw()
  
  local cx,cy,cw,ch=self.cam:getViewport()
  
  self.map:draw(-cx,-cy,self.scale,self.scale)
  
  self.cam:attach()

  self:drawBox2d()
  
  self.cam:detach()
end

function mundoGenerico:keypressed(key)

end

function mundoGenerico:keyreleased(key)
  
end

function mundoGenerico:mousepressed(x,y,button)
  
end

function mundoGenerico:mousereleased(x,y,button)
  
end

return mundoGenerico