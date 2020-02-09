local Class = require "libs.hump.class"
local destructive_terrain = require "entities.map_object.destructive_terrain"
local plataforma = Class{
    __includes = {destructive_terrain}
}

function plataforma:init(entidad,poligono,img)
  self.entidad = entidad
  
  self.entidad:add_obj("platform",self)
  
  destructive_terrain.init(self,poligono,img.texturas.techo)
  
  self.ox,self.oy,self.w,self.h = self.poligonos_tabla[1].fixture:getBoundingBox(1)
  
end

function plataforma:draw()
 
  self:draw_obj()

end

function plataforma:update(dt)
  self:update_obj(dt)
end

return plataforma