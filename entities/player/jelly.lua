local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local Bala = require "entities.bullet.bala"
local Acciones =  require "entities.player.acciones"

local jelly = Class{
  __includes = {Bala,Acciones}
}

function jelly:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("player",self)
  
  self.creador = 1
  
  self.hp = 25
  self.max_hp = self.hp
  self.vel = 175
  self.jump = 30
  
  
  self.spritesheet = img.personajes[1]
  self.spritesheet_arma = img.armas
  
  Acciones.init(self,posicion[1],posicion[2],54.75, 84)
  
  self:masa(posicion[1],posicion[2])
  
  Bala.init(self,{"player","baba","soldier"})
  
  
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
  
      if tipo_obj and (tipo_obj.data=="map_object" or tipo_obj.data == "liquido") then
        self.ground = true
        self.acciones.saltando=false
      end
  
      return -1
  end

  self.timer:every(0.1, function()
    self.ground = false
    
    local x1,y1,w1,h1 = self.body2:getWorldPoints(self.lineas_fisica.shape_suelo1:getPoints())
    self.entidad.world:rayCast(x1,y1,w1,h1, raycast_funcion)
    
    local x2,y2,w2,h2 = self.body2:getWorldPoints(self.lineas_fisica.shape_suelo2:getPoints())
    self.entidad.world:rayCast(x2,y2,w2,h2, raycast_funcion)
  end)

  self.shader_player = love.graphics.newShader(shader_index.shader_player)
  self.vec4_shader = {0.3,0,0,0}
  
  self.shader_player:send("color_player",self.vec4_shader)
  
  self.spritesheet_accesorio = img.accesorios
  self.id_accesorio = 2
  
  
  self.arma_index = 1
  self.armas_values[1].enable = true
  self.armas_values[1].stock = self.armas_values[self.arma_index].max_stock
  self.armas_values[1].municion = self.armas_values[self.arma_index].max_stock
end

function jelly:draw()
  self:draw_player()
end

function jelly:update(dt)
  self:check_door()
  self:update_player(dt)
  
  
  self.entidad.cam:setPosition(self.ox, self.oy)
end

function jelly:check_door()
  local contacts = self.body:getContacts()
  
  self.hay_puerta = false
  self.data_puerta = nil
  
  for _,contact in ipairs(contacts) do
    local a,b = contact:getFixtures()
    local obj1, obj2 = self.entidad:validar_pos(a,b)
    
    if obj1 and obj2 then
      if obj1.data == "player" and obj2.data == "door" then
        self.hay_puerta = true
        self.data_puerta = obj2.obj.data_puerta
      end
    end
  end
end



return jelly

