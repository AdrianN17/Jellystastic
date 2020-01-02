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
      
      local tipo_obj=fixture:getUserData().data
      
      if tipo_obj=="map_object" then
        self.cambiar_direccion=false
      end

      return 1
  end
  
  local raycast_funcion_pared = function (fixture, x, y, xn, yn, fraction)
      local tipo_obj=fixture:getUserData().data
      
      if tipo_obj=="map_object" then
        self.cambiar_direccion=true
      end

    return 1
  end
  
  local raycast_funcion_atacar = function (fixture, x, y, xn, yn, fraction)
      local tipo_obj=fixture:getUserData().data
      
      if tipo_obj=="player" then
        self.posicion_ataque=true
        
        if self.obj_presa == nil then
          self.obj_presa = fixture:getUserData().obj
        end
        
      end

    return 1
  end
  
  self.timer:every(0.1,function() 
    self.cambiar_direccion=true

    self.entidad.world:rayCast(self.ox+(82.25/2)*self.direccion,self.oy,self.ox+(82.25/2)*self.direccion,self.oy+80,    raycast_funcion_suelo)
    
    self.entidad.world:rayCast(self.ox,self.oy,self.ox+(50)*self.direccion,self.oy,raycast_funcion_pared)
  
    if self.cambiar_direccion then
      self.direccion=self.direccion*-1
    end
    
  end)


  self.timer:every(0.05,function() 
    self.posicion_ataque=false
    
    self.entidad.world:rayCast(self.ox,self.oy,self.ox+(self.limite_vision)*self.direccion,self.oy,raycast_funcion_atacar)
    
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
  
  --love.graphics.line(self.ox,self.oy,self.ox+(self.limite_vision)*self.direccion,self.oy)
  
  --love.graphics.print(self.iterador,self.ox,self.oy-100)
end

function baba:update(dt)
  
  self.timer:update(dt)
  
  
  if self.acciones.atacando and self.obj_presa then
    local ox,oy = self.obj_presa.ox,self.obj_presa.oy
    
    local distancia = self:distance(self.ox,self.oy,ox,oy)
    
    local direccion = ox - self.ox
    
    if distancia < self.limite_vision then
      if direccion>0 and self.direccion == 1 then
        
      elseif direccion<0 and self.direccion == -1 then
        
      end
    else
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