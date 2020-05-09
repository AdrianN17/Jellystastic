local texturaFisica = require "entidades.Objetos_Mapa.texturaFisica"

local liquido = Class{
  __includes = {texturaFisica}
}

function liquido:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  texturaFisica.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

  self.densidad = properties.densidad or 1
end

function liquido:buoyancy(density,a,b,coll)  --in pre
	local bodyA,bodyB=a:getBody(),b:getBody()

	coll:setEnabled(false)

	if bodyB:getType()~="dynamic" then return end

	local bVerts
	local shapeA,shapeB=a:getShape(),b:getShape()

	if shapeB:getType()=="circle" then
		local x,y=bodyB:getWorldPoints(shapeB:getPoint())
		local r = shapeB:getRadius()
		local count= r/3 > 8 and r/3 or 8
		bVerts={}
		for i=1,count do
			table.insert(bVerts, x+r*math.sin(i*math.pi*2/count))
			table.insert(bVerts, y+r*math.cos(i*math.pi*2/count))
		end
	else
		bVerts={bodyB:getWorldPoints(shapeB:getPoints())}
	end


	local gx,gy=self.entidad.world:getGravity()
	local aVerts={bodyA:getWorldPoints(shapeA:getPoints())}
	local intersection = math.polygonClip(bVerts,aVerts)
	if not intersection then return end
	local cx,cy,area = math.getPolygonArea(intersection)
	if not area then return end

	local displacedMass = area*density/love.physics.getMeter()^2
	bodyB:applyForce(-displacedMass*gx ,-displacedMass*gy,cx,cy)
	local fixtureB=bodyB:getFixtures()[1]
	--bodyB:resetMassData()
	local vx,vy= bodyB:getLinearVelocity()
	bodyB:applyForce(-vx/10,-vy/10)
	local vr = bodyB:getAngularVelocity()
	bodyB:applyTorque(-vr*5000)

	local dragMod = 0.25
    local liftMod = 0.25
    local maxDrag = 20
    local maxLift = 5

    for i=1, #intersection-1,2 do
		local p1x,p1y=intersection[i],intersection[i+1]
		local ii = i+2>#intersection and 1 or i+2
		local p2x,p2y=intersection[ii],intersection[ii+1]
		local pmx,pmy = (p1x+p2x)/2,(p1y+p2y)/2

		local vax,vay=bodyA:getLinearVelocityFromWorldPoint(pmx,pmy)
		local vbx,vby=bodyB:getLinearVelocityFromWorldPoint(pmx,pmy)

		local vrx,vry=vbx-vax,vby-vay
		local vr=math.vec2.normalize(vrx,vry)

		local ex,ey=p2x-p1x,p2y-p1y
		local elen=math.vec2.normalize(ex,ey)
		local enx,eny=math.vec2.cross(-1,0,ex,ey),0
		local dragDot=math.vec2.dot(enx,eny,vrx,vry)

		if dragDot>=0 then
			local dragMag=dragDot * dragMod * elen * density * vr * vr/ love.physics.getMeter()^3;
			if dragMag>0 then
				dragMag = math.min( dragMag, maxDrag )
			elseif dragMag<0 then
				dragMag = math.max( dragMag, -maxDrag )
			end
			local dragForceX,dragForceY=-dragMag*vrx,-dragMag*vry


			local liftDot=math.vec2.dot(ex,ey,vrx,vry)
			local liftMag =dragDot *liftDot* liftMod * elen * density * vr * vr/ love.physics.getMeter()^3
			liftMag = math.min(liftMag,maxLift)
			if liftMag>0 then
				liftMag = math.min( liftMag, maxLift )
			elseif liftMag<0 then
				liftMag = math.max( liftMag, -maxLift )
			end
			local lx,ly= math.vec2.cross(1,0,vrx,vry),0
			local liftForceX,liftForceY=-liftMag*lx,-liftMag*ly
			bodyB:applyForce(liftForceX,liftForceY,pmx,pmy)

		end
  end
end

function liquido:preSolve(obj,coll)
	colisionadorObj:execute("liquido","preSolve",coll,obj,self)
end


return liquido