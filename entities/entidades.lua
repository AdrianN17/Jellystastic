local Class = require "libs.class"

local entidades  = Class{}

function entidades:init(map,cam,world,timer,scale,create_meteor)
	self.map=map
	self.cam=cam
	self.world=world
	self.timer=timer
	self.scale=scale
	self.player=nil

	self.objects={enemigos={},balas={},ascensor={},meteoro={}}
	self.bodies={tierra={},pared={},puerta={},plataforma={},armas={},municion={}}
	self.files={ player=require "entities.player", baba_1=require "entities.baba_1", balas=require "entities.balas" ,ascensor= require "entities.ascensor" ,meteoro= require "entities.meteoro"}
	self.camview={x=0,y=0,w=0,h=0}
	self.create_meteor=create_meteor
	self.limit={}
	self.limit.x,self.limit.y,self.limit.x_end,self.limit.y_end=self.cam:getWorld()

	self.limit.x=self.limit.x-100
	self.limit.y=self.limit.y-100

	self.limit.x_end=self.limit.x_end+100
	self.limit.y_end=self.limit.y_end+100
end

function entidades:destroy()
	self.map=nil
	self.cam=nil
	self.world:destroy()
	self.timer:clear()
	self.scale=1
	self.player=nil
	self.object=nil
	self.bodies=nil
	self.files=nil 
	self.camview=nil
	self.create_meteor=false
end

function entidades:new_player(player)
	self.player=player
end

function entidades:remove(name,obj)
	for i, data in ipairs(self.objects[name]) do
		if data==obj then
			table.remove(self.objects[name],i)
			return 
		end
	end
end

function entidades:data()
	self.world:setQueryDebugDrawing(true)

	self.world:addCollisionClass("puerta")
	self.world:addCollisionClass("tierra",{ignores = {"puerta"}})
	self.world:addCollisionClass("pared",{ignores = {"puerta"}})
	self.world:addCollisionClass("plataforma",{ignores = {"puerta"}})
	self.world:addCollisionClass("enemigos",{ignores = {"puerta","enemigos"}})
	self.world:addCollisionClass("player",{ignores = { "player"}})
	self.world:addCollisionClass("balas_player",{ignores = { "puerta", "player","balas_player"}})
	self.world:addCollisionClass("ascensor")
	self.world:addCollisionClass("armas")
	self.world:addCollisionClass("municion")
	self.world:addCollisionClass("meteoro",{ignores = {"enemigos","player"}})


	for _, layer in ipairs(self.map.layers) do
		if layer.type=="tilelayer" then
			self:tile(layer)
		elseif layer.type=="objectgroup" then
			self:objetos(layer)
		end
	end



	self.timer:every(0.15, function() 
		for _, enemy in ipairs(self.objects.enemigos) do
			enemy:animation()
		end
	end)

	self.timer:every(1, function()
		for _, enemy in ipairs(self.objects.enemigos) do
			enemy:jump()
		end
	end)

	if self.create_meteor then
		self.timer:every(2.5, function()
			local x= love.math.random(self.camview.x-100,self.camview.x+self.camview.w+100)
			local y= self.camview.y-100
			table.insert(self.objects.meteoro,self.files.meteoro(self,x,y))
		end)
	end
end

function entidades:objetos(objectlayer)
	if objectlayer.name=="Tierra" then

		for _, obj in pairs(objectlayer.objects) do
			if obj.properties.triangulo == true then
				if obj.properties.tipo == 1 then
		
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x,obj.y,obj.x+obj.width,obj.y})
					body:setCollisionClass("tierra")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.tierra, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				elseif obj.properties.tipo == 2 then
		
					local body=self.world:newPolygonCollider({obj.x,obj.y,obj.x+obj.width,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("tierra")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.tierra, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				elseif obj.properties.tipo == 3 then
					
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("tierra")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.tierra, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})
					
				elseif obj.properties.tipo == 4 then
					
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x+obj.width,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("tierra")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.tierra, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				end

			else
				local body=self.world:newRectangleCollider(obj.x,obj.y-obj.height,obj.width,obj.height)
				body:setCollisionClass("tierra")
				body:setType("static")
				local fix=body : getFixtures (  )
				body.fixture: setFriction(0)
				body.body:setUserData(true)
				--print(body.body:getUserData())

				table.insert(self.bodies.tierra, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=0})

			end
		end
	elseif objectlayer.name=="Pared" then
		for _, obj in pairs(objectlayer.objects) do

			if obj.properties.triangulo == true then

				if obj.properties.tipo == 1 then
		
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x,obj.y,obj.x+obj.width,obj.y})
					body:setCollisionClass("pared")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.pared, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				elseif obj.properties.tipo == 2 then
		
					local body=self.world:newPolygonCollider({obj.x,obj.y,obj.x+obj.width,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("pared")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.pared, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				elseif obj.properties.tipo == 3 then
					
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("pared")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.pared, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})
					
				elseif obj.properties.tipo == 4 then
					
					local body=self.world:newPolygonCollider({obj.x,obj.y-obj.height,obj.x+obj.width,obj.y,obj.x+obj.width,obj.y-obj.height})
					body:setCollisionClass("pared")
					body:setType("static")
					body.fixture: setFriction(0)

					table.insert(self.bodies.pared, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=1})

				end
			else

				local body=self.world:newRectangleCollider(obj.x,obj.y-obj.height,obj.width,obj.height)
				body:setCollisionClass("pared")
				body:setType("static")
				local fix=body : getFixtures (  )
				body.fixture: setFriction(0)
				body.body:setUserData(true)


				table.insert(self.bodies.pared, {body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,tipo=0})
			end
		end
	elseif objectlayer.name=="Plataforma" then
		for _, obj in pairs(objectlayer.objects) do
			local body=self.world:newLineCollider(obj.x,obj.y-15,obj.x+obj.width,obj.y-15)
			body:setCollisionClass("plataforma")
			body:setType("static")

			table.insert(self.bodies.plataforma,{body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid})
		end
	elseif objectlayer.name=="Puertas" then
		for _, obj in pairs(objectlayer.objects) do

			local body=self.world:newRectangleCollider(obj.x,obj.y-obj.height,obj.width,obj.height)
			body:setCollisionClass("puerta")
			body:setType("static")
			body.fixture:setSensor(true)
			body.body:setUserData({name=obj.properties.room,id=obj.properties.id})

			table.insert(self.bodies.puerta,{body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid})
		end
	elseif objectlayer.name=="Ascensor" then
		for _, obj in pairs(objectlayer.objects) do
			local asc = self.files.ascensor(self,obj.x,obj.y-obj.height/8,obj.width,obj.height/8,obj.gid,{x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height})
			table.insert(self.objects.ascensor,asc)
		end
	elseif objectlayer.name=="Armas" then
		for _, obj in pairs(objectlayer.objects) do
			local body=self.world:newRectangleCollider(obj.x,obj.y-obj.height,obj.width,obj.height)
			body:setCollisionClass("armas")
			body:setType("static")
			body.fixture:setSensor(true)
			table.insert(self.bodies.armas,{body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,name=tonumber(obj.name)})
		end
		
	elseif objectlayer.name=="Municion" then
		for _, obj in pairs(objectlayer.objects) do
			local body=self.world:newRectangleCollider(obj.x,obj.y-obj.height,obj.width,obj.height)
			body:setCollisionClass("municion")
			body:setType("static")
			body.fixture:setSensor(true)


			local get_balas=function(name)
				if name==1 then
					return love.math.random(10,20)
				elseif name==2 then
					return love.math.random(8,15)
				elseif name==3 then
					return love.math.random(5,10)
				elseif name==4 then
					return love.math.random(30,50)
				elseif name==5 then
					return love.math.random(1,2)
				end
			end

			local balas=get_balas(tonumber(obj.name))


			table.insert(self.bodies.municion,{body=body,x=obj.x,y=obj.y-obj.height,w=obj.width,h=obj.height,gid=obj.gid,name=tonumber(obj.name),balas=balas})
		end

	elseif objectlayer.name=="Borrador" then
		for _, obj in pairs(objectlayer.objects) do
			if obj.name == "player" then
				self.player=self.files.player(self,obj.x,obj.y,obj.width,obj.height)
        	elseif obj.name == "Baba" then
        		local baba1=self.files.baba_1(self,obj.x,obj.y,obj.width,obj.height)
        		table.insert(self.objects.enemigos,baba1)
        	end
		end
		self.map:removeLayer ("Borrador")
	end

	for _,obj in ipairs(self.bodies.tierra) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.bodies.pared) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.objects.ascensor) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.data.x == instance.x and obj.data.y == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.bodies.armas) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.bodies.municion) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.bodies.plataforma) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end

	for _,obj in ipairs(self.bodies.puerta) do
		for _, instance in ipairs(self.map.tileInstances[obj.gid]) do
			if obj.x == instance.x and obj.y  == instance.y then
				obj.instance=instance
			end
		end
	end


	

end


function entidades:tile(tilelayer)

end

function entidades:update(dt)
	self.world:update(dt)
	self.timer:update(dt)
	self:check_room()
	self:check_armas_municion()
	self:check_end_bodies()
	self.map:update(dt)

	self.cam:setPosition(self.player.body:getPosition( ))

	
end

function entidades:draw()
	self.camview.x,self.camview.y,self.camview.w,self.camview.h=self.cam:getVisible()
	self.map:draw(-self.camview.x,-self.camview.y,self.scale,self.scale)
	

	self.cam:draw(function(l,t,w,h)
  		--self.world:draw()
	end)
end

function entidades:layer()
	local tierra=self.map.layers["Tierra"]
	local personajes=self.map.layers["Personajes"] 
	local pared=self.map.layers["Pared"]
	local plataforma=self.map.layers["Plataforma"]
	local ascensor=self.map.layers["Ascensor"]

	personajes.draw = function(obj)
		for _,met in ipairs(self.objects.meteoro) do
			met:draw()
		end

		for _, enemy in ipairs(self.objects.enemigos) do
			enemy:draw()
		end

		for _,bullet in ipairs(self.objects.balas) do
			bullet:draw()
		end

		self.player:draw()

		

	end

	personajes.update = function(obj,dt)
		for _,met in ipairs(self.objects.meteoro) do
			met:update(dt)
		end

		for _, enemy in ipairs(self.objects.enemigos) do
			enemy:update(dt)
		end

		self.player:update(dt)

		for _,bullet in ipairs(self.objects.balas) do
			bullet:update(dt)
		end

		
		
	end


	tierra.update = function(obj,dt)
		for _,obj in ipairs(self.bodies.tierra) do
			if obj.tipo==1 then

				local get_triangle_center= function(x1,y1,x2,y2,x3,y3) 
					return (x1+x2+x3)/3,(y1+y2+y3)/3
				end

				local x,y=get_triangle_center(obj.body.body:getWorldPoints(obj.body.shape:getPoints()))
				local r= obj.body.body:getAngle()
				local sx,sy=obj.w/32,obj.h/32

				if not (obj.ox and obj.oy) then
					obj.ox,obj.oy=(x-obj.instance.x)/sx,(y-obj.instance.y)/sy
				end

				obj.instance.batch:set(obj.instance.id, self.map.tiles[obj.instance.gid].quad,x,y,r,sx,sy,obj.ox,obj.oy)

			else

				local x,y=obj.body.body:getWorldCenter( )
				local r= obj.body.body:getAngle()
				local sx,sy=obj.w/32,obj.h/32
				local ox,oy=(obj.w/2)/sx,(obj.h/2)/sy
				obj.instance.batch:set(obj.instance.id, self.map.tiles[obj.instance.gid].quad,x,y,r,sx,	sy,ox,oy)
			end
		end
	end

	pared.update = function(obj,dt)
		for _,obj in ipairs(self.bodies.pared) do
			if obj.tipo==1 then

				local get_triangle_center= function(x1,y1,x2,y2,x3,y3) 
					return (x1+x2+x3)/3,(y1+y2+y3)/3
				end

				local x,y=get_triangle_center(obj.body.body:getWorldPoints(obj.body.shape:getPoints()))
				local r= obj.body.body:getAngle()
				local sx,sy=obj.w/32,obj.h/32

				if not (obj.ox and obj.oy) then
					obj.ox,obj.oy=(x-obj.instance.x)/sx,(y-obj.instance.y)/sy
				end

				obj.instance.batch:set(obj.instance.id, self.map.tiles[obj.instance.gid].quad,x,y,r,sx,sy,obj.ox,obj.oy)

			else

				local x,y=obj.body.body:getWorldCenter( )
				local r= obj.body.body:getAngle()
				local sx,sy=obj.w/32,obj.h/32
				local ox,oy=(obj.w/2)/sx,(obj.h/2)/sy
				obj.instance.batch:set(obj.instance.id, self.map.tiles[obj.instance.gid].quad,x,y,r,sx,	sy,ox,oy)
			end
		end
	end

	plataforma.update = function(obj,dt)
		for _,obj in ipairs(self.bodies.plataforma) do
			local get_line_center = function(x1,y1,x2,y2)
				return (x1+x2)/2,(y1+y2)/2
			end
			local x,y=get_line_center(obj.body.body:getWorldPoints(obj.body.shape:getPoints()))
			
			local r= obj.body.body:getAngle()
			local sx,sy=obj.w/32,obj.h/32

			if not (obj.ox and obj.oy) then
				obj.ox,obj.oy=(x-obj.instance.x)/sx,(y-obj.instance.y)/sy
			end


			obj.instance.batch:set(obj.instance.id, self.map.tiles[obj.instance.gid].quad,x,y,r,sx,sy,obj.ox,obj.oy)
		end
	end

	ascensor.update = function(obj,dt)
		for _,asc in ipairs(self.objects.ascensor) do
			asc:update(dt)
		end
	end

	--self.world:setQueryDebugDrawing(true)
end

function entidades:getXY()
	local cx,cy=self.cam:toWorld(love.mouse.getPosition())
	return cx,cy
end


function entidades:keypressed(key)
	self.player:keypressed(key)
end

function entidades:keyreleased(key)
	self.player:keyreleased(key)
end

function entidades:mousepressed(x,y,button)
	local cx,cy=self.cam:toWorld(x,y)
	self.player:mousepressed(cx,cy,button)
end

function entidades:mousereleased(x,y,button)
	local cx,cy=self.cam:toWorld(x,y)
	self.player:mousereleased(cx,cy,button)
end


function entidades:change_bodies()
	for _,body in ipairs(self.bodies.tierra) do
		body.body.body:setType("dynamic")
		body.body.body:applyLinearImpulse (love.math.random(-5,5)*10000 , love.math.random(-5,5)*10000 )
	end

	for _,body in ipairs(self.bodies.pared) do
		body.body.body:setType("dynamic")
		body.body.body:applyLinearImpulse (love.math.random(-5,5)*10000 , love.math.random(-5,5)*10000 )
	end

	for _,body in ipairs(self.bodies.plataforma) do
		body.body.body:setType("dynamic")
		body.body.body:applyLinearImpulse (love.math.random(-5,5)*10000 , love.math.random(-5,5)*10000 )
	end

	for _,as in ipairs(self.objects.ascensor) do
		as:remove()
	end
end

function entidades:check_room()
	self.player.change_world=false
	self.player.change_map=""

	for _,body in ipairs(self.bodies.puerta) do
		if self.player.body.body:isTouching(body.body.body) then
			self.player.change_world=true
			self.player.change_map=body.body.body:getUserData().name
			self.player.room_id=body.body.body:getUserData().id
			break
		end
	end
end

function entidades:check_armas_municion()

	for i,body in ipairs(self.bodies.armas) do
		if self.player.body.body:isTouching(body.body.body) then
			self.player.arma_existente[body.name]=true

			body.instance.batch:set(body.instance.id, self.map.tiles[body.instance.gid].quad,0,0,0,0,0)
			body.body:destroy()
			table.remove(self.bodies.armas,i)
			break
		end
	end

	for i,body in ipairs(self.bodies.municion) do
		if self.player.body.body:isTouching(body.body.body) and self.player.arma_existente[body.name] then
			local t=body.name
			local b=body.balas

			if self.player.municion[t]+b < self.player.max_municion[t] then
				self.player.municion[t]=self.player.municion[t]+b
				b=0

				body.instance.batch:set(body.instance.id, self.map.tiles[body.instance.gid].quad,0,0,0,0,0)
				body.body:destroy()
				table.remove(self.bodies.municion,i)
				break

			else
				local muni=self.player.max_municion[t]-self.player.municion[t]
				self.player.municion[t]=self.player.municion[t]+muni
				bs=b-muni
			end
		end
	end
end


function entidades:replace_tile(layer, tile, newTileGid)
	local x=(tile.x/self.map.tilewidth)+1
	local y=(tile.y/self.map.tileheight)+1

	layer = self.map.layers[layer]
	for i, instance in ipairs(self.map.tileInstances[layer.data[y][x].gid]) do
		if instance.layer == layer and instance.x == tile.x and instance.y == tile.y then
		  instance.batch:set(instance.id, self.map.tiles[newTileGid].quad, instance.x, instance.y)
		  break
		end
	end
end

function entidades:replace_object(object,gid_tile)
	for i, instance in ipairs(self.map.tileInstances[object.gid]) do
  		if object.x == instance.x and object.y  == instance.y then
      		instance.batch:set(instance.id, self.map.tiles[gid_tile].quad, object.x,object.y)
      		break
      	end
  	end
end

function entidades:get(player_table)
	local player=self.player
	
	player.municion=player_table.municion 
	player.stock=player_table.stock 
	player.arma_existente=player_table.arma_existente
	player.body.body:getUserData().hp=player_table.body.body:getUserData().hp

	for _,body in ipairs(self.bodies.puerta) do
		if body.body.body:getUserData().id== player_table.room_id then
			player.body:setPosition(body.body.body:getWorldCenter())
			break
		end
	end
	--print()

end

function entidades:check_no_camera(ox,oy)
	return ox < self.camview.x or ox > self.camview.x + self.camview.w  or oy < self.camview.y  or oy > self.camview.y + self.camview.h 
end

function entidades:check_rooms_destroy(meteor)
	for i,body in ipairs(self.bodies.puerta) do
		if meteor.body:isTouching(body.body.body) then
			body.body:destroy()
			body.instance.batch:set(body.instance.id, self.map.tiles[body.instance.gid].quad,0,0,0,0,0)
			table.remove(self.bodies.puerta,i)
			return
		end
	end
end

function entidades:check_end_bodies()
	for i, bodies in ipairs( self.bodies.tierra ) do
		local body=bodies.body.body
		if body:getType()=="dynamic" and self:check_limit(body:getWorldCenter())   then
			bodies.body:destroy()
			bodies.instance.batch:set(bodies.instance.id, self.map.tiles[bodies.instance.gid].quad,0,0,0,0,0)
			table.remove(self.bodies.tierra,i)
		end
	end

	for i,bodies in ipairs( self.bodies.pared) do
		local body=bodies.body.body
		if body:getType()=="dynamic" and self:check_limit(body:getWorldCenter())   then
			bodies.body:destroy()
			bodies.instance.batch:set(bodies.instance.id, self.map.tiles[bodies.instance.gid].quad,0,0,0,0,0)
			table.remove(self.bodies.pared,i)
		end
	end

	for i,bodies in ipairs( self.bodies.plataforma) do
		local body=bodies.body.body
		if body:getType()=="dynamic" and self:check_limit(body:getWorldCenter())   then
			bodies.body:destroy()
			bodies.instance.batch:set(bodies.instance.id, self.map.tiles[bodies.instance.gid].quad,0,0,0,0,0)
			table.remove(self.bodies.plataforma,i)
		end
	end


end

function entidades:check_limit(ox,oy)
	return ox < self.limit.x or ox > self.limit.x_end  or oy < self.limit.y  or oy > self.limit.y_end 
end


return entidades