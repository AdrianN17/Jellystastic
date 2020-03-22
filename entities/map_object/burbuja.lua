local Class = require "libs.hump.class"

local burbuja = Class{}

function burbuja:init(entidad,posicion,img,radio,tipo,propiedad)
  self.entidad = entidad
  
  self.spritesheet = img.burbujas
  
  
  
  self.w,self.h = posicion[3],posicion[4]
  
  _,_,self.wi,self.hi =  self.spritesheet.quad[1]:getViewport()
  
  self.entidad:add_obj("extras",self)
  
  self.radio = radio
  
  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  self.ox,self.oy = posicion[1]+self.w/2,posicion[2]+self.h/2
  
  self.iterador = 1
  
  self.entidad.timer:every(0.25,function()
    if self.iterador<3 then
      self.iterador=self.iterador+1
    else
      self.iterador=1
    end
  end)
  
end

function burbuja:update(dt)
  
end

function burbuja:draw()
  love.graphics.draw(self.spritesheet.img,self.spritesheet.quad[self.iterador],self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

return burbuja