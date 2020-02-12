local Class = require "libs.hump.class"
local puerta = Class{}

function puerta:init(entidad,x,y,img,radio,tipo,id)
  self.entidad = entidad
  
  self.img = img.cosas.puerta[1]
  self.img_data = img.cosas.puerta_data
  self.radio = math.rad(radio)
  
  self.w = self.img:getWidth()
  self.h = self.img:getHeight()
  
  self.id_mapa = tonumber(tipo)
  
  self.id_puerta = id
  
  self.body = love.physics.newBody(entidad.world,x+(self.w*self.img_data.x)/2,y+(self.h*self.img_data.y)/2,"kinematic")
  self.shape = love.physics.newRectangleShape(self.w*self.img_data.x,self.h*self.img_data.y)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  
  self.body:setAngle(self.radio)
    
  self.ox,self.oy = self.body:getX(), self.body:getY()
  
  self.fixture:setUserData( {data="door",obj=self, pos=orden.door})
  
  self.data_puerta = {id_mapa = self.id_mapa,id_puerta = self.id_puerta}
  
  self.entidad:add_obj("door",self)
  
  self.vivo = true
end

function puerta:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio,self.img_data.x,self.img_data.y,self.w/2,self.h/2)
end

function puerta:update(dt)
  self.ox,self.oy = self.body:getX(), self.body:getY()
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