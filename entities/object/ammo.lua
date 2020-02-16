local Class = require "libs.hump.class"
local ammo = Class{}

function ammo:init(entidad,posicion,img,_,tipo,propiedades)
  self.entidad =entidad
  
  self.spritesheet = img
  self.img = img.armas.img
  self.quad = img.municion.quad
  self.scale = img.municion.scale
  
  
  
  local x,y,w,h = self.quad:getViewport()
  self.w,self.h=w*self.scale.x,h*self.scale.y
  
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"static")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  
  self.entidad:add_obj("object",self)
  
  self.ox,self.oy= self.body:getX(), self.body:getY()
  
  self.fixture:setUserData( {data="object",obj=self, pos=orden.municion} )
  
  self.tipo_bala = tonumber(tipo)
  self.cantidad = propiedades.stock

end

function ammo:draw()
  local x,y,w,h = self.quad:getViewport()
  
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,0,self.scale.x,self.scale.y,w/2,h/2)
end

function ammo:update(dt)
  
end

function ammo:usar(obj)
  self:recargar(obj.armas_values[self.tipo_bala])
end

function ammo:recargar(armas)
  if armas.enable then

    if armas.municion + self.cantidad < armas.max_municion then
      armas.municion = armas.municion + self.cantidad
      self.cantidad = 0
      self:remove()
    else
      local muni = armas.max_municion - armas.municion
      armas.municion = armas.municion + muni
      self.cantidad = self.cantidad - muni
    end
    
  end
end

function ammo:remove()

    self.body:destroy()

    self.entidad:remove_obj("object",self)
end

return ammo