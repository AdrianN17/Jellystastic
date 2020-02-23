local Class = require "libs.hump.class"
local health = Class{}

function health:init(entidad,posicion,img,_,tipo,propiedades)
  self.entidad =entidad
  
  self.tipo_vida = tonumber(tipo)
  
  self.spritesheet = img
  self.img = img.vidas.img
  self.quad = img.vidas.quad[self.tipo_vida]
  self.scale = img.vidas.scale
  
  
  
  local x,y,w,h = self.quad:getViewport()
  self.w,self.h=w*self.scale.x,h*self.scale.y
  
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"static")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  
  self.entidad:add_obj("object",self)
  
  self.ox,self.oy= self.body:getX(), self.body:getY()
  
  self.fixture:setUserData( {data="object",obj=self, pos=orden.vida} )
  
  
  self.cantidad = propiedades.stock

end

function health:draw()
  local x,y,w,h = self.quad:getViewport()
  
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,0,self.scale.x,self.scale.y,w/2,h/2)
end

function health:update(dt)
  
end

function health:usar(obj)
  if self.tipo_vida == 1 then
    self:subir_vida(obj)
  elseif self.tipo_vida == 2 then
    self:extender_vida(obj)
  end
end

function health:subir_vida(obj)
  
  if obj.hp == obj.max_hp then
    
  else
    obj.hp = obj.hp + obj.max_hp * 0.15
    obj.hp = math.min(obj.hp,obj.max_hp)
    obj.hp = math.floor(obj.hp)
    
    self:remove()
  end
end

function health:extender_vida(obj)
  obj.max_hp = obj.max_hp + obj.max_hp * 0.2
  obj.hp = obj.max_hp
  
  self:remove()
end

function health:remove()
  self.body:destroy()
  self.entidad:remove_obj("object",self)
end

return health