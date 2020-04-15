local Utils = require "gamestates.utils"

local mundoGenerico = Class{
  __includes = {Utils}
}

xg,yg = 0,0

function mundoGenerico:init(mapa)

  self.timer = Timer()
  
  self.indexPlayer = 1
  
  Utils.init(self)

  self.gameobject = {}
  self.entidadesUnicas = {}
  
  self.map = Sti(mapa)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)

  
  self.scaleDPI = 1
  self.scale = 1/self.scaleDPI
  
  local x,y=love.graphics.getDimensions( )
  
  self.screenX, self.screenY = x,y
  
  self.map:resize(x/self.scale,y/self.scale)
  
  --self.cam = Camera.new(0, 0, self.scale, 0,0,0,x,y,0.5,0.5)
  self.cam = Gamera.new(0,0,self.map.width*self.map.tilewidth, self.map.height*self.map.tileheight)
  self.cam:setWindow(0,0,x,y)
  self.cam:setScale(self.scale)
  
  
  self:createObjects(Entities_index)
  
  love.graphics.setLineWidth( 2 )
  
  self.vision = {x=0,y=0,w=0,h=0}
  
  self.parallaxCount = 0
  self.parallaxLast = 0
  self.parallaxVariable = 320
  
  self.spritesheetFondo = Index_img.capa3
  self.imgFondo = self.spritesheetFondo.img[1]
  self.dimensionFondo =  self.spritesheetFondo.dimensions[1]
  
  self.spritesheetFondoMovible = Index_img.capa2
  self.imgFondoMovible= self.spritesheetFondoMovible.img[1]
  self.dimensionFondoMovible =  self.spritesheetFondoMovible.dimensions[1]
  
  self.skyboxX = self.screenX/ self.dimensionFondo.w

  self.skyboxY = self.screenY/ self.dimensionFondo.h
  
  self.parallaxX = self.screenX/ self.dimensionFondoMovible.w

  self.parallaxY = self.screenY/ self.dimensionFondoMovible.h
  
  self.shaderEnemigo = love.graphics.newShader(Shader_index.shader_player)
  self.vec4Shader = {0.7,-0.4,0,0}
  self.shaderEnemigo:send("color_player",self.vec4Shader)
  
  self:setCallbacks()
  
  self.spritesheetIconoAliados = Index_img.ui
  self.imgIconoAliados= self.spritesheetIconoAliados.img["aliadosSalvados"]
  self.dimensionIconoAliados =  self.spritesheetIconoAliados.dimensions["aliadosSalvados"]
  
end

function mundoGenerico:enter()
  
end

function mundoGenerico:update(dt)
  dt = math.min (dt, 1/30)
  

  self.timer:update(dt)
  self.world:update(dt)
  self.map:update(dt)

 
end

function mundoGenerico:draw()
  
  local cx,cy,cw,ch=self.cam:getVisible()
  
  self.vision.x,self.vision.y,self.vision.w,self.vision.h = cx,cy,cw,ch
  
  self.vision.x = self.vision.x - self.vision.w/2
  self.vision.y = self.vision.y - self.vision.h/2
  
 
  self.vision.w = self.vision.w + self.vision.w
  self.vision.h = self.vision.h + self.vision.h
  
  self:skybox()
  self:parallax()
  
  self.map:draw(-cx,-cy,self.scale,self.scale)
  
  self:dibujarIconos()
  
  --self.cam:attach()
  
  self.cam:draw(function(l,t,w,h)
    self:drawBox2d()
  end)
  
  --self.cam:detach()
  
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function mundoGenerico:keypressed(key)
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:keypressed(key)
  end
  
  if key == "p" then
    Gamestate.switch(Pausa)
  end
  
  if key == "0" then
    
    self:limpiar()
  end
  
  if key == "9" then
    self:cambiarNivel()
  end
  
end

function mundoGenerico:keyreleased(key)
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    self.gameobject.jugadores[self.indexPlayer]:keyreleased(key)
  end
end

function mundoGenerico:mousepressed(x,y,button,istouch,presses)
  
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    local cx,cy = self.cam:toWorld(x,y)
    self.gameobject.jugadores[self.indexPlayer]:mousepressed(cx,cy,button,istouch,presses)
  end
end

function mundoGenerico:mousereleased(x,y,button)
  
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    local cx,cy = self.cam:toWorld(x,y)
    self.gameobject.jugadores[self.indexPlayer]:mousereleased(cx,cy,button)
  end
end

function mundoGenerico:mousemoved( x, y, dx, dy, istouch )
  
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    local cx,cy = self.cam:toWorld(x,y)
    self.gameobject.jugadores[self.indexPlayer]:mousemoved(cx,cy)
    
  end
end

function mundoGenerico:skybox()
  love.graphics.draw(self.imgFondo, 0, 0, 0, self.skyboxX, self.skyboxY)
end

function mundoGenerico:parallax()
  
  xc,yc,hc,wc=self.cam:getVisible()
  
  local x = xc/wc
  
  local dif = x - self.parallaxLast

  if dif~=0 then
    self.parallaxCount = self.parallaxCount + dif
  end
  
  self.parallaxLast = x
  
  local xp = math.floor(self.parallaxCount*self.parallaxVariable)
  
  love.graphics.draw(self.imgFondoMovible,xp , 0, 0, self.parallaxX, self.parallaxY)
  
  if self.parallaxCount ~= 0 then
    if self.parallaxCount*self.parallaxVariable>0 then
      love.graphics.draw(self.imgFondoMovible, xp-self.screenX , 0, 0, self.parallaxX, self.parallaxY)
    end
    
    if self.parallaxCount*self.parallaxVariable<0 then
      love.graphics.draw(self.imgFondoMovible, xp+self.screenX, 0, 0, self.parallaxX, self.parallaxY)
    end
  end
    
  if self.parallaxCount*self.parallaxVariable>self.screenX or self.parallaxCount*self.parallaxVariable<-self.screenX then
    self.parallaxCount = 0
  end
  
end

function mundoGenerico:limpiarEscenario()
  
  Sti:flush ()
  self.map = nil
  self.cam = nil
  
  
  
  self.timer:destroy()
  
  self.gameobject = {}

  self.world:destroy()
end

function mundoGenerico:dibujarIconos()
  local x,y = self.screenX - 100  ,50
  love.graphics.draw(self.imgIconoAliados,x,y,0,0.10,0.10,self.dimensionIconoAliados.w/2,self.dimensionIconoAliados.h/2)
  local contador = 0
  
  if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
    contador = self.gameobject.jugadores[self.indexPlayer].npcsSalvados 
  end
  
  love.graphics.print(contador, x+50,y)
end

function mundoGenerico:focus(f)
  if not f then
    Gamestate.switch(Pausa)
  end
end


return mundoGenerico