local Class = require "libs.hump.class"
local weapon = Class{}

function weapon:init(entidad,posicion,img,_,tipo,propiedades)
  self.entidad =entidad
  
  self.tipo_arma = tonumber(tipo)

  self.spritesheet = img
  self.img = img.armas.img
  self.quad = img.armas.quad[self.tipo_arma]
  self.scale = img.armas.scale[self.tipo_arma]
  
  local x,y,w,h = self.quad:getViewport()
  self.w,self.h=w*self.scale.x,h*self.scale.y
  
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"static")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  
  self.entidad:add_obj("object",self)
  
  self.ox,self.oy= self.body:getX(), self.body:getY()
  
  self.fixture:setUserData( {data="object",obj=self, pos=orden.arma} )
  
end

function weapon:draw()
  local x,y,w,h = self.quad:getViewport()
  
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,0,self.scale.x,self.scale.y,w/2,h/2)
end

function weapon:update(dt)
  
end

function weapon:usar(obj)
  local balas = obj.armas_values[self.tipo_arma]
  
  obj.armas_values[self.tipo_arma].enable = true
  obj.armas_values[self.tipo_arma].stock = balas.max_stock
  
  self:remove()
end

function weapon:remove()
  self.body:destroy()
  self.entidad:remove_obj("object",self)
end

return weapon