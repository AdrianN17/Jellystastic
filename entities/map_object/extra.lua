local Class = require "libs.hump.class"

local extra = Class{}

function extra:init(entidad,posicion,img,radio,tipo,propiedad)
  
  self.entidad = entidad
  
  self.spritesheet = img.objetos_mapa
  
  self.quad = self.spritesheet[tipo]
  
  local _,_,w,h = self.quad:getViewport()
  
  self.w,self.h = posicion[3],posicion[4]
  
  self.wi,self.hi =  w,h
  
  self.entidad:add_obj("extras",self)
  
  self.radio = radio
  
  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  self.ox,self.oy = posicion[1]+self.w/2,posicion[2]+self.h/2
  
end

function extra:update(dt)
  
end

function extra:draw()
  love.graphics.draw(self.spritesheet["img"],self.quad,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

return extra