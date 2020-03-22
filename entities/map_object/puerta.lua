local Class = require "libs.hump.class"

local puerta = Class{}

function puerta:init(entidad,posicion,img,radio,tipo,propiedad)
  
  self.entidad = entidad
  
  self.img = img.puerta
  self.radio = math.rad(radio)
  
  self.w,self.h = posicion[3],posicion[4]
  
  self.wi,self.hi = self.img:getDimensions()

  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  self.id_mapa = tonumber(tipo)
  
  self.id_puerta = propiedad.id
  
  self.body = love.physics.newBody(entidad.world,posicion[1]+posicion[3]/2,posicion[2]+posicion[4]/2,"static")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  
  self.body:setAngle(self.radio)
  
  self.fixture:setUserData( {data="door",obj=self, pos=orden.door})
  
  self.data_puerta = {id_mapa = self.id_mapa,id_puerta = self.id_puerta}
  
  self.entidad:add_obj("door",self)
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
  
  
end

function puerta:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

function puerta:update(dt)

end

function puerta:colisiona_centro(fixture)
  if fixture:testPoint(self.ox,self.oy) then
    self:remove()
  end
end

function puerta:remove()
  if not self.body:isDestroyed() then
    self.body:destroy()
  end
end

return puerta