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
  
  self:map_read();
end

function game_conf:update_conf(dt)
  self.map:update(dt)
end

function game_conf:draw_conf()
  self.map:draw()
end


function game_conf:map_read()

  for _, layer in ipairs(self.map.layers) do
    if layer.type=="tilelayer" then
      --self:get_tile(layer)
    elseif layer.type=="objectgroup" then
      self:get_objects(layer)
    end
  end
  
  --self.map:removeLayer("Borrador")
  
end

function game_conf:get_objects(objectlayer)
  
    for _, obj in pairs(objectlayer.objects) do
      if obj.name then
        
        local data_pos = nil
        
        if obj.shape =="point" then
          data_pos = {obj.x,obj.y}
        elseif obj.shape == "polygon" then
          local polygon = {}

          for _,data in ipairs(obj.polygon) do
            table.insert(polygon,data.x)
            table.insert(polygon,data.y)
          end
          
          data_pos = polygon
        end
        
        if data_pos ~= nil then
        
        end
        
      end
    end
end


return game_conf