local Class = require "libs.hump.class"

local saliva = Class{
    __includes = {}
}

function saliva:init(entidad,img,x,y,ex,ey,direccion)
  self.entidad = entidad
  self.entidad:add_obj("bullet",self)
  
  self.spritesheet = img
  
  self.radio = 0
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,x,y,"dynamic")
  self.shape = love.physics.newCircleShape(18)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setRestitution(0.5)
  
  self.body:setMass(0)
  self.body:setLinearDamping( 1 )
  self.fixture:setFriction(0)
  self.fixture:setDensity(1)
  self.body: setFixedRotation (true)
  --self.fixture:setSensor( true )
  self.fixture : setGroupIndex ( - 2 )
  --self.body:setGravityScale( 0 )
  
  self.fixture:setUserData( {data="enemy_bullet",obj=self, pos=4} )
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  local angle = self.entidad:round(math.deg(math.atan2(self.oy - ey,self.oy - ex)))
  --print(angle)
  local angle = math.rad(angle)
  local cx,cy  = math.cos(angle),math.sin(angle)
  self.vel = 175
  
  self.body:applyLinearImpulse(cx*self.vel*-direccion, cy*self.vel)
  
  self.vida=true
end

function saliva:update(dt)
  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if not self.vida then
    self:remove()
  end
end

function saliva:draw()
  local quad = self.spritesheet.saliva
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()

  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

function saliva:remove()
  self.body:destroy()
  self.entidad:remove_obj("bullet",self)

end



return saliva