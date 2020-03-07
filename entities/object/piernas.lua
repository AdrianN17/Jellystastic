local Class = require "libs.hump.class"
local piernas = Class{}

function piernas:init(entidad,tabla)
  self.entidad = entidad
  
  self.w,self.h = tabla.wi*tabla.scale.x,tabla.hi*tabla.scale.y
  
  self.body = love.physics.newBody(self.entidad.world,tabla.ox,tabla.oy,"dynamic")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setUserData( {data="pierna",obj=self, pos=orden.pierna} )
  self.fixture:setSensor(true)
  
  self.ox,self.oy = self.body:getX(), self.body:getY()
  
  self.wi,self.hi = tabla.wi,tabla.hi
  self.scale = tabla.scale
  
  self.spritesheet = tabla.spritesheet
  self.quad = tabla.quad
  
  self.shader = tabla.shader
  
  self.entidad:add_obj("muerte",self)
end

function piernas:draw()
  if self.shader then
    love.graphics.setShader(self.shader)
  end
    love.graphics.draw(self.spritesheet.img,self.quad,self.ox,self.oy,0,self.scale.x,self.scale.y,self.wi/2,self.hi/2)
  love.graphics.setShader()
end

function piernas:update(dt)
  self.ox,self.oy = self.body:getX(), self.body:getY()
  
  if self.oy > self.entidad.caida_y then
    self.entidad:remove_obj("muerte",self)
    
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
    
  end
end


return piernas