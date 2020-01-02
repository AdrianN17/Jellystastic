local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Saliva = require "entities.bullet.saliva"

local baba = Class{
    __includes = {}
}

function baba:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.radio = 0
  
  self.hp = 10
  self.vel = 85
  
  self.iterador=1
  
  self.spritesheet = img.baba
  
  self.iterador=1
  
  self.cambiar_direccion=false
  self.direccion=-1
  
  self.acciones = {moviendo = true, atacando = false}
  self.posicion_ataque=false
  
  self.limite_vision=200
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,82.25, 94.5)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  --extremidades
  
  self.lineas_fisica = {}
  self.lineas_fisica.shape_suelo = {}
  self.lineas_fisica.shape_suelo[-1] = love.physics.newEdgeShape((82.25/2)*self.direccion,0,(82.25/2)*self.direccion,80)
  self.lineas_fisica.shape_suelo[1] = love.physics.newEdgeShape(-(82.25/2)*self.direccion,0,-(82.25/2)*self.direccion,80)
  self.lineas_fisica.shape_pared = {}
  self.lineas_fisica.shape_pared[-1] = love.physics.newEdgeShape(0,0,50*self.direccion,0)
  self.lineas_fisica.shape_pared[1] = love.physics.newEdgeShape(0,0,-50*self.direccion,0)
  self.lineas_fisica.shape_player = {}
  self.lineas_fisica.shape_player[-1] = love.physics.newEdgeShape(0,0,self.limite_vision*self.direccion,0)
  self.lineas_fisica.shape_player[1] = love.physics.newEdgeShape(0,0,-self.limite_vision*self.direccion,0)
  
  self.lineas_fisica.fixture_suelo = {}
  self.lineas_fisica.fixture_suelo[-1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo[-1])
  self.lineas_fisica.fixture_suelo[1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo[1])
  self.lineas_fisica.fixture_pared = {}
  self.lineas_fisica.fixture_pared[-1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_pared[-1])
  self.lineas_fisica.fixture_pared[1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_pared[1])
  self.lineas_fisica.fixture_player = {}
  self.lineas_fisica.fixture_player[-1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_player[-1])
  self.lineas_fisica.fixture_player[1] = love.physics.newFixture(self.body,self.lineas_fisica.shape_player[1])
  
  self.lineas_fisica.fixture_suelo[-1]:setSensor( true )
  self.lineas_fisica.fixture_suelo[1]:setSensor( true )
  self.lineas_fisica.fixture_pared[-1]:setSensor( true )
  self.lineas_fisica.fixture_pared[1]:setSensor( true )
  self.lineas_fisica.fixture_player[-1]:setSensor( true )
  self.lineas_fisica.fixture_player[1]:setSensor( true )
  

  self.fixture:setFriction(0.5)
  self.fixture:setDensity(1)
  --self.body:setInertia( 0 )
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)
  
  self.body:setMass(50)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fixture:setUserData( {data="enemy",obj=self, pos=2} )
  self.fixture : setGroupIndex ( - 2 )
  
  
  
  
  --timer
  
  self.timer = Timer()
  
  self.timer:every(0.5,function () 
    if self.acciones.moviendo and not self.acciones.atacando then
      self.iterador = self.iterador +1
      
      if self.iterador>3 then
        self.iterador=1
      end
    else
      if self.acciones.atacando then
        self.iterador = self.iterador +1
        
        if self.iterador == 5 and self.obj_presa then
          --lanzar saliva
          Saliva(self.entidad,self.spritesheet,self.ox,self.oy,self.obj_presa.ox,self.obj_presa.oy)
        end
        
        if self.iterador>5 then
          self.iterador=4
        end
      end
    end
  end)
  
  
  --raycast
  
  local raycast_funcion_suelo = function (fixture, x, y, xn, yn, fraction)
      
      local tipo_obj=fixture:getUserData()
      
      if tipo_obj and tipo_obj.data=="map_object" then
        self.cambiar_direccion=false
      end

      return 1
  end
  
  local raycast_funcion_pared = function (fixture, x, y, xn, yn, fraction)
      local tipo_obj=fixture:getUserData()
      
      if tipo_obj and tipo_obj.data=="map_object" then
        self.cambiar_direccion=true
      end

    return 1
  end
  
  local raycast_funcion_atacar = function (fixture, x, y, xn, yn, fraction)
      local tipo_obj=fixture:getUserData()
      
      if tipo_obj and tipo_obj.data=="player" then
        self.posicion_ataque=true
        
        if self.obj_presa == nil then
          self.obj_presa = fixture:getUserData().obj
        end
        
      end

    return 1
  end
  
  self.timer:every(0.1,function() 
    self.cambiar_direccion=true

    local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_suelo[self.direccion]:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1,raycast_funcion_suelo)
    
    local x2,y2,w2,h2 = self.body:getWorldPoints(self.lineas_fisica.shape_pared[self.direccion]:getPoints())
    self.entidad.world:rayCast(x2,y2,w2,h2,raycast_funcion_pared)
  
    if self.cambiar_direccion then
      self.direccion=self.direccion*-1
    end
    
  end)


  self.timer:every(0.05,function() 
    self.posicion_ataque=false
    
    local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_player[self.direccion]:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1,raycast_funcion_atacar)
    
    if self.posicion_ataque and not self.acciones.atacando then
      self.acciones.atacando=true
      self.acciones.moviendo=false
      self.iterador = 4
      self.posicion_ataque=false
    end
  end)

  --presa
  self.obj_presa = nil
  
end

function baba:draw()
  local quad = self.spritesheet.quad[self.iterador]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  
  --love.graphics.line(self.ox+(82.25/2)*self.direccion,self.oy,self.ox+(82.25/2)*self.direccion,self.oy+80)
  
  --love.graphics.line(self.ox,self.oy,self.ox+(50)*self.direccion,self.oy)
  
  local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_player[self.direccion]:getPoints())
  love.graphics.line(x1,y1,w1,h1)
  
  --love.graphics.print(self.iterador,self.ox,self.oy-100)
end

function baba:update(dt)
  
  self.timer:update(dt)
  
  
  if self.acciones.atacando and self.obj_presa then
    local ox,oy = self.obj_presa.ox,self.obj_presa.oy
    
    local distancia = self:distance(self.ox,self.oy,ox,oy)
    
    local direccion = ox - self.ox
    --print(direccion)
    
    if distancia > self.limite_vision or direccion>0 and self.direccion == -1 or direccion<0 and self.direccion == 1 then
      self.acciones.atacando=false
      self.obj_presa=nil
      self.acciones.moviendo = true
    end
    
  end
  

  
  if self.acciones.moviendo then
  
    local mx=self.direccion*self.mass*self.vel*dt
    
    local vx,vy=self.body:getLinearVelocity()
    
    if math.abs(vx)<self.vel then
      self.body:applyLinearImpulse(mx,0)
    end
  end

  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function baba:distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

return baba