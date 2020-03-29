local textura = Class{}

function textura:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  self.ox,self.oy = ox,oy

  self.mesh = poly2mesh(shapeTableClear,properties.uv or 1)
  self.mesh:setTexture(Index_img.texturas[properties.grupo][tonumber(properties.img) or properties.img])
  
  entidad:add(properties.tabla,self)
  
  self.width,self.heigth = width,height
  self.widthArreglo,self.heightArreglo = properties.widthArreglo,properties.heightArreglo
end

function textura:draw()
  love.graphics.draw(self.mesh,self.ox,self.oy)
end

return textura