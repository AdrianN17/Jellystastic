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
  self.vel = 175
  self.jump = 30
  
  
  
  self.iterador=1
  self.iterador2=1
  self.arma_index = 0
  
  self.acciones = {moviendo = false, saltando = false}
  
  self.spritesheet = img.personajes[1]
  
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,54.75, 84)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  --extremidades
  
  self.lineas_fisica = {}
  self.lineas_fisica.shape_suelo1 = love.physics.newEdgeShape(-27.375,0,-27.375,50)
  self.lineas_fisica.shape_suelo2 = love.physics.newEdgeShape(27.375,0,27.375,50)
  self.lineas_fisica.fixture_suelo1 = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo1)
  self.lineas_fisica.fixture_suelo2 = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo2)
  self.lineas_fisica.fixture_suelo1:setSensor( true )
  self.lineas_fisica.fixture_suelo2:setSensor( true )
  
  self.fixture:setFriction(0.1)
  self.fixture:setDensity(1)
	--self.body:setInertia( 1)
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)
  
  self.fixture:setUserData( {data="player",obj=self, pos=1} )
  
  self.body:resetMassData ()
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

  --raycast
  
  self.raycast_ground = true

  local raycast_funcion = function (fixture, x, y, xn, yn, fraction)
      
      local tipo_obj=fixture:getUserData()
  
  
      if tipo_obj and tipo_obj.data=="map_object" then
        self.ground = true
        self.acciones.saltando=false
      end
  
      return 1
  end

  self.timer:every(0.1, function()
    self.ground = false
    
    local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_suelo1:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1, raycast_funcion)
    
    local x2,y2,w2,h2 = self.body:getWorldPoints(self.lineas_fisica.shape_suelo2:getPoints())
    self.entidad.world:rayCast(x2,y2,w2,h2, raycast_funcion)
  end)

  
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
  
  --love.graphics.line(self.ox-27.375,self.oy,self.ox-27.375,self.oy+50)
  --love.graphics.line(self.ox+27.375,self.oy,self.ox+27.375,self.oy+50)
  
  --love.graphics.print(tostring(self.ground),self.ox,self.oy-100)
  --love.graphics.print(tostring(self.acciones.saltando),self.ox,self.oy-200)
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
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function jelly_boy:keypressed(key)
  if key == "a" then
    self.movimiento.a = true
  end
  
  if key == "d" then
    self.movimiento.d = true
  end
  
  if key == "w" and self.ground and not self.acciones.saltando then
    self.body:applyLinearImpulse( 0, -self.jump*self.mass )
    
    self.acciones.saltando=true
    self.raycast_ground=false
    
    self.timer:after(0.2,function()
      self.ground = false
      self.raycast_ground=true

    end)
  end
  
  if key == "1" then
    self.body:setY(0)
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


