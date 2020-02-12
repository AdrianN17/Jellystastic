local Class = require "libs.hump.class"
local Sti = require "libs.sti"
local Gamera = require "libs.gamera.gamera"

local index_entidades = require "entities.index"

local Timer = require "libs.chrono.Timer"

local Box2d_conf = require "gamestates.box2d_conf"
local UI_player = require "gamestates.ui_player"
local max_decoration = require "entities.max_decoration"

local joy_disparo=nil
local joy_movimiento=nil

local game_conf_default = Class{
  __includes = {Box2d_conf,UI_player}
}


function game_conf_default:init(nombreMapa)
  
  local dpi = 0
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    dpi = 1.5
  else
    dpi = 1
  end
  
  self.scale_dpi = dpi
  
  local x,y=love.graphics.getDimensions( )
  
  self.screen_y_normal = y
  
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    
    y = y+100*self.scale_dpi
  end
  
  self.screen_x,self.screen_y = x,y
  
  

  self.scale = 1/self.scale_dpi
  
  self.espacio_x_no_escalado = 180
  self.espacio_x = self.espacio_x_no_escalado*self.scale
  
  self.explosion_scale = 2
  
  self.map = Sti(nombreMapa)
  self.map:resize((x/self.scale)-self.espacio_x,(y/self.scale))
  
  self.cam = Gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x-self.espacio_x,y)
  self.cam:setScale(self.scale)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)
  self.world:setCallbacks(self:callbacks())
  
  
  self.gameobject = {}
  self.gameobject.player = {}
  self.gameobject.enemy = {}
  self.gameobject.bullet={}
  self.gameobject.object = {}
  self.gameobject.npc = {}
  self.gameobject.map_object = {}
  self.gameobject.holes = {}
  
  self.gameobject.decoration={}
  
  self.gameobject.door = {}
  self.gameobject.platform = {}
  
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
43 , -25}
--50 , 0}

  for i,k in ipairs(self.poligono_explosion) do
    self.poligono_explosion[i] = k*self.explosion_scale 
  end
  
  
  self.timer = Timer()
  
  self.vision={x=0,y=0,w=0,h=0}
  
  UI_player.init(self)
  
  self.body = love.physics.newBody(self.world,0,0,"static")
  local w_m=self.map.width*self.map.tilewidth
  local h_m=self.map.height*self.map.tileheight
  self.caida_y=h_m
  
  self.shape = love.physics.newChainShape(true,0,0,w_m,0,w_m,h_m+500,0,h_m+500)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setUserData({data="bedrock",obj=nil,pos=orden.bedrock})
  
  
  ----
  
  self.index_player=1
  
  if self.gameobject.player[self.index_player] and love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
  
  local style = {
    showBorder = true,
    bgColor = {0, 0, 0,0.2}
  }
  gooi.setStyle(style)
  
  
    joy_movimiento = gooi.newJoy({size = 150*self.scale,  x = 80*self.scale,y = self.screen_y_normal - 150*self.scale, deadZone = 0.2}):setDigital():setStyle({showBorder = true}):setImage("assets/img/joystick.png")
    joy_disparo = gooi.newJoy({size = 150*self.scale, x = self.camera_x_ui - 150*self.scale,y = self.screen_y_normal - 150*self.scale, deadZone = 0.2}):setStyle({showBorder = true}):setImage("assets/img/joystick.png"):noSpring() 
  end
  
  self:arreglar_posicion_puerta()
  
end

function game_conf_default:update_conf(dt)
  
  self.world:update(dt)
  self.timer:update(dt)
  self.map:update(dt)
end

function game_conf_default:draw_conf()
  
  local cx,cy,cw,ch=self.cam:getVisible()
  
  --love.graphics.print("Scaled text", 100,100)
  self.vision.x,self.vision.y,self.vision.w,self.vision.h = cx,cy,cw,ch
  
  self.vision.x = self.vision.x - self.vision.w/2
  self.vision.y = self.vision.y - self.vision.h/2
  
 
  self.vision.w = self.vision.w + self.vision.w
  self.vision.h = self.vision.h + self.vision.h
  
  
  
 self.map:draw(-cx,-cy,self.scale,self.scale)
 
  self.cam:draw(function(l,t,w,h)
     
    for _, body in pairs(self.world:getBodies()) do
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
    end

end)

  love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill",self.camera_x_ui,0,self.espacio_x,self.screen_y)
  love.graphics.setColor(1,1,1,1)
  self:draw_ui()
 

end


function game_conf_default:map_read()

  for _, layer in ipairs(self.map.layers) do
    if layer.type=="tilelayer" then
      --self:get_tile(layer)
    elseif layer.type=="objectgroup" then
      self:get_objects(layer)
    end
  end
  
  self.map:removeLayer("Borrador")
  
end

function game_conf_default:get_objects(objectlayer)
  
    for _, obj in pairs(objectlayer.objects) do
      if obj.name then
        
        local data_pos = nil
        
        if obj.shape =="point" then
          if obj.name == "Decoration" then
            table.insert(self.gameobject.decoration,{x=obj.x,y=obj.y,tipo = obj.type, propiedades = obj.properties})
          else
            data_pos = {obj.x,obj.y}
          end
        elseif obj.shape == "polygon" then
          local polygon = {}

          for _,data in ipairs(obj.polygon) do
            table.insert(polygon,data.x)
            table.insert(polygon,data.y)
          end
          
          data_pos = polygon
        elseif obj.shape == "rectangle" then
          if obj.name == "Puerta" then
            index_entidades[obj.name](self,obj.x,obj.y,img_index,obj.rotation,obj.type,obj.properties.id)
          else
            data_pos = {obj.x,obj.y,obj.width,obj.height,obj.rotation}
          end
        elseif obj.shape == "ellipse" then
          data_pos = {obj.x,obj.y,obj.width,obj.height}
        end
        
        if data_pos ~= nil and index_entidades[obj.name] ~= nil then 
          index_entidades[obj.name](self,data_pos,img_index)
        end
        
      end
    end
    
    self:dividir_decoraciones()
end

function game_conf_default:map_create()
  local map_object = self.map:addCustomLayer ("map_object",1 )
  local player = self.map:addCustomLayer ("player", 2)
  local enemy = self.map:addCustomLayer ("enemy", 3)
  local npc = self.map:addCustomLayer ("npc", 4)
  local bullet = self.map:addCustomLayer ("object",5 )
  local object = self.map:addCustomLayer ("object",6 )
  
  
  local function stencil()
    for _, obj_data in pairs(self.gameobject.holes) do
      love.graphics.circle("fill", obj_data.x, obj_data.y, 50*self.explosion_scale)
    end
  end
  
  
  player.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.player) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
  end
  
  player.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.player) do
      obj_data:update(dt)
    end
  end
  
  enemy.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.enemy) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
  end
  
  enemy.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.enemy) do
      obj_data:update(dt)
    end
  end
  
  npc.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.npc) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
  end
  
  npc.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.npc) do
      obj_data:update(dt)
    end
  end
  
  bullet.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.bullet) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
  end
  
  bullet.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.bullet) do
      obj_data:update(dt)
    end
  end
  
  object.draw = function(obj)
    for _, obj_data in ipairs(self.gameobject.object) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
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
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox,obj_data.oy,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
    
    for _, obj_data in pairs(self.gameobject.decoration) do
      for _, obj_data2 in ipairs(obj_data) do
        local img = img_index.cosas[obj_data2.tipo][obj_data2.id]
        local scale = img_index.cosas[obj_data2.tipo .. "_data"]
        local w,h = img:getWidth()/2,img:getHeight()/2
        if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data2.x,obj_data2.y,w,h)) then
          love.graphics.draw(img,obj_data2.x,obj_data2.y,obj_data2.r,scale.x,scale.y,w,h)
        end
      end
    end
    
    for _, obj_data in ipairs(self.gameobject.door) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
    
    for _, obj_data in ipairs(self.gameobject.platform) do
      if(self:CheckCollision(self.vision.x,self.vision.y,self.vision.w,self.vision.h,obj_data.ox-obj_data.w/2,obj_data.oy-obj_data.h/2,obj_data.w,obj_data.h)) then
        obj_data:draw()
      end
    end
    
    love.graphics.setStencilTest()
    
  end
  
  map_object.update = function(obj,dt)
    for _, obj_data in ipairs(self.gameobject.map_object) do
      obj_data:update()
    end
  end
  
  
end

function game_conf_default:add_obj(name,obj)
	table.insert(self.gameobject[name],obj)
end

function game_conf_default:remove_obj(name,obj)
  for i = #self.gameobject[name],1,-1 do
    
    e = self.gameobject[name][i]
    
		if e==obj then
			table.remove(self.gameobject[name],i)
			return
		end
	end
end

function game_conf_default:poligono_para_destruir(x,y)
  local poligono_explosion = {}
  
  for i=1,#self.poligono_explosion,2 do
    poligono_explosion[i] = self.poligono_explosion[i]+x
    poligono_explosion[i+1] = self.poligono_explosion[i+1]+y
  end
  
  return poligono_explosion
end



function game_conf_default:validar_pos(a,b)
  local o1,o2=a:getUserData(),b:getUserData()
  
  
  if not o1 or not o2 then
    return nil,nil
  end
  
  local min = math.min(o1.pos,o2.pos)
  
  if min == o1.pos then
    return o1,o2
  else
    return o2,o1
  end
end

function game_conf_default:round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function game_conf_default:distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

function game_conf_default:dano(obj1,dano)
  obj1.hp = obj1.hp - dano
end

function game_conf_default:CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function game_conf_default:dividir_decoraciones()
  local list = self.gameobject.decoration
  self.gameobject.decoration = {}
  
  
  for i,k in ipairs(list) do
    if self.gameobject.decoration[k.tipo] == nil then
      self.gameobject.decoration[k.tipo] = {}
    end
    
    local t = {}
    
    t.tipo = k.tipo
    t.id = math.random(1,max_decoration[k.tipo])
    t.x,t.y = k.x,k.y
    t.r = math.rad(k.propiedades.radio) 
    
    table.insert(self.gameobject.decoration[k.tipo],t)
    
  end
  
end

function game_conf_default:update(dt)
  dt = math.min (dt, 1/30)
  gooi.update(dt)
  
  if self.gameobject.player[self.index_player] and love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
    local dir = joy_movimiento:direction()
    self.gameobject.player[self.index_player]:joystick(dir)
  end
  
  self:update_conf(dt)
end

function game_conf_default:draw()
  love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
   
  self:draw_conf()

  gooi.draw()
  
end

function game_conf_default:keypressed(key)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[self.index_player] then
      self.gameobject.player[self.index_player]:keypressed(key)
    end
  end
  
  --[[if key == "0" then
    --muerte
    self:clear()
  end
  if key == "9" then
    --cambiar mapa
    self:cambiar_mundo()
  end]]
end

function game_conf_default:keyreleased(key)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[self.index_player] then
      self.gameobject.player[self.index_player]:keyreleased(key)
    end
  end
end

function game_conf_default:mousepressed(x,y,button)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    local cx,cy = self.cam:toWorld(x,y)
    if self.gameobject.player[self.index_player] then
      self.gameobject.player[self.index_player]:mousepressed(cx,cy,button)
    end
  end
end

function game_conf_default:mousereleased(x,y,button)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    local cx,cy = self.cam:toWorld(x,y)
    if self.gameobject.player[self.index_player] then
      self.gameobject.player[self.index_player]:mousereleased(x,y,button)
    end
  end
end

function game_conf_default:touchpressed( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
    
    gooi.pressed(id, x, y)
    
    if self.gameobject.player[self.index_player] then
      self:check_arma(x,y,1)
    end
  end
end

function game_conf_default:touchreleased( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    
    gooi.released(id, x, y)
    if self.gameobject.player[self.index_player] then
      self:check_arma(x,y,2)
    end
  end
end

function game_conf_default:touchmoved( id, x, y, dx, dy, pressure )
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    gooi.moved(id, x, y)
    if self.gameobject.player[self.index_player] then

    end
  end
end

function game_conf_default:analogico()
  return joy_disparo:xValue(),joy_disparo:yValue()
end

function game_conf_default:default_clear()
  self.map = nil
  self.cam = nil
  
  self.gameobject = {}

  
  self.world:destroy()
end

function game_conf_default:arreglar_posicion_puerta()
  local data_door = self.gameobject.door 
  self.gameobject.door = {}
  
  for _,k in ipairs(data_door) do
    self.gameobject.door[k.id_puerta] = k
  end

end

return game_conf_default