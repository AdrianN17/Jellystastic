local Class = require "libs.class"
local base = require "gamestate.base"
local entidad = require "entidades.entidad"
local HC = require "libs.HC"
local Bala = require "entidades.bala"
local player = Class{
	__includes = entidad
}

function player:init(x,y,w,h,change,hp)
	self.x,self.y=x,y
	self.body= HC.rectangle(x,y,w,h)
	self.ox,self.oy=self.body:center()
	self.g=-500
	self.vx,self.vy=0,0
	self.ground=true
	self.vym=300
	self.ac=0

	self.isjump=false
	self.escalar=false
	self.ignore=false
	self.isplatformer=false
	self.ignore2=false
	self.isascensor=false
	self.ignore3=false
	self.ischange=false

	self.rx,self.ry=-1,-1

	self.l=change

	self.attack=false

	self.melee=HC.rectangle(self.ox,self.oy,80,10)
	self.mr=0

	self.isright=true

	self.mx,self.my=self.melee:center()

	self.immunity=false

	self.hp=hp
	self.maxhp=hp
	self.time=0

	self.friend=0

	self.dead=false

	self.moveright=false
	self.moveleft=false

	--manejo de balas
	self.narma={"Pistola","Revolver","Escopeta","Ametralladora","Launcher"}
	self.municion={0,0,0,0,0}
	self.stock={0,0,0,0,0}
	self.maxstock={10,5,5,45,1}
	self.maxmuni={50,40,25,90,5}

	self.arma={false,false,false,false,false}
	self.armaa=0

	self.point=HC.point(self.ox+30,self.oy+30,10)
	self.angle=0
	self.ax,self.ay=0,0

	self.mdamage=3

	self.h={"pheart","gheart"}
	self.hi=1

	self.fin=false
end

function player:draw()
	--love.graphics.setColor(0.5, 0.5, 0.5)
	--self.body:draw("fill")
	--love.graphics.setColor(0, 0, 1)
	--love.graphics.setColor(1, 1, 1)
	--self.melee:draw("fill")

	if not self.dead then

		love.graphics.draw(sprites["img"],sprites["player"],self.ox,self.oy,0,1,1,31,37)

		if self.attack and self.armaa==0 then
			love.graphics.draw(sprites["img"],sprites["espada"],self.mx,self.my,self.mr-math.pi,1,1,40,5)--,-70,-10)
		end

		--self.point:draw("fill")
	end


end

function player:update(dt)
	local x,y=0,0

	if self.moveleft and not self.dead then
		self.vx=-500
	elseif self.moveright and not self.dead then
		self.vx=500
	else
		self.vx=0
	end


	if self.up and not self.ground then
		x,y=x+0,y+-4
	end

	if self.down and not self.ground then
		x,y=x+0,y+4
	end

	if not self.ground and not self.isjump and not self.escalar and not self.subida and not self.dead then
		if self.vy > 50 then
			self.g=-2000
		end
		self.vy=self.vy-self.g*dt
		y=y+self.vy*dt
	end


	if self.isjump then
		y=y-0.5
		self.ground=false
		self.vy=-400
		self.isjump=false
	end

	if self.vy>self.vym then
		self.vy=self.vym
	end


	x=x+self.vx*dt


	self.body:move(x,y)

	self.ox,self.oy=self.body:center()



	self.mr=self.mr+dt
	
	self.melee:move(x,y)

	self.mx,self.my=self.melee:center()

	if self.attack then
		if self.isright then
			if  self.mr<math.rad(55) then
				self.mr=self.mr+dt*4
			else
				self.mr=math.rad(-90)
			end
		end

		if not self.isright then
			if self.mr>math.rad(-215) then
				self.mr=self.mr-dt*5
			else
				self.mr=math.rad(-90)
			end
		end
	end

	if self.isright and not self.attack then
		self.mr=math.rad(-90)
	elseif not self.isright and not self.attack then	
		self.mr=math.rad(-90)
	end

	
	self.melee:setRotation(self.mr,self.ox,self.oy)

	self.ischange=false
	self.ground=false
	self.subida=false
	self.escalar=false
	self.isplatformer=false
	self.isascensor=false
	self.g=-500

	if self.immunity then
		self.time=self.time+dt
		if self.time>1 then
			self.immunity=false
			self.time=0
		end
	end
	
	self.point:move(x,y)

	self.angle=math.atan2(self.ay-self.oy,self.ax-self.ox)
	self.point:setRotation(math.rad(-45)+self.angle,self.ox,self.oy)

	if self.hp<1 or self.oy>7240 then
		--error nil
		--HC.remove(self.body)
		--base.entidades:removeactor(self)
		self.dead=true
	end

end

function player:keypressed(key)
	if key=="w" and self.ground and not self.isjump and not self.escalar then
		self.isjump=true
	end

	if key=="w" and self.escalar then
		self.up=true
	end

	if key=="s" and self.escalar then
		self.down=true
	end

	if key=="a" and not self.dead then
		self.moveleft=true
		--self.vx=-500
		self.isright=false
		self.mr=math.rad(-90)
	end

	if key=="d" and not self.dead then
		self.moveright=true
		--self.vx=500
		self.isright=true
		self.mr=math.rad(-90)
	end

	if key=="s" and self.subida then
		self.ignore=true
	end

	if key=="w" and self.ignore then
		self.ignore=false
	end

	if key=="s" and self.isplatformer then
		self.ignore2=true
	end

	if key=="w" and self.ignore2 then
		self.ignore2=false
	end
	--
	if key=="s" and self.isascensor then
		self.ignore3=true
	end

	if key=="w" and self.ignore3 then
		self.ignore3=false
	end

	if key=="x" and not self.attack and not self.dead and self.armaa==0 then
		self.attack=true
	end

	--armas

	if key=="1" then
		self.armaa=0
	elseif key=="2" and self.arma[1] then
		self.armaa=1
	elseif key=="3" and self.arma[2] then
		self.armaa=2
	elseif key=="4" and self.arma[3] then
		self.armaa=3
	elseif key=="5" and self.arma[4] then
		self.armaa=4
	elseif key=="6" and self.arma[5] then
		self.armaa=5
	end



end

function player:keyreleased(key)
	if key=="a" then
		--self.vx=0
		self.moveleft=false
	end

	if key=="d" then
		--self.vx=0
		self.moveright=false
	end

	if key=="w" then
		self.up=false
	end

	if key=="s" then
		self.down=false
	end

	if key=="x" and self.attack then
		self.attack=false
	end
end

function player:mousepressed(x,y,button)
	if button==1 and self.arma[self.armaa] and self.armaa>0 and self.stock[self.armaa]>0 then
		local damage,speed=0,0

		if self.armaa==1 then
			damage,speed=1,1000
		elseif self.armaa==2 then
			damage,speed=3,700
		elseif self.armaa==3 then
			damage,speed=3,1000
		elseif self.armaa==4 then
			damage,speed=2,1300
		elseif self.armaa==5 then
			damage,speed=4,500
		end
		self.stock[self.armaa]=self.stock[self.armaa]-1
		local i,j=self.point:center()
		base.entidades:addextra(Bala(i,j,self.angle,speed,self.l,damage),"bullet")
		if self.armaa==3 then
			base.entidades:addextra(Bala(i,j,self.angle+math.rad(5),speed,self.l,damage),"bullet")
			base.entidades:addextra(Bala(i,j,self.angle+math.rad(-5),speed,self.l,damage),"bullet")
		end

	elseif button==2 and self.arma[self.armaa] and self.armaa>0 then--  
		if self.municion[self.armaa]+self.stock[self.armaa]<self.maxstock[self.armaa] then
			self.stock[self.armaa]=self.municion[self.armaa]+self.stock[self.armaa]
			self.municion[self.armaa]=0
		else
			local carga=self.maxstock[self.armaa]-self.stock[self.armaa]
			self.stock[self.armaa]=self.stock[self.armaa]+carga
			self.municion[self.armaa]=self.municion[self.armaa]-carga
		end
	end
	
end


return player

