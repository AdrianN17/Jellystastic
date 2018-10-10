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
	entidades:enter(self.maps)
	end;
	entidades = entidades;
	gamera = gamera;
}

return base