local Class = require "libs.hump.class"

local movible = Class {}

function movible:init(entidad,posicion,img,radio,tipo,propiedad)
  self.entidad = entidad
  
  self.img = img.movible[1]
  
  self.w,self.h = posicion[3],posicion[4]
  
  self.wi,self.hi =  self.img:getDimensions()
  
  self.entidad:add_obj("movible",self)
  
  
  self.scale_x = self.w/self.wi
  self.scale_y = self.h/self.hi
  
  self.body = love.physics.newBody(entidad.world,posicion[1]+posicion[3]/2,posicion[2]+posicion[4]/2,"dynamic")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setUserData( {data="movible",obj=self, pos=orden.terrain} )

  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
  
  --self.joint = love.physics.newMouseJoint(self.body, self.ox,self.oy)
end

function movible:update(dt)
  --self.joint:setTarget(self.entidad:get_mouse_pos())
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
end

function movible:draw()
  
  love.graphics.draw(self.img,self.ox,self.oy,self.radio,self.scale_x,self.scale_y,self.wi/2,self.hi/2)
  
end

return movible