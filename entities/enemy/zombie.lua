local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Saliva = require "entities.bullet.saliva"
local LSM = require "libs.statemachine.statemachine"
local Acciones =  require "entities.enemy.acciones"

local zombie = Class{
    __includes = {Acciones}
}

function zombie:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.objetivos={"player","soldier","npc"}
  self.paredes_suelo={"map_object","bedrock"}
  
  
  self.creador = -2
  self.hp = 20
  self.max_hp = self.hp
  self.vel = 150
  self.limite_vision=450
  self.dano_tocar = true
  self.posicion_ataque = false
  self.giro_completo = false
  
  self.spritesheet = img.personajes[1]
  
  self.timer = Timer()
  
  
  --FSM
  
  self.acciones = LSM.create({
   initial = 'mover',
    events ={
      {name = "a_atacar", from = "mover", to = "atacar"},
      {name = "a_mover", from = "atacar", to = "mover"}
    }
  })
  
  Acciones.init(self,posicion[1],posicion[2],54.75, 84)
  
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
      local tipo_obj=fixture:getUserData()
      
      for _,objetivo in ipairs(self.objetivos) do
        if tipo_obj and tipo_obj.data==objetivo then
          self.posicion_ataque=true
          
          --if self.obj_presa == nil then
            self.obj_presa = fixture:getUserData().obj
          --end
          
        end
      end

    return 1
  end

  --Timer
  
  self.timer:every(0.25,function () 
    if self.acciones.current == "mover" then
      self.iterador2 = self.iterador2 +1
      
      if self.iterador2>3 then
        self.iterador2=1
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

  self.iterador = 5

  local dir = {-1,1}
  self.direccion = dir[math.random(1,2)]
end

function zombie:draw()
  self:draw_enemy3()
end

function zombie:update(dt)
  self:update_enemy(dt)
end


return zombie