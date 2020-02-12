local Class = require "libs.hump.class"
local destructive_terrain_physic = require "entities.map_object.destructive_terrain_physic"
local plataforma = Class{
    __includes = {destructive_terrain_physic}
}

function plataforma:init(entidad,poligono,img)
  self.entidad = entidad
  
  destructive_terrain_physic.init(self,poligono)
  
  self.ox,self.oy,self.w,self.h = self.poligonos_tabla[1].fixture:getBoundingBox(1)
  
  self.img = img.redimensionable[1]
  
  self.wi = self.img:getWidth()
  self.hi = self.img:getHeight()
  

  self.scale_w,self.scale_h = 0.2,0.5
  

  self.entidad:add_obj("platform",self)
  
end

function plataforma:draw()
 
  love.graphics.draw(self.img,self.ox,self.oy,0,self.scale_w,self.scale_h,self.wi/2,self.hi/2)

end

function plataforma:update(dt)
  
end

return plataforma