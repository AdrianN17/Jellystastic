local Class = require "libs.hump.class"
local sti = require "libs.sti"
local gamera = require "libs.gamera.gamera"

local game_conf = Class{}

function game_conf:init(nombreMapa)
  
  local x,y=love.graphics.getDimensions( )
  
  self.map = sti(nombreMapa)
  self.map:resize(x,y)
  self.cam = gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x,y)
  
end

function game_conf:update_conf(dt)
  self.map:update(dt)
end

function game_conf:draw_conf()
  self.map:draw()
end


return game_conf