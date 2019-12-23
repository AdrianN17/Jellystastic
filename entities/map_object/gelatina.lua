local Class = require "libs.hump.class"
local destructive_terrain = require "entities.map_object.destructive_terrain"
local gelatina = Class{
    __includes = {destructive_terrain}
}

function gelatina:init(entidad,poligono,img)
  self.entidad = entidad
  
  self.entidad:add_obj("map_object",self)
  
  destructive_terrain.init(self,poligono,img.texturas.gelatina)
  
  --fisicas
  
  self.body = love.physics.newBody(entidad.world,0,0,"kinematic")
  self.shape = love.physics.newChainShape(true,poligono)
  self.fixture = love.physics.newFixture(self.body,self.shape)
end

function gelatina:draw()
  self:draw_obj()
end

function gelatina:update(dt)
  self:update_obj(dt)
end

return gelatina