local Class = require "libs.hump.class"

local jelly_boy = Class{
    __includes = {}
}

function jelly_boy:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("player",self)
  self.ox,self.oy = posicion[1],posicion[2]
  self.radio = 0
  
  self.movimiento = {a=false,d=false}
  self.ground = false
  
  self.hp = 10
  self.vel = 100
  self.jump = 50
  
  
  self.arma_index = 0
  
  self.spritesheet = img.personajes[1]
  
  
  
end

function jelly_boy:draw()
  
  local quad = self.spritesheet.quad[1][1]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
    
    love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

function jelly_boy:update(dt)
  self.entidad.cam:setPosition(self.ox, self.oy)
end

function jelly_boy:keypressed(key)
  if key == "a" then
    self.movimiento.a = true
  elseif key == "d" then
    self.movimiento.d = true
  end
  
  if key == "w" and self.ground then
    
  end
end

function jelly_boy:keyreleased(key)
  if key == "a" then
    self.movimiento.a = false
  elseif key == "d" then
    self.movimiento.d = false
  end
  
end

return jelly_boy


