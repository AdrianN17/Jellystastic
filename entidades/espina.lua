local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"

local espina = Class{
	__includes = entidad
}

function espina:init(x,y,w,h,px,py,speed,change,damage)
	self.body=HC.rectangle(x,y,w,h)
	self.speed=speed
	self.l=change
	self.ox,self.oy=self.body:center()
	self.angle=math.atan2(py-self.oy,px-self.ox)
	self.hp=1
	self.damage=damage
	self.lx,self.ly,self.lh,self.lw=base.entidades:pos()
end

function espina:draw()
	love.graphics.draw(sprites["img3"],sprites["espina"],self.ox,self.oy,angle,1,1,6,2.5)
end

function espina:update(dt)
	self.lx,self.ly,self.lh,self.lw=base.entidades:pos()

	local x,y=self.speed*dt*math.cos(self.angle),self.speed*dt*math.sin(self.angle)
	self.body:move(x,y)
	self.ox,self.oy=self.body:center()
	if self.hp<1 or not (self.ox>self.lx and self.ox<self.lx+self.lh and self.oy>self.ly and self.oy<self.ly+self.lw) then
		--print("a")
		HC.remove(self.body)
		base.entidades:removeextra(self,"bullete")
	end
end

return espina