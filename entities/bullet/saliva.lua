local Class = require "libs.hump.class"

local saliva = Class{
    __includes = {}
}

function saliva:init(entidad,img,x,y,ex,ey)
  self.entidad = entidad
  self.entidad:add_obj("bullet",self)
  
  self.spritesheet = img
  
  self.ox,self.oy = x,y
  
end

function saliva:update(dt)
  
end

function saliva:draw()
  local quad = self.spritesheet.saliva
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

return saliva