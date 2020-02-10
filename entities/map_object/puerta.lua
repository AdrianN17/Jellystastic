local Class = require "libs.hump.class"
local puerta = Class{}

function puerta:init(entidad,x,y,img,radio,tipo)
  self.entidad = entidad
  
  self.img = img.cosas.puerta[1]
  self.img_data = img.cosas.puerta_data
  self.radio = math.rad(radio)
  
  self.w = self.img:getWidth()
  self.h = self.img:getHeight()
  
  self.tipo_puerta = tipo
  
  self.body = love.physics.newBody(entidad.world,x+(self.w*self.img_data.x)/2,y+(self.h*self.img_data.y)/2,"kinematic")
  self.shape = love.physics.newRectangleShape(self.w*self.img_data.x,self.h*self.img_data.y)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
    
  self.ox,self.oy = self.body:getX(), self.body:getY()
  
  self.fixture:setUserData( {data="door",obj=self, pos=orden.door})
  
  self.data_puerta = {id = self.tipo_puerta}
  
  self.entidad:add_obj("door",self)
  
  self.vivo = true
end

function puerta:draw()
  love.graphics.draw(self.img,self.ox+(self.w*self.img_data.x)/2,self.oy+(self.h*self.img_data.y)/2,self.radio,self.img_data.x,self.img_data.y,self.w,self.h)
end

function puerta:update(dt)
  
end

function puerta:colisiona_centro(fixture)
  if fixture:testPoint(self.ox,self.oy) then
    self:remove()
  end
end

function puerta:remove()
  if self.vivo then
    
    self.body:destroy()
    
    self.vivo = false
    
  end
end

return puerta