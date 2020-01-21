local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Bala = require "entities.bullet.bala"

local jelly_boy = Class{
    __includes = {Bala}
}

function jelly_boy:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("player",self)
  
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
  
  self.fixture : setGroupIndex ( - 1 )
  
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
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
  
  
  love.graphics.print(self.hp,self.ox,self.oy-100)
  
  local arma = self.armas_values[self.arma_index]
  
  love.graphics.print(Inspect(arma),self.ox,self.oy-200)
  
  self:draw_bala()
end

function jelly_boy:update(dt)
  
  self:update_bala()
  
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
  
  --if x~=0 then

		local mx=x*self.mass*self.vel*dt
    
		local vx,vy=self.body:getLinearVelocity()
    

		if math.abs(vx)<self.vel then
			self.body:applyLinearImpulse(mx,0)
		end
	--end
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.hp < 1 then
    self.body:destroy()
    self.entidad:remove_obj("player",self)
  end
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
  
  if key == "1" or key == "2" or key == "3" or key == "6" then
    
    local index = tonumber(key)
    
    if self.armas_values[index].enable then
      if self.timer_balas then
        self.timer_balas=nil
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
  
  if button == 1 and self.arma_index > 0 then
    self:disparo()
  elseif button == 2 and self.arma_index > 0 then
    self:recarga()
  end
  
end

function jelly_boy:mousereleased(x,y,button)

  if button == 1 and self.arma_index > 0 and self.timer_balas then
    self.timer:cancel(self.timer_balas)
    self.timer_balas = nil
  end
end

function jelly_boy:disparo()
  local arma = self.armas_values[self.arma_index]
    
    if arma.stock>=1 then
      
      if arma.raycast then
        self:generar_bala_raycast()
      else
        
      end
      
      arma.stock = arma.stock-1
    end
    
    if arma.tiempo ~= 0 then
      self.timer_balas = nil
      self.timer_balas = self.timer:every(arma.tiempo,
        function()
          if arma.stock>=1 then
            
            if arma.raycast then
              self:generar_bala_raycast()
            else
              
            end
            
            arma.stock = arma.stock-1
          end
        end)
    end
end

function jelly_boy:generar_bala_raycast()
    self.entidad.world:rayCast(self.ox,self.oy,self.ox + math.cos(self.bala_radio)*self.max_distancia_bala,self.oy + math.sin(  self.bala_radio)*self.max_distancia_bala,self.raycast_bala_disparo)
    
    self:unico_target()
    
    self.bala_objetivos = {}
end

function jelly_boy:recarga()
    local arma = self.armas_values[self.arma_index]
    
    if arma.max_stock>arma.stock and arma.municion>0 then
      if arma.municion + arma.stock < arma.max_stock then
        arma.stock=arma.municion+arma.stock
        arma.municion=0
      else
        local carga=arma.max_stock-arma.stock
        arma.stock=arma.stock+carga
        arma.municion=arma.municion-carga
      end
    end
end

return jelly_boy


--[[

if tabla.municion[self.tipo]+self.cantidad< tabla.max_municion[self.tipo] then
		tabla.municion[self.tipo]=tabla.municion[self.tipo]+self.cantidad
		self.cantidad=0
		be:remove(self,"objetos")
	else
		local muni=tabla.max_municion[self.tipo]-tabla.municion[self.tipo]
		tabla.municion[self.tipo]=tabla.municion[self.tipo]+muni
		self.cantidad=self.cantidad-muni
	end
]]


