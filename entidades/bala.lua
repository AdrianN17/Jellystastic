local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"

local bala = Class{
	__includes = entidad
}

function bala:init(x,y,angle,speed,change,damage)
	self.body=HC.circle(x,y,5)
	self.ox,self.oy=self.body:center()
	self.angle=angle
	self.speed=speed
	self.time=0
	self.l=change
	self.hp=1
	self.time=0
	self.damage=damage
	self.type="good"
end

function bala:draw()
	--love.graphics.setColor(0, 0, 1)
	--self.body:draw("fill")
	--love.graphics.setColor(1, 1, 1)
	love.graphics.draw(sprites["img"],sprites["bala"],self.ox,self.oy,0,1,1,5,5)
	--love.graphics.circle("fill",self.ox,self.oy,10)
end

function bala:update(dt)
	self.time=self.time+dt
	local x,y=self.speed*dt*math.cos(self.angle),self.speed*dt*math.sin(self.angle)
	self.body:move(x,y)
	self.ox,self.oy=self.body:center()

	if self.time>3 or self.hp<1 then 
		HC.remove(self.body)
		base.entidades:removeextra(self,"bullet")
	end
end


return bala