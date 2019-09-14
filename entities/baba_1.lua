local Class = require "libs.class"
local vector = require "libs.vector"
local baba_1 = Class{}

function baba_1:init(entidades,x,y,w,h)
	self.entidades=entidades
	self.body=self.entidades.world:newRectangleCollider(x,y,w,h)

	self.w,self.h=w,h

	self.body:setCollisionClass("enemigos")
	self.body:setType('dynamic')
	self.body:setInertia( 0 )

	self.ox,self.oy=self.body:getWorldCenter( )

	self.vx=400

	self.dx=1

	self.img_id=1

	self.suelo=false

	self.timer=0.5

	self.delta=vector(self.vx,0)
	
	self.body.body:setLinearVelocity(self.delta:unpack())

	self.body.fixture:setFriction(0)


	self.sensor_1=false
	self.sensor_2=false


	self.body.body:setUserData({hp=10,damage=2})




	self.body:setPreSolve(function(collider_1, collider_2, contact)
		if collider_1.collision_class == 'enemigos' and collider_2.collision_class == 'balas_player' then
			contact:setEnabled(false)

			self.body.body:getUserData().hp=self.body.body:getUserData().hp-collider_2.body:getUserData().damage
			collider_2.body:getUserData().hp=collider_2.body:getUserData().hp-1

			
    	end
	end)
end

function baba_1:draw()
	love.graphics.draw(spritesheet["spritesheet"],spritesheet["baba1"][self.img_id],self.ox,self.oy,0,self.dx,1,self.w/2,self.h/2)

	love.graphics.print(self.body.body:getUserData().hp,self.ox,self.oy-200)

end

function baba_1:update(dt)

	if self.body:enter("tierra") then
    	self.suelo=true
	end

	if self.suelo then
		self:ia_check_suelo()
	end

	

	self.delta.x,self.delta.y=self.body.body:getLinearVelocity()
	self.body.body:setLinearVelocity(self.vx*self.dx,self.delta.y)
	
	self.ox,self.oy=self.body:getWorldCenter( )

	if self.body.body:getUserData().hp<1  or self.entidades:check_limit(self.ox,self.oy) then
		self:destruir()
	end
end

function baba_1:ia_check_suelo()
	self.sensor_1=false
	self.sensor_2=false

	for _, body in ipairs(self.entidades.bodies.tierra) do
		local a=body.body.fixture:testPoint(self.ox+self.dx*self.w/1.5,  self.oy+self.h/1.2)
		local b=body.body.fixture:testPoint(self.ox+self.dx*self.w/1.5,  self.oy)

		if a then
			self.sensor_1 =true
			break
		end

		if b then
			self.sensor_2 =true
			break
		end
	end	

	if not self.sensor_1 or self.sensor_2 then
		self.dx=self.dx*-1
	end
end

function baba_1:disparo()

end

function baba_1:animation()
	if self.img_id==1 then
		self.img_id=2 
	else
		self.img_id=1
	end
end

function baba_1:jump()
	self.body:applyLinearImpulse(0, -4000)
end

function baba_1:destruir()
	self.body:destroy()
	self.entidades:remove("enemigos",self)
end

return baba_1

