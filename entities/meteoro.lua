local Class = require "libs.class"
local vector = require "libs.vector"
local meteoro = Class{}

function meteoro:init(entidades,x,y)
	self.entidades=entidades
	self.body=self.entidades.world:newCircleCollider(x,y,61.5/2)
	self.body:setCollisionClass("meteoro")
	self.body:setType('dynamic')
	self.body:setRestitution(0.3)
	self.ox,self.oy=self.body:getWorldCenter( )
	self.body.fixture:setFriction(0)
	
	self.hp=5
	self.rad=61.5/2
	self.r=self.body.body:getAngle()

	self.entidades.timer:after(4,function() 
		

	end)

	self.body:setPreSolve(function(collider_1, collider_2, contact)
		if collider_1.collision_class == 'enemigos' and collider_2.collision_class == 'balas_player' then
			contact:setEnabled(false)

			self.body.body:getUserData().hp=self.body.body:getUserData().hp-collider_2.body:getUserData().damage
			collider_2.body:getUserData().hp=collider_2.body:getUserData().hp-1

			
    	end
	end)

	self.body.body:setUserData({hp=5})
	self.timer=0
end

function meteoro:draw()
	if self.body.body then
		love.graphics.print(self.body.body:getUserData().hp,self.ox,self.oy-100)
		love.graphics.draw(spritesheet["meteoro"],self.ox,self.oy,self.r,1,1,self.rad,self.rad)
	end
end

function meteoro:update(dt)
	self.timer=self.timer+dt



	if self.body.body then
		self.ox,self.oy=self.body:getWorldCenter( )
		self.r=self.body.body:getAngle()

		if self.body.body:getUserData().hp<1 then
			self:destruir()
		end

		if self.timer>4 then
			self.entidades:check_rooms_destroy(self.body)
			self.body:destroy()
			local x,y,r=self.ox, self.oy, self.rad*5
			colliders = self.entidades.world:queryCircleArea(x,y,r, {'All', except = {'player','enemigos','puerta','balas_player','meteoro'}}) 
			for _, collider in ipairs(colliders) do
	        	collider.body:setType("dynamic")
	       		collider.body:applyLinearImpulse (love.math.random(-5,5)*2000 , love.math.random(-5,5)*2000 )
	        end		
		end
	end

	if self.entidades:check_limit(self.ox,self.oy) then
		self:destruir()
	end
end

function meteoro:destruir()
	self.body:destroy()
	self.entidades:remove("meteoro",self)
end


return meteoro