local Class = require "libs.hump.class"
local destructive_terrain = require "entities.map_object.destructive_terrain"
local gelatina = Class{
    __includes = {destructive_terrain}
}

function gelatina:init(entidad,poligono,img)
  self.entidad = entidad
  
  self.entidad:add_obj("map_object",self)
  
  destructive_terrain.init(self,poligono,img.texturas.gelatina)
  
  self.ox,self.oy,self.w,self.h = self.poligonos_tabla[1].fixture:getBoundingBox(1)
  
end

function gelatina:draw()
 
  self:draw_obj()

end

function gelatina:update(dt)
  self:update_obj(dt)
end

return gelatina