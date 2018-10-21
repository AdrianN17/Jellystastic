local Gamestate = require "libs.gamestate"
local base = require "gamestate.base"
local Class = require "libs.class"
local sti= require "libs.sti"
local gamera = require "libs.gamera"
local Player = require "entidades.player"

local nivel1_2 = Class{
	__includes = base
}

function nivel1_2:init()
	self:sprites()
end

function nivel1_2:enter()
	base.init(self,"assets/level/nivel_1_2_1.lua","assets/level/nivel_1_2_1.lua")
	self.cam=gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
	tmw,tmh=self.map.width*self.map.tilewidth,self.map.height*self.map.tileheight
	self.cam:setScale(scale)
end

function nivel1_2:update(dt)

end

function nivel1_2:keyreleased(key)
	base.entidades:keyreleased(key)
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