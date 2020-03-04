local Class = require "libs.hump.class"
local bala_normal = Class{}

function bala_normal:init(entidad,img,x,y,angle,creador,dano)
  
  self.entidad = entidad
  
  self.img = img_index.bala.img 
  self.scale = img_index.bala.scale
  
  
  self.ox,self.oy = x,y
  self.wi,self.hi = self.img:getDimensions()
  self.w,self.h = self.wi * self.scale.x,self.hi * self.scale.y


  self.dano = dano
  
  
  self.radio = angle- math.pi/2
  
  self.vel=2000
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  
  self.shape = love.physics.newCircleShape(1)
  self.fixture = love.physics.newFixture(self.body,self.shape, 0)
  
  
  
  self.body:setAngle(self.radio)
  self.body:setBullet(true)
  
  self.body:setMass(0)
  --self.body:setFixedRotation(true)
  self.body:setLinearDamping(0)
  --self.body:setAngularDamping(4)
  self.fixture:setRestitution(0.6)
  
  self.mass= self.body:getMass()*self.body:getMass()
  
  self.creador = creador
  
  
  self.distance = self.h
  
  
  self.entidad:add_obj("bullet",self)
  self.fixture:setUserData( {data="bullet",obj=self, pos=orden.bullet} )
  
  self.ox,self.oy = self.body:getX(),self.body:getY()

  
  local cx,cy = math.cos(angle), math.sin(angle)
 
  
  local dir = -1
  if cx>0 then
    dir = 1
  end
  
  self.cx,self.cy=cx,cy
  
  self.direccion = dir
  

  
  self.body:setGravityScale( 0 )

  
  self.fx,self.fy = self.ox -(self.distance * self.cx),self.oy -(self.distance * self.cy)
  
end

function bala_normal:update(dt)
  self.body:applyForce( self.cx*self.vel, self.cy*self.vel)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fx,self.fy = self.ox -(self.distance * self.cx),self.oy -(self.distance * self.cy)
end


function bala_normal:draw()
  love.graphics.draw(self.img,self.fx,self.fy,self.radio,self.scale.x,self.scale.y,self.wi/2,0)

end

function bala_normal:remove()
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
      
    self.entidad:remove_obj("bullet",self)
end


return bala_normal