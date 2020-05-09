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

  self.cambiarDireccion = {suelo = true,pared=false}

  if not properties.camper then

    self.timer:every(0.01, function()
      self.ground = false
      local contacts = self.body:getContacts()
  
      self:buscarColisionesEspacio(contacts)
  
    end)
  

    local raycastSuelo = function (fixture, x, y, xn, yn, fraction)

      local tipoObj=fixture:getUserData()

      if tipoObj and tipoObj.obj and tipoObj.obj.Es_tierra  and self.ground then
        self.cambiarDireccion.suelo=false
      end

      return 1
    end

    local raycastPared = function (fixture, x, y, xn, yn, fraction)

      local tipoObj=fixture:getUserData()

      if tipoObj and tipoObj.obj and tipoObj.obj.Es_tierra then
        self.cambiarDireccion.pared=true
      end

      return 1
    end

    self.timer:every(0.1,function()
      self.cambiarDireccion.suelo = true

      if not self.ground then
        self.cambiarDireccion.suelo = false
      end

      self.cambiarDireccion.pared=false


      self.entidad.world:rayCast(self.ox,self.oy,self.oxSuelo,self.oySuelo,raycastSuelo)


      self.entidad.world:rayCast(self.ox,self.oy,self.oxPared,self.oyPared,raycastPared)

      if self.cambiarDireccion.suelo or self.cambiarDireccion.pared then

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
      self:terminarSeguimiento()

    end,

    atacar = function()

      self:terminarSeguimiento()

    end,

    seguir = function()

      self:terminarSeguimiento()

      if self.objPresa then
        local ox,oy = self.objPresa.ox,self.objPresa.oy

        local dir = math.abs(self.ox - ox)

        if dir>60 then
          self:moverEntidad()
        end
      end
    end
  })


  self:checkPresaNoDestruida()

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

  if self.objPresa then
    local ox,oy = self.objPresa.ox,self.objPresa.oy

    local distancia = math.distance(self.ox,self.oy,ox,oy)

    if distancia > self.limiteVision then
      self.objPresa=nil
      if self.automata.current ~= "mover" then
        self.automata:Fmover()
      end
    end

  end
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

function estandarEnemigos:checkPresaNoDestruida()
  if self.objPresa then
    if self.objPresa.body:isDestroyed() then
      self.objPresa=nil

      if self.automata.current =="seguir" or self.automata.current =="atacar" then
        self.automata:Fmover()
      end
    end
  end
end

function estandarEnemigos:buscarColisionesEspacio(contacts)

  for _,contact in ipairs(contacts) do
    local sueloObj =  self.entidad:getUserDataValue(contact,"Es_tierra")

    if sueloObj  then

      local x,y = contact:getNormal()


      if y<0 and math.abs(x) < 0.1 then
        self.ground = true
        contact:setFriction( 1 )
      else
        contact:setFriction( 0 )

      end
    end
  end

end

return estandarEnemigos