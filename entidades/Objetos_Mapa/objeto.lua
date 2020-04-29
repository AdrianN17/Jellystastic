local visible = require "entidades.visible"

local objeto = Class{
  __includes = {visible}
}

function objeto:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  self.entidad = entidad
  self.shapeTableClear = shapeTableClear

  self.ox,self.oy = ox,oy

  self.spritesheet = Index_img[properties.img]

  local quadNombre = tonumber(properties.quad) or properties.quad

  self.dimension = self.spritesheet.viewport[quadNombre]

  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad[quadNombre]

  self.direccion_x = properties.direccion_x
  self.direccion_y = properties.direccion_y

  self.posicion_x = properties.posicion_x
  self.posicion_y = properties.posicion_y

  self.width,self.height = width,height
  self.widthArreglo,self.heightArreglo = properties.widthArreglo,properties.heightArreglo

  self.wi,self.hi = self.width/self.dimension.w,self.height/self.dimension.h

  self.radio = radio

  entidad:add(properties.tabla,self)

  visible.init(self)
end

function objeto:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi*(self.direccion_x or 1),self.hi*(self.direccion_y or 1),self.dimension.w/2 * (self.posicion_x or 1),self.dimension.h/2 * (self.posicion_y or 1))

end

return objeto