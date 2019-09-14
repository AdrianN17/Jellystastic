local Gamestate = require "libs.gamestate"
local Class = require "libs.class"
local sti= require "libs.sti"
local gamera = require "libs.gamera"
local wf = require 'libs.windfield'
local Timer = require "libs.timer"
local Entidades = require "entities.entidades"


local base = Class{
	__includes = Gamestate,
	init = function(self, mapfile,scale,create_meteor)
	self.create_meteor=create_meteor
	self.map=sti(mapfile)
	self.scale=scale
	--camara
	self.cam=gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
	self.cam:setScale(self.scale)
	--mapa
	self.map:resize(love.graphics.getWidth()*2,love.graphics.getHeight()*2)
	--mundo BOX2d
	self.world = wf.newWorld(0, 627.84, true)
	--tiempo
	self.timer= Timer.new()

	self.entidades=Entidades(self.map,self.cam,self.world,self.timer,self.scale,self.create_meteor)
	end
}

return base