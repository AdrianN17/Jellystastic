local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local LSM = require "libs.statemachine.statemachine"
local Piernas = require "entities.object.piernas"

local jelly_npc = Class {}

function jelly_npc:init(entidad,posicion,img,radio,tipo,propiedad)
  self.entidad = entidad
  self.iterador=1
  self.iterador2 = 1
  
  self.hp = 8
  self.max_hp = self.hp
  self.limite_vision = 100
  
  self.w,self.h = 54.75, 84
  self.direccion = 1
  
  self.spritesheet = img.personajes[1]
  self.spritesheet_arma = img.armas
  
  --fisica
  
  self.body = love.physics.newBody(self.entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,54.75, 84)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  
  self.body2 = love.physics.newBody(self.entidad.world,posicion[1],posicion[2],"dynamic")
  self.lineas_fisica = {}
  
  self.joint = love.physics.newRevoluteJoint(self.body,self.body2,posicion[1],posicion[2],false)
  
  self:masa(posicion[1],posicion[2])
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.entidad:add_obj("npc",self)
  
  self.cooldown_iterador=true
  
  self.iterador_hablar=1
  
  --timer
  
  self.timer = Timer()
  
  self.timer_busqueda = self.timer:every(2,function () 
    if self.iterador_hablar < 2 then
      self.iterador_hablar = self.iterador_hablar + 1
    else
      self.iterador_hablar = 1
    end
  end)
  
  
  self.acciones = {invulnerable =false}
  
  
  self.lista_frases={propiedad.frase,propiedad.frase2,propiedad.ayuda}
  
  --shaders
  
  self.shader_npc = love.graphics.newShader(shader_index.shader_player)
  self.vec4_shader =  {propiedad.r,propiedad.g,propiedad.b,propiedad.a}
  
  self.shader_npc:send("color_player",self.vec4_shader)

end

function jelly_npc:draw()
  local quad = self.spritesheet.quad[self.iterador][self.iterador2]
  local scale = self.spritesheet.scale
  local _, _ ,w,h = quad:getViewport()
  
  love.graphics.setShader(self.shader_npc)
    love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x*self.direccion,scale.y,w/2,h/2)
  love.graphics.setShader()
  
  if self.iterador_hablar>0 or self.iterador>1 then
    love.graphics.print(self.lista_frases[self.iterador_hablar],self.ox,self.oy-100)
  end
end

function jelly_npc:update(dt)
  self.timer:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  if self.hp < 0.1 and self.iterador== 4 then
    self.entidad:crear_zombie(self.ox,self.oy)
  end
  
  if self.hp < 0.1 or self.oy > self.entidad.caida_y then
    self:remove()
  end
  
end

function jelly_npc:remove()
  if not self.body:isDestroyed() then
    self.entidad:eliminar_presa(self)
    self:crear_sprite_muerto()
    self.timer:destroy()
    self.body2:destroy()
    self.body:destroy()
    self.entidad:remove_obj("npc",self)
  end
end

function jelly_npc:save_remove()
  if not self.body:isDestroyed() then
    self.entidad.contador_salvados = self.entidad.contador_salvados +1
    self.entidad:eliminar_presa(self)
    self.timer:destroy()
    self.body2:destroy()
    self.body:destroy()
    self.entidad:remove_obj("npc",self)
  end
end

function jelly_npc:cambiar_estado(tipo)
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
    self.iterador_hablar=3
    
    self.timer:cancel(self.timer_busqueda)
    
  end
end

function jelly_npc:masa(x,y)
  self.joint = love.physics.newRevoluteJoint(self.body,self.body2,x,y,false)
  
  self.fixture:setFriction(0.5)
  self.fixture:setDensity(1)
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)
  
  self.body:setMass(50)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fixture:setUserData( {data="npc",obj=self, pos=orden.npc} )
end

function jelly_npc:crear_sprite_muerto()
  local iterador2 = 1
    
  if self.iterador == 4 then
    iterador2 = 2
  end
  
  local scale = self.spritesheet.scale
  
  local _,_,wi,hi = self.spritesheet.quad[6][iterador2]:getViewport()

  local spritesheet = self.spritesheet
  local quad = self.spritesheet.quad[6][iterador2]

  local data = {spritesheet = spritesheet, quad = quad,scale=scale,ox=self.ox,oy = ((self.oy + self.h/2) - (hi*scale.y)/2),w = self.h,h = self.h,wi = wi, hi = hi,shader = self.shader_npc }
  
  Piernas(self.entidad,data)
end

return jelly_npc