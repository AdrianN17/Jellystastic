local Timer = require "libs.chrono.Timer"

local player = Class{}

function player:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.entidad = entidad
  
  entidad:add(properties.tabla,self)
  
  self.ox,self.oy = ox,oy

end

function player:update(dt)
  self.ox,self.oy = self.body:getX(), self.body:getY()
  self.entidad.cam:setPos(self.ox,self.oy)
end

function player:draw()
  love.graphics.circle("fill",self.ox,self.oy,5)
end

return player