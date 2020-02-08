local Class = require "libs.hump.class"

local acciones = Class {}

function acciones:init(x,y,w,h)
    
  self.radio = 0
    
  self.iterador=1
  self.cambiar_direccion=false
  self.direccion=-1
  
  self.w,self.h =w, h
  
  --fisicas
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,w,h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.body2 = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  
  --extremidades
  
  self.lineas_fisica = {}
  self.lineas_fisica.shape_suelo = {}
  self.lineas_fisica.shape_suelo[-1] = love.physics.newEdgeShape((82.25/4)*self.direccion,0,(82.25/4)*self.direccion,80)
  self.lineas_fisica.shape_suelo[1] = love.physics.newEdgeShape(-(82.25/4)*self.direccion,0,-(82.25/4)*self.direccion,80)
  self.lineas_fisica.shape_pared = {}
  self.lineas_fisica.shape_pared[-1] = love.physics.newEdgeShape(0,0,75*self.direccion,0)
  self.lineas_fisica.shape_pared[1] = love.physics.newEdgeShape(0,0,-75*self.direccion,0)
  self.lineas_fisica.shape_player = {}
  self.lineas_fisica.shape_player[-1] = love.physics.newEdgeShape(0,0,self.limite_vision*self.direccion,0)
  self.lineas_fisica.shape_player[1] = love.physics.newEdgeShape(0,0,-self.limite_vision*self.direccion,0)
  
  self.lineas_fisica.fixture_suelo = {}
  self.lineas_fisica.fixture_suelo[-1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo[-1])
  self.lineas_fisica.fixture_suelo[1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo[1])
  self.lineas_fisica.fixture_pared = {}
  self.lineas_fisica.fixture_pared[-1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_pared[-1])
  self.lineas_fisica.fixture_pared[1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_pared[1])
  self.lineas_fisica.fixture_player = {}
  self.lineas_fisica.fixture_player[-1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_player[-1])
  self.lineas_fisica.fixture_player[1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_player[1])
  
  self.lineas_fisica.fixture_suelo[-1]:setSensor( true )
  self.lineas_fisica.fixture_suelo[1]:setSensor( true )
  self.lineas_fisica.fixture_pared[-1]:setSensor( true )
  self.lineas_fisica.fixture_pared[1]:setSensor( true )
  self.lineas_fisica.fixture_player[-1]:setSensor( true )
  self.lineas_fisica.fixture_player[1]:setSensor( true )

  --presa
  self.obj_presa = nil
end

function acciones:draw_enemy()
  local quad = self.spritesheet.quad[self.iterador]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  
  --love.graphics.line(self.ox+(82.25/2)*self.direccion,self.oy,self.ox+(82.25/2)*self.direccion,self.oy+80)
  
  --love.graphics.line(self.ox,self.oy,self.ox+(50)*self.direccion,self.oy)
  
  --local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_player[self.direccion]:getPoints())
  --love.graphics.line(x1,y1,w1,h1)
  
  love.graphics.print(self.hp,self.ox,self.oy-100)
end

function acciones:update_enemy(dt)
  self.timer:update(dt)
  
  
  if self.acciones.current == "atacar" and self.obj_presa then
    local ox,oy = self.obj_presa.ox,self.obj_presa.oy
    
    local distancia = self.entidad:distance(self.ox,self.oy,ox,oy)
    
    local direccion = ox - self.ox
    --print(direccion)
    
    if distancia > self.limite_vision or direccion>0 and self.direccion == -1 or direccion<0 and self.direccion == 1 then
      self.obj_presa=nil
      self.acciones:a_mover()
    end
    
  end
  

  
  if self.acciones.current == "mover" then
  
    local mx=self.direccion*self.mass*self.vel
    
    local vx,vy=self.body:getLinearVelocity()
    
    if math.abs(vx)<self.vel then
      --self.body:applyLinearImpulse(mx,0)
      self.body:applyForce(mx,0)
    end
  end

  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.hp < 0.1 then
    self.body2:destroy()
    self.body:destroy()
    self.entidad:remove_obj("enemy",self)
  end
end


function acciones:masa(x,y)
  self.joint = love.physics.newRevoluteJoint(self.body,self.body2,x,y,false)
  
  self.fixture:setFriction(0.5)
  self.fixture:setDensity(1)
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)
  
  self.body:setMass(50)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fixture:setUserData( {data="enemy",obj=self, pos=2} )
  self.fixture : setGroupIndex ( self.creador)
end


return acciones