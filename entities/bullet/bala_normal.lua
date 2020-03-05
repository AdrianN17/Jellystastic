local Class = require "libs.hump.class"
local bala_normal = Class{}

function bala_normal:init(entidad,img,x,y,angle,creador,dano)
  
  self.entidad = entidad
  
  self.img = img_index.bala.img 
  self.quad = img_index.bala.quad[1]
  
  
  self.ox,self.oy = x,y
  _,_,self.wi,self.hi = self.quad:getViewport()
  
  self.w,self.h = 12.5,12.5
  

  self.dano = dano
  
  
  self.radio = angle- math.pi/2
  
  self.vel=1500
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  
  self.shape = love.physics.newCircleShape(6.25)
  self.fixture = love.physics.newFixture(self.body,self.shape, 1)
  
  
  
  self.body:setAngle(self.radio)
  self.body:setBullet(true)

  
  self.body:setMass(0)
  self.body:setFixedRotation(true)
  self.body:setLinearDamping(0)
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

  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
end

function bala_normal:update(dt)
  self.body:applyForce( self.cx*self.vel, self.cy*self.vel)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
end


function bala_normal:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)

end

function bala_normal:remove()
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
      
    self.entidad:remove_obj("bullet",self)
end


return bala_normal