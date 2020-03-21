local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Saliva = require "entities.bullet.saliva"
local LSM = require "libs.statemachine.statemachine"
local Acciones =  require "entities.enemy.acciones"
local Piernas = require "entities.object.piernas"

local zombie = Class{
    __includes = {Acciones}
}

function zombie:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.objetivos={"player","soldier","npc","map_object","bedrock","movible","bajada"}
  self.paredes_suelo={"map_object","bedrock","movible","bajada"}
  
  
  self.creador = 3
  self.hp = 20
  self.max_hp = self.hp
  self.vel = 125
  self.limite_vision=100
  self.dano_tocar = true
  self.posicion_ataque = false
  self.giro_completo = false
  self.multi_ataque = true
  
  self.spritesheet = img.personajes[1]
  
  self.timer = Timer()
  
  
  --FSM
  
  self.acciones = LSM.create({
   initial = 'mover',
    events ={
      {name = "a_atacar", from = "mover", to = "seguir"},
      {name = "a_mover", from = "seguir", to = "mover"}
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
      if not fixture:isSensor( ) then
        local tipo_obj=fixture:getUserData()
        
        if tipo_obj then
          table.insert(self.vision_objetivos,{x=x,y=y,name = tipo_obj.data, obj = tipo_obj.obj})
        end
      end

    return 1
  end

  --Timer
  
  self.timer:every(0.15,function () 
    
      self.iterador2 = self.iterador2 +1
      
      if self.iterador2>3 then
        self.iterador2=1
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
      self.posicion_ataque=false
    end
  end)

  self.iterador = 5

  --local dir = {-1,1}
  --self.direccion = dir[math.random(1,2)]
end

function zombie:draw()
  self:draw_enemy3()
  love.graphics.print(tostring(self.obj_presa),self.ox,self.oy-200)
end

function zombie:update(dt)
  self:update_enemy(dt)
end

function zombie:crear_sprite_muerto()
  local iterador2 = 3
  
  local scale = self.spritesheet.scale
  
  local _,_,wi,hi = self.spritesheet.quad[6][iterador2]:getViewport()
  
  local spritesheet = self.spritesheet
  local quad = self.spritesheet.quad[6][iterador2]

  local data = {spritesheet = spritesheet, quad = quad,scale=scale,ox=self.ox,oy = ((self.oy + self.h/2) - (hi*scale.y)/2),w = self.h,h = self.h,wi = wi, hi = hi }
  
  Piernas(self.entidad,data)
end

return zombie