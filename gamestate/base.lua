local HC = require "libs.HC"
local Gamestate = require "libs.gamestate"
local Class = require "libs.class"
local entidades = require "entidades.entidades"
local sti= require "libs.sti"
local gamera = require "libs.gamera"

local base = Class{
	__includes = Gamestate,
	init = function(self, mapfile,mapfile2)
	self.maps={sti(mapfile),sti(mapfile2)}
	self.map = self.maps[1]
	self.HC=HC
	self.gamera=gamera
	self.scale=0.65
	self.cam=self.gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
	self.cam:setScale(self.scale)
	entidades:enter(self.maps,self.HC,self.gamera)
	end;
	entidades = entidades;
	gamera = gamera;
}

return base