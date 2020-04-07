local Timer = require "libs.chrono.Timer"
local remove = require "entidades.remove"

local npc = Class{
  __includes = {remove}
}

function npc:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.shapeTableClear = shapeTableClear
  self.properties = properties
  
  self.entidad = entidad
  
  self.radio = radio
  
  self.grupo = properties.grupo
  self.hp = properties.hp
  self.maxHp = self.hp
  
  self.spritesheet = Index_img[properties.img]
  
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad
  self.dimension = self.spritesheet.viewport
  
  self.iterador = 1
  self.iteradorEstado = 1
  
  entidad:add(properties.tabla,self)
  
  remove.init(self,entidad,properties.tabla)
  
  self.width,self.height = width,height
  
  self.ox,self.oy = ox,oy
  
  self.Es_salvable = properties.Es_salvable
  
  self.vec4Shader = {properties.h or 0,properties.s or 0,0,0}
  
  self.shaderPlayer = love.graphics.newShader(Shader_index.shader_player)
  self.shaderPlayer:send("color_player",self.vec4Shader)
  
end

function npc:draw()
  local dimension = self.dimension[1][1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h 
  
  love.graphics.setShader(self.shaderPlayer)
    love.graphics.draw(self.img,self.quad[self.iteradorEstado][self.iterador],self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)
  love.graphics.setShader()
end

function npc:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
end

return npc