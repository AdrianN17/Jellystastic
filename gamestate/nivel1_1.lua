local Gamestate = require "libs.gamestate"
local base = require "gamestate.base"
local Class = require "libs.class"
local sti= require "libs.sti"
local gamera = require "libs.gamera"
local Player= require "entidades.player"
local Meteoro = require "entidades.meteoro"
local Ascensor = require "entidades.ascensor"
local Baba1 = require "entidades.baba_1"
local Npc = require "entidades.npc"
local HC = require "libs.HC"
local Zombie = require "entidades.zombie"
local pausa = require "gamestate.pausa"
local Explosion = require "entidades.explosion"
local nivel1_1 = Class{
	__includes = base
}
local scale=0.65
local xc,yc,hc,wc=0,0,0,0
local time=0
local background=nil
local city=nil
local timer=0
local tmw,tmh=0,0
local backgroundPosition=0
local gh=0
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
	self.cam=gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
	tmw,tmh=self.map.width*self.map.tilewidth,self.map.height*self.map.tileheight
	self.cam:setScale(scale)
	--mapeados
	nivel1_1:inicializate_1()
	nivel1_1:inicializate_2()	

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

	local x,y,h,w=0,0,0,0
	x,y,h,w=xc-100,yc-100,hc+200,wc+200
	--limitar los movimientos de los demas
	base.entidades:setcamera(x,y,h,w)
	self.map:update(dt)
	self.cam:setPosition(base.entidades.player.ox, base.entidades.player.oy)

	time=time+dt
	-- creacion de meteoros
	if time>5 and not base.entidades.player.fin then
		for i=1,love.math.random(4,7),1 do
			local ex,ey,r,a,s=love.math.random(x,x+h),y-500,50,love.math.random(-15,15),400
			base.entidades:addextra(Meteoro(ex,ey,r,a,s,base.entidades.l),"meteor")
			--collectgarbage()
			time=0
		end
	end

	-- iterador de paredes

	for _,col in pairs(base.entidades.colli) do
		if col.l==base.entidades.l and col.ox>x and col.ox<x+h and col.oy>y and col.oy<y+w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=base.entidades.player.body:collidesWith(col.body)--player pared
			--base.entidades.player.ox
			if col.type=="col" and colli then
				--print(dx,dy)
				if dy<0 and dx==0 then
					base.entidades.player.ground=true
					base.entidades.player.body:move(0,dy/2)
					base.entidades.player.melee:move(0,dy/2)
					base.entidades.player.point:move(0,dy/2)
					base.entidades.player.vy=0
				elseif dy>0 and dx==0 then
						base.entidades.player.vy=base.entidades.player.vy/2
						base.entidades.player.body:move(0,dy*1.2)
						base.entidades.player.melee:move(0,dy*1.2)
						base.entidades.player.point:move(0,dy*1.2)
				elseif dx~=0 then 
					if dx<0 then
						base.entidades.player.moveleft=false
						base.entidades.player.body:move(math.min(dx*1.2,5),0)
						base.entidades.player.melee:move(math.min(dx*1.2,5),0)
						base.entidades.player.point:move(math.min(dx*1.2,5),0)
					elseif dx>0 then
						base.entidades.player.moveright=false
						base.entidades.player.body:move(math.max(dx*1.2,-5),0)
						base.entidades.player.melee:move(math.max(dx*1.2,-5),0)
						base.entidades.player.point:move(math.max(dx*1.2,-5),0)
					end
				end
			elseif not base.entidades.player.ignore2 and col.type=="plat" and colli then
				if dy<0 then
					base.entidades.player.ground=true
					base.entidades.player.isplatformer=true
					base.entidades.player.vy=0
					base.entidades.player.body:move(dx,dy/10)
					base.entidades.player.melee:move(dx,dy/10)
					base.entidades.player.point:move(dx,dy/10)
				end
			end
		end
			
		--[[for _, en in pairs(base.entidades.npcs) do
			if col.l==en.l and en.l==base.entidades.l and en.ox>x and en.ox<x+h and en.oy>y and en.oy<y+w and col.ox>x and col.ox<x+h and col.oy>y and col.oy<y+w then
				--para cada entidad (enemigos, aliados y jugador)
				local dx,dy,colli=0,0,false
				colli,dx,dy=en.body:collidesWith(col.body)--collision pared personaje
				if col.type=="col" and colli and not en.ground then
					if dy<0 then --and dx==0 then
						en.ground=true
						en.body:move(0,dy)
						en.vy=0
					end
				elseif not colli then
					en.ground=false
				end
			end
		end]]

		for _, bu in pairs(base.entidades.bullet) do
			if col.l==bu.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bu.body:collidesWith(col.body)--collision bala pared
				if colli and col.type =="col" then
					if bu.damage==4 then
						

						--pcall (self:deletetiled(col.x,col.y,col.gid,base.entidades.l,4),"error")
						base.entidades:removeextra(col,"colli")
						HC.remove(col.body)

						base.entidades:addextra(Explosion(bu.ox,bu.oy,bu.l),"explosion")
					end
					bu.hp=bu.hp-1
				end
			end
		end

		for _, bue in pairs(base.entidades.bullete) do
			if col.l==bue.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bue.body:collidesWith(col.body)--collision bala pared
				if colli then
					bue.hp=bue.hp-1
				end
			end
		end


		for _, me in pairs(base.entidades.meteor) do
			if me.l==col.l then
				--para cada meteoro
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(col.body)--collision meteoro pared
				if colli then
					pcall (self:deletetiled(col.x,col.y,col.gid,base.entidades.l,4),"error2")
					HC.remove(col.body)
					--table.remove(base.entidades.colli,c)
					base.entidades:removeextra(col,"colli")
					me.hp=me.hp-1
				end
			end
		end

		for _, ene in pairs(base.entidades.enemies) do
			if col.l==ene.l and ene.l==base.entidades.l and ene.ox>x and ene.ox<x+h and ene.oy>y and ene.oy<y+w and col.ox>x and col.ox<x+h and col.oy>y and col.oy<y+w then
				-- para cada enemigo
				local dx,dy,colli=0,0,false
				colli,dx,dy=ene.body:collidesWith(col.body)--collision pared enemigo
				if  colli then
					ene.move=true
					if dy<0 then
						ene.ground=true
						ene.body:move(dx/5,dy/5)
					end
				end
			end
		end

		for _, ex in pairs(base.entidades.explosion) do
			if col.l==ex.l and ex.l==base.entidades.l and col.ox>x and col.ox<x+h and col.oy>y and col.oy<y+w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(col.body)--collision pared explosion
				if colli then
					pcall (self:deletetiled(col.x,col.y,col.gid,base.entidades.l,4),"error2")
					HC.remove(col.body)
					base.entidades:removeextra(col,"colli")
				end
			end
		end
	end

	-- iterador de objetos

	for _,obj in pairs(base.entidades.object) do
		if obj.l==base.entidades.l and obj.ox>x and obj.ox<x+h and obj.oy>y and obj.oy<y+w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=base.entidades.player.body:collidesWith(obj.body)--collision objeto player
			if obj.type=="subida" and not base.entidades.player.ignore  and colli then
				if  (dy<0 and dx>0 and obj.d==1) or (dy<0 and dx<0 and obj.d==0)  then
					base.entidades.player.subida=true
					base.entidades.player.ground=true
					base.entidades.player.body:move(dx,dy)
					base.entidades.player.melee:move(dx,dy)
					base.entidades.player.point:move(dx,dy)
					base.entidades.player.vy=0
				end
			elseif obj.type=="escalera" and colli then
				base.entidades.player.escalar=true
			elseif obj.type=="puerta" and colli then
				base.entidades.player.ischange=true
				base.entidades.player.rx,base.entidades.player.ry=obj.body:center()
			elseif obj.type=="municion" and colli and base.entidades.player.arma[obj.tipo] then
				-- si la municion actual + municion agregada es menor al max de municion
				if base.entidades.player.municion[obj.tipo]+obj.stock< base.entidades.player.maxmuni[obj.tipo] then
					base.entidades.player.municion[obj.tipo]=base.entidades.player.municion[obj.tipo]+obj.stock
					obj.stock=0
					HC.remove(obj.body)
					base.entidades:removeextra(obj,"object")
					--table.remove(base.entidades.object,o)
				else
					--coger la diferencia y agregarla al usuario y disminuirla al stock del paquete
					local muni=base.entidades.player.maxmuni[obj.tipo]-base.entidades.player.municion[obj.tipo]
					base.entidades.player.municion[obj.tipo]=base.entidades.player.municion[obj.tipo]+muni
					obj.stock=obj.stock-muni
				end
			elseif obj.type=="arma" and colli then
				base.entidades.player.arma[obj.tipo]=true
				HC.remove(obj.body)
				base.entidades:removeextra(obj,"object")
				--table.remove(base.entidades.object,o)
			elseif obj.type=="vida" and colli then
				base.entidades.player.maxhp=base.entidades.player.maxhp+2
				base.entidades.player.hi=2
				HC.remove(obj.body)
				base.entidades:removeextra(obj,"object")
			end
		end 

		for _, me in pairs(base.entidades.meteor) do
			if obj.l==me.l and me.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(obj.body)--collision objetos meteoro
				if colli then
					if obj.id==nil then
						HC.remove(obj.body)
						--table.remove(base.entidades.object,o)
						base.entidades:removeextra(obj,"object")
					else
						--para borrar ambas puertas, lado 1 y 2
						for _, de in pairs(base.entidades.object) do
							if de.id==obj.id then
								HC.remove(de.body)
								base.entidades:removeextra(de,"object")
								--table.remove(base.entidades.object,d)
							end
						end
					end
					me.hp=me.hp-1
				end
			end
		end
	end

	-- iterador de meteoro

	for _, me in pairs(base.entidades.meteor) do
		for _, bu in pairs(base.entidades.bullet) do
			if me.l==bu.l and me.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(bu.body)--collision bala meteoro
				if colli then
					bu.hp=bu.hp-1
					me.hp=me.hp-1
				end
			end
		end

		for _, en in pairs(base.entidades.npcs) do
			if me.l==en.l and en.l==base.entidades.l and en.ox>x-1000 and en.ox<x+h+1000 and en.oy>y-1000 and en.oy<y+w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(en.body)-- collision npc meteoro
				if colli then
					en.hp=en.hp-5
				end
			end
		end
	end

	--iterador objetos dinamicos

	for d, di in pairs(base.entidades.dinamic) do
		if di.l==base.entidades.l and di.ox>x and di.ox<x+h and di.oy>y and di.oy<y+w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=base.entidades.player.body:collidesWith(di.body) --collision player ascensor
			if not base.entidades.player.ignore3 and di.type=="ascensor" and colli then
				if dy<0 then
					base.entidades.player.isascensor=true
					base.entidades.player.ground=true
					base.entidades.player.body:move(dx,dy*2)
					base.entidades.player.melee:move(dx,dy*2)
					base.entidades.player.point:move(dx,dy*2)
					base.entidades.player.vy=0
				end
			end
		end

		for _, me in pairs(base.entidades.meteor) do
			if di.l==me.l and me.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(di.body) --collision meteoro dinamico
				if colli then
					HC.remove(di.body)
					--table.remove(base.entidades.dinamic,d)
					base.entidades:removeextra(di,"dinamic")
					me.hp=me.hp-1
				end
			end
		end

		for _, po in pairs(base.entidades.point) do
			if po.l==di.l and po.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=di.body:collidesWith(po.body) --collsion punto dinamico
				if colli then
					di.body:move(dx,dy*2)
					di.vy=di.vy*-1
				end
			end
		end
	end	

	-- iterador enemigos

	for _, ene in pairs(base.entidades.enemies) do
		if ene.l==base.entidades.l and ene.ox<x+h and ene.oy>y and ene.oy<y+w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=base.entidades.player.body:collidesWith(ene.body)--collision player enemigo
			if colli and not base.entidades.player.immunity then
				base.entidades.player.hp=base.entidades.player.hp-ene.damage*0.5
				base.entidades.player.immunity=true
				if base.entidades.player.friend>0 and not base.entidades.player.dead then
					base.entidades.player.friend=base.entidades.player.friend-1
					--insertar zombies
					base.entidades:addextra(Zombie(ene.ox,ene.oy,62,74,ene.l),"enemies")
				end
			end
			local ex,ey,colli2=0,0,false
			colli2,ex,ey=base.entidades.player.melee:collidesWith(ene.body)-- collision espada enemigo
			if base.entidades.player.attack and colli2 and not ene.immunity then
				ene.jump=true
				ene.move=false
				ene.immunity=true
				ene.isjump=true
				ene.hp=ene.hp-base.entidades.player.mdamage*ene.defense
				ene.timea=0
			end
		end


		for _, ex in pairs(base.entidades.explosion) do
			if ene.l==base.entidades.l and ene.ox<x+h and ene.oy>y and ene.oy<y+w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(ene.body)

				if colli then
					ene.hp=ene.hp-ex.damage*(ene.defense/2)
				end
			end
		end

		--[[for e, en in pairs(base.entidades.npcs) do
			if ene.l==en.l and ene.l==base.entidades.l and en.ox>x and en.ox<x+h and en.oy>y and en.oy<y+w and ene.ox>x and ene.ox<x+h and ene.oy>y and ene.oy<y+w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=en.body:collidesWith(ene.body)--collision npc enemigo
				if colli and not en.immunity then
					if en.hp-ene.damage <1 then
						--insertar zombie
					end
					en.hp=en.hp-ene.damage
					en.immunity=true
				end
			end
		end]]

		for _, bu in pairs(base.entidades.bullet) do
			if bu.l==ene.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ene.body:collidesWith(bu.body)--collision enemigo bala
				if bu.damage~=4 and colli then
					bu.hp=bu.hp-1
					ene.hp=ene.hp-bu.damage
				end
			end
		end

		for _, po in pairs(base.entidades.point) do
			if ene.l==po.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ene.body:collidesWith(po.body)--collision enemigo punto
				if colli and not ene.istouch then
					ene.istouch=true
					ene.body:move(dx*4,dy)
					ene.vx=-ene.vx
				end
			end
		end
	end	

	--iterador npc
	for _, en in pairs(base.entidades.npcs) do
		if en.l==base.entidades.l and en.ox>x-1000 and en.ox<x+h+1000 and en.oy>y-1000 and en.oy<y+w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=base.entidades.player.body:collidesWith(en.body)-- collision aliado player
			if colli then
				base.entidades.player.friend=base.entidades.player.friend+en:save()
				if base.entidades.player.hp<base.entidades.player.maxhp then
					base.entidades.player.hp=base.entidades.player.hp+0.5
				end
			end
		end

		for _, ex in pairs(base.entidades.explosion) do
			if en.l==base.entidades.l and en.ox>x-1000 and en.ox<x+h+1000 and en.oy>y-1000 and en.oy<y+w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(en.body)-- collision aliado explosion
				if colli then
					en.hp=en.hp-ex.damage
				end
			end
		end

		--[[for b, bue in pairs(base.entidades.bullete) do
			if en.l==bue.l and en.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bue.body:collidesWith(en.body)--collision bala enemigo - aliado
				if colli then
					if en.hp-bue.damage<1 then
						--transformar a zombie
					end
					en.hp=en.hp-bue.damage
				end
			end
		end]]
	end

	--iterador bullet enemigo
	for _, bue in pairs(base.entidades.bullete) do
		if base.entidades.l==bue.l then
			local dx,dy,colli=0,0,false
			colli,dx,dy=bue.body:collidesWith(base.entidades.player.body)-- collision bala enemigo - player
			if colli then
				bue.hp=bue.hp-1
				base.entidades.player.hp=base.entidades.player.hp-bue.damage*0.5
			end
			local cx,cy,colli2=0,0,false
			colli2,cx,cy=bue.body:collidesWith(base.entidades.player.melee)
			if colli2 then
				bue.hp=bue.hp-1
			end
		end

		for _, bu in pairs(base.entidades.bullet) do
			if bu.l==bue.l and bue.l==base.entidades.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bue.body:collidesWith(bu.body)
				if colli then
					bu.hp=bu.hp-1
					bue.hp=bue.hp-1
				end
			end
		end
	end

	for _, f in pairs(base.entidades.flags) do
		if base.entidades.l==f.l then
			if f.body:collidesWith(base.entidades.player.body) then
				
				base.entidades.player.fin=true
				HC.remove(f.body)
				base.entidades:removeextra(f,"flags")
				
			end
		end
	end
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
	self.map:draw(-xc,-yc,scale,scale)
	--vida del jugador
	love.graphics.draw(sprites["heart"],sprites[base.entidades.player.h[base.entidades.player.hi]],10,25)
	love.graphics.print(math.max(base.entidades.player.hp*10,0) .. " %",20,40,0,1.5,1.5)
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
	love.graphics.setColor(0, 0, 0)
		local stats = love.graphics.getStats()
	 
	    local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
	    love.graphics.print("debug",1200,10)
	    love.graphics.print(str, 1200, 30)
		love.graphics.print('Memory actually used (in kB): ' .. counter, 1200,50)
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 1200, 70)

		
		
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

	if key=="p" then
		Gamestate.push(pausa)
	end

	if base.entidades.player.dead and key=="return" then
		base.entidades:clear()
		HC.resetHash()
		collectgarbage()
		self:enter()
	end

end

function nivel1_1:keyreleased(key)
	base.entidades:keyreleased(key)
end

function nivel1_1:deletetiled(tx,ty,gid,c,id)
	for i, ti in ipairs(self.maps[c].tileInstances[gid]) do
		if ti ~=nil then
			if ti.x == tx and ti.y==ty then
				ti.batch:set(ti.id, self.maps[c].tiles[id].quad,tx,ty)
				break
			end
		end
	end
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
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),id=object.properties.numero,type="puerta",l=1},"object")
    	elseif object.name == "baba1" then
    		--enemigo baba1
    		base.entidades:addextra(Baba1(object.x,object.y,object.width,object.height,1,object.properties.hp),"enemies")
    	elseif object.name == "punto" then
    		base.entidades:addextra({body=HC.point(object.x,object.y),l=1},"point")
    	elseif object.name == "fin" then
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),l=1},"flags")
    	end
    end

    local layer = self.maps[1].layers[1]

	for y=1, 220,1 do
	   for x=1,251,1 do
	      local tile = layer.data[y][x]
	      if tile then
	      	if tile.properties.collidable or tile.properties.collidable=="true" then
	      		base.entidades:addextra({body=HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="col",l=1},"colli")
	        elseif tile.properties.plataforma or tile.properties.plataforma=="true" then
	        	base.entidades:addextra({body=HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="plat",l=1},"colli")
	        end
	      end
	   end
	end

	self.maps[1]:removeLayer(2)
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
    		base.entidades:addextra({body=HC.polygon(t[1],t[2],t[3],t[4],t[5],t[6]),d=object.properties.direccion,type="subida",l=2},"object")
    	elseif object.name == "escalera2" then
    		--escalera rectangular
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),type="escalera",l=2},"object")
    	elseif object.name == "ascensor" then
    		--objeto ascensor
    		base.entidades:addextra(Ascensor(object.x,object.y,object.width,object.height,2),"dinamic")

    	elseif object.name == "Puerta" then
    		--aqui se coje el id de la puerta
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),id=object.properties.numero,type="puerta",l=2},"object")
    	elseif object.name == "punto" then
    		base.entidades:addextra({body=HC.point(object.x,object.y),l=2},"point")
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

    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),stock=mun,tipo=object.properties.tipo,l=2,type="municion"},"object")
    	elseif object.name == "arma" then
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),tipo=object.properties.tipo,l=2,type="arma"},"object")
    	elseif object.name == "vida" then
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),l=2,type="vida"},"object")
    	elseif object.name == "fin" then
    		base.entidades:addextra({body=HC.rectangle(object.x,object.y,object.width,object.height),l=2},"flags")
    	end
    end

    local layer = self.maps[2].layers[1]

	for y=1, 220,1 do
	   for x=1,251,1 do
	      local tile = layer.data[y][x]
	      if tile then
	      	if tile.properties.collidable or tile.properties.collidable=="true" then
	      		base.entidades:addextra({body=HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="col",l=2},"colli")
	        elseif tile.properties.plataforma or tile.properties.plataforma=="true" then
	        	base.entidades:addextra({body=HC.rectangle((x-1)*self.map.tilewidth,(y-1)*self.map.tileheight,self.map.tilewidth,self.map.tileheight),x=(x-1)*self.map.tilewidth,y=(y-1)*self.map.tileheight,gid=tile.gid,type="plat",l=2},"colli")
	        end
	      end
	   end
	end

	self.maps[2]:removeLayer(2)

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