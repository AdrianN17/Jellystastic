local Class = require "libs.hump.class"

local jelly_boy = Class{
    __includes = {}
}

function jelly_boy:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("player",self)
  
  self.radio = 0
  
  self.movimiento = {a=false,d=false}
  self.ground = true
  
  self.hp = 10
  self.vel = 100
  self.jump = 25
  
  
  
  
  self.arma_index = 0
  
  self.spritesheet = img.personajes[1]
  
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,54.75, 84)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  --self.fixture:setFriction(0)
  --self.fixture:setDensity(0)
	self.body:setInertia( 0 )
  self.body:setLinearDamping( 1 )
  
  self.body:setMass(20)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.acciones = {moviendo = false}
  
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[1][1]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

function jelly_boy:update(dt)
  self.entidad.cam:setPosition(self.ox, self.oy)
  
  local x=0
  
  self.acciones.moviendo = false
  
  if self.movimiento.a then
    x=-1
    self.acciones.moviendo = true
  elseif self.movimiento.d then
    x=1
    self.acciones.moviendo = true
  end
  
  if x~=0 then

		local mx=x*self.mass*self.vel*dt
    
		local vx,vy=self.body:getLinearVelocity()
    

		if math.abs(vx)<self.vel then
			self.body:applyLinearImpulse(mx,0)
		end
	end
  
  
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function jelly_boy:keypressed(key)
  if key == "a" then
    self.movimiento.a = true
  end
  
  if key == "d" then
    self.movimiento.d = true
  end
  
  if key == "w" and self.ground then
    self.body:applyLinearImpulse( 0, -self.jump*self.mass )
  end
end

function jelly_boy:keyreleased(key)
  if key == "a" then
    self.movimiento.a = false
  end
  
  if key == "d" then
    self.movimiento.d = false
  end
  
end



return jelly_boy


