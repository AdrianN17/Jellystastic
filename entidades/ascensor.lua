local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local ascensor = Class{
	__includes = Entity
}


function ascensor:init(x,y,w,h,change)
	self.body=HC.rectangle(x,y,w,h)
	self.type="ascensor"
	self.l=change
	self.vy=-1
end

function ascensor:draw()
	self.body:draw("fill")
end

function ascensor:update(dt)
	self.body:move(0,self.vy)
end

return ascensor

--collision con dt y meteoros con timer