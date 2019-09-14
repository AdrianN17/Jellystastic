local Gamestate = require "libs.gamestate"
local Class = require "libs.class"
local Base = require "gamestate.base"

local maps={}

local level_1_1 = Class{
	__includes = Base
}
local i
local time=0
function level_1_1:init()
	_G.currentmap={}
	maps={level_1_1_room1=require "gamestate.level_1_1_room1",level_1_1_room2=require "gamestate.level_1_1_room2"}
	i=0

	self:create()
end

function level_1_1:enter()

	print("main " .. i)
	i=i+1
end

function level_1_1:draw()
	self.entidades:draw()

	love.graphics.print('Memory actually used (in kB): ' .. counter, 580,50,0,0.7,0.7)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 500, 90)

	love.graphics.print("main  " .. time,100,100,0,2,2)
end

function level_1_1:update(dt)
	self.entidades:update(dt)
	counter=collectgarbage('count')/1000
	time=time+dt
end

function level_1_1:keypressed(key)
	self.entidades:keypressed(key)

	if key=="t" then
		self.entidades:change_bodies()
	end

	if key=="m" and self.entidades.player.dead then
		
		self.entidades:destroy()
		self:create_all()

	end

	if key=="g" and self.entidades.player.change_world then
		Gamestate.switch(maps[self.entidades.player.change_map])
	end
end

function level_1_1:keyreleased(key)
	self.entidades:keyreleased(key)
end

function level_1_1:mousepressed(x,y,button)
	self.entidades:mousepressed(x,y,button)
end

function level_1_1:mousereleased(x,y,button)
	self.entidades:mousereleased(x,y,button)
end

function level_1_1:create()
	Base.init(self,"assets/maps/lv1-1.lua",0.65,true)
	self.entidades:data()

	self.entidades:layer()

	self.name="level_1_1"
end

function level_1_1:create_all()
	for _,maps in ipairs(_G.currentmap) do
		maps:create()
	end

	self:create()
end


return level_1_1