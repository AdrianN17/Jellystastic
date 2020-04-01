local textura = Class{}

function textura:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  self.ox,self.oy = ox,oy

  self.mesh = poly2mesh(shapeTableClear,properties.uv or 1)
  self.mesh:setTexture(Index_img.texturas[properties.grupo][tonumber(properties.img) or properties.img])
  
  entidad:add(properties.tabla,self)
  
  self.width,self.heigth = width,height
  self.widthArreglo,self.heightArreglo = properties.widthArreglo or 2,properties.heightArreglo or 2
end

function textura:draw()
  love.graphics.draw(self.mesh,self.ox,self.oy)
  
  --love.graphics.rectangle("line",self.ox-self.width/self.widthArreglo,self.oy-self.heigth/self.heightArreglo,self.width,self.heigth)
end

return textura