

local entidades = {
	personajes = {},
	colli={},
	object={},
	meteor={},
	dinamic={},
	bullet={},
	enemies={},
	point={},
	bullete={},
	l=1,
	player=nil,
	x=0,y=0,h=0,w=0,
	maps={},
	explosion={},
	flags={},
	HC={},
	door={}
}

function entidades:enter(maps,HC)
	self.maps=maps
	self.HC=HC
end



function entidades:addactor(e)
	self.player=e
end

function entidades:removeactor(e)
	self.player=nil
end

function entidades:clear()
	self.npcs={}
	self.colli={}
	self.object={}
	self.meteor={}
	self.dinamic={}
	self.bullet={}
	self.enemies={}
	self.point={}
	self.bullete={}
	self.explosion={}
	self.l=1
	self.player=nil
	self.x=0
	self.y=0
	self.h=0
	self.w=0
	self.maps={}
	self.flags={}
	self.door={}
	
end

function entidades:addextra(e,select)
	if select=="colli" then
		local x,y=e.body:center()
		e.ox=x
		e.oy=y
		table.insert(self.colli,e)
	elseif select=="object" then
		local x,y=e.body:center()
		e.ox=x
		e.oy=y
		table.insert(self.object,e)
	elseif select=="meteor" then
		table.insert(self.meteor,e)
	elseif select=="dinamic" then
		table.insert(self.dinamic,e)
	elseif select=="bullet" then
		table.insert(self.bullet,e)
	elseif select=="enemies" then
		table.insert(self.enemies,e)
	elseif select=="point" then
		table.insert(self.point,e)
	elseif select=="npcs" then
		table.insert(self.npcs,e)
	elseif select=="bullete" then
		table.insert(self.bullete,e)
	elseif select=="flags" then
		table.insert(self.flags,e)
	elseif select=="explosion" then
		table.insert(self.explosion,e)
	elseif select=="door" then
		local x,y=e.body:center()
		e.ox=x
		e.oy=y
		table.insert(self.door,e)
	end
end

function entidades:removeextra(e,select)
	if select=="colli" then
		for i , en in ipairs(self.colli) do
			if en==e then
				table.remove(self.colli,i)
				return
			end
		end
	elseif select=="object" then
		for i , en in ipairs(self.object) do
			if en==e then
				table.remove(self.object,i)
				return
			end
		end
	elseif select=="meteor" then
		for i , en in ipairs(self.meteor) do
			if en==e then
				table.remove(self.meteor,i)
				return
			end
		end
	elseif select=="dinamic" then
		for i, en in ipairs(self.dinamic) do
			if en==e then
				table.remove(self.dinamic,i)
				return
			end
		end
	elseif select=="bullet" then
		for i, en in ipairs(self.bullet) do
			if en==e then
				table.remove(self.bullet,i)
				return
			end
		end
	elseif select=="enemies" then
		for i, en in ipairs(self.enemies) do
			if en==e then
				table.remove(self.enemies,i)
				return
			end
		end
	elseif select=="point" then
		for i, en in ipairs(self.point) do
			if en==e then
				table.remove(self.point,i)
				return
			end
		end
	elseif select=="npcs" then
		for i, en in ipairs(self.npcs) do
			if en==e  then
				table.remove(self.npcs,i)
				return
			end
		end
	elseif select=="bullete" then
		for i, en in ipairs(self.bullete) do
			if en==e  then
				table.remove(self.bullete,i)
				return
			end
		end
	elseif select=="flags" then
		for i, en in ipairs(self.flags) do
			if en==e  then
				table.remove(self.flags,i)
				return
			end
		end
	elseif select=="explosion" then
		for i, en in ipairs(self.explosion) do
			if en==e  then
				table.remove(self.explosion,i)
				return
			end
		end
	elseif select=="door" then
		for i, en in ipairs(self.door) do
			if en==e  then
				table.remove(self.door,i)
				return
			end
		end
	end
end

--draw()

function entidades:draw_p()
	for i, e in ipairs(self.bullet) do
		if e.l==self.l then
			e:draw()
		end
	end

	--[[for i, e in ipairs(self.colli) do
		if e.l==self.l then
			e.body:draw("fill")
		end
	end]]

	for i, e in ipairs(self.npcs)  do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e:draw()
		end
	end

	self.player:draw()
end

function entidades:draw_o()
	love.graphics.setColor(0.5, 0.6, 0.6)

	for i, e in ipairs(self.door) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e.body:draw("fill")
		end
	end

	love.graphics.setColor(1, 1, 1)
	
	for i, e in ipairs(self.object) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			if e.type=="arma" then
				love.graphics.setColor(0.5, 0.8, 0.3)
			elseif e.type=="municion" then
				love.graphics.setColor(0.2, 0.3, 0.2)
			elseif e.type=="vida" then
				love.graphics.setColor(1, 0.8, 0.2)
			else
				love.graphics.setColor(0.5, 0.5, 0.5)
			end
			e.body:draw("fill")
		end
	end

	love.graphics.setColor(1, 1, 1)

	for i, e in ipairs(self.dinamic) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e:draw()
		end
	end
end

function entidades:draw_e()
	for i, e in ipairs(self.explosion) do
		if e.l==self.l then
			e:draw()
		end
	end

	for i, e in ipairs(self.meteor) do
		if e.l==self.l then
			e:draw()
		end
	end

	for i, e in ipairs(self.bullete) do
		if e.l==self.l then
			e:draw()
		end
	end

	for i, e in ipairs(self.enemies) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then --and self.y and self.y then
			e:draw()
		end
	end
end

--update()

function entidades:update_p(dt)
	for i, e in ipairs(self.bullet) do
		if e.l==self.l then
			e:update(dt)
		end
	end

	self.player:update(dt)

	for i, e in ipairs(self.npcs) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e:update(dt)
		end
	end

end

function entidades:update_o(dt)
	for i, e in ipairs(self.dinamic) do
		if e.l==self.l and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e:update(dt)
		end
	end
end

function entidades:update_e(dt)
	for i, e in ipairs(self.explosion) do
		if e.l==self.l then
			e:update(dt)
		end
	end
	
	for i, e in ipairs(self.meteor) do
		if e.l==self.l then
			e:update(dt)
		end
	end

	for i, e in ipairs(self.bullete) do
		if e.l==self.l then
			e:update(dt)
		end
	end

	for i, e in ipairs(self.enemies) do
		if e.l==self.l  and e.ox>self.x and e.ox<self.h and e.oy>self.y and e.oy<self.w then
			e:update(dt)
		end
	end
end

function entidades:keypressed(key)
	self.player:keypressed(key)
end

function entidades:keyreleased(key)
	self.player:keyreleased(key)
end

function entidades:mousepressed(x, y, button)
	self.player:mousepressed(x, y, button)
end

function entidades:mousereleased(x, y, button)
	self.player:mousereleased(x, y, button)
end



function entidades:setcamera(x,y,h,w)
	self.x,self.y,self.h,self.w=x,y,x+h,y+w
end

function entidades:pos()
	return self.x,self.y,self.h,self.w
end

function entidades:collisions()
	-- iterador de paredes
	for _,col in ipairs(self.colli) do
		if col.l==self.l and col.ox>self.x and col.ox<self.h and col.oy>self.y and col.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(col.body)--player pared
			--self.player.ox
			if col.type=="col" and colli then
				--print(dx,dy)
				if dy<0 and dx==0 then
					self.player.ground=true
					self.player.body:move(0,dy/2)
					self.player.melee:move(0,dy/2)
					self.player.point:move(0,dy/2)
					self.player.vy=0
				elseif dy>0 and dx==0 then
						self.player.vy=self.player.vy/2
						self.player.body:move(0,dy*1.2)
						self.player.melee:move(0,dy*1.2)
						self.player.point:move(0,dy*1.2)
				elseif dx~=0 then 
					if dx<0 then
						self.player.moveleft=false
						self.player.body:move(math.min(dx*1.2,5),0)
						self.player.melee:move(math.min(dx*1.2,5),0)
						self.player.point:move(math.min(dx*1.2,5),0)
					elseif dx>0 then
						self.player.moveright=false
						self.player.body:move(math.max(dx*1.2,-5),0)
						self.player.melee:move(math.max(dx*1.2,-5),0)
						self.player.point:move(math.max(dx*1.2,-5),0)
					end
				end
			elseif not self.player.ignore2 and col.type=="plat" and colli then
				if dy<0 then
					self.player.ground=true
					self.player.isplatformer=true
					self.player.vy=0
					self.player.body:move(dx,dy/10)
					self.player.melee:move(dx,dy/10)
					self.player.point:move(dx,dy/10)
				end
			elseif col.type=="inc" and colli then
				if dy<0 then
					self.player.ground=true
					self.player.body:move(dx,dy)
					self.player.melee:move(dx,dy)
					self.player.point:move(dx,dy)
					self.player.vy=0
				elseif dy>0  then
					self.player.vy=self.player.vy/2
					self.player.body:move(0,dy*1.2)
					self.player.melee:move(0,dy*1.2)
					self.player.point:move(0,dy*1.2)
				end
			elseif col.type=="liso" and colli then
				if dy<0 then
					self.player.ground=true
					self.player.body:move(dx*7,dy/2)
					self.player.melee:move(dx*7,dy/2)
					self.player.point:move(dx*7,dy/2)

					self.player.moveleft=false
					self.player.moveright=false

				elseif dy>0  then
					self.player.vy=self.player.vy/2
					self.player.body:move(0,dy*1.2)
					self.player.melee:move(0,dy*1.2)
					self.player.point:move(0,dy*1.2)
				end
			end
		end

		--[[for _, en in ipairs(base.entidades.npcs) do
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
			
		for _, bu in ipairs(self.bullet) do
			if col.l==bu.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bu.body:collidesWith(col.body)--collision bala pared
				if colli and col.type =="col" then
					if bu.damage==4 then
						

						--pcall (self:deletetiled(col.x,col.y,col.gid,self.l,4),"error")
						self:removeextra(col,"colli")
						self.HC.remove(col.body)

						bu:change()
					end
					bu.hp=bu.hp-1
				end
			end
		end

		for _, bue in ipairs(self.bullete) do
			if col.l==bue.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bue.body:collidesWith(col.body)--collision bala pared
				if colli then
					bue.hp=bue.hp-1
				end
			end
		end


		for _, me in ipairs(self.meteor) do
			if me.l==col.l then
				--para cada meteoro
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(col.body)--collision meteoro pared
				if colli then
					pcall (self:deletetiled(col.x,col.y,col.gid,self.l,4),"error2")
					self.HC.remove(col.body)
					--table.remove(self.colli,c)
					self:removeextra(col,"colli")
					me.hp=me.hp-1
				end
			end
		end

		for _, ene in ipairs(self.enemies) do
			if col.l==ene.l and ene.l==self.l and ene.ox>self.x and ene.ox<self.h and ene.oy>self.y and ene.oy<self.w then
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

		for _, ex in ipairs(self.explosion) do
			if col.l==ex.l and col.ox>self.x and col.ox<self.h and col.oy>self.y and col.oy<self.w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(col.body)--collision pared explosion
				if colli then
					pcall (self:deletetiled(col.x,col.y,col.gid,self.l,4),"error2")
					self.HC.remove(col.body)
					self:removeextra(col,"colli")
				end
			end
		end
	end

	--iterador de puertas

	for _, d in ipairs(self.door) do
		
		if d.l==self.l and d.ox>self.x and d.ox<self.h and d.oy>self.y and d.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(d.body)--collision puerta player
			if colli then
				self.player.ischange=true
				self.player.rx,self.player.ry=d.body:center()
			end
		end

		for _, me in ipairs(self.meteor) do
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(d.body)

				if colli then
					self.HC.remove(d.body)
					self:removeextra(d,"door")	

					
					me.hp=me.hp-0.5
				end		
			end
	end

	-- iterador de objetos

	for _,obj in ipairs(self.object) do
		if obj.l==self.l and obj.ox>self.x and obj.ox<self.h and obj.oy>self.y and obj.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(obj.body)--collision objeto player
			if obj.type=="subida" and not self.player.ignore  and colli then
				if  (dy<0 and dx>0 and obj.d==1) or (dy<0 and dx<0 and obj.d==0)  then
					self.player.subida=true
					self.player.ground=true
					self.player.body:move(dx,dy)
					self.player.melee:move(dx,dy)
					self.player.point:move(dx,dy)
					self.player.vy=0
				end
			elseif obj.type=="escalera" and colli then
				self.player.escalar=true
			elseif obj.type=="municion" and colli and self.player.arma[obj.tipo] then
				-- si la municion actual + municion agregada es menor al max de municion
				if self.player.municion[obj.tipo]+obj.stock< self.player.maxmuni[obj.tipo] then
					self.player.municion[obj.tipo]=self.player.municion[obj.tipo]+obj.stock
					obj.stock=0
					self.HC.remove(obj.body)
					self:removeextra(obj,"object")
					--table.remove(self.object,o)
				else
					--coger la diferencia y agregarla al usuario y disminuirla al stock del paquete
					local muni=self.player.maxmuni[obj.tipo]-self.player.municion[obj.tipo]
					self.player.municion[obj.tipo]=self.player.municion[obj.tipo]+muni
					obj.stock=obj.stock-muni
				end
			elseif obj.type=="arma" and colli then
				self.player.arma[obj.tipo]=true
				self.HC.remove(obj.body)
				self:removeextra(obj,"object")
				--table.remove(self.object,o)
			elseif obj.type=="vida" and colli then
				self.player.maxhp=self.player.maxhp+2
				self.player.hi=2
				self.HC.remove(obj.body)
				self:removeextra(obj,"object")
			end
		end 

		for _, me in ipairs(self.meteor) do
			if obj.l==me.l and me.l==self.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(obj.body)--collision objetos meteoro
				if colli then
					self.HC.remove(obj.body)
					--table.remove(self.object,o)
					self:removeextra(obj,"object")
				end
			end
		end
	end

	-- iterador de meteoro

	for _, me in ipairs(self.meteor) do
		for _, bu in ipairs(self.bullet) do
			if me.l==bu.l and me.l==self.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(bu.body)--collision bala meteoro
				if colli then
					if bu.damage==4 then
						

						--pcall (self:deletetiled(col.x,col.y,col.gid,self.l,4),"error")
						self:removeextra(me,"meteor")
						self.HC.remove(me.body)

						bu:change()
					end
					bu.hp=bu.hp-1
					me.hp=me.hp-1
				end
			end
		end

		for _, en in ipairs(self.npcs) do
			if me.l==en.l and en.l==self.l and en.ox>self.x-1000 and en.ox<self.h+1000 and en.oy>self.y-1000 and en.oy<self.w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(en.body)-- collision npc meteoro
				if colli then
					en.hp=en.hp-5
				end
			end
		end

		for _, ex in ipairs(self.explosion) do
			if ex.l==me.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(ex.body)-- collision explosion meteoro
				if colli then
					me.hp=me.hp-ex.damage
				end
			end
		end
	end

	--iterador objetos dinamicos

	for d, di in ipairs(self.dinamic) do
		if di.l==self.l and di.ox>self.x and di.ox<self.h and di.oy>self.y and di.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(di.body) --collision player ascensor
			if not self.player.ignore3 and di.type=="ascensor" and colli then
				if dy<0 then
					self.player.isascensor=true
					self.player.ground=true
					self.player.body:move(dx,dy*2)
					self.player.melee:move(dx,dy*2)
					self.player.point:move(dx,dy*2)
					self.player.vy=0
				end
			end
		end

		for _, me in ipairs(self.meteor) do
			if di.l==me.l and me.l==self.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=me.body:collidesWith(di.body) --collision meteoro dinamico
				if colli then
					self.HC.remove(di.body)
					--table.remove(self.dinamic,d)
					self:removeextra(di,"dinamic")
					me.hp=me.hp-1
				end
			end
		end

		for _, po in ipairs(self.point) do
			if po.l==di.l and po.l==self.l then
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

	for _, ene in ipairs(self.enemies) do
		if ene.l==self.l and ene.ox<self.h and ene.oy>self.y and ene.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(ene.body)--collision player enemigo
			if colli and not self.player.immunity then
				self.player.hp=self.player.hp-ene.damage*0.5
				self.player.immunity=true
				if self.player.friend>0 and not self.player.dead then
					self.player.friend=self.player.friend-1
					--insertar zombies
					self.player:fall()
				end
			end
			local ex,ey,colli2=0,0,false
			colli2,ex,ey=self.player.melee:collidesWith(ene.body)-- collision espada enemigo
			if self.player.attack and colli2 and not ene.immunity then
				ene.jump=true
				ene.move=false
				ene.immunity=true
				ene.isjump=true
				ene.hp=ene.hp-self.player.mdamage*ene.defense
				ene.timea=0
			end
		end


		for _, ex in ipairs(self.explosion) do
			if ene.l==self.l and ene.ox<self.h and ene.oy>self.y and ene.oy<self.w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(ene.body)

				if colli then
					ene.hp=ene.hp-ex.damage*(ene.defense/2)
				end
			end
		end

		--[[for e, en in ipairs(self.npcs) do
			if ene.l==en.l and ene.l==self.l and en.ox>x and en.ox<x+h and en.oy>y and en.oy<y+w and ene.ox>x and ene.ox<x+h and ene.oy>y and ene.oy<y+w then
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

		for _, bu in ipairs(self.bullet) do
			if bu.l==ene.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ene.body:collidesWith(bu.body)--collision enemigo bala
				if bu.damage~=4 and colli then
					bu.hp=bu.hp-1
					ene.hp=ene.hp-bu.damage
				end
			end
		end

		for _, po in ipairs(self.point) do
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
	for _, en in ipairs(self.npcs) do
		if en.l==self.l and en.ox>self.x-1000 and en.ox<self.h+1000 and en.oy>self.y-1000 and en.oy<self.w then
			local dx,dy,colli=0,0,false
			colli,dx,dy=self.player.body:collidesWith(en.body)-- collision aliado player
			if colli then
				self.player.friend=self.player.friend+en:save()
				if self.player.hp<self.player.maxhp then
					self.player.hp=self.player.hp+0.5
				end
			end
		end

		for _, ex in ipairs(self.explosion) do
			if en.l==self.l and en.ox>self.x-1000 and en.ox<self.h+1000 and en.oy>self.y-1000 and en.oy<self.w then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(en.body)-- collision aliado explosion
				if colli then
					en.hp=en.hp-ex.damage
				end
			end
		end

		--[[for b, bue in ipairs(self.bullete) do
			if en.l==bue.l and en.l==self.l then
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
	for _, bue in ipairs(self.bullete) do
		if self.l==bue.l then
			local dx,dy,colli=0,0,false
			colli,dx,dy=bue.body:collidesWith(self.player.body)-- collision bala enemigo - player
			if colli then
				bue.hp=bue.hp-1
				self.player.hp=self.player.hp-bue.damage*0.5
			end
			local cx,cy,colli2=0,0,false
			colli2,cx,cy=bue.body:collidesWith(self.player.melee)
			if colli2 then
				bue.hp=bue.hp-1
			end
		end

		for _, bu in ipairs(self.bullet) do
			if bu.l==bue.l and bue.l==self.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=bue.body:collidesWith(bu.body)
				if colli then
					bu.hp=bu.hp-1
					bue.hp=bue.hp-1
				end
			end
		end

		for _, ex in ipairs(self.explosion) do
			if bue.l==ex.l then
				local dx,dy,colli=0,0,false
				colli,dx,dy=ex.body:collidesWith(bue.body)
				if colli then
					bue.hp=bue.hp-1
				end
			end
		end
	end

	--iterador explosion
	for _, ex in ipairs(self.explosion) do
		if ex.body:collidesWith(self.player.body) and not self.player.immunity then
			self.player.hp=self.player.hp-(ex.damage*2)/10
			self.player.immunity=true
		end
	end

	--iterador bandera
	for _, f in ipairs(self.flags) do
		if self.l==f.l then
			if f.body:collidesWith(self.player.body) then		
				self.player.fin=true
				self.HC.remove(f.body)
				self:removeextra(f,"flags")			
			end
		end
	end
end



function entidades:deletetiled(tx,ty,gid,c,id)
	for i, ti in ipairs(self.maps[c].tileInstances[gid]) do
		if ti ~=nil then
			if ti.x == tx and ti.y==ty then
				ti.batch:set(ti.id, self.maps[c].tiles[id].quad,tx,ty)
				break
			end
		end
	end
end

return entidades