local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"

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
  
  
  
  self.iterador=1
  self.iterador2=1
  self.arma_index = 0
  
  self.acciones = {moviendo = false, saltando = false}
  
  self.spritesheet = img.personajes[1]
  
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,54.75, 84)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  --self.fixture:setFriction(0)
  --self.fixture:setDensity(0)
	self.body:setInertia( 0 )
  self.body:setLinearDamping( 1 )
  

  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fixture:setUserData( {data="player",obj=self, pos=1} )
  
  --raycast
  
  --[[self.shape_raycast = love.physics.newEdgeShape(0,50,0,40)
  self.fixture_raycast=love.physics.newFixture(self.body,self.shape_raycast)]]
  
  self.body:setMass(20)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  --timer
  
  self.timer = Timer()
  
  self.timer:every(0.25, function()
    if self.acciones.moviendo and not self.acciones.saltando then
      
      self.iterador2 = self.iterador2 +1
      
      if self.iterador2>3 then
        self.iterador2=1
      end
      
    elseif self.acciones.saltando then
      self.iterador2=4
    else
      self.iterador2=1
    end
  end)

  local raycast_funcion = function (fixture, x, y, xn, yn, fraction)
      
      local tipo_obj=fixture:getUserData().data
  
      self.ground = false
  
      if tipo_obj=="map_object" then
        self.ground = true
        self.acciones.saltando=false
      end
  
      return -1
  end

  self.timer:every(0.1, function()
    self.entidad.world:rayCast(self.ox,self.oy,self.ox,self.oy+100, raycast_funcion)
  end)
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
  
  love.graphics.line(self.ox,self.oy+40,self.ox,self.oy+50)
  
  love.graphics.print(tostring(self.ground),self.ox,self.oy-100)
end

function jelly_boy:update(dt)
  
  
  self.timer:update(dt)
  
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
    
    
    self.timer:after(0.2,function()
      self.ground = false
      self.acciones.saltando=true
    end)
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


