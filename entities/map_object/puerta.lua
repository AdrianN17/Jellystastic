local Class = require "libs.hump.class"
local puerta = Class{}

function puerta:init(entidad,x,y,img,radio)
  print(entidad,x,y,img,radio)
  self.entidad = entidad
  self.ox,self.oy = x,y
  self.img = img.cosas.puerta[1]
  self.img_data = img.cosas.puerta_data
  self.radio = math.rad(radio)
  
  self.w = self.img:getWidth()
  self.h = self.img:getHeight()
  
  self.entidad:add_obj("door",self)
  
  print(self.w*self.img_data.x,self.h*self.img_data.y)
end

function puerta:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio,self.img_data.x,self.img_data.y,self.w,self.h)
end

function puerta:update(dt)
  
end

return puerta