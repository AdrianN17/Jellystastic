local Class = require "libs.hump.class"
local Timer = require "libs.chrono.Timer"
local LSM = require "libs.statemachine.statemachine"

local jelly_npc = Class {}

function jelly_npc:init(entidad,posicion,img)
  self.entidad = entidad
end

function jelly_npc:draw()
  
end

function jelly_npc:update(dt)
  
end

return jelly_npc