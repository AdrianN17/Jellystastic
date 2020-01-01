local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"

local baba = Class{
    __includes = {}
}

function baba:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.radio = 0
  
  self.hp = 10
  self.vel = 50
  
  self.iterador=1
  
  self.spritesheet = img.baba
  
  self.iterador=1
  
  self.cambiar_direccion=false
  self.direccion=-1
  
  self.acciones = {moviendo = false, atacando = false}
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,82.25, 94.5)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setFriction(1)
  self.fixture:setDensity(0)
	self.body:setInertia( 0 )
  self.body:setLinearDamping( 1 )
  
  self.body:setMass(20)
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
        
        if self.iterador>5 then
          self.iterador=1
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
  
  self.timer:every(0.1,function() 
    self.cambiar_direccion=true

    self.entidad.world:rayCast(self.ox+(82.25/2)*self.direccion,self.oy,self.ox+(82.25/2)*self.direccion,self.oy+60, raycast_funcion_suelo,1)
    
    if self.cambiar_direccion then
      self.direccion=self.direccion*-1
    end

  end)
  
  
end

function baba:draw()
  local quad = self.spritesheet.quad[self.iterador]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  
  love.graphics.line(self.ox+(82.25/2)*self.direccion,self.oy,self.ox+(82.25/2)*self.direccion,self.oy+60)
end

function baba:update(dt)
  
  self.timer:update(dt)
  
  self.acciones.moviendo = false
  
  if self.direccion ~= 0 then
    self.acciones.moviendo = true
  
    local mx=self.direccion*self.mass*self.vel*dt
    
    local vx,vy=self.body:getLinearVelocity()
    
    if math.abs(vx)<self.vel then
      self.body:applyLinearImpulse(mx,0)
    end
  end

  self.ox,self.oy = self.body:getX(),self.body:getY()
end

return baba