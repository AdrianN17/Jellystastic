local Class = require "libs.hump.class"
local sti = require "libs.sti"
local gamera = require "libs.gamera.gamera"

local index_entidades = require "entities.index"
local img_index = require "assets/img/index"



local game_conf = Class{}

function game_conf:init(nombreMapa)
  
  local x,y=love.graphics.getDimensions( )
  
  self.map = sti(nombreMapa)
  self.map:resize(x,y)
  self.cam = gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x,y)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, true)
  
  
  self.gameobject = {}
  self.gameobject.player = {}
  self.gameobject.enemy = {}
  self.gameobject.object = {}
  self.gameobject.npc = {}
  self.gameobject.map_object = {}
  self.gameobject.holes = {}
  
  self:map_read()
  self:map_create()
  
  
  self.poligono_explosion = {50 , 0,
43 , 25,
25 , 43,
0 , 50,
-25 , 43,
-43 , 25,
-50 , 0,
-43 , -25,
-25 , -43,
0 , -50,
25 , -43,
43 , -25,
50 , 0}
  
  
  
  
end

function game_conf:update_conf(dt)
  self.world:update(dt)
  self.map:update(dt)
  
end

function game_conf:draw_conf()
  local cx,cy,cw,ch=self.cam:getVisible()

  self.map:draw(-cx,-cy,1,1)
  
  self.cam:draw(function(l,t,w,h)
    --[[  red = 115/255
    green = 27/255
    blue = 135/255
    alpha = 50/100
    
    love.graphics.setBackgroundColor( red, green, blue, alpha)]]
    
      
    --[[for _, body in pairs(self.world:getBodies()) do
      for _, fixture in pairs(body:getFixtures()) do
        local shape = fixture:getShape()
     
        if shape:typeOf("CircleShape") then
            local cx, cy = body:getWorldPoints(shape:getPoint())
            love.graphics.circle("line", cx, cy, shape:getRadius())
        elseif shape:typeOf("PolygonShape") then
            love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
        else
            love.graphics.line(body:getWorldPoints(shape:getPoints()))
        end
      end
    end]]

  end)
  
end


function game_conf:map_read()

  for _, layer in ipairs(self.map.layers) do
    if layer.type=="tilelayer" then
      --self:get_tile(layer)
    elseif layer.type=="objectgroup" then
      self:get_objects(layer)
    end
  end
  
  self.map:removeLayer("Borrador")
  
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
        elseif obj.shape == "rectangle" then
          data_pos = {obj.x,obj.y,obj.width,obj.height}
        elseif obj.shape == "ellipse" then
          data_pos = {obj.x,obj.y,obj.width,obj.height}
        end
        
        if data_pos ~= nil and index_entidades[obj.name] ~= nil then 
          index_entidades[obj.name](self,data_pos,img_index)
        end
        
      end
    end
end

function game_conf:map_create()
  local player = self.map:addCustomLayer ("player", 1)
  local enemy = self.map:addCustomLayer ("enemy", 2)
  local npc = self.map:addCustomLayer ("npc", 3)
  local object = self.map:addCustomLayer ("object",4 )
  local map_object = self.map:addCustomLayer ("map_object",5 )
  
  local function stencil()
    for _, obj_data in pairs(self.gameobject.holes) do
      love.graphics.circle("fill", obj_data.x, obj_data.y, 50)
    end
  end
  
  
  player.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.player) do
      obj_data:draw()
    end
  end
  
  player.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.player) do
      obj_data:update(dt)
    end
  end
  
  enemy.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.enemy) do
      obj_data:draw()
    end
  end
  
  enemy.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.enemy) do
      obj_data:update(dt)
    end
  end
  
  npc.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.npc) do
      obj_data:draw()
    end
  end
  
  npc.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.npc) do
      obj_data:update(dt)
    end
  end
  
  object.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.object) do
      obj_data:draw()
    end
  end
  
  object.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.object) do
      obj_data:update(dt)
    end
  end
  
  map_object.draw = function(obj)

    love.graphics.stencil(stencil, "replace", 1)
   

    love.graphics.setStencilTest("equal", 0)
     
    for _, obj_data in ipairs(self.gameobject.map_object) do
      obj_data:draw()
    end
    
    love.graphics.setStencilTest()
    
  end
  
  map_object.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.map_object) do
      obj_data:update(dt)
    end
  end
  
  
end

function game_conf:add_obj(name,obj)
	table.insert(self.gameobject[name],obj)
end

function game_conf:remove_obj(name,obj)
  for i = #self.gameobject[name],1,-1 do
    
    e = self.gameobject[name][i]
    
		if e==obj then
			table.remove(self.gameobject[name],i)
			return
		end
	end
end


return game_conf