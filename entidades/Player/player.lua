local Timer = require "libs.chrono.Timer"
local tipoBala = require "entidades.Balas.tipoBala"
local remove = require "entidades.remove"
local visible = require "entidades.visible"


local player = Class{
  __includes = {tipoBala,remove,visible}
}

function player:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture

  self.shapeTableClear = shapeTableClear
  self.properties = properties

  self.entidad = entidad

  self.velocidad = properties.velocidad
  self.salto = properties.salto
  self.radio = radio

  self.tag = properties.tag
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
  self.acciones = {moviendo = false, saltando = false,cayendo = false, invulnerable = false,pasarPlataformas=false,coger = false, usar = false}

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

  tipoBala.init(self)

  self.itemManoIndex = 1
  self.itemsManos = {armaIndex= properties.armaIndex or 0, itemIndex = properties.itemIndex or 0}

  self:recargarDoble()

  self.funcionCambiarMovible = nil

  self.npcsSalvados = 0

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

  self.timer:every(0.05, function()
    self.ground = false

    local contacts = self.body:getContacts()

    self.puertaValues = nil

    self:buscarColisionesEspacio(contacts)

    self:buscarObjetosUtilizables(contacts)

  end)


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

  visible.init(self)

  self.fixture:setGroupIndex(grupos.player)

  self.inmunidadTimerVariable = true
  self.cooldownInmunidadTimer = nil

end

function player:update(dt)

  self.radio = self.body:getAngle()

  self.ox,self.oy = self.body:getX(),self.body:getY()

  self.timer:update(dt)

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

  if self.itemManoIndex == 1 then
    self:drawArma()
  else
    --dibujar item
  end

  love.graphics.print(self.hp,self.ox,self.oy-100)
  --love.graphics.print(tostring(self.acciones.invulnerable),self.ox,self.oy-200)

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
    local x,y = self.body:getLinearVelocity()
    if y> -10 then
      self:saltar()
    end
  end

  if key == _G.teclas.down  then

    self.acciones.pasarPlataformas = true

    if not self.ground and not self.acciones.cayendo then
      self:caer()
      self.acciones.cayendo = true
    end
  end

  if key == _G.teclas.getBox then

    self:terminarDisparoArma()

    self.acciones.coger = not self.acciones.coger

    if not self.acciones.coger and self.jointMovible and not self.jointMovible:isDestroyed( ) then
      self.jointMovible:destroy()
      self.jointMovible = nil

      if self.funcionCambiarMovible then
        self:funcionCambiarMovible()
      end
    end

  end

  if key == _G.teclas.get then
    self:terminarDisparoArma()
    self.acciones.usar = true
  end


   if key == _G.teclas.changeWeapon and not self.jointMovible then
    self:terminarDisparoArma()

    if self.itemManoIndex == 1 then
      self.itemManoIndex = 2
    else
      self.itemManoIndex = 1
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

  if key == _G.teclas.get then
    self.acciones.usar = false
  end

end

function player:mousepressed(x,y,button,istouch,presses)
  if presses == 1 and self.itemManoIndex == 1 then
      if button == 1 then
        self:dispararArma()
      elseif button == 2 then
        self:recargarArma()
      end
  end
end

function player:mousemoved(x,y)

  if self.itemManoIndex == 1 then
    if x>self.oxBala then
      self.vistaX = 1
    else
      self.vistaX = -1
    end

    self.radioBala = math.atan2(self.oyBala-y,self.oxBala-x)+math.pi
  end
end

function player:mousereleased(x,y,button)
  if button == 1 and self.itemsManos.armaIndex>0 and self.itemManoIndex == 1 then
    local arma = self.armasValues[self.itemsManos.armaIndex]

    self:terminarDisparoArma()
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
  self.fixture:setFriction(1)
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

  local x,y = self.body:getLinearVelocity()

  self.body:setLinearVelocity(x,0)

  self.body:applyLinearImpulse( 0, (self.salto*self.mass)/4 )
end

function player:get()
  local t = {}

  t.armasValues = self.armasValues
  t.itemsManos = self.itemsManos
  t.itemManoIndex = self.itemManoIndex
  t.hp = self.hp
  t.iteradorEstado = self.iteradorEstado
  t.cooldownIterador = self.cooldownIterador

  t.dataCreacion = self.dataCreacion
  t.npcsSalvados = self.npcsSalvados

  t.acciones = self.acciones

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

function player:limpiarMovimiento()
  self.movimiento = {a=false,d=false}
  self:terminarDisparoArma()
end

function player:preSolve(obj,coll)
  colisionadorObj:execute("player","preSolve",coll,obj,self)
end

function player:endContact(obj,coll)
  colisionadorObj:execute("player","endContact",coll,obj,self)
end

function player:buscarObjetosUtilizables(contacts)
  for _,contact in pairs(contacts) do

    local salvableObj = self.entidad:getUserDataValue(contact,"Es_salvable")
    local movibleObj = self.entidad:getUserDataValue(contact,"Es_movible")
    local puertaObj = self.entidad:getUserDataValue(contact,"Es_portal")
    local itemObj =  self.entidad:getUserDataValue(contact,"Es_usable")

    if itemObj and itemObj.obj and not itemObj.obj.body:isDestroyed() and self.acciones.usar and self.ground then

      itemObj.obj:usar(self)
      self.acciones.usar= false

    elseif salvableObj and salvableObj.obj and not salvableObj.obj.body:isDestroyed() and self.acciones.usar
    and self.ground then

      self.npcsSalvados = self.npcsSalvados+1

      salvableObj.obj:remove()

      self.acciones.usar= false

    elseif movibleObj and not self.jointMovible and self.itemManoIndex== 2 and self.acciones.coger and self.ground then

      local x,y = contact:getPositions()
      local nx,ny = contact:getNormal()

      if x and y and nx and ny and math.abs(ny)<0.1 then
        self.jointMovible = love.physics.newWeldJoint(self.body,movibleObj.obj.body,x,y,true)
        movibleObj.obj.pasarPlataformas = true

        self.funcionCambiarMovible = function()
          if movibleObj and movibleObj.obj and not movibleObj.obj.body:isDestroyed() and movibleObj.obj.pasarPlataformas then
            movibleObj.obj.pasarPlataformas = false
          end
        end

      end

    elseif puertaObj and self.acciones.usar and not self.jointMovible and self.ground then

      self.acciones.usar=false

      if puertaObj.obj.llave then

        if self.itemManoIndex == 2 and puertaObj.obj.llave>0 and puertaObj.obj.llave == self.itemsManos.itemIndex then
          self.itemsManos.itemIndex = 0
          puertaObj.obj.llave = nil
        end

      else
        if self.cooldownInmunidadTimer then
          self.entidad.timer:cancel(self.cooldownInmunidadTimer)
        end
        self.cooldownInmunidadTimer = nil
        self.acciones.invulnerable=false
        self.entidad:cambiarSubnivel(puertaObj.obj.puertaValues)
      end
    end
  end
end

function player:buscarColisionesEspacio(contacts)

  for _,contact in ipairs(contacts) do
    local sueloObj =  self.entidad:getUserDataValue(contact,"Es_tierra")
    local liquidoObj =  self.entidad:getUserDataValue(contact,"Es_liquido")

    if sueloObj then

      local x,y = contact:getNormal()


      if y<0 and math.abs(x) < 0.1 then
        self.ground = true
        self.acciones.saltando=false
        self.acciones.cayendo = false
        contact:setFriction( 1 )
      else
        contact:setFriction( 0 )

      end
    elseif liquidoObj then
      local x,y = contact:getNormal()

      if y<-0.1 then
        self.ground = true
        self.acciones.saltando=false
        self.acciones.cayendo = false
      end
    end
  end

end

return player