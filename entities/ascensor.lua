local Class = require "libs.class"
local vector = require "libs.vector"
local ascensor = Class{}

function ascensor:init(entidades,x,y,w,h,gid,table)
	self.entidades=entidades

	self.body=self.entidades.world:newRectangleCollider(x,y,w,h)

	self.body:setCollisionClass("ascensor")
	self.body:setType('kinematic')

	self.ox,self.oy=self.body:getWorldCenter( )

	self.p={250,-10}

	self.gid=gid

	self.instance=nil

	self.data=table

	self.sx,self.sy=self.data.w/32,self.data.h/32
	self.r=self.body.body:getAngle()

	self.ins_ox,self.ins_oy=(self.data.w/2)/self.sx,(self.data.h/2)/self.sy
	self.ins_oy_diferencia=14

	self.body:setInertia( 0 )
	self.body.fixture:setFriction(0)

	self.delta=vector(0,0)

	self.vy=100
	self.check=false
	self.move=false
	self.it=1

	self.old_deltay=-1
end

function ascensor:update(dt)
	local check=false

	if self.entidades.player.body.fixture:testPoint(self.ox,self.oy-50) then
		check=true
	end

	if self.body:enter("player") then
		self.check=true
	end

	if self.body:exit("player") then
		self.check=false
	end

	if self.check and self.entidades.player.is_ascensor and check then
		self.entidades.player.is_ascensor=false
		self.move=true
		self.delta.y=self.old_deltay
	end

	if self.move then
		
		for _, body in ipairs(self.entidades.bodies.pared) do

			if body.body.fixture:testPoint(self.ox,self.oy-self.p[self.it]) then

				if self.it==1 then
					self.it=2 
				else
					self.it=1
				end

				self.old_deltay=self.delta.y*-1

				self.delta.y=0

				self.move=false
			end
		end	
	end

	self.body.body:setLinearVelocity(0,self.delta.y*self.vy)

	self.instance.batch:set(self.instance.id, self.entidades.map.tiles[self.instance.gid].quad,self.ox,self.oy,self.r,self.sx,self.sy,self.ins_ox,self.ins_oy+self.ins_oy_diferencia)
	self.r=self.body.body:getAngle()
	self.ox,self.oy=self.body:getWorldCenter( )


end

function ascensor:remove()
	self.body.body:destroy()
	self.instance.batch:set(self.instance.id, self.entidades.map.tiles[100].quad, 0, 0, 0, 0, 0)
	self.entidades:remove("ascensor",self)
end

return ascensor