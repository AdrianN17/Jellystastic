local baba = require "entidades.Balas.baba"
local estandarEnemigos =  require "entidades.Enemigos.estandarEnemigos"
local remove = require "entidades.remove"

local enemigo1 = Class{
  __includes = {estandarEnemigos,remove}
}

function enemigo1:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

  self.body = body
  self.shape = shape
  self.fixture = fixture

  self.shapeTableClear = shapeTableClear
  self.properties = properties

  self.entidad = entidad

  self.velocidad = properties.velocidad

  self.radio = radio

  self.tag = properties.tag
  self.hp = properties.hp

  self.limiteVision = properties.limiteVision

  self.spritesheet = Index_img[properties.img]

  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad
  self.dimension = self.spritesheet.viewport

  self.iterador = 1

  self.width,self.height = width,height

  self.ox,self.oy = ox,oy

  self.fixture:setFriction(0)
  self.fixture:setDensity(1)
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)

  self.body:setMass(50)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass

  entidad:add(properties.tabla,self)

  self.automata = Fsm.create({
   initial = 'mover',
    events ={
      {name = "Fatacar", from = "mover", to = "atacar"},
      {name = "Fmover", from = "atacar", to = "mover"}
    }
  })

  self.timer = Timer()

  self.direccion = properties.direccion or -1

  estandarEnemigos.init(self,properties)

  self.timer:every(0.5,function ()


    Switch(self.automata.current, {
      mover = function()
        self.iterador = self.iterador +1

        if self.iterador>3 then
          self.iterador=1
        end
      end,

      atacar = function()
        self.iterador = self.iterador +1

        if self.iterador == 5 and self.objPresa then

          local r = math.atan2(self.objPresa.oy-self.oyDisparo,self.objPresa.ox-self.oxDisparo)
          baba(self.entidad,self,self.oxDisparo,self.oyDisparo,r)
        end

        if self.iterador>5 then
          self.iterador=4
        end
      end
    })
  end)

  self.oxDisparo,self.oyDisparo = math.getPointAngle(self.ox,self.oy,self.radio,30,self.direccionAngulo[self.direccion]-20*self.direccion)

  self.oxAtaque,self.oyAtaque = math.getPointAngle(self.ox,self.oy,self.radio,self.limiteVision,self.direccionAngulo[self.direccion])


  local raycastAtacar = function (fixture, x, y, xn, yn, fraction)

    if not fixture:isSensor() and not fixture:getBody():isBullet() then

      local tipoObj=fixture:getUserData()

      if self.fractionRaycast>fraction then

        self.prePresa = tipoObj

        self.fractionRaycast = fraction
      end
    end

    return 1
  end

  self.timer:every(0.1,function()
    self.posicionAtaque=false

    self.entidad.world:rayCast(self.ox,self.oy,self.oxAtaque,self.oyAtaque,raycastAtacar)

    self:checkPresa()

    if self.posicionAtaque and self.automata.current == "mover" then
      self.automata:Fatacar()
      self.iterador = 4
    elseif not self.posicionAtaque and self.automata.current == "atacar" then
      self.objPresa = nil
      self.automata:Fmover()
    end

  end)

  self.objetivosEnemigos = {"humano","humano_enemigo"}

  remove.init(self,entidad,properties.tabla)

  self.acciones = {invulnerable =false}

  self.fixture:setGroupIndex(grupos.infectados)
end

function enemigo1:draw()
  local dimension = self.dimension[1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h

  love.graphics.draw(self.img,self.quad[self.iterador],self.ox,self.oy,self.radio,wi*self.direccion,hi,dimension.w/2,dimension.h/2)

  love.graphics.print(self.hp,self.ox,self.oy-100)
end

function enemigo1:update(dt)

  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()

  self:updatePuntos()

  self.oxDisparo,self.oyDisparo = math.getPointAngle(self.ox,self.oy,self.radio,30,self.direccionAngulo[self.direccion]-20*self.direccion)

  self.timer:update(dt)

  self:updateEnemigo(dt)

  self:checkVida()
end

return enemigo1