local Class = require "libs.hump.class"

local acciones = Class {}

function acciones:init(x,y,w,h)
  
  self.w,self.h =w, h
  
  self.movimiento = {a=false,d=false}
  self.ground = true
  self.acciones = {moviendo = false, saltando = false, invulnerable = false}
  
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
  self.lineas_fisica.shape_suelo1 = love.physics.newEdgeShape(-27.375/2,-35,-27.375/2,75)
  self.lineas_fisica.shape_suelo2 = love.physics.newEdgeShape(27.375/2,-35,27.375/2,75)
  self.lineas_fisica.fixture_suelo1 = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo1)
  self.lineas_fisica.fixture_suelo2 = love.physics.newFixture(self.body2,self.lineas_fisica.shape_suelo2)
  self.lineas_fisica.fixture_suelo1:setSensor( true )
  self.lineas_fisica.fixture_suelo2:setSensor( true )
  
  self.mano_fisica = {}
  self.mano_fisica.shape_mano = love.physics.newCircleShape(20,5,1)
  self.mano_fisica.fixture_mano = love.physics.newFixture(self.body2,self.mano_fisica.shape_mano,0)
  self.mano_fisica.fixture_mano:setSensor( true )
  
  
  self.body:setBullet(true)
  
  self.hay_puerta=false
  self.data_puerta=nil
  
  self.cooldown_timer = nil
  self.cooldown = false
  
  self.cooldown_iterador = true
  
  self.funcion_arma_temp =nil
  
  self.item_touch = nil
  
  self.arma_index_respaldo = 0
  
  self.joint_movible = nil
  self.objetivo_movible = nil
  
end

function acciones:draw_player()
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local _, _ ,w,h = quad:getViewport()
  
  love.graphics.setShader(self.shader_player)
    love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  love.graphics.setShader()
  
  
  local quad1 = self.spritesheet_accesorio.quad[self.id_accesorio]
  local scale1 = self.spritesheet_accesorio.scale
  local _,_,w1,h1 = quad1:getViewport()
  love.graphics.draw(self.spritesheet_accesorio["img"],quad1,self.ox,self.oy-35,self.radio,scale1.x*self.direccion,scale1.y,w1/2,h1/2)
  
  love.graphics.print(self.hp,self.ox,self.oy-100)
  
  local arma = self.armas_values[self.arma_index]
  
  
  if arma then
   -- love.graphics.print(tostring(self.cooldown) .. " , " .. tostring(self.cooldown_timer) .. " , " .. tostring(arma.stock),self.ox,self.oy-150)
  end
  
  self:draw_bala()
end

function acciones:update_player(dt)
  self:update_bala_player()
  
  self.timer:update(dt)
  
  if self.funcion_arma_temp and not self.cooldown then
    self:funcion_arma_temp()
    self.funcion_arma_temp=nil
  end
  
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
  
  
  if self.hp < 0.1 and self.iterador== 4 then
    self.entidad:crear_zombie(self.ox,self.oy)
  end
  
  if self.hp < 0.1 or self.oy > self.entidad.caida_y then
    self.entidad:eliminar_presa(self)
    self.body2:destroy()
    self.body:destroy()
    self.entidad:remove_obj("player",self)
    
  end
end


function acciones:saltar()
  self.body:applyLinearImpulse( 0, -self.jump*self.mass )
    
    self.acciones.saltando=true
    self.raycast_ground=false
    self.ground = false
    
    self.timer:after(0.1,function()
      if not self.acciones.saltando then
        self.acciones.saltando=true
        self.ground = false
      end
    end)
    
    self.timer:after(0.5,function()
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
  
  if key == "w" and self.ground and not self.acciones.saltando and self.raycast_ground then
    self:saltar()
  end
  
  if key == "q" then
    if self.arma_index_respaldo == 0 then
      self.arma_index_respaldo = self.arma_index
      self.arma_index = 0
    else
      self.arma_index = self.arma_index_respaldo 
      self.arma_index_respaldo = 0
    end
  end
  
  if key == "e" and self.item_touch then
    self.item_touch:usar(self)
  elseif key == "e" and self.hay_puerta and self.data_puerta and self.ground then
    self.entidad:ir_a_otro_nivel(self.data_puerta)
  end
  
  if key == "g" and self.objetivo_movible and self.ground and not self.joint_movible then
    self.joint_movible = love.physics.newWeldJoint(self.body,self.objetivo_movible.obj.body,self.objetivo_movible.x,self.objetivo_movible.y,true)
  end
end

function acciones:keyreleased(key)
  if key == "a" then
    self.movimiento.a = false
  end
  
  if key == "d" then
    self.movimiento.d = false
  end
  
  if key == "g" and self.objetivo_movible  then
    self.objetivo_movible = nil
    self.joint_movible:destroy( )
    self.joint_movible=nil
  end
end

function acciones:mousepressed(x,y,button)
  
  if not self.funcion_arma_temp then
    self.funcion_arma_temp = function()
      if button == 1 then
        self:disparo_balas()
      elseif button == 2 then
        self:recargar_arma()
      end
    end
  end

  if button == 1 and not self.cooldown then
    self:disparo_balas()
  elseif button == 2 and not self.cooldown then
    self:recargar_arma()
  end
  
end

function acciones:mousereleased(x,y,button)

  if button == 1 and not self.cooldown and self.arma_index>0 then
    self:terminar_disparo_balas()
    
    self.cooldown = true
    
    self.cooldown_timer = self.timer:after(self.armas_values[self.arma_index].tiempo, function()
      self.cooldown = false
      self.cooldown_timer=nil
    end)
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

  if dir:match("t") and self.ground and not self.acciones.saltando and self.raycast_ground then
    self:saltar()
  elseif dir:match("b") and self.hay_puerta and self.data_puerta and self.ground then
    self.entidad:ir_a_otro_nivel(self.data_puerta)
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
  
  self.fixture:setUserData( {data="player",obj=self, pos=orden.player} )
  
  self.body:resetMassData ()
  self.body:setMass(20)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
end

function acciones:clear_puerta()
  self.hay_puerta=false
  self.data_puerta=nil
end

function acciones:cambiar_estado(tipo)
  local hp = self.max_hp*0.5

  if self.hp<hp and self.cooldown_iterador then
    
    if tipo == "semizombie" then
      self.iterador = 4
    elseif tipo == "agujereado" then
      self.iterador = 2
    elseif tipo == "canon" then
      self.iterador = 3
    end
    
    self.cooldown_iterador = false
    
  elseif self.hp>hp and not self.cooldown_iterador then
    
    self.iterador = 1
    self.cooldown_iterador = true
  end
end

function acciones:limpiar_movimiento()
  self.movimiento = {a=false,d=false}
end

return acciones