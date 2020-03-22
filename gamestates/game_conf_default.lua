local Class = require "libs.hump.class"
local Sti = require "libs.sti"
local Gamera = require "libs.gamera.gamera"

local index_entidades = require "entities.index"

local Timer = require "libs.chrono.Timer"

local Box2d_conf = require "gamestates.box2d_conf"

local Pausa = require "gamestates.pausa"

local game_conf_default = Class{
  __includes = {Box2d_conf,UI_player}
}

function game_conf_default:init(nombreMapa)
  
  self.scale_dpi = 1
  
  local x,y=love.graphics.getDimensions( )
  
  self.screen_y_normal = y
  
  
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    
    y = y+100*self.scale_dpi
  end
  
  self.screen_x,self.screen_y = x,y

  self.scale = 1/self.scale_dpi
  
  
  self.explosion_scale = 1.5
  
  self.map = Sti(nombreMapa)
  self.map:resize((x/self.scale),(y/self.scale))
  
  self.cam = Gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x,y)
  self.cam:setScale(self.scale)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)
  self.world:setCallbacks(self:callbacks())
  
  self.timer = Timer()
  
  
  self.gameobject = {}
  self.gameobject.player = {}
  self.gameobject.enemy = {}
  self.gameobject.bullet={}
  self.gameobject.object = {}
  self.gameobject.npc = {}
  self.gameobject.map_object = {}
  self.gameobject.holes = {}
  self.gameobject.liquid= {}
  self.gameobject.decoration={}
  self.gameobject.extras = {}
  self.gameobject.door = {}
  self.gameobject.platform = {}
  self.gameobject.movible = {}
  self.gameobject.meteorito = {}
  self.gameobject.muerte = {}
  
  self:map_read()
  self:map_create()
  
  
  
  self.vision={x=0,y=0,w=0,h=0}
  
  self.body = love.physics.newBody(self.world,0,0,"static")
  local w_m=self.map.width*self.map.tilewidth
  local h_m=self.map.height*self.map.tileheight
  self.caida_y=h_m
  
  self.shape = love.physics.newChainShape(true,0,0,w_m,0,w_m,h_m+500,0,h_m+500)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setUserData({data="bedrock",obj=nil,pos=orden.bedrock})
  
  
  ----
  
  self.index_player=1
  
  self.sky_box = 1
  self.background = 1
  
  self.img_fondo = img_index.skybox[self.sky_box]
  self.img_fondo2 = img_index.background[self.background]
  
  --shaders compartidos
  
  self.shader_enemigo = love.graphics.newShader(shader_index.shader_player)
  
  
  self.vec4_shader = {0.7,-0.4,0,0}
  
  self.shader_enemigo:send("color_player",self.vec4_shader)
  
  --capas
  
  self.skybox_x = self.screen_x/ self.img_fondo:getWidth()

  self.skybox_y = self.screen_y/ self.img_fondo:getHeight()
  
  self.parallax_x = self.screen_x/ self.img_fondo2:getWidth()

  self.parallax_y = self.screen_y/ self.img_fondo2:getHeight()
  
  self.parallax_count = 0
  self.parallax_last = 0
  self.parallax_variable = 320
  
  self.contador_salvados = 0
  
  --send data values
  
  if self.gameobject.player[self.index_player] then
    local player = self.gameobject.player[self.index_player]
    player:set_player_values(_G.player_values)
  end
  
end

function game_conf_default:update_conf(dt)
  
  self.world:update(dt)
  self.timer:update(dt)
  self.map:update(dt)
end

function game_conf_default:draw_conf()
  
  local cx,cy,cw,ch=self.cam:getVisible()
  
  self.vision.x,self.vision.y,self.vision.w,self.vision.h = cx,cy,cw,ch
  
  self.vision.x = self.vision.x - self.vision.w/2
  self.vision.y = self.vision.y - self.vision.h/2
  
 
  self.vision.w = self.vision.w + self.vision.w
  self.vision.h = self.vision.h + self.vision.h
  
  self:skybox()
  self:parallax()
  
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

  
  love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10,10)
  love.graphics.print(self.contador_salvados,10,25)

end


function game_conf_default:map_read()

  for _, layer in ipairs(self.map.layers) do
    
    if layer.type=="tilelayer" then
      self:get_tile(layer)
    elseif layer.type=="objectgroup" then
      self:get_objects(layer)
    end
    
  end
  
  for _, layer in pairs(self.map.layers) do
   self.map:removeLayer(layer.name)
  end
  
end

function game_conf_default:get_objects(objectlayer)
  
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
        elseif obj.shape == "polyline" then
          
          local line = {}

          for _,data in ipairs(obj.polyline) do
            table.insert(line,data.x)
            table.insert(line,data.y)
          end
          
          data_pos = line
          
        elseif obj.shape == "rectangle" then

          data_pos = {obj.x,obj.y,obj.width,obj.height}
          
        elseif obj.shape == "ellipse" then
          data_pos = {obj.x,obj.y,obj.width,obj.height}
        end
        
        if data_pos ~= nil and index_entidades[obj.name] ~= nil then 
          index_entidades[obj.name](self,data_pos,img_index,obj.rotation,obj.type,obj.properties)
        end
        
      end
    end
    
    
end

function game_conf_default:map_create()
  
  local map_object = self.map:addCustomLayer ("map_object",1 )
  local player = self.map:addCustomLayer ("player", 2)
  local enemy = self.map:addCustomLayer ("enemy", 3)
  local npc = self.map:addCustomLayer ("npc", 4)
  local muerte = self.map:addCustomLayer("muerte",5)
  local object = self.map:addCustomLayer ("object",6 )
  
  
  local function stencil()
    for _, obj_data in pairs(self.gameobject.holes) do
      love.graphics.circle("fill", obj_data.x, obj_data.y, 50*self.explosion_scale)
    end
  end
  
  
  player.draw = function(obj)
    self:draw_gameobjects("player")
  end
  
  player.update = function(obj,dt)
    self:update_gameobjects("player", dt)
  end
  
  enemy.draw = function(obj)
    self:draw_gameobjects("enemy")
  end
  
  enemy.update = function(obj,dt)
    self:update_gameobjects("enemy", dt)
  end
  
  npc.draw = function(obj)
    self:draw_gameobjects("npc")
  end
  
  npc.update = function(obj,dt)
    self:update_gameobjects("npc", dt)
  end
  
  muerte.draw = function(obj,dt)
    self:draw_gameobjects("muerte")
  end
  
  muerte.update = function(obj,dt)
    self:update_gameobjects("muerte",dt)
  end
  
  object.draw = function(obj)
    self:draw_gameobjects("object")
  end
  
  object.update = function(obj,dt)
    self:update_gameobjects("object",dt)
  end
  
  map_object.draw = function(obj)
     
    self:draw_gameobjects("map_object")
    self:draw_gameobjects("liquid")
    self:draw_gameobjects("extras")
    self:draw_gameobjects("decoration")
    self:draw_gameobjects("door")
    self:draw_gameobjects("movible")
    self:draw_gameobjects("platform")
    self:draw_gameobjects("meteorito")
    self:draw_gameobjects("bullet")
    
  end
  
  map_object.update = function(obj,dt)
    self:update_gameobjects("map_object",dt)
    self:update_gameobjects("liquid",dt)
    self:update_gameobjects("extras",dt)
    self:update_gameobjects("decoration",dt)
    self:update_gameobjects("door",dt)
    self:update_gameobjects("movible",dt)
    self:update_gameobjects("platform",dt)
    self:update_gameobjects("meteorito",dt)
    self:update_gameobjects("bullet",dt)
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
   
  self:draw_conf()

  gooi.draw()
  
end

function game_conf_default:keypressed(key)
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    if self.gameobject.player[self.index_player] then
      self.gameobject.player[self.index_player]:keypressed(key)
    end
    
    if key == "p" then
      Gamestate.switch(Pausa)
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
      --self:check_arma(x,y,1)
    end
  end
end

function game_conf_default:touchreleased( id, x, y, dx, dy, pressure )
  if love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS"  then
    
    gooi.released(id, x, y)
    if self.gameobject.player[self.index_player] then
      --self:check_arma(x,y,2)
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



function game_conf_default:eliminar_presa(player)
  for _, enemy in ipairs(self.gameobject.enemy) do
    if enemy.obj_presa == player then
      
      if enemy.restaurar_radio then
        enemy:restaurar_radio()
      end
      enemy.obj_presa = nil
      enemy.acciones:a_mover()
      
    end
  end
end

function game_conf_default:skybox()
  love.graphics.draw(self.img_fondo, 0, 0, 0, self.skybox_x, self.skybox_y)
end

function game_conf_default:parallax()
  
  xc,yc,hc,wc=self.cam:getVisible()
  
  local x = xc/wc
  
  local dif = x - self.parallax_last

  if dif~=0 then
    self.parallax_count = self.parallax_count + dif
  end
  
  self.parallax_last = x
  
  local x_p = math.floor(self.parallax_count*self.parallax_variable)
  
  love.graphics.draw(self.img_fondo2,x_p , 0, 0, self.parallax_x, self.parallax_y)
  
  if self.parallax_count ~= 0 then
    if self.parallax_count*self.parallax_variable>0 then
      love.graphics.draw(self.img_fondo2, x_p-self.screen_x , 0, 0, self.parallax_x, self.parallax_y)
    end
    
    if self.parallax_count*self.parallax_variable<0 then
      love.graphics.draw(self.img_fondo2, x_p+self.screen_x , 0, 0, self.parallax_x, self.parallax_y)
    end
  end
  
  
    
    
  if self.parallax_count*self.parallax_variable>self.screen_x or self.parallax_count*self.parallax_variable<-self.screen_x then
    self.parallax_count = 0
  end
  
end

function game_conf_default:crear_zombie(x,y)
  index_entidades["Zombie"](self,{x,y},img_index)
end

function game_conf_default:buscar_puerta(id)
  for _,door in ipairs(self.gameobject.door) do
    if id == door.id_puerta then
      return door
    end
  end
  
  return nil
end

function game_conf_default:get_mouse_pos()
  local x,y = love.mouse.getPosition()
  local cx,cy = self.cam:toWorld(x,y)
  return cx,cy
end

function game_conf_default:update_gameobjects(nombre,dt)
  for _, obj_data in ipairs(self.gameobject[nombre]) do
    obj_data:update(dt)
  end
end

function game_conf_default:draw_gameobjects(nombre)
  for _, obj_data in ipairs(self.gameobject[nombre]) do
    obj_data:draw()
  end
end

return game_conf_default