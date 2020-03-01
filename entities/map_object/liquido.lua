local Class = require "libs.hump.class"
local vector= require "libs.hump.vector"

local liquido = Class{}

function liquido:init(entidad,poligono,img,radio,tipo)
  self.entidad = entidad
  
  self.entidad:add_obj("liquid",self)
  
  texture = img.texturas.liquido[tonumber(tipo)]
  
  self.mesh = self:poly2mesh(poligono,2)
  self.mesh:setTexture(texture)
  
  
  self.body = love.physics.newBody(self.entidad.world,0,0)
  self.shape = love.physics.newPolygonShape(poligono)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  --self.fixture:setSensor(true)
  
  self.fixture:setUserData( {data="liquido",obj=self, pos=orden.liquido} )
  
  self.ox,self.oy,self.w,self.h = self.fixture:getBoundingBox(1)
  
  self.lista_flote={}
  
end

function liquido:draw()
  love.graphics.draw(self.mesh)
end

function liquido:update()
  
  --[[for i= 1 , #self.lista_flote, 2 do
    
    local f1,f2 = self.lista_flote[i],self.lista_flote[i+1]
    
    if f1 and f2 then
      local density = f1:getDensity()
      local intersectionPoints,validador = findIntersectionOfFixtures(f1, f2)
      
      if validador then
        local centroid,area = ComputeCentroid(intersectionPoints)
        
        --
        local gravity = vector( 0, -10 )
        
        local displacedMass = f1:getDensity() * area;
        local buoyancyForce = displacedMass * -gravity;
        fixtureB->GetBody()->ApplyForce( buoyancyForce, centroid );
        
      end
      
    end
    
  end]]
  
end

function liquido:poly2mesh(points,uv_scale)
  local polypts = love.math.triangulate(points)
  local tlist

  local vnums = {}
  local vcoords = {}
  do
    local verthash = {}
    local n = 0
    local v
    -- use unique vertices by using a coordinate hash table
    for i = 1, #polypts do
      for j = 1, 3 do
        local px = polypts[i][j * 2 - 1]
        local py = polypts[i][j * 2]
        if not verthash[px] then
          verthash[px] = {}
        end
        if not verthash[px][py] then
          n = n + 1
          verthash[px][py] = n
          vcoords[n * 2 - 1] = px
          vcoords[n * 2] = py
          v = n
        else
          v = verthash[px][py]
        end
        vnums[(i - 1) * 3 + j] = v
      end
    end
  end



  local mesh = love.graphics.newMesh(#vcoords, "triangles", "static")
  for i = 1, #vcoords / 2 do
    local x, y = vcoords[i * 2 - 1], vcoords[i * 2]

    -- Here's where the UVs are assigned
    mesh:setVertex(i, x, y, x / (50*uv_scale), y / (50*uv_scale))
  end
  mesh:setVertexMap(vnums)
  return mesh
end

function liquido:agregar(obj)
  for _, data in ipairs(self.lista_flote) do
    if data == obj then
      return
    end
  end
  
  table.insert(self.lista_flote,obj)
  
end

function liquido:eliminar(obj)
  
  local id = -1
  
  for i, data in ipairs(self.lista_flote) do
    if data == obj then
      id = i
    end
  end
  
  if id ~= -1 then
    table.remove(self.lista_flote,id)
  end
end

function liquido:buoyancy(density,a,b,coll)  --in pre
	local bodyA,bodyB=a:getBody(),b:getBody()
	coll:setEnabled(false)
	if bodyB:getType()~="dynamic" then return end
	local bVerts
	local shapeA,shapeB=a:getShape(),b:getShape()
	if shapeB:getType()=="circle" then
		local x,y=shapeB:getPoint()
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


--[[

function liquido:inside(cp1,cp2,cp)
  return (cp2.x-cp1.x)*(p.y-cp1.y) > (cp2.y-cp1.y)*(p.x-cp1.x)
end

function liquido:intersection(cp1,cp2,s,e)
  local dc = vector( cp1.x - cp2.x, cp1.y - cp2.y )
  local dp = vector( s.x - e.x, s.y - e.y )
  local n1 = cp1.x * cp2.y - cp1.y * cp2.x
  local n2 = s.x * e.y - s.y * e.x
  local n3 = 1.0 / (dc.x * dp.y - dc.y * dp.x)
  return vector( (n1*dp.x - n2*dc.x) * n3, (n1*dp.y - n2*dc.y) * n3)
end

function liquido:findIntersectionOfFixtures(fixturea, fixtureb)
  
  local outputVertices = {}
  
  local shapea = fixturea:getShape()
  local shapeb = fixtureb:getShape()
  
  local bodya = fixturea:getBody()
  local bodyb = fixturea:getBody()
  
  if shapea:getType( ) == shapeb:getType( ) then
    return false,outputVertices
  end
  
  outputVertices = self:list_vector(bodya.getWorldPoints(shapea:getPoints()))
  local clipPolygon = self:list_vector(bodyb.getWorldPoints(shapeb:getPoints()))
  
  local cp1  =  clipPolygon[#clipPolygon]
  
  for i = 0, #clipPolygon, 1 do
    cp2 = clipPolygon[i]
    
    if #outputVertices == 0 then
      return false,outputVertices
    end
    
    local inputList = outputVertices
    outputVertices = {}
    
    local s = inputList[#inputList]
    
    for j = 0, #inputList, 1 do
      local e = inputList[j]
      
      if self:inside(cp1, cp2, e) then
        if not self:inside(cp1, cp2, s) then
          table.insert(outputVertices,self:intersection(cp1, cp2, s, e))
        end
        table.insert(outputVertices,e)
      elseif self:inside(cp1, cp2, s) then
        table.insert(outputVertices,self:intersection(cp1, cp2, s, e))
      end

    end
    
    cp1 = cp2
  end
  
  return not table.empty(outputVertices),outputVertices
  
end

function liquido:list_vector(list)
  local t = {}
  
  for i = 1 , #list, 2 do
    table.insert(t, vector(list[i],list[i+1]) )
  end
  
  return t
end

function liquido:ComputeCentroid(vs)
  
  local area = 0
  
  local count = #vs
  
  local c = vector(0,0)
  local pRef(0,0)
  
  local inv3 = 1/3
  
  for i= 1, count, 1 do
    local p1 = pRef
    local p2 = vs[1]
    
    --b2Vec2 p3 = i + 1 < count ? vs[i+1] : vs[0];
    local p3 = nil
    
    if i+1 < count then
      p3 = vs[i+1]
    else
      p3 = vs[0]
    end
    
    local e1 = p2 - p1
    local e2 = p3 - p1;
  
    local D = e1:cross(e2);
  
    local triangleArea = 0.5 * D;
    area = area + triangleArea;
    c = c + triangleArea * inv3* (p1 + p2 + p3)
    
    
    c *= 1.0f / area;

    return c;
    
  end
  
  

]]
  
  
  



return liquido