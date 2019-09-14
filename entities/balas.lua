local Class = require "libs.class"
local vector = require "libs.vector"
local balas = Class{}

function balas:init(entidades,x,y,r,vr,vel,tipo,daño)

	self.entidades=entidades
	self.body=self.entidades.world: newCircleCollider ( x , y ,r )
	self.r=r

	self.body:setCollisionClass("balas_player")
	self.body:setType('dynamic')
	self.body.body:setGravityScale( 0 )
	--math.cos(self.r),math.sin(self.r)
	self.vx,self.vy=math.cos(vr),math.sin(vr)
	self.vel=vel
	self.delta=vector(self.vx,self.vy)

	self.body.body:setUserData({hp=1,damage=daño})

	self.ox,self.oy=self.body:getWorldCenter( )

	self.tipo=tipo

	
end

function balas:draw()
	love.graphics.draw(spritesheet["spritesheet2"],spritesheet["balas"][self.tipo],self.ox,self.oy,0,1,1,10/2,10/2)
end

function balas:update()
	if self.body:enter("pared") or self.body:enter("tierra") or self.body:enter("plataforma") then
   		self.body.body:getUserData().hp=0
	end

	self.body.body:setLinearVelocity (self.delta.x*self.vel,self.delta.y*self.vel)

	self.ox,self.oy=self.body:getWorldCenter( )

	if self.body.body:getUserData().hp<1 or self.entidades:check_no_camera(self.ox,self.oy) then
		self:destruir()	
	end
end

function balas:destruir()
	self.body:destroy()
	self.entidades:remove("balas",self)
end

return balas