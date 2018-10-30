local Gamestate = require "libs.gamestate"
local base = require "gamestate.base"
local Class = require "libs.class"

local gamera = require "libs.gamera"
local Player= require "entidades.player"
local Meteoro = require "entidades.meteoro"
local Ascensor = require "entidades.ascensor"
local Baba1 = require "entidades.baba_1"
local Npc = require "entidades.npc"

local pausa = require "gamestate.pausa"

local nivel1_2 = Class{
	__includes = base
}
local xc,yc,hc,wc=0,0,0,0
local time=0
local background=nil
local city=nil
local time2=0
local tmw,tmh=0,0
local backgroundPosition=0
local gh=0
local intervalo=true
sprites={}

local counter=0
function nivel1_2:init()
	self:sprites()
	background=love.graphics.newImage("assets/img/background.png")
	city=love.graphics.newImage("assets/img/city.png")
	gh=love.graphics.getWidth()
end


function nivel1_2:enter()
	collectgarbage("stop")
	base.entidades:clear()

	timer=0
	base.init(self,"assets/level/nivel_1_2.lua")
	tmw,tmh=self.map.width*self.map.tilewidth,self.map.height*self.map.tileheight
	--mapeados
	self:inicializate_1()

	local layerplayer = self.map.layers["Jugadores"]
	local layerenemigo = self.map.layers["Enemigos"]
	local layerobjetos = self.map.layers["Objetos"]
	local layerpuertas = self.map.layers["Puertas"]

	--update

	function layerplayer:update(dt)
		base.entidades:update_p(dt)
	end

	function layerenemigo:update(dt)
		base.entidades:update_e(dt)
	end

	function layerobjetos:update(dt)
		base.entidades:update_o(dt)
	end

	function layerpuertas:update(dt)
		--base.entidades:update_pu(dt)
	end

	--draw

	function layerplayer:draw()
		base.entidades:draw_p()
	end

	function layerenemigo:draw()
		base.entidades:draw_e()
	end

	function layerobjetos:draw()
		base.entidades:draw_o()
	end

	function layerpuertas:draw()
		base.entidades:draw_pu()
	end

end



--generar colision cuando este choque con el radio para mayor destruccion

function nivel1_2:update(dt)

	counter=collectgarbage('count')/1000
	--collectgarbage
	--mandar valor a entidades
	if counter >90 then
		collectgarbage()
	end
	
	base.entidades.player.ax,base.entidades.player.ay=self.cam:toWorld(love.mouse.getPosition())

	local x,y,h,w=xc-100,yc-100,hc+200,wc+200
	
	--limitar los movimientos de los demas
	base.entidades:setcamera(x,y,h,w)
	self.map:update(dt)
	self.cam:setPosition(base.entidades.player.ox, base.entidades.player.oy)

	self:setmeteor(dt,x,y,h,w)

	base.entidades:collisions()

	
end
--1600	900
function nivel1_2:draw()
	love.graphics.draw(background,0,0)

	xc,yc,hc,wc=self.cam:getVisible()
	--print(self.cam:getWorld())
	--self.cam:draw(function(l,t,w,h)
		love.graphics.draw(city,(xc/wc)*320,0)
		--print((xc/wc)*32)
		love.graphics.draw(city,(xc/wc)*320 -gh,0)
	--end)
	self.map:draw(-xc,-yc,self.scale,self.scale)
	--vida del jugador
	love.graphics.draw(sprites["heart"],sprites[base.entidades.player.h[base.entidades.player.hi]],10,25)
	love.graphics.print(math.max(base.entidades.player.hp*10,0) .. " %",20,40,0,1.5,1.5)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("Npcs salvados : " .. base.entidades.player.friend,20,100)
	if base.entidades.player.armaa>0 then
		love.graphics.print("Arma : " .. base.entidades.player.narma[base.entidades.player.armaa] .. " Municion : " .. base.entidades.player.municion[base.entidades.player.armaa] .. " Stock : " .. base.entidades.player.stock[base.entidades.player.armaa],20,140)
	end
	if base.entidades.player.dead then
		love.graphics.print("Presione enter para reiniciar",700,450,0,1.5,1.5)
	elseif base.entidades.player.fin then
		love.graphics.print("Nivel superado",700,450,0,1.5,1.5)
	end
	
		local stats = love.graphics.getStats()
	 
	    local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
	    love.graphics.print("debug",1200,10)
	    love.graphics.print(str, 1200, 30)
		love.graphics.print('Memory actually used (in kB): ' .. counter, 1200,50)
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1200, 70)

	love.graphics.setColor(1, 1, 1)
end

function nivel1_2:keypressed(key)
	base.entidades:keypressed(key)

	if key=="e" and base.entidades.player.ischange then
		--cambio de fase
		

		if base.entidades.l==1 then
			base.entidades.l=2
			self:changemap(false,true)

		else
			base.entidades.l=1
			self:changemap(true,false)
		end


		--limpiar balas
		base.entidades.bullet={}
		--limpiar balas enemigos
		base.entidades.bullete={}
		--acomodar player
		local ux,uy=base.entidades.player.body:center()
		base.entidades.player.body:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.melee:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.point:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.rx,base.entidades.player.ry=-1,-1
		base.entidades.player.vy=0
		base.entidades.player.l=base.entidades.l

		collectgarbage()
	end

	if key=="p" and not base.entidades.player.fin then
		Gamestate.push(pausa)
	end

	if base.entidades.player.dead and key=="return" then
		base.entidades:clear()
		self.HC.resetHash()
		collectgarbage()
		self:enter()
	end

	
end

function nivel1_2:keyreleased(key)
	base.entidades:keyreleased(key)
end


function nivel1_2:mousepressed(x,y,button)
	local cx,cy=self.cam:toWorld(x,y)
	base.entidades:mousepressed(cx,cy,button)

	--[[if button==2 then

		local ux,uy=base.entidades.player.body:center()
		local ix,iy=self.cam:toWorld(x,y)
		base.entidades.player.body:move(ix-ux,iy-uy)
		base.entidades.player.melee:move(ix-ux,iy-uy)
		base.entidades.player.point:move(ix-ux,iy-uy)
	
	end]]

end

function nivel1_2:setmeteor(dt,x,y,h,w)
	time2=time2+dt

	if time2>3.5 and not base.entidades.player.fin then
		intervalo=not intervalo
		time2=0
	end

	if intervalo then
		time=time+dt
	    -- creacion de meteoros
		if time>5 and not base.entidades.player.fin then
			for i=1,love.math.random(2,5),1 do
				local ex,ey,r,a,s=love.math.random(x,x+h),y-500,50,love.math.random(-15,15),300
				base.entidades:addextra(Meteoro(ex,ey,r,a,s,base.entidades.l),"meteor")
				--collectgarbage()
				time=0
			end
		end
	end
end

function nivel1_2:inicializate_1()
	self.map:resize(love.graphics.getWidth()*2,love.graphics.getHeight()*2)

	for k, object in pairs(self.map.objects) do
        if object.name == "player" then
        	--objeto player
            base.entidades:addactor(Player(object.x,object.y,object.width,object.height,object.properties.l,object.properties.hp))
            break
        end
    end

    for k, object in pairs(self.map.objects) do
    	if object.name == "escalera" then
    		--escalera triangular
    		local x,y=object.x,object.y
    		local t={}
    		for i, p in pairs(object.polygon) do
    			table.insert(t,p.x)
    			table.insert(t,p.y)
    		end
    		--escaleras triangulares
    		base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),d=object.properties.direccion,type="subida",l=2},"object")
    	elseif object.name == "escalera2" then
    		--escalera rectangular
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),type="escalera",l=object.properties.l},"object")
    	elseif object.name == "ascensor" then
    		--objeto ascensor
    		base.entidades:addextra(Ascensor(object.x,object.y,object.width,object.height,object.properties.l,object.properties.val),"dinamic")
    	elseif object.name == "Puerta" then
    		--aqui se coje el id de la puerta
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),id=object.properties.numero,l=object.properties.l},"door")
    	elseif object.name == "baba1" then
    		--enemigo baba1
    		base.entidades:addextra(Baba1(object.x,object.y,object.width,object.height,object.properties.l,object.properties.hp),"enemies")
    	elseif object.name == "punto" then
    		base.entidades:addextra({body=self.HC.point(object.x,object.y),l=object.properties.l},"point")
    	elseif object.name == "Aliados" then
    		base.entidades:addextra(Npc(object.x,object.y,object.width,object.height,2),"npcs")
    	elseif object.name == "arma" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),tipo=object.properties.tipo,l=2,type="arma"},"object")
    	elseif object.name == "vida" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),l=2,type="vida"},"object")
    	elseif object.name == "fin" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),l=object.properties.l},"flags")
    	elseif object.name == "municion" then
    		local mun=0

    		if object.properties.tipo==1 then
    			mun=love.math.random(5,10)
    		elseif object.properties.tipo==2 then
    			mun=love.math.random(5,10)
    		elseif object.properties.tipo==3 then 
    			mun=love.math.random(5,10)
    		elseif object.properties.tipo==4 then
    			mun=love.math.random(25,40)
    		elseif object.properties.tipo==5 then
    			mun=love.math.random(1,2)
    		end

    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),stock=mun,tipo=object.properties.tipo,l=object.properties.l,type="municion"},"object")
    	end
    end

    self:gettiles(1,1)
	self:gettiles(2,1)
	self:gettiles(3,2)
	self:gettiles(4,2)

	self.map:removeLayer("Borrador")

	self:changemap(true,false)
end

function nivel1_2:changemap(v1,v2)
	for i, layer in ipairs(self.map.layers) do
		if i==1 or i==2  then
			layer.visible=v1
		elseif i==3 or i==4  then
			layer.visible=v2
		end
	end
end

function nivel1_2:gettiles(i,s)
	for y=1, self.map.height,1 do
		   for x=1,self.map.width,1 do
		      local tile = self.map.layers[i].data[y][x]
		      if tile then
		      	if tile.properties.col or tile.properties.col=="true" then
	      			local tx,ty=0,0
	      			local og=tile.objectGroup.objects

	      			local t={}
	      			local id=0
	      			for _, o in pairs(og) do
	      				id=o.name
	      				if o.name=="3" then
	      					tx,ty=(x-1)*self.map.tilewidth,(y)*self.map.tileheight
	      				else
	      					tx,ty=(x-1)*self.map.tilewidth,(y-1)*self.map.tileheight
	      				end
	      				for _, p in pairs(o.polygon) do
	      					table.insert(t,tx+p.x)
							table.insert(t,ty+p.y)
			    		end
	      			end

	      			--35 34 36 33

	      			base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),type="inc",l=s,gid=tile.gid,x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,to=32+id},"colli")
	      		elseif tile.properties.liso or tile.properties.liso=="true" then
	      			local tx,ty=0,0
	      			local og=tile.objectGroup.objects

	      			local t={}
	      			local id=0
	      			for _, o in pairs(og) do
	      				id=o.name
	      				if o.name=="3" then
	      					tx,ty=(x-1)*self.map.tilewidth,(y)*self.map.tileheight
	      				else
	      					tx,ty=(x-1)*self.map.tilewidth,(y-1)*self.map.tileheight
	      				end
	      				for _, p in pairs(o.polygon) do
	      					table.insert(t,tx+p.x)
							table.insert(t,ty+p.y)
			    		end
	      			end

		      		base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),type="liso",l=s,gid=tile.gid,x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,to=32+id},"colli")
		      	elseif tile.properties.plat or tile.properties.plat=="true" then
	      			local tx,ty=0,0
	      			local og=tile.objectGroup.objects

	      			local t={}
	      			local id=0
	      			for _, o in pairs(og) do
	      				id=o.name
	      				if o.name=="3" then
	      					tx,ty=(x-1)*self.map.tilewidth,(y)*self.map.tileheight
	      				else
	      					tx,ty=(x-1)*self.map.tilewidth,(y-1)*self.map.tileheight
	      				end
	      				for _, p in pairs(o.polygon) do
	      					table.insert(t,tx+p.x)
							table.insert(t,ty+p.y)
			    		end
	      			end

		      		base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),type="plate",l=s,gid=tile.gid,x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,to=32+id},"colli")
		      	
		      	elseif tile.properties.collidable or tile.properties.collidable=="true" then
		      		base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="col",l=s,to=4},"colli")
		        elseif tile.properties.plataforma or tile.properties.plataforma=="true" then
		        	base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="plat",l=s,to=4},"colli")
		        end
		    end
		end
	end
end


function nivel1_2:sprites()
	sprites["img"]=love.graphics.newImage("assets/img/player.png")
	sprites["player"]=love.graphics.newQuad(0,0,62,74,sprites["img"]:getDimensions())
	sprites["espada"]=love.graphics.newQuad(0,74,80,10,sprites["img"]:getDimensions())
	sprites["bala"]=love.graphics.newQuad(62,0,10,10,sprites["img"]:getDimensions())
	sprites["img2"]=love.graphics.newImage("assets/img/meteoro.png")
	sprites["meteoro"]=love.graphics.newQuad(0,0,60,60,sprites["img2"]:getDimensions())
	sprites["img3"]=love.graphics.newImage("assets/img/babas.png")
	sprites["babas1"]=love.graphics.newQuad(0,0,80,50,sprites["img3"]:getDimensions())
	sprites["img4"]=love.graphics.newImage("assets/img/npc.png")
	sprites["npc"]=love.graphics.newQuad(0,0,62,74,sprites["img4"]:getDimensions())
	sprites["heart"]=love.graphics.newImage("assets/img/heart.png")
	sprites["pheart"]=love.graphics.newQuad(0,0,68,60,sprites["heart"]:getDimensions())
	sprites["gheart"]=love.graphics.newQuad(70,0,68,60,sprites["heart"]:getDimensions())
	sprites["espina"]=love.graphics.newQuad(0,50,12,5,sprites["img3"]:getDimensions())
	sprites["zombie"]=love.graphics.newQuad(80,0,62,74,sprites["img3"]:getDimensions())
end

		

return nivel1_2