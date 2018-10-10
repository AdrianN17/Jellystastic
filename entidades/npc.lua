local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local npc = Class{
	__includes = entidad
}

function npc:init(x,y,w,h,change)
	self.body=HC.rectangle(x,y,w,h)
	self.ox,self.oy=self.body:center()
	self.g=-500
	self.l=change
	self.hp=2
	self.vx,self.vy=0,0
	self.ground=false
end

function npc:draw()
	love.graphics.draw(sprites["img4"],sprites["npc"],self.ox,self.oy,0,1,1,31,37)
end

function npc:update(dt)
	--[[local x,y=0,0

	if not self.ground  then
		self.vy=self.vy-self.g*dt
		y=y+self.vy*dt
	end

	self.body:move(x,y)
	self.ox,self.oy=self.body:center()]]
	
	if self.hp<1 or self.oy>7040 then
		HC.remove(self.body)
		base.entidades:removeextra(self,"npcs")
	end

	--self.ground=false
end

function npc:save()
	HC.remove(self.body)
	base.entidades:removeextra(self,"npcs")
	return 1
end

return npc