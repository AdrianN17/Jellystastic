local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Bala = require "entities.bullet.bala"

local jelly_boy = Class{
    __includes = {Bala}
}

function jelly_boy:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("player",self)
  
  self.creador = - 1
  
  self.radio = 0
  
  self.movimiento = {a=false,d=false}
  self.ground = true
  
  self.hp = 100
  self.vel = 175
  self.jump = 30
  
  
  self.iterador=1
  self.iterador2=1
  self.arma_index = 0
  
  self.acciones = {moviendo = false, saltando = false, invulnerable = false}
  
  self.spritesheet = img.personajes[1]
  self.spritesheet_arma = img.armas
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,54.75, 84)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.w,self.h = 54.75, 84
  
  --extremidades
  
  self.lineas_fisica = {}
  self.lineas_fisica.shape_suelo1 = love.physics.newEdgeShape(-27.375/2,0,-27.375/2,50)
  self.lineas_fisica.shape_suelo2 = love.physics.newEdgeShape(27.375/2,0,27.375/2,50)
  self.lineas_fisica.fixture_suelo1 = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo1)
  self.lineas_fisica.fixture_suelo2 = love.physics.newFixture(self.body,self.lineas_fisica.shape_suelo2)
  self.lineas_fisica.fixture_suelo1:setSensor( true )
  self.lineas_fisica.fixture_suelo2:setSensor( true )
  
  self.mano_fisica = {}
  self.mano_fisica.shape_mano = love.physics.newCircleShape(20,5,1)
  self.mano_fisica.fixture_mano = love.physics.newFixture(self.body,self.mano_fisica.shape_mano)
  self.mano_fisica.fixture_mano:setSensor( true )
  
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
  
  self.fixture : setGroupIndex ( self.creador )
  
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
  
      return -1
  end

  self.timer:every(0.1, function()
    self.ground = false
    
    local x1,y1,w1,h1 = self.body:getWorldPoints(self.lineas_fisica.shape_suelo1:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1, raycast_funcion)
    
    local x2,y2,w2,h2 = self.body:getWorldPoints(self.lineas_fisica.shape_suelo2:getPoints())
    self.entidad.world:rayCast(x2,y2,w2,h2, raycast_funcion)
  end)

  Bala.init(self,"enemy")
  
  
  self.touch_inicial={x=0,y=0}
  --self.touch_inicial2={x=0,y=0}
  self.touch_list={nil,nil}
  
  self.direccion = 1
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  
  
  love.graphics.print(self.hp,self.ox,self.oy-100)
  
  local arma = self.armas_values[self.arma_index]
  
  love.graphics.print(self.direccion,self.ox,self.oy-200)
  
  
  
  self:draw_bala()
end

function jelly_boy:update(dt)
  
  self:update_bala()
  
  self.timer:update(dt)
  
  self.entidad.cam:setPosition(self.ox, self.oy)
  
  self.acciones.moviendo = false
  
  local x=0
  
  if self.movimiento.a then
    x=-1
    self.acciones.moviendo = true
  elseif self.movimiento.d then
    x=1
    self.acciones.moviendo = true
  end
  
  --if x~=0 then

		local mx=x*self.mass*self.vel
    
		local vx,vy=self.body:getLinearVelocity()
    

		if math.abs(vx)<self.vel then
			--self.body:applyLinearImpulse(mx,0)
      self.body:applyForce(mx,0)
		end
	--end
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.hp < 1 then
    self.body:destroy()
    self.entidad:remove_obj("player",self)
  end
end

function jelly_boy:saltar()
  self.body:applyLinearImpulse( 0, -self.jump*self.mass )
    
    self.acciones.saltando=true
    self.raycast_ground=false
    
    self.timer:after(0.2,function()
      self.ground = false
      self.raycast_ground=true

  end)
end

function jelly_boy:keypressed(key)
  if key == "a" then
    self.movimiento.a = true
    self.direccion=-1
  end
  
  if key == "d" then
    self.movimiento.d = true
    self.direccion=1
  end
  
  if key == "w" and self.ground and not self.acciones.saltando then
    self:saltar()
  end
  
  if key == "1" or key == "2" or key == "3" or key == "6" then
    
    local index = tonumber(key)
    
    if self.armas_values[index].enable then
      if self.timer_balas then
        self.timer:cancel(self.timer_balas)
        self.timer_balas=nil
      end
      
      if self.timer_recarga then
        self.timer:cancel(self.timer_recarga)
        self.timer_recarga=nil
      end
      
      
      
      self.arma_index = index
    end
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

function jelly_boy:mousepressed(x,y,button)
  
  if button == 1 and self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
    self:disparo(self.arma_index)
  elseif button == 2 and self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
    self.timer_recarga = nil
    self.timer_recarga = self.timer:after(self.armas_values[self.arma_index].tiempo_recarga, function()
      self:recarga(self.arma_index)
      self.timer:cancel(self.timer_recarga)
      self.timer_recarga = nil
    end)
  end
  
end

function jelly_boy:mousereleased(x,y,button)

  if button == 1 and self.arma_index > 0 and self.timer_balas then
    self.timer:cancel(self.timer_balas)
    self.timer_balas = nil
  end
end

function jelly_boy:touchpressed( id, x, y, dx, dy, pressure )
  
  self:add_touch(id)
  
  if id == self.touch_list[1] then
    
    self.touch_inicial.x = x
    self.touch_inicial.y = y
    
  elseif id==self.touch_list[2] then
    
    --self.touch_inicial2.x = x
    --self.touch_inicial2.y = y
    
    self:update_bala_android(self.ox,self.oy,x,y)
    
    if self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
      self:disparo(self.arma_index)
    end
    
  end
end

function jelly_boy:touchreleased( id, x, y, dx, dy, pressure )

  
  
  if id==self.touch_list[1] then
    self.movimiento.a = false
    self.movimiento.d = false
  elseif id==self.touch_list[2]  then
    if self.arma_index > 0 and self.timer_balas then
      self.timer:cancel(self.timer_balas)
      self.timer_balas = nil
    end
  end
  
  self:remove_touch(id)
  
end

function jelly_boy:touchmoved( id, x, y, dx, dy, pressure )
 
  
  if id==self.touch_list[1] then
    
    local x_c = self.touch_inicial.x-x
    local y_c = self.touch_inicial.y-y
    
    if  x_c <= 50 then
      
      self.movimiento.a = false
      self.movimiento.d = true
    elseif x_c >= -50 then
      self.movimiento.a = true
      self.movimiento.d = false
    end
    
    if y_c >= 80 and self.ground and not self.acciones.saltando then
      self:saltar()
    end
    
  elseif id==self.touch_list[2] then
    --self:update_bala_android(self.touch_inicial2.x,self.touch_inicial2.y,x,y)
    self:update_bala_android(self.ox,self.oy,x,y)
    
  end
  
end

function jelly_boy:add_touch(id)
  
  local validar=true
  
  for i=1,2,1 do
    local k = self.touch_list[i]
    
    if k == id then
      validar=false
      break
    end
  end
  

  if validar then
    for i=1,2,1 do
      local k = self.touch_list[i]
      
      if k == nil then
        self.touch_list[i] = id
        break
      end
    end
  end
end

function jelly_boy:remove_touch(id)
  for i=1,2,1 do
    local k = self.touch_list[i]
    if k == id then
      self.touch_list[i] = nil
      break
    end
  end
end

return jelly_boy

--disparo por presion

