-- Represents a single drawable object
local Class = require 'libs.class'

local entidad = Class{}

function entidad:init(x,y)
	-- Do nothing by default, but we still have to have something to call
end

function entidad:draw()
  -- Do nothing by default, but we still have to have something to call
end

function entidad:update(dt)

  -- Do nothing by default, but we still have to have something to call 
end

function entidad:keypressed(key,isrepeat)
  -- Do nothing by default, but we still have to have something to call
end

function entidad:keyreleased(key)
  -- Do nothing by default, but we still have to have something to call
end

function entidad:mousepressed(x, y, button)
  -- Do nothing by default, but we still have to have something to call
end

function entidad:mousereleased(x, y, button)
  -- Do nothing by default, but we still have to have something to call
end

return entidad