local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local Espina = require "entidades.espina"
local baba_1 = Class{
	__includes = entidad
}

function baba_1:init(x,y,w,h,change,hp)
	self.body=HC.rectangle(x,y,w,h)
	self.l=change
	self.vx,self.vy=150,0
	self.g=-500
	self.hp=hp
	self.ox,self.oy=self.body:center()
	self.damage=2

	self.ground=false

	self.time=0
	self.time2=0

	self.istouch=false

	self.move=true

	self.immunity=false

	self.vym=300

	self.isjump=true

	self.timea=0
	self.defense=1

	self.d=1
end

function baba_1:draw()
	--self.body:draw("fill")

	--love.graphics.print("jump" .. tostring(self.isjump) , self.ox,self.oy-160,0,2,2)
	love.graphics.print(math.max(self.hp,0),self.ox,self.oy-100,0,2,2)
	love.graphics.draw(sprites["img3"],sprites["babas1"],self.ox,self.oy,0,1,1,40,25)
end

function baba_1:update(dt)
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
		if self.timea>2.5 and math.abs(base.entidades.player.oy-self.oy)<60 and math.abs(base.entidades.player.ox-self.ox)<1300 then

			self.timea=0
			base.entidades:addextra(Espina(self.ox,self.oy,12,5,base.entidades.player.ox,base.entidades.player.oy,400,self.l,1),"bullete")
		end
		
		if self.istouch then
			self.time=self.time+dt
			if self.time>1 then
				self.time=0
				self.istouch=false
			end
		end

	elseif not self.move then
		d=self.d
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

return baba_1
