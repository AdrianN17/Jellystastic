local Class = require "libs.hump.class"
local Explosion = require "entities.explosion.explosion"

local misil = Class{}

function misil:init(entidad,img,x,y,angle,creador,index_bala,dano)
  self.entidad = entidad
  
  self.spritesheet = img
  
  self.index_bala = index_bala
  self.dano = dano
  
  
  self.radio = angle
  
  self.vel=300
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  
  local quad = self.spritesheet.balas.quad[index_bala]
  local scale = self.spritesheet.balas.scale[index_bala]
  local x,y,w,h = quad:getViewport()
  
  self.shape = love.physics.newRectangleShape(w*scale.x,h*scale.y)
  self.fixture = love.physics.newFixture(self.body,self.shape, 5)
  
  
  
  self.body:setAngle(self.radio)
  self.body:setBullet(true)
  
  self.body:setMass(2.5)
  --self.body:setFixedRotation(true)
  self.body:setLinearDamping(0)
  --self.body:setAngularDamping(4)
  self.fixture:setRestitution(0.6)
  
  self.mass= self.body:getMass()*self.body:getMass()
  
  self.creador = creador
  self.fixture : setGroupIndex ( self.creador)
    
  
  
  
  local cx,cy = math.cos(angle), math.sin(angle)
  self.body:applyLinearImpulse( cx*self.mass*self.vel,cy*self.mass*self.vel)
  

  
  
  self.entidad:add_obj("bullet",self)
  self.fixture:setUserData( {data="destructive_bullet",obj=self, pos=orden.destructive_bullet} )
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.w,self.h = w*scale.x,h*scale.y
  
  self.existe=true
  self.explosion={}
  
  self.quad = self.spritesheet.balas.quad[self.index_bala]
  self.scale = self.spritesheet.balas.scale[self.index_bala]
  
end

function misil:draw()
  
  local x,y,w,h = self.quad:getViewport()
  
  love.graphics.draw(self.spritesheet["img"],self.quad,self.ox,self.oy,self.radio,self.scale.x,self.scale.y,w/2,h/2)
end

function misil:update(dt)
  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.oy > self.entidad.caida_y  then
    self:remove()
  end
  
end

function misil:remove()
    if self.existe then
      self.body:destroy()
      self.existe=false
    end
      
    self.entidad:remove_obj("bullet",self)
end

function misil:crear_circulo(x,y,scale)

  Explosion(self.entidad,x,y,scale,self.dano)
  
  self:remove()
  
end

return misil