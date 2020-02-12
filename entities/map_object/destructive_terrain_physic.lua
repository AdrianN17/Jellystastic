local Class = require "libs.hump.class"

local Destructive = require "entities.map_object.destructive"

local destructive_terrain_physic = Class{
    __includes = {Destructive}
}

function destructive_terrain_physic:init(poligono)
  Destructive.init(self)
  self.poligonos_tabla={}
  
  
  --self.body = love.physics.newBody(self.entidad.world,0,0,"kinematic")
  self.poligono_main_index=1
  self:crear_poligonos_fisica(poligono)
  
end

function destructive_terrain_physic:update_obj(dt)
  
end

return destructive_terrain_physic