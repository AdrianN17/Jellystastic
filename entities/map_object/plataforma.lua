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
  
  self.x,self.y = (poligono[1]+poligono[5])/2 , (poligono[2]+poligono[6])/2
  self.w_p,self.h_p = poligono[3] - poligono[1]  , poligono[8] - poligono[2]

  self.scale_w,self.scale_h = self.w_p/self.wi,self.h_p/self.hi
  
  self.radio = math.atan2(poligono[4] - poligono[2], poligono[3] - poligono[1]) 
  
  self.entidad:add_obj("platform",self)
  
  

end

function plataforma:draw()
 
  love.graphics.draw(self.img,self.x,self.y,self.radio,self.scale_w,self.scale_h,self.wi/2,self.hi/2)

end

function plataforma:update(dt)
  
end

return plataforma