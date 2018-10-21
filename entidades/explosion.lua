local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local explosion = Class{
	__includes = entidad
}

function explosion:init(x,y,change)
	self.body=HC.circle(x,y,75)
	self.l=change
	self.time=0
	self.damage=10
end

function explosion:update(dt)
	self.time=self.time+dt
	if self.time>0.1 then 
		HC.remove(self.body)
		base.entidades:removeextra(self,"explosion")
	end
end

function explosion:draw()
	self.body:draw("fill")
end

return explosion