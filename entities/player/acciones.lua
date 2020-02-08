local Class = require "libs.hump.class"

local acciones = Class {}

function acciones:init(x,y,w,h)
  
  self.w,self.h =w, h
  
  self.movimiento = {a=false,d=false}
  self.ground = true
  self.acciones = {moviendo = false, saltando = false, invulnerable = false, quemadura = falses}
  
  self.direccion = 1
  
  self.iterador=1
  self.iterador2=1
  self.arma_index = 0
  
  self.radio = 0
   
  --fisicas
  
  self.body = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,w,h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  --extremidades
  
  self.body2 = love.physics.newBody(self.entidad.world,x,y,"dynamic")
  
  self.lineas_fisica = {}
  self.lineas_fisica.shape_suelo1 = love.physics.newEdgeShape(-27.375/2,0,-27.375/2,50)
  self.lineas_fisica.shape_suelo2 = love.physics.newEdgeShape(27.375/2,0,27.375/2,50)
  self.lineas_fisica.fixture_suelo1 = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo1)
  self.lineas_fisica.fixture_suelo2 = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo2)
  self.lineas_fisica.fixture_suelo1:setSensor( true )
  self.lineas_fisica.fixture_suelo2:setSensor( true )
  
  self.mano_fisica = {}
  self.mano_fisica.shape_mano = love.physics.newCircleShape(20,5,1)
  self.mano_fisica.fixture_mano = love.physics.newFixture(self.body2,self.mano_fisica.shape_mano,0)
  self.mano_fisica.fixture_mano:setSensor( true )
  
  self.fixture : setGroupIndex ( self.creador )
  
end

function acciones:draw_player()
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  
  love.graphics.print(self.hp,self.ox,self.oy-100)
  
  
  local arma = self.armas_values[self.arma_index]
  
  
  if arma then
    love.graphics.print(tostring(arma.stock),self.ox,self.oy-150)
  end
  
  self:draw_bala()
end

function acciones:update_player(dt)
  self:update_bala_player()
  
  self.timer:update(dt)
  
  self.acciones.moviendo = false
  
  local x=0
  
  if self.movimiento.a then
    x=-1
    self.acciones.moviendo = true
  elseif self.movimiento.d then
    x=1
    self.acciones.moviendo = true
  end
  
  local mx=x*self.mass*self.vel
  
  local vx,vy=self.body:getLinearVelocity()
  

  if math.abs(vx)<self.vel then
    self.body:applyForce(mx,0)
  end
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.hp < 0.1 or self.oy > self.entidad.caida_y then
    self.body2:destroy()
    self.body:destroy()
    self.entidad:remove_obj("player",self)
  end
end


function acciones:saltar()
  self.body:applyLinearImpulse( 0, -self.jump*self.mass )
    
    self.acciones.saltando=true
    self.raycast_ground=false
    
    self.timer:after(0.2,function()
      self.ground = false
      self.raycast_ground=true

  end)
end

function acciones:keypressed(key)
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

function acciones:keyreleased(key)
  if key == "a" then
    self.movimiento.a = false
  end
  
  if key == "d" then
    self.movimiento.d = false
  end
end

function acciones:mousepressed(x,y,button)
  
  if(love.mouse.getX()<self.entidad.camera_x_ui) then
    if button == 1 and self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
      self:disparo(self.arma_index)
    elseif button == 2 then
      self:recargar_arma()
    end
  else
    --moviles
    self.entidad:check_arma()
  end
  
end

function acciones:mousereleased(x,y,button)

  
  if button == 1 and self.arma_index > 0 and self.timer_balas then
    self.timer:cancel(self.timer_balas)
    self.timer_balas = nil
  end

end

function acciones:joystick(dir)
  
  self.movimiento.a = false
  self.movimiento.d = false
  
  if dir:match("l") then
    self.movimiento.a = true
  elseif dir:match("r") then
    self.movimiento.d = true
  end

  if dir:match("t") and self.ground and not self.acciones.saltando then
    self:saltar()
  end
end

function acciones:masa(x,y)
  self.body2:setMass(1)
  
  self.joint = love.physics.newRevoluteJoint(self.body,self.body2,x,y,false)
  
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
end

function acciones:recargar_arma()
  
  if self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
    self.timer_recarga = nil
    self.timer_recarga = self.timer:after(self.armas_values[self.arma_index].tiempo_recarga, function()
      self:recarga(self.arma_index)
      self.timer:cancel(self.timer_recarga)
      self.timer_recarga = nil
    end)
  end
end

return acciones


--[[

function acciones:touchpressed( id, x, y, dx, dy, pressure )
  
  if(love.mouse.getX()<self.entidad.camera_x_ui) then
    self:add_touch(id)
    
    if id == self.touch_list[1] then
      
      self.touch_inicial.x = x
      self.touch_inicial.y = y
      
    elseif id==self.touch_list[2] then

      
      self:update_bala_android(self.ox,self.oy,x,y)
      
      if self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
        self:disparo(self.arma_index)
      end
    end
  else
    --moviles
    self.entidad:check_arma()
  end
end

function acciones:touchreleased( id, x, y, dx, dy, pressure )
  
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

function acciones:touchmoved( id, x, y, dx, dy, pressure )
 
  if(love.mouse.getX()<self.entidad.camera_x_ui) then
  
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
      self:update_bala_android(self.ox,self.oy,x,y)
      
    end
  end
  
end

function acciones:add_touch(id)
  
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

function acciones:remove_touch(id)
  for i=1,2,1 do
    local k = self.touch_list[i]
    if k == id then
      self.touch_list[i] = nil
      break
    end
  end
end]]