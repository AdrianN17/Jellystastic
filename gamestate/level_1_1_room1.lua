local Gamestate = require "libs.gamestate"
local Class = require "libs.class"
local Base = require "gamestate.base"

local level_1_1_room1 = Class{
	__includes = Base
}
local i
local time=0
function level_1_1_room1:init()
	table.insert(_G.currentmap,self)
	i=0

	self:create()
end

function level_1_1_room1:enter(from)
	print("room " .. i)
	i=i+1
	self.from = from

	if self.from then
		self.entidades:get(self.from.entidades.player)
	end
end

function level_1_1_room1:draw()
	self.entidades:draw()

	love.graphics.print('Memory actually used (in kB): ' .. counter, 580,50,0,0.7,0.7)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 500, 90)

	love.graphics.print("room  " .. time,100,100,0,2,2)
end

function level_1_1_room1:update(dt)
	self.entidades:update(dt)
	counter=collectgarbage('count')/1000
	time=time+dt
end

function level_1_1_room1:keypressed(key)
	self.entidades:keypressed(key)

	if key=="t" then
		self.entidades:change_bodies()
	end

	if key=="m" and self.entidades.player.dead then
		self.entidades:destroy()
		self.from:create_all()
		Gamestate.push(self.from)
	end

	if key=="g" and self.entidades.player.change_world and self.entidades.player.change_map=="main" then
		self.from.entidades:get(self.entidades.player)
		Gamestate.push(self.from)
	end
end

function level_1_1_room1:keyreleased(key)
	self.entidades:keyreleased(key)
end

function level_1_1_room1:mousepressed(x,y,button)
	self.entidades:mousepressed(x,y,button)
end

function level_1_1_room1:mousereleased(x,y,button)
	self.entidades:mousereleased(x,y,button)
end

function level_1_1_room1:create()
	Base.init(self,"assets/maps/lv1-1_room1.lua",1.2,false)
	self.entidades:data()

	self.entidades:layer()

	self.name="level_1_1_room1"
end



return level_1_1_room1