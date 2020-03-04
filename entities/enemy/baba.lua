local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Saliva = require "entities.bullet.saliva"
local LSM = require "libs.statemachine.statemachine"
local Acciones =  require "entities.enemy.acciones"

local baba = Class{
    __includes = {Acciones}
}

function baba:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.objetivos={"player","soldier","npc","map_object","bedrock"}
  self.paredes_suelo={"map_object","bedrock"}
  
  
  self.creador = 3
  self.hp = 15
  self.max_hp = self.hp
  self.vel = 100
  self.limite_vision=350
  self.dano_tocar = true
  self.posicion_ataque = false
  self.giro_completo = false
  
  self.spritesheet = img.baba
  
  self.timer = Timer()
  
  --FSM
  
  self.acciones = LSM.create({
   initial = 'mover',
    events ={
      {name = "a_atacar", from = "mover", to = "atacar"},
      {name = "a_mover", from = "atacar", to = "mover"}
    }
  })
  
  Acciones.init(self,posicion[1],posicion[2],82.25, 94.5)
  
  self.lineas_fisica.shape_player = {}
  self.lineas_fisica.shape_player[-1] = love.physics.newEdgeShape(0,0,-self.limite_vision,0)
  self.lineas_fisica.shape_player[1] = love.physics.newEdgeShape(0,0,self.limite_vision,0)
  self.lineas_fisica.fixture_player = {}
  self.lineas_fisica.fixture_player[-1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_player[-1])
  self.lineas_fisica.fixture_player[1] = love.physics.newFixture(self.body2,self.lineas_fisica.shape_player[1])
  self.lineas_fisica.fixture_player[-1]:setSensor( true )
  self.lineas_fisica.fixture_player[1]:setSensor( true )
  
  self:masa(posicion[1],posicion[2],"baba")

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
  
  self.timer:every(0.5,function () 
    if self.acciones.current == "mover" then
      self.iterador = self.iterador +1
      
      if self.iterador>3 then
        self.iterador=1
      end
    elseif self.acciones.current == "atacar" then
      
      self.iterador = self.iterador +1
      
      if self.iterador == 5 and self.obj_presa then
        --lanzar saliva

        Saliva(self.entidad,self.spritesheet,self.ox,self.oy,self.obj_presa.ox,self.obj_presa.oy,self.direccion,self.creador)
      end
      
      if self.iterador>5 then
        self.iterador=4
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
    end
  end)

  self.timer:every(0.05,function() 
    self.posicion_ataque=false
    
    local x1,y1,w1,h1 = self.body2:getWorldPoints(self.lineas_fisica.shape_player[self.direccion]:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1,raycast_funcion_atacar)
    
    self:buscar_posibles_presas()
    
    if self.posicion_ataque and self.acciones.current == "mover" then
      self.acciones:a_atacar()
      self.iterador = 4
      self.posicion_ataque=false
    end
  end)

  self.tipo_enemigo = "baba"
end

function baba:draw()
  self:draw_enemy()
end

function baba:update(dt)
  self:update_enemy(dt)
end


return baba