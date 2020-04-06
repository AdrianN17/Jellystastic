local Timer = require "libs.chrono.Timer"
local tipoBala = require "entidades.Balas.tipoBala"
local remove = require "entidades.remove"


local player = Class{
  __includes = {tipoBala,remove}
}

function player:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  
  self.entidad = entidad
  
  self.velocidad = properties.velocidad
  self.salto = properties.salto
  self.radio = radio
  
  self.grupo = properties.grupo
  self.hp = properties.hp
  self.maxHp = self.hp
  
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
  self.acciones = {moviendo = false, saltando = false, invulnerable = false,pasarPlataformas=false,coger = false}
  
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
  
  self.ground = true
  
  self.timer = Timer()
  
  self.puertaValues = nil
  
  self.timer:every(0.25, function()
    if self.acciones.moviendo and not self.acciones.saltando then
      
      self.iterador = self.iterador +1
      
      if self.iterador>3 then
        self.iterador=1
      end
      
    elseif self.acciones.saltando then
      self.iterador=4
    else
      self.iterador=1
    end
  end)

  self.timer:every(0.005, function()
    local contacts = self.body:getContacts()
    
    self.puertaValues = nil
    self.ground = false
    
    for _,contact in ipairs(contacts) do
      
      
      if self.entidad:getUserDataValue(contact,"Es_tierra") then
        
        local x,y = contact:getNormal()
        
        if y<0 then
          self.ground = true
          
          self.acciones.saltando=false
        end
      end
      
      local puerta = self.entidad:getUserDataValue(contact,"Es_portal")
      if puerta then
        self.puertaValues = puerta.obj.puertaValues
      end
      
    end
    
  end)

  tipoBala.init(self)

  self.armaIndex = properties.armaIndex or 0
  self.armaIndexRespaldo = 0
  
  self:recargarMax()
  
  
  self.cooldownTimer = nil
  self.cooldownArma = false
  
  self.objetivosEnemigos = {"humano","humano_enemigo","infectado"}
  
  remove.init(self,entidad,properties.tabla)
  
  self.cooldownIterador = true
  
  self.jointMovible = nil
  
  self.dataCreacion = {
    ox = ox,
    oy = oy,
    radio = radio,
    shapeTableClear = shapeTableClear,
    properties = properties,
    width = width,
    height = height
  }
  
end

function player:update(dt)
  
  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.timer:update(dt)
  
  self:updateBala(dt)
  
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
  
  self.entidad.cam:setPosition(self.ox, self.oy)
  self:checkVida()
end

function player:draw()
  local dimension = self.dimension[1][1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h 
  
  love.graphics.setShader(self.shaderPlayer)
    love.graphics.draw(self.img,self.quad[self.iteradorEstado][self.iterador],self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)
  love.graphics.setShader()
  
  if self.idAccesorio>0 then
    local dimensionAccesorio = self.dimensionAccesorio[self.idAccesorio]
    local scaleAccesorio = self.scaleAccesorio[self.idAccesorio]
    
    local ox,oy = math.getPointAngle(self.ox,self.oy,self.radio,35,-90)
    love.graphics.draw(self.imgAccesorio,self.quadAccesorio[self.idAccesorio],ox,oy,self.radio,scaleAccesorio.x*self.direccion,scaleAccesorio.y,dimensionAccesorio.w/2,dimensionAccesorio.h/2)
  end
  
  self:drawArma()
  
  love.graphics.print(tostring(self.acciones.pasarPlataformas),self.ox,self.oy-100)

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
  
  if key == _G.teclas.up and self.ground and not self.acciones.saltando then
    self:saltar()
  end
  
  if key == _G.teclas.down and not self.ground then
    self:caer()
    self.acciones.pasarPlataformas = true
  end
  
  if key == _G.teclas.get and self.puertaValues and self.ground then
    self.entidad:cambiarSubnivel(self.puertaValues)
  end
  
   if key == _G.teclas.changeWeapon and not self.jointMovible then
    if self.armaIndexRespaldo == 0 then
      self.armaIndexRespaldo = self.armaIndex
      self.armaIndex = 0
    else
      self.armaIndex = self.armaIndexRespaldo 
      self.armaIndexRespaldo = 0
    end
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
  if button == 1 and not self.cooldownArma then
    self:dispararArma()
  elseif button == 2 and not self.cooldownArma then
    self:recargarArma()
  end
end

function player:mousereleased(x,y,button)
  if button == 1 and not self.cooldownArma and self.armaIndex>0 then
    local arma = self.armasValues[self.armaIndex]
    
    self:terminarDisparoArma()
    
    if arma.stock>0 then
      
      self.cooldown = true
      
      self.cooldownTimer = self.timer:after(arma.tiempo, function()
        self.cooldown = false
        self.cooldownTimer=nil
      end)
    end
  end
end

function player:setPlayerValues(tabla)
  self.vec4Shader = tabla[1]
  self.idAccesorio = tabla[2]
  
  self.shaderPlayer:send("color_player",self.vec4Shader)
end

function player:masa()
  self.body:setLinearDamping( 1 )
  self.body:resetMassData ()
  self.body: setFixedRotation (true)
  self.body:setMass(20)
  self.fixture:setFriction(0)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
end

function player:saltar()
  self.body:applyLinearImpulse( 0, -self.salto*self.mass )
    
    self.acciones.saltando=true
    self.ground = false
    
    self.timer:after(0.1,function()
      if not self.acciones.saltando then
        self.acciones.saltando=true
        self.ground = false
      end
    end)
    
    self.timer:after(0.5,function()
      self.raycast_ground=true
    end)
end

function player:caer()
  self.body:applyLinearImpulse( 0, (self.salto*self.mass)/2 )
end

function player:get()
  local t = {}
  
  t.armasValues = self.armasValues
  t.armaIndex = self.armaIndex
  t.hp = self.hp
  t.iterador = self.iterador
  t.cooldown = self.cooldown
  t.cooldownIterador = self.cooldownIterador
  t.armaIndexRespaldo = self.armaIndexRespaldo
  t.dataCreacion = self.dataCreacion
  
  return t
end

function player:set(tabla)
  for i,k in pairs(tabla) do
    self[i] = k
  end
end

function player:cambiarEstado(tipo)
  local hp = self.maxHp*0.5

  if self.hp<hp and self.cooldownIterador then
    
    if tipo == "semizombie" then
      self.iteradorEstado = 4
    elseif tipo == "agujereado" then
      self.iteradorEstado = 2
    elseif tipo == "canon" then
      self.iteradorEstado = 3
    end
    
    self.cooldownIterador = false
    
  elseif self.hp>hp and not self.cooldownIterador then
    
    self.iteradorEstado = 1
    self.cooldownIterador = true
  end
end

function player:clearPuerta()
  self.puertaValues=nil
end

function player:limpiarMovimiento()
  self.movimiento = {a=false,d=false}
  self:terminarDisparoArma()
end

function player:preSolve(obj,coll)
  
  if obj.Es_pasable then
    local x,y = coll:getNormal()

    if y>-0.01 then
      coll:setEnabled( false )
    else
      if self.acciones.pasarPlataformas  then
        
        coll:setEnabled( false )
      end
    end
  end
end

function player:postSolve(obj,coll)
  
end

function player:endContact(obj,coll)
  if obj.Es_pasable then
    if self.acciones.pasarPlataformas then
      self.acciones.pasarPlataformas=false
    end
  end
end

return player