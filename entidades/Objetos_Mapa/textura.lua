local visible = require "entidades.visible"

local textura = Class{
  __includes = {visible}
}

function textura:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  self.entidad = entidad
  self.shapeTableClear = shapeTableClear

  self.ox,self.oy = ox,oy

  self.mesh = poly2mesh(shapeTableClear,properties.uv or 1)
  self.mesh:setTexture(Index_img.texturas[properties.grupo][tonumber(properties.img) or properties.img])

  entidad:add(properties.tabla,self)

  self.width,self.heigth = width,height

  visible.init(self)

end

function textura:draw()
  love.graphics.draw(self.mesh,self.ox,self.oy)

end

return textura