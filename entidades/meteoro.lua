local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"

local meteoro = Class{
	__includes = entidad
}

function meteoro:init(x,y,r,angle,speed,change)
	self.body=HC.circle(x,y,r)
	--self.r=r
	--self.body=HC.point(x,y)
	self.ox,self.oy=self.body:center()
	self.angle=math.rad(angle)
	self.speed=speed
	self.hp=3
	self.l=change
end

function meteoro:draw()
	--love.graphics.setColor(1, 0, 0)
	--love.graphics.circle("fill",self.ox,self.oy,self.r)
	--self.body:draw("fill")
	--love.graphics.setColor(1, 1, 1)
	love.graphics.draw(sprites["img2"],sprites["meteoro"],self.ox,self.oy,0,1,1,30,30)

end

function meteoro:update(dt)
	local x,y=math.sin(self.angle)*dt*self.speed,math.cos(self.angle)*dt*self.speed
	self.body:move(x,y)
	self.ox,self.oy=self.body:center()

	if self.hp<1 or self.oy>7340 then
		HC.remove(self.body)
		base.entidades:removeextra(self,"meteor")
	end
end

return meteoro