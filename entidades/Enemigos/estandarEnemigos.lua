local visible = require "entidades.visible"

local estandarEnemigos = Class{
  __includes = {visible}
}

function estandarEnemigos:init(properties)

  self.maxHp = self.hp

  self.direccionAngulo = {}
  self.direccionAngulo[1] = 0
  self.direccionAngulo[-1] = -180

  self.oxPared,self.oyPared = math.getPointAngle(self.ox,self.oy,self.radio,75,self.direccionAngulo[self.direccion])
  self.oxSuelo,self.oySuelo = math.getPointAngle(self.ox,self.oy,self.radio,150,self.direccionAngulo[self.direccion]+20*self.direccion)

  self.objPresa = nil
  self.cambiarDireccion=false
  self.posicionAtaque = false

  self.fractionRaycast = 9999
  self.prePresa = nil

  if not properties.camper then
    local raycastSuelo = function (fixture, x, y, xn, yn, fraction)

      local tipoObj=fixture:getUserData()

      if tipoObj and tipoObj.obj and tipoObj.obj.Es_tierra then
        self.cambiarDireccion=false
      end

      return 1
    end

    local raycastPared = function (fixture, x, y, xn, yn, fraction)

      local tipoObj=fixture:getUserData()

      if tipoObj and tipoObj.obj and tipoObj.obj.Es_tierra then
        self.cambiarDireccion=true
      end

      return 1
    end

    self.timer:every(0.1,function()
      self.cambiarDireccion=true

      self.entidad.world:rayCast(self.ox,self.oy,self.oxSuelo,self.oySuelo,raycastSuelo)

      self.entidad.world:rayCast(self.ox,self.oy,self.oxPared,self.oyPared,raycastPared)

      if self.cambiarDireccion then

        self.direccion=self.direccion*-1

        if self.voltear then
          self:voltear()
        end
      end
    end)
  end

end

function estandarEnemigos:updateEnemigo(dt)

  Switch(self.automata.current, {

    mover = function()

      self:moverEntidad()

    end,

    atacar = function()
      local ox,oy = self.objPresa.ox,self.objPresa.oy

      local distancia = math.distance(self.ox,self.oy,ox,oy)

      local direccion = ox - self.ox

      if not self.giroCompleto then
        if distancia > self.limiteVision or ((direccion>0 and self.direccion == -1) or (direccion<0 and self.direccion == 1)) then
          self:terminarSeguimiento()
        end

      elseif self.giroCompleto and distancia > self.limiteVision then
        self:terminarSeguimiento()
      end
    end,

    seguir = function()
      local ox,oy = self.objPresa.ox,self.objPresa.oy

      local distancia = math.distance(self.ox,self.oy,ox,oy)

      local direccion = ox - self.ox

      if not self.giroCompleto then
        if distancia > self.limiteVision or ((direccion>0 and self.direccion == -1) or (direccion<0 and self.direccion == 1)) then
          self:terminarSeguimiento()
        end

      elseif self.giroCompleto and distancia > self.limiteVision then
        self:terminarSeguimiento()
      end

      local dir = math.abs(self.ox - ox)

      if dir>60 then
        self:moverEntidad()
      end
    end
  })


  if self.objPresa then
    if self.objPresa.body:isDestroyed() then
      self.objPresa=nil

      if self.automata.current =="seguir" or self.automata.current =="atacar" then
        self.automata:Fmover()
      end
    end
  end

  visible.init(self)

end

function estandarEnemigos:updatePuntos()

  if self.oxAtaque and self.oyAtaque then
    self.oxAtaque,self.oyAtaque = math.getPointAngle(self.ox,self.oy,self.radio,self.limiteVision,self.direccionAngulo[self.direccion])
  end

  self.oxPared,self.oyPared = math.getPointAngle(self.ox,self.oy,self.radio,75,self.direccionAngulo[self.direccion])
  self.oxSuelo,self.oySuelo = math.getPointAngle(self.ox,self.oy,self.radio,150,self.direccionAngulo[self.direccion]+20*self.direccion)

end

function estandarEnemigos:moverEntidad()
  local mx=self.direccion*self.mass*self.velocidad
  local vx,vy=self.body:getLinearVelocity()

  if math.abs(vx)<self.velocidad then
    self.body:applyForce(mx,0)
  end
end

function estandarEnemigos:terminarSeguimiento()
  self.objpresa=nil
  self.automata:Fmover()
end

function estandarEnemigos:cambiarDeDireccion()
  self.direccion=self.direccion*-1
end

function estandarEnemigos:checkPresa()

  if self.prePresa and self.prePresa.obj and checkStringInTable(self.prePresa.obj.tag,self.objetivosEnemigos) then
    self.objPresa = self.prePresa.obj
    self.posicionAtaque=true
  end

  self.fractionRaycast = 9999
  self.prePresa = nil
end

function estandarEnemigos:preSolve(obj,coll)
  colisionadorObj:execute("enemigo","preSolve",coll,obj,self)
end

return estandarEnemigos