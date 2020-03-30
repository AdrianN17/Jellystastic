local Timer = require "libs.chrono.Timer"

local player = Class{}

function player:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.entidad = entidad
  
  self.velocidad = properties.velocidad
  self.salto = properties.salto
  self.radio = 0
  
  self.spritesheet = Index_img[properties.img]
  
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad
  self.dimension = self.spritesheet.viewport
  
  self.iterador = 1
  self.iteradorEstado = 1
  
  entidad:add(properties.tabla,self)
  
  self.width,self.height = width,height
  
  self.ox,self.oy = ox,oy
  
  self.movimiento = {a = false,b = false}
  self.acciones = {moviendo = false, saltando = false, invulnerable = false}
  
  self.vec4Shader = {0,0,0,0}
  
  self.shaderPlayer = love.graphics.newShader(Shader_index.shader_player)
  self.shaderPlayer:send("color_player",self.vec4Shader)
  
  
  self.idAccesorio = 0
  
  self.spritesheetAccesorio = Index_img[properties.imgAccesorio]
  self.imgAccesorio = self.spritesheetAccesorio.img 
  self.quadAccesorio = self.spritesheetAccesorio.quad
  self.dimensionAccesorio = self.spritesheetAccesorio.viewport
  self.scaleAccesorio  = self.spritesheetAccesorio.scale
  
  self.direccion = 1
  
  self:masa()
end

function player:update(dt)
  self.acciones.moviendo = false
  
  local x=0
  
  if self.movimiento.a then
    x=-1
    self.acciones.moviendo = true
  elseif self.movimiento.d then
    x=1
    self.acciones.moviendo = true
  end
  
  local mx=x*self.mass*self.velocidad
  
  local vx,vy=self.body:getLinearVelocity()
  

  if math.abs(vx)<self.velocidad then
    self.body:applyForce(mx,0)
  end
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.entidad.cam:setPosition(self.ox, self.oy)
end

function player:draw()
  local dimension = self.dimension[self.iterador][self.iteradorEstado]
  local wi,hi = self.width/dimension.w,self.height/dimension.h 
  
  love.graphics.setShader(self.shaderPlayer)
    love.graphics.draw(self.img,self.quad[self.iterador][self.iteradorEstado],self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)
  love.graphics.setShader()
  
  if self.idAccesorio>0 then
    local dimensionAccesorio = self.dimensionAccesorio[self.idAccesorio]
    local scaleAccesorio = self.scaleAccesorio[self.idAccesorio]
    
    local y = hi*dimension.h/2.2
    love.graphics.draw(self.imgAccesorio,self.quadAccesorio[self.idAccesorio],self.ox,self.oy-y,self.radio,scaleAccesorio.x*self.direccion,scaleAccesorio.y,dimensionAccesorio.w/2,dimensionAccesorio.h/2)
  end
end

function player:keypressed(key)
  if key == _G.teclas.left then
    self.movimiento.a = true
    self.direccion=-1
  end
  
  if key == _G.teclas.right then
    self.movimiento.d = true
    self.direccion=1
  end
end

function player:keyreleased(key) 
  if key == _G.teclas.left then
    self.movimiento.a = false
  end
  
  if key == _G.teclas.right then
    self.movimiento.d = false
  end
end

function player:mousepressed(x,y,button)
  
end

function player:mousereleased(x,y,button)
  
end

function player:setPlayerValues(tabla)
  self.vec4Shader = tabla[1]
  self.idAccesorio = tabla[2]
  
  self.shaderPlayer:send("color_player",self.vec4Shader)
end

function player:masa()
  
  self.body:resetMassData ()
  self.body:setMass(20)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
end



return player