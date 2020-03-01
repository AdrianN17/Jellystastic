local Class = require "libs.hump.class"

local saliva = Class{
    __includes = {}
}

function saliva:init(entidad,img,x,y,direccion,creador)
  self.entidad = entidad
  self.entidad:add_obj("bullet",self)
  
  self.creador = creador
  
  self.spritesheet = img
  
  self.radio = 0
  
  self.dano = 2
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,x,y,"dynamic")
  self.shape = love.physics.newCircleShape(18)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setRestitution(0.5)
  self.body:setBullet(true)
  self.body:setMass(0)
  self.body:setLinearDamping( 1 )
  self.fixture:setFriction(1)
  self.fixture:setDensity(1)
  self.body: setFixedRotation (true)
  --self.fixture:setSensor( true )
  self.fixture : setGroupIndex ( - 2 )
  --self.body:setGravityScale( 0 )
  
  self.fixture:setUserData( {data="enemy_bullet",obj=self, pos=orden.bullet_enemy} )
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.w,self.h = 18,18
  
  self.vel = 200
  
  self.direccion = direccion
  
  self.body:applyLinearImpulse(self.vel*self.direccion,0)
  
  self.fixture : setGroupIndex ( self.creador )
end

function saliva:update(dt)

  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function saliva:draw()
  local quad = self.spritesheet.saliva
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()

  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

function saliva:remove()
  
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
      
      
    self.entidad:remove_obj("bullet",self)
end



return saliva