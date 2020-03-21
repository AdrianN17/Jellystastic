local Class = require "libs.hump.class"

local plataforma = Class{
    __includes = {}
}

function plataforma:init(entidad,posicion,img,radio,tipo,propiedades)
  self.entidad = entidad
  
  self.body = love.physics.newBody(self.entidad.world,posicion[1],posicion[2])
  
  self.scale_x,self.scale_y = propiedades.scale_x,propiedades.scale_y
  
local poligono = {  -485 , 35,
485 , 35,
430 , -35,
-460 , -35}

  for i=1,#poligono,2 do
    poligono[i] = poligono[i] * self.scale_x
    poligono[i+1] = poligono[i+1] * self.scale_y
  end

  self.shape = love.physics.newPolygonShape(poligono)
  self.fixture = love.physics.newFixture(self.body,self.shape)

  
  self.fixture:setUserData( {data="map_object",obj=self, pos=orden.terrain} )
  
  self.img = img.redimensionable[1]
  
  self.wi,self.hi = self.img:getDimensions()
  
  
  self.ox,self.oy = posicion[1],posicion[2]
  
  self.entidad:add_obj("platform",self)
  
  self.w,self.h = self.wi,self.hi
  
  local radio = math.rad(propiedades.radio)
  self.body:setAngle(radio)
  self.radio = radio

  
end

function plataforma:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio ,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

function plataforma:update(dt)
  
end

return plataforma