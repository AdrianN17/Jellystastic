local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"

local slime = Class{
    __includes = {}
}

function slime:init(entidad,posicion,img)
  self.entidad = entidad
  
  self.entidad:add_obj("enemy",self)
  
  self.radio = 0
  
  self.hp = 10
  self.vel = 100
  
  self.iterador=1
  
  self.spritesheet = img.baba
  
  self.iterador=1
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,posicion[1],posicion[2],"dynamic")
  self.shape = love.physics.newRectangleShape(0,0,82.25, 94.5)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setFriction(0.1)
  self.fixture:setDensity(0)
	self.body:setInertia( 0 )
  self.body:setLinearDamping( 1 )
  

  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.fixture:setUserData( {data="enemy",obj=self, pos=2} )
  
  
end

function slime:draw()
  local quad = self.spritesheet.quad[self.iterador]
  local scale = self.spritesheet.scale
  local x,y,w,h = quad:getViewport()
  
    
  love.graphics.draw(self.spritesheet["img"],quad,self.ox,self.oy,self.radio,scale.x,scale.y,w/2,h/2)
end

function slime:update()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

return slime