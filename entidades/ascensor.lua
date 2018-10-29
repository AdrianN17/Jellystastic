local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local ascensor = Class{
	__includes = Entity
}


function ascensor:init(x,y,w,h,change,type)
	self.body=HC.rectangle(x,y,w,h)
	self.type="ascensor"
	self.l=change
	self.vy=-2
	self.vx=-2
	self.ox,self.oy=self.body:center()

	if type==false then
		self.vx=0
	elseif type==true then
		self.vy=0
	end
end

function ascensor:draw()
	self.body:draw("fill")
end

function ascensor:update(dt)
	self.ox,self.oy=self.body:center()
	self.body:move(self.vx,self.vy)
end

return ascensor

--collision con dt y meteoros con timer