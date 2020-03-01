local Class = require "libs.hump.class"

local plataforma = Class{
    __includes = {}
}

function plataforma:init(entidad,poligono,img)
  self.entidad = entidad
  
  self.body = love.physics.newBody(self.entidad.world,0,0)
  self.shape = love.physics.newChainShape(true,poligono)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setUserData( {data="map_object",obj=self, pos=orden.terrain} )
  
  self.ox,self.oy,self.w,self.h = self.fixture:getBoundingBox(1)
  
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