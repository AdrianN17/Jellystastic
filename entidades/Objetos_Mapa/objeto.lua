local objeto = Class{}

function objeto:init(entidad,ox,oy,radio,shapeTableClear,properties,width,height) 
  
  self.ox,self.oy = ox,oy
  
  self.spritesheet = Index_img[properties.img]
  self.dimension = self.spritesheet.viewport[properties.quad]
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad[properties.quad]
  
  self.direccion_x = properties.direccion_x
  self.direccion_y = properties.direccion_y
  
  local wi,hi =width,height
  
  self.wi,self.hi = wi/self.dimension.w,hi/self.dimension.h 
  
  self.radio = radio

  entidad:add(properties.tabla,self)
end

function objeto:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi*(self.direccion_x or 1),self.hi*(self.direccion_y or 1),self.dimension.w/2,self.dimension.h/2)
  
  love.graphics.circle("fill",self.ox,self.oy,6)
end

return objeto