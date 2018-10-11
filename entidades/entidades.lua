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
	flags={}
}

function entidades:enter(maps)
	self.maps=maps
	self:clear()
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
end

--draw()

function entidades:draw_p()
	for i, e in ipairs(self.bullet) do
		if e.l==self.l then
			e:draw()
		end
	end

	for i, e in ipairs(self.npcs)  do
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
			e:draw()
		end
	end

	self.player:draw()
end

function entidades:draw_o()
	
	
	for i, e in ipairs(self.object) do
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
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
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
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
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then --and self.y and self.y then
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
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
			e:update(dt)
		end
	end

end

function entidades:update_o(dt)
	for i, e in ipairs(self.dinamic) do
		if e.l==self.l and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
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
		if e.l==self.l  and e.ox>self.x and e.ox<self.x+self.h and e.oy>self.y and e.oy<self.y+self.w then
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
		local x,y=e.body:center()
		e.ox=x
		e.oy=y
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
	end
end

function entidades:setcamera(x,y,h,w)
	self.x,self.y,self.h,self.w=x,y,h,w
end


return entidades