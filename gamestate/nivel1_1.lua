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

local nivel1_1 = Class{
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
function nivel1_1:init()
	self:sprites()
	background=love.graphics.newImage("assets/img/background.png")
	city=love.graphics.newImage("assets/img/city.png")
	gh=love.graphics.getWidth()
end


function nivel1_1:enter()
	collectgarbage("stop")
	base.entidades:clear()

	timer=0
	base.init(self,"assets/level/nivel_1_1_1.lua","assets/level/nivel_1_1_2.lua")
	tmw,tmh=self.map.width*self.map.tilewidth,self.map.height*self.map.tileheight
	--mapeados
	self:inicializate_1()
	self:inicializate_2()	

	local layerplayer_1 = self.maps[1].layers["Jugadores"]
	local layerenemigo_1 = self.maps[1].layers["Enemigos"]
	local layerobjetos_1 = self.maps[1].layers["Objetos"]

	local layerplayer_2 = self.maps[2].layers["Jugadores"]
	local layerenemigo_2 = self.maps[2].layers["Enemigos"]
	local layerobjetos_2 = self.maps[2].layers["Objetos"]

	--update

	function layerplayer_1:update(dt)
		if base.entidades.l==1 then
			base.entidades:update_p(dt)
		end
	end

	function layerenemigo_1:update(dt)
		if base.entidades.l==1 then
			base.entidades:update_e(dt)
		end
	end

	function layerobjetos_1:update(dt)
		if base.entidades.l==1 then
			base.entidades:update_o(dt)
		end
	end

	function layerplayer_2:update(dt)
		if base.entidades.l==2 then
			base.entidades:update_p(dt)
		end
	end

	function layerenemigo_2:update(dt)
		if base.entidades.l==2 then
			base.entidades:update_e(dt)
		end
	end

	function layerobjetos_2:update(dt)
		if base.entidades.l==2 then
			base.entidades:update_o(dt)
		end
	end

	--draw

	function layerplayer_1:draw()
		if base.entidades.l==1 then
			base.entidades:draw_p()
		end
	end

	function layerenemigo_1:draw()
		if base.entidades.l==1 then
			base.entidades:draw_e()
		end
	end

	function layerobjetos_1:draw()
		if base.entidades.l==1 then
			base.entidades:draw_o()
		end
	end

	function layerplayer_2:draw()
		if base.entidades.l==2 then
			base.entidades:draw_p()
		end
	end

	function layerenemigo_2:draw()
		if base.entidades.l==2 then
			base.entidades:draw_e()
		end
	end

	function layerobjetos_2:draw()
		if base.entidades.l==2 then
			base.entidades:draw_o()
		end
	end

end



--generar colision cuando este choque con el radio para mayor destruccion

function nivel1_1:update(dt)

	counter=collectgarbage('count')/1000
	--collectgarbage
	--mandar valor a entidades
	if counter >35 then
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
function nivel1_1:draw()
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



	--[[love.graphics.print("arma 1 : " ..  tostring(base.entidades.player.arma[1]) .. " municion 1 : " .. base.entidades.player.municion[1] .. " stock 1 : " .. base.entidades.player.stock[1],20,120)
	love.graphics.print("arma 2 : " ..  tostring(base.entidades.player.arma[2]) .. " municion 2 : " .. base.entidades.player.municion[2] .. " stock 2 : " .. base.entidades.player.stock[2],20,140)
	love.graphics.print("arma 3 : " ..  tostring(base.entidades.player.arma[3]) .. " municion 3 : " .. base.entidades.player.municion[3] .. " stock 3 : " .. base.entidades.player.stock[3],20,160)
	love.graphics.print("arma 4 : " ..  tostring(base.entidades.player.arma[4]) .. " municion 4 : " .. base.entidades.player.municion[4] .. " stock 4 : " .. base.entidades.player.stock[4],20,180)
	love.graphics.print("arma 5 : " ..  tostring(base.entidades.player.arma[5]) .. " municion 5 : " .. base.entidades.player.municion[5] .. " stock 5 : " .. base.entidades.player.stock[5],20,200)
	]]
	--love.graphics.print(,20,250)
	
		local stats = love.graphics.getStats()
	 
	    local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
	    love.graphics.print("debug",1200,10)
	    love.graphics.print(str, 1200, 30)
		love.graphics.print('Memory actually used (in kB): ' .. counter, 1200,50)
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1200, 70)
		--love.graphics.print(tostring( intervalo ),500,500)
		
		
		--debug
		--[[love.graphics.print("Ground : " .. tostring(player.ground),100,100)
		love.graphics.print("Is jump : " .. tostring(player.isjump),100,150)
		love.graphics.print("Subida : " .. tostring(player.subida),100,200)
		love.graphics.print("Escalada : " .. tostring(player.escalar),100,250)
		love.graphics.print("Plataforma : " .. tostring(player.isplatformer),100,300)
		love.graphics.print("velocidad y: " .. player.vy,200,100 )
		love.graphics.print("vida : " .. player.hp,300,200 )
		love.graphics.print("angulo mr : " .. math.deg(player.mr),300,300 )]]

	love.graphics.setColor(1, 1, 1)
end

function nivel1_1:keypressed(key)
	base.entidades:keypressed(key)

	if key=="e" and base.entidades.player.ischange then
		--cambio de fase
		if base.entidades.l==1 then
			base.entidades.l=2
		else
			base.entidades.l=1
		end
		--limpiar balas
		base.entidades.bullet={}
		--acomodar player
		local ux,uy=base.entidades.player.body:center()
		base.entidades.player.body:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.melee:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.point:move(base.entidades.player.rx-ux,base.entidades.player.ry-uy)
		base.entidades.player.rx,base.entidades.player.ry=-1,-1
		base.entidades.player.vy=0
		base.entidades.player.l=base.entidades.l

		collectgarbage()

		self.map=self.maps[base.entidades.l]
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

function nivel1_1:keyreleased(key)
	base.entidades:keyreleased(key)
end


function nivel1_1:mousepressed(x,y,button)
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

function nivel1_1:setmeteor(dt,x,y,h,w)
	time2=time2+dt

	if time2>3.5 and not base.entidades.player.fin then
		intervalo=not intervalo
		time2=0
	end

	if intervalo then
		time=time+dt
	    -- creacion de meteoros
		if time>2 and not base.entidades.player.fin then
			for i=1,love.math.random(4,7),1 do
				local ex,ey,r,a,s=love.math.random(x,x+h),y-500,50,love.math.random(-15,15),300
				base.entidades:addextra(Meteoro(ex,ey,r,a,s,base.entidades.l),"meteor")
				--collectgarbage()
				time=0
			end
		end
	end
end

function nivel1_1:inicializate_1()
	self.maps[1]:resize(love.graphics.getWidth()*2,love.graphics.getHeight()*2)

	for k, object in pairs(self.maps[1].objects) do
        if object.name == "player" then
        	--objeto player
            base.entidades:addactor(Player(object.x,object.y,object.width,object.height,1,object.properties.hp))
            break
        end
    end

    for k, object in pairs(self.maps[1].objects) do
    	if object.name == "Puerta" then
    		--aqui se coje el id de la puerta
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),id=object.properties.numero,l=1},"door")
    	elseif object.name == "baba1" then
    		--enemigo baba1
    		base.entidades:addextra(Baba1(object.x,object.y,object.width,object.height,1,object.properties.hp),"enemies")
    	elseif object.name == "punto" then
    		base.entidades:addextra({body=self.HC.point(object.x,object.y),l=1},"point")
    	elseif object.name == "fin" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),l=1},"flags")
    	end
    end

    local layer = self.maps[1].layers[1]

	for y=1, self.map.height,1 do
	   for x=1,self.map.width,1 do
	      local tile = layer.data[y][x]
	      if tile then
	      	if tile.properties.col or tile.properties.col=="true" then
      			local tx,ty=0,0
      			local og=tile.objectGroup.objects

      			local t={}

      			for _, o in pairs(og) do
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

      			base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),type="inc",l=1,gid=tile.gid},"colli")
      		elseif tile.properties.liso or tile.properties.liso=="true" then
      			local tx,ty=0,0
      			local og=tile.objectGroup.objects

      			local t={}

      			for _, o in pairs(og) do
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

	      		base.entidades:addextra({body=self.HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),type="liso",l=1,gid=tile.gid},"colli")
	      	elseif tile.properties.collidable or tile.properties.collidable=="true" then
	      		base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="col",l=1},"colli")
	        elseif tile.properties.plataforma or tile.properties.plataforma=="true" then
	        	base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="plat",l=1},"colli")
	        end
	      end
	   end
	end

	self.maps[1]:removeLayer("Borrador")
end

function nivel1_1:inicializate_2()
	self.maps[2]:resize(love.graphics.getWidth()*2,love.graphics.getHeight()*2)

    for k, object in pairs(self.maps[2].objects) do
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
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),type="escalera",l=2},"object")
    	elseif object.name == "ascensor" then
    		--objeto ascensor
    		base.entidades:addextra(Ascensor(object.x,object.y,object.width,object.height,2),"dinamic")

    	elseif object.name == "Puerta" then
    		--aqui se coje el id de la puerta
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),id=object.properties.numero,l=2},"door")
    	elseif object.name == "punto" then
    		base.entidades:addextra({body=self.HC.point(object.x,object.y),l=2},"point")
    	elseif object.name == "Aliados" then
    		base.entidades:addextra(Npc(object.x,object.y,object.width,object.height,2),"npcs")
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

    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),stock=mun,tipo=object.properties.tipo,l=2,type="municion"},"object")
    	elseif object.name == "arma" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),tipo=object.properties.tipo,l=2,type="arma"},"object")
    	elseif object.name == "vida" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),l=2,type="vida"},"object")
    	elseif object.name == "fin" then
    		base.entidades:addextra({body=self.HC.rectangle(object.x,object.y,object.width,object.height),l=2},"flags")
    	end
    end

    local layer = self.maps[2].layers[1]

	for y=1, self.map.height,1 do
	   for x=1,self.map.width,1 do
	      local tile = layer.data[y][x]
	      if tile then
	      	if tile.properties.collidable or tile.properties.collidable=="true" then
	      		base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="col",l=2},"colli")
	        elseif tile.properties.plataforma or tile.properties.plataforma=="true" then
	        	base.entidades:addextra({body=self.HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="plat",l=2},"colli")
	        end
	      end
	   end
	end

	self.maps[2]:removeLayer("Borrador")

end

function nivel1_1:sprites()
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

		

return nivel1_1