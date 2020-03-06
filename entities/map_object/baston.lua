local Class = require "libs.hump.class"

local baston = Class{
    __includes = {}
}

function baston:init(entidad,posicion,img,radio,tipo,propiedades)
  self.entidad = entidad
  
  self.body = love.physics.newBody(self.entidad.world,posicion[1],posicion[2])
  
  self.scale_x,self.scale_y = propiedades.scale_x,propiedades.scale_y
  
  self.direccion = propiedades.direccion
  
  local poligono = {}
  
  poligono[1] = {-500 , -240,
-180 , -240,
-180 , 65,
-500 , 65}

  poligono[-1] = {180 , -240,
500 , -240,
500 , 65,
180 , 65}

  local poligono2 = {-500 , 65,
500 , 65,
500 , 215,
-500 , 215}

  for i=1,#poligono[self.direccion ],2 do
    poligono[self.direccion][i] = poligono[self.direccion][i] * self.scale_x
    poligono[self.direccion][i+1] = poligono[self.direccion][i+1] * self.scale_y
  end
  
  for i=1,#poligono2,2 do
    poligono2[i] = poligono2[i] * self.scale_x
    poligono2[i+1] = poligono2[i+1] * self.scale_y
  end


  self.shape = love.physics.newPolygonShape(poligono[self.direccion ])
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  
  self.shape2 = love.physics.newPolygonShape(poligono2)
  self.fixture2 = love.physics.newFixture(self.body,self.shape2)
  
  
  self.fixture:setUserData( {data="map_object",obj=self, pos=orden.terrain} )
  self.fixture2:setUserData( {data="map_object",obj=self, pos=orden.terrain} )
  
  self.img = img.redimensionable[2]
  
  self.wi,self.hi = self.img:getDimensions()
  
  
  self.ox,self.oy = posicion[1],posicion[2]
  
  self.entidad:add_obj("platform",self)
  
  self.w,self.h = self.wi,self.hi
  
  local radio = math.rad(propiedades.radio)
  self.body:setAngle(radio)
  self.radio = radio
end

function baston:update(dt)
  
end

function baston:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio ,self.scale_x*self.direccion,self.scale_y,self.wi/2,self.hi/2)
end

return baston