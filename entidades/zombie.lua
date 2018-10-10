local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local Espina = require "entidades.espina"
local zombie = Class{
	__includes = entidad
}

function zombie:init(x,y,w,h,change)
	self.body=HC.rectangle(x,y,w,h)
	self.l=change
	self.hp=6
	self.vx,self.vy=300,0
	self.g=-450
	self.ox,self.oy=self.body:center()
	self.damage=3
	self.ground=false
	self.time=0
	self.time2=0
	self.timea=0
	self.defense=1.5

	self.immunity=false
	self.vym=300
	self.isjump=true
end

function zombie:draw()
	love.graphics.print(self.hp,self.ox,self.oy-100,0,2,2)
	love.graphics.draw(sprites["img3"],sprites["zombie"],self.ox,self.oy,0,1,1,31,37)
end

function zombie:update(dt)
	local x,y=0,0
	local d=1

	if not self.ground  then
		if self.vy > 30 then
			self.g=-1300
		end
		self.vy=self.vy-self.g*dt
		y=y+self.vy*dt
	end

	x=self.vx*dt

	if self.move then
		d=1

		self.timea=self.timea+dt
		if self.timea>2 and math.abs(base.entidades.player.oy-self.oy)<60 and math.abs(base.entidades.player.ox-self.ox)<1300 then

			self.timea=0
			base.entidades:addextra(Espina(self.ox,self.oy,12,5,base.entidades.player.ox,base.entidades.player.oy+10,500,self.l,1),"bullete")
			base.entidades:addextra(Espina(self.ox,self.oy,12,5,base.entidades.player.ox,base.entidades.player.oy-10,500,self.l,1),"bullete")
		end

		
		if self.istouch then
			self.time=self.time+dt
			if self.time>0.2 then
				self.time=0
				self.istouch=false
			end
		end

	elseif not self.move then
		d=-1
		if self.isjump then
			y=y-0.5
			self.ground=false
			self.vy=-300
			self.isjump=false
		end

	end

	if self.vy>self.vym then
		self.vy=self.vym
	end

	self.body:move(x*d,y)
	self.ox,self.oy=self.body:center()

	self.ground=false

	if self.immunity then
		self.time2=self.time2+dt
		if self.time2>0.5 then
			self.immunity=false
			self.time2=0
		end
	end

	if self.hp<1 or self.oy>7040 then
		HC.remove(self.body)
		base.entidades:removeextra(self,"enemies")
	end
end


return zombie