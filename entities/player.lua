local Class = require "libs.class"
local vector = require "libs.vector"
local player = Class{}

function player:init(entidades,x,y,w,h)
	self.entidades=entidades

	self.body=self.entidades.world:newRectangleCollider(x,y,w,h)

	self.w,self.h=w,h

	self.body:setCollisionClass("player")
	self.body:setType('dynamic')
	
	self.ox,self.oy=self.body:getWorldCenter( )

	self.direccion={a=false,d=false,s=false,w=false}

	self.estado={suelo=false,mover=false,salto=false}

	self.delta=vector(0,0)

	self.body:setInertia( 0 )

	self.img_id=1

	self.entidades.timer:every(0.15, function() 

		if self.estado.correr and not self.estado.salto then
			if self.img_id==1 then 
				self.img_id=2 
			else 
				self.img_id=1
			end 
		elseif not self.estado.correr and not self.estado.salto then
			self.img_id=1
		elseif self.estado.salto then
			self.img_id=3
		end

		if self.arma_4_usando then
			self:disparo_arma(4)
		end
	end)

	self.dx=1

	self.body.fixture:setFriction(0)

	self.body.body:setUserData({hp=10})

	self.immunity=false

	self.change_world=false
	self.change_map=""

	self.is_ascensor=false

	self.body:setPreSolve(function(collider_1, collider_2, contact)
		if collider_1.collision_class == 'player' and collider_2.collision_class == 'enemigos' then

			contact:setEnabled(false)

			if not self.immunity then
				self.body.body:getUserData().hp=self.body.body:getUserData().hp-collider_2.body:getUserData().damage
				self.immunity=true

				self.entidades.timer:after(0.75,function() self.immunity=false end)
			end
    	elseif collider_1.collision_class == 'player' and collider_2.collision_class == 'plataforma' then
    		self.estado.suelo=true
    		self.estado.salto=false

    		if self.direccion.w or self.direccion.s then
    			self.estado.suelo=false
    			contact:setEnabled(false)
    		end
    	end
	end)

	



	self.r=0
	self.r_arma=0
	self.arma=0
	self.nombre_arma={"Pistola","Revolver","Escopeta","Ametralladora","Launcher"}
	self.municion={0,0,0,0,0}
	self.stock={0,0,0,0,0}
	self.max_stock={10,5,5,45,1}
	self.max_municion={50,40,25,90,5}
	self.velocidad_bala={700,1000,600,1200,500}

	self.arma_existente={false,false,false,false,false}
	self.arma_4_usando=false
	self.daño={1,2.5,3,1.5,10}

	self.config={40,3,3,1}

	self.room_id=0

	self.dead=false

	
	
end

function player:draw()
	love.graphics.draw(spritesheet["spritesheet"],spritesheet["pj1"][self.img_id],self.ox,self.oy,0,self.dx,1,self.w/2,self.h/2)
	love.graphics.print(self.body.body:getUserData().hp,self.ox,self.oy-200,0,2,2)
	if self.arma>0 then
		love.graphics.draw(spritesheet["spritesheet3"],spritesheet["arma"][self.arma],self.ox+self.config[1],self.oy,self.r_arma,self.config[2]*self.config[4],self.config[3],
			spritesheet["arma_t"][self.arma][1]/self.config[2],spritesheet["arma_t"][self.arma][2]/(self.config[3]))

		love.graphics.print(self.stock[self.arma] .. " , " .. self.municion[self.arma],self.ox,self.oy-100,0,2,2)
	end

	
end

function player:update(dt)

	if self.body:enter("tierra") then
		self:checkground("tierra")
	elseif self.body:enter("pared") then
		self:checkground("pared")
	elseif  self.body:enter("ascensor")  then
		self:checkground("ascensor")
	end


	if self.body:exit("tierra") or self.body:exit("pared") or self.body:exit("ascensor")  then
    	self.estado.suelo=false
	end


	self:radio()

	
	self.delta.x,self.delta.y=self.body:getLinearVelocity()

	if self.direccion.a then
		self.delta.x = -500
		self.estado.correr=true
		self.dx=-1
	elseif self.direccion.d then
		self.delta.x = 500
		self.estado.correr=true
		self.dx=1
	else
		self.delta.x=0
		self.estado.correr=false
	end

	self.body:setLinearVelocity(self.delta:unpack())

	self.ox,self.oy=self.body:getWorldCenter()
	
	if self.estado.suelo and self.estado.salto then
		self.estado.salto=false
	end	

	if self.entidades:check_limit(self.ox,self.oy) or self.body.body:getUserData().hp<1 then
		self.dead=true
	end
end

function player:keypressed(key)
	if key=="a"  then
		self.direccion.a=true
	elseif key=="d" then
		self.direccion.d=true
	end

	if key=="w"  then

		self.direccion.w=true

		if self.estado.suelo then
			self.body:applyLinearImpulse(0, -12000)
			self.estado.suelo=false
			self.estado.salto=true
		end
	elseif key=="s" then
		self.direccion.s=true
		if not self.estado.suelo then
			self.body:applyLinearImpulse(0, 4000)
		end
	end


	if key=="0" then
		self.arma=0
	elseif key=="1" and self.arma_existente[1] then
		self.arma=1
	elseif key=="2" and self.arma_existente[2] then
		self.arma=2
	elseif key=="3" and self.arma_existente[3] then
		self.arma=3
	elseif key=="4" and self.arma_existente[4] then
		self.arma=4
	elseif key=="5" and self.arma_existente[5] then
		self.arma=5
	end

	if key=="r" then
		self:recarga_arma(self.arma)
	end

	if key=="e" then
		self.is_ascensor=true
	end
end

function player:keyreleased(key)
	if key=="a" then
		self.direccion.a=false
	elseif key=="d" then
		self.direccion.d=false
	end

	if key=="w" then
		self.direccion.w=false
	elseif key=="s" then
		self.direccion.s=false
	end

	if key=="e" then
		self.is_ascensor=false
	end
end

function player:mousepressed(x,y,button)
	if self.arma>0 and button==1 then
		if self.arma==4 then
			self.arma_4_usando=true
		end
		self:disparo_arma(self.arma)
	end
end

function player:mousereleased(x,y,button)
	if self.arma==4 and self.arma_4_usando then
		self.arma_4_usando=false
	end
end

function player:radio()
	local x,y= self.entidades:getXY()
	local r=math.atan2(y-(self.oy),x-(self.ox+self.config[1]))
	if r<-math.pi/2 or r>math.pi/2 then
		self.config[4]=-1
		self.r_arma=r-math.pi
	else
		self.config[4]=1
		self.r_arma=r
	end

	self.r=r
end

function player:disparo_arma(tipo)
	if self.stock[tipo]>0 then
		if tipo==1 then
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy,5,self.r,self.velocidad_bala[1],1,self.daño[1]))
		elseif tipo==2 then
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy,5,self.r,self.velocidad_bala[2],2,self.daño[2]))
		elseif tipo==3 then
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy-15,5,self.r,self.velocidad_bala[3],3,self.daño[3]))
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy,5,self.r,self.velocidad_bala[3],3,self.daño[3]))
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy+15,5,self.r,self.velocidad_bala[3],3,self.daño[3]))
		elseif tipo==4 then
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy,5,self.r,self.velocidad_bala[4],4,self.daño[4]))
		elseif tipo==5 then
			table.insert(self.entidades.objects.balas,self.entidades.files.balas(self.entidades,self.ox+self.config[1],self.oy,5,self.r,self.velocidad_bala[5],5,self.daño[5]))
		end

		self.stock[tipo]=self.stock[tipo]-1
	end
end

function player:recarga_arma(tipo)
	if self.arma_existente[self.arma] and self.arma>0 then 
		if self.municion[self.arma]+self.stock[self.arma]<self.max_stock[self.arma] then
			self.stock[self.arma]=self.municion[self.arma]+self.stock[self.arma]
			self.municion[self.arma]=0
		else
			local carga=self.max_stock[self.arma]-self.stock[self.arma]
			self.stock[self.arma]=self.stock[self.arma]+carga
			self.municion[self.arma]=self.municion[self.arma]-carga
		end
	end
end


function player:checkground(class)
	local collision_data = self.body:getEnterCollisionData(class)
    	local i,j=collision_data.contact:getNormal( )
    	local f1,f2=collision_data.contact:getFixtures( )
    	local body=f1:getBody()

    	--print(i,j)

    	if j==-1 and body:getUserData() then
			self.estado.suelo=true
    		self.estado.salto=false
    	elseif j==1 and class=="ascensor" then
    		self.estado.suelo=true
    		self.estado.salto=false
    	elseif not body:getUserData() then
    		self.estado.suelo=true
    		self.estado.salto=false
    	end
end

return player