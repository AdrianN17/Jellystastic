local meteorito = Class{}

function meteorito:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.radio = radio
  
  entidad:add(properties.tabla,self)
  
  self.spritesheet = Index_img[properties.img]
  
  local quadNombre = tonumber(properties.quad) or properties.quad
  
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad[quadNombre]
  self.dimension = self.spritesheet.viewport[quadNombre]
  
  self.quadEstela = self.spritesheet.quad[properties.quadEstela]
  self.dimensionEstela = self.spritesheet.viewport[properties.quadEstela]
  
  self.width,self.height = width,height
  
  self.direccion = properties.direccion
  
  self.wi,self.hi = self.width/self.dimension.w,self.height/self.dimension.h 
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function meteorito:draw()
  love.graphics.draw(self.img,self.quadEstela,self.ox,self.oy,self.radio,self.wi*self.direccion,self.hi,
    self.dimensionEstela.w/2,(self.dimensionEstela.h/2) + self.dimensionEstela.h/5)

  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi,self.hi,self.dimension.w/2,self.dimension.h/2)
end

function meteorito:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

return meteorito