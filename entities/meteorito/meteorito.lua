local Class = require "libs.hump.class"

local meteorito = Class{}

function meteorito:init(entidad,posicion)
  self.entidad=entidad
  
  self.ix,self.iy = posicion[1],posicion[2]
  
  self.img = img_index.meteorito.img
  self.quad = img_index.meteorito.quad[1]
  self.estela = img_index.meteorito.fuego
  
  _,_,self.wi,self.hi = self.quad:getViewport()
  _,_,self.wi2,self.hi2 = self.estela:getViewport()
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newCircleShape(25)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setUserData( {data="meteorito",obj = self, pos=orden.meteorito} )
  
  self.w,self.h = 50,50
  
  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  self.ox,self.oy = self.body:getX(), self.body:getY()
  self.radio = self.body:getAngle()
  
  self.direccion = 1
  self.dano = 15

  self.entidad:add_obj("meteorito",self)
end

function meteorito:update(dt)
  self.ox,self.oy = self.body:getX(), self.body:getY()
  self.radio = self.body:getAngle()
end

function meteorito:draw()
  love.graphics.draw(self.img,self.estela,self.ox,self.oy,self.radio,self.scale_x* self.direccion,self.scale_y,self.wi2/2,(self.hi2/2)+self.hi2/5)
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

function meteorito:mover()
  self.entidad.timer:after(0.01, function()
    self.body:setPosition(self.ix,self.iy)
    self.body:setLinearVelocity(0,0)
  end)
end

return meteorito