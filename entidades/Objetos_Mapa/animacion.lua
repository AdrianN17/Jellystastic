local visible = require "entidades.visible"

local animacion = Class{
  __includes = {visible}
}

function animacion:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  self.entidad = entidad
  self.shapeTableClear = shapeTableClear

  self.ox,self.oy = ox,oy

  self.spritesheet = Index_img[properties.img]

  self.dimension = self.spritesheet.viewport
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad

  self.width,self.height = width,height

  self.radio = radio

  self.iterador = properties.iterador or 1
  self.maxIterador = #self.quad

  entidad:add(properties.tabla,self)

  entidad.timer:every((properties.tiempo or 1), function()

    self.iterador = self.iterador +1

    if self.iterador>self.maxIterador then
      self.iterador = 1
    end

  end)

  visible.init(self)

end

function animacion:draw()

  local quad = self.quad[self.iterador]
  local dimension = self.dimension[self.iterador]

  local wi, hi = self.width/dimension.w,self.height/dimension.h

  love.graphics.draw(self.img,quad,self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)

end

return animacion
