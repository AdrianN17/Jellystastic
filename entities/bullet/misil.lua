local Class = require "libs.hump.class"
local Explosion = require "entities.explosion.explosion"

local misil = Class{}

function misil:init(entidad,img,x,y,angle,creador,dano)
  self.entidad = entidad
  
  self.spritesheet = img
  
  self.dano = dano
  
  self.radio = angle
  
  self.vel=300
  
  self.w,self.h = 30,20
  
  
  self.quad = self.spritesheet.balas.quad[1]
  self.scale = self.spritesheet.balas.scale[1]
  
   _,_,self.wi,self.hi = self.quad:getViewport()
  _,_,w,h = self.quad:getViewport()
   
  
  
  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  self.shape = love.physics.newRectangleShape(w*self.scale_x,h* self.scale_y)
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
  
  --self.fixture : setGroupIndex ( self.creador)
  
  local cx,cy = math.cos(angle), math.sin(angle)
  self.body:applyLinearImpulse( cx*self.mass*self.vel,cy*self.mass*self.vel)
  
  
  self.entidad:add_obj("bullet",self)
  self.fixture:setUserData( {data="bullet",obj=self, pos=orden.bullet} )
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  
  
  local dir = -1
  if cx>0 then
    dir = 1
  end
  
  self.direccion = dir
  
 
end

function misil:draw()
  love.graphics.draw(self.spritesheet["img"],self.quad,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
end

function misil:update(dt)
  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.oy > self.entidad.caida_y  then
    self:remove(self.ox,self.oy)
  end
  
end

function misil:remove(x,y)
  
  if not self.body:isDestroyed() then
    
    self.entidad.timer:after(0.01,function()
      self:crear_circulo(x,y,self.explosion_scale)
    end)
    self.body:destroy()
    
    self.entidad:remove_obj("bullet",self)
  end

end

function misil:crear_circulo(x,y,scale)

  Explosion(self.entidad,x,y,scale,self.dano)
  
  self:remove()
  
end

return misil