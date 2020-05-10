local Timer = require "libs.chrono.Timer"
local remove = require "entidades.remove"
local visible = require "entidades.visible"

local npc = Class{
  __includes = {remove,visible}
}

function npc:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture

  self.entidad = entidad

  self.shapeTableClear = shapeTableClear
  self.properties = properties

  self.radio = radio

  self.tag = properties.tag
  self.hp = properties.hp
  self.maxHp = self.hp

  self.spritesheet = Index_img[properties.img]

  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad
  self.dimension = self.spritesheet.viewport

  self.iterador = 1
  self.iteradorEstado = 1

  entidad:add(properties.tabla,self)

  self.timer = Timer()

  remove.init(self,entidad,properties.tabla)

  self.width,self.height = width,height

  self.ox,self.oy = ox,oy

  self.Es_salvable = properties.Es_salvable

  self.vec4Shader = {properties.h or 0,properties.s or 0,0,0}

  self.shaderPlayer = love.graphics.newShader(Shader_index.shader_player)
  self.shaderPlayer:send("color_player",self.vec4Shader)

  self.acciones = {invulnerable =false}

  self.cooldownIterador = true

  visible.init(self)

  self.fixture:setGroupIndex(grupos.npcs)
end

function npc:draw()
  local dimension = self.dimension[1][1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h 

  love.graphics.setShader(self.shaderPlayer)
    love.graphics.draw(self.img,self.quad[self.iteradorEstado][self.iterador],self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)
  love.graphics.setShader()

  love.graphics.print(self.hp,self.ox,self.oy-100)
end

function npc:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()

  self.timer:update(dt)

  self:checkVida()

end

function npc:cambiarEstado(tipo)
  local hp = self.maxHp/2


  if self.hp<=hp and self.cooldownIterador then

    if tipo == "semizombie" then
      self.iteradorEstado = 4
    elseif tipo == "agujereado" then
      print("a",self.hp)
      self.iteradorEstado = 2
    elseif tipo == "canon" then
      self.iteradorEstado = 3
    end

    self.cooldownIterador = false

  elseif self.hp>hp and not self.cooldownIterador then

    self.iteradorEstado = 1
    self.cooldownIterador = true
  end
end

return npc