local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Bala = require "entities.bullet.bala"
local LSM = require "libs.statemachine.statemachine"
local Acciones =  require "entities.enemy.acciones"

local soldado = Class{
    __includes = {Acciones,Bala}
}

function soldado:init(entidad,posicion,img,radio,tipo)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.objetivos={"player","baba","npc","map_object","bedrock","movible"}
  self.paredes_suelo={"map_object","bedrock","movible"}
  
  self.creador = 2
  self.hp = 12
  self.max_hp = self.hp
  self.vel = 100
  self.limite_vision=1000
  self.giro_completo = true
  
  
  self.dano_tocar = false
  self.posicion_ataque = false
  self.auto_recarga=true

  
  self.spritesheet = img.personajes[1]
  self.spritesheet_arma = img.armas
  
  self.timer = Timer()
  
  
  Acciones.init(self,posicion[1],posicion[2],54.75, 84)
  Bala.init(self,{"player","baba","npc"})
  self.arma_index = tonumber(tipo)
  
  self.mano_fisica = {}
  self.mano_fisica.shape_mano = love.physics.newCircleShape(20,5,1)
  self.mano_fisica.fixture_mano = love.physics.newFixture(self.body2,self.mano_fisica.shape_mano,0)
  self.mano_fisica.fixture_mano:setSensor( true )
  
  self:masa(posicion[1],posicion[2],"soldier")
  
  --FSM
  
  self.acciones = LSM.create({
   initial = 'mover',
    events ={
      {name = "a_atacar", from = {"recargar","mover"}, to = "atacar"},
      {name = "a_mover", from = {"atacar","recargar"}, to = "mover"},
      {name = "a_recargar", from ={"mover","atacar"}, to =  "recargar"}
    },
  
    callbacks = {
      ona_atacar = function(_,event,from,to)

          self:disparo_balas()

      end,
      ona_mover = function(_,event,from,to)
 
          self:terminar_disparo_balas()
        
      end,
      
      ona_recargar= function(_, event, from, to) 
        if self.timer_balas then
          self.timer:cancel(self.timer_balas)
          self.timer_balas = nil
        end
        
        self:recargar_arma()
        local bala = self.armas_values[self.arma_index]
        self.timer:after(bala.tiempo_recarga+0.25,function()
          if self.obj_presa then
            self.acciones:a_atacar()
          else
            self.acciones:a_mover()
          end
        end)
      
      end
    }
  })
  
  

  --Raycast
  
  local raycast_funcion_suelo = function (fixture, x, y, xn, yn, fraction)
      
    local tipo_obj=fixture:getUserData()
    
    for _,solido in ipairs(self.paredes_suelo) do
      if tipo_obj and tipo_obj.data==solido then
        self.cambiar_direccion=false
      end
    end

    return 1
  end
  
  local raycast_funcion_pared = function (fixture, x, y, xn, yn, fraction)
      local tipo_obj=fixture:getUserData()
      
      for _,solido in ipairs(self.paredes_suelo) do
        if tipo_obj and tipo_obj.data==solido then
          self.cambiar_direccion=true
        end
      end

    return 1
  end
  
  local raycast_funcion_atacar = function (fixture, x, y, xn, yn, fraction)
      
      if not fixture:isSensor( ) then
        local tipo_obj=fixture:getUserData()
        
        if tipo_obj then
          table.insert(self.vision_objetivos,{x=x,y=y,name = tipo_obj.data, obj = tipo_obj.obj})
        end
      end

    return 1
  end

  --Timer
  
  self.timer:every(0.3,function () 
    if self.acciones.current == "mover" then
      self.iterador2 = self.iterador2 +1
      
      if self.iterador2>3 then
        self.iterador2=1
      end
    end
    
    if self.arma_index>0 then
      local bala = self.armas_values[self.arma_index]
      if bala.stock<1 and bala.municion>0 then
        self.acciones:a_recargar()
      end
    end
    
  end)
  
  self.timer:every(0.1,function() 
    self.cambiar_direccion=true

    local x1,y1,w1,h1 = self.body2:getWorldPoints(self.lineas_fisica.shape_suelo[self.direccion]:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1,raycast_funcion_suelo)
    
    local x2,y2,w2,h2 = self.body2:getWorldPoints(self.lineas_fisica.shape_pared[self.direccion]:getPoints())
    self.entidad.world:rayCast(x2,y2,w2,h2,raycast_funcion_pared)
  
    if self.cambiar_direccion then
      self.direccion=self.direccion*-1

      self:voltear()
    end
  end)

  self.timer:every(0.025,function() 
    self.posicion_ataque=false
    
    local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
    self.entidad.world:rayCast(cx,cy,cx + math.cos(self.bala_radio)*self.limite_vision,cy + math.sin(self.bala_radio)*self.limite_vision,raycast_funcion_atacar)
    
    self:buscar_posibles_presas()
    
    if self.posicion_ataque and self.acciones.current == "mover" then
      self.acciones:a_atacar()
      
      self.iterador2 = 1
      self.posicion_ataque=false
      
    end
  end)
  
  
  self.spritesheet_accesorio = img.accesorios
  self.id_accesorio = 1
  
  self:recargar_max()
  
  self.cooldown_iterador=true
  
  self.tipo_enemigo = "soldier"
  
  self.acciones.invulnerable =false
end

function soldado:draw()
  self:draw_enemy2()
  
  love.graphics.print(self.acciones.current ,self.ox,self.oy-200)
end

function soldado:update(dt)
  self:update_bala_enemigo(dt)
  self:update_enemy(dt)
end

function soldado:voltear()
  self.bala_radio = math.atan2(math.sin(self.bala_radio),math.cos(self.bala_radio)*-1)
      
  if self.direccion == -1 then
    self.bala_radio = math.abs(self.bala_radio)
  end
end

function soldado:cambiar_estado(tipo)
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
    
  end
end

return soldado