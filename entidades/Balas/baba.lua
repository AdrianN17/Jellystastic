local remove = require "entidades.remove"
local visible = require "entidades.visible"

local baba = Class{
  __includes = {remove,visible}
}

function baba:init(entidad,objeto,ox,oy,radio)
  self.entidad = entidad
  self.objeto = objeto
  self.ox,self.oy = ox,oy
  self.radio = radio
  self.dano = 2

  self.velocidad = 200

  self.spritesheet = Index_img.baba
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad["baba"]
  self.dimension = self.spritesheet.viewport["baba"]

  self.entidad:add("balas",self)

  self.width,self.height = 36,36

  self.wi,self.hi = self.width/self.dimension.w,self.height/self.dimension.h

  self.body = love.physics.newBody(entidad.world,ox,oy,"dynamic")
  self.shape = love.physics.newCircleShape(18)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setUserData({obj=self})

  self.fixture:setRestitution(0.5)
  self.body:setBullet(true)
  self.body:setMass(0)
  self.body:setLinearDamping( 1 )
  self.fixture:setFriction(1)
  self.fixture:setDensity(1)
  self.body: setFixedRotation (true)

  local cx,cy = math.cos(radio),math.sin(radio)
  self.body:applyLinearImpulse(self.velocidad*cx,self.velocidad*cy)

  remove.init(self,entidad,"balas")
  self.tag = "baba"

  self.Es_dispersable = true
  self.timerRemove = nil

  visible.init(self)

  self.Es_danoExplosivo = true

  self.objetivosEnemigos = self.objeto.objetivosEnemigos
  self.balasEnemigos = {"bala"}

  self.fixture:setGroupIndex(self.objeto.fixture:getGroupIndex())

  self.tocarLiquido = false

end

function baba:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi,self.hi,self.dimension.w/2,self.dimension.h/2)
end

function baba:update(dt)

  self.radio = self.body:getAngle()

  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function baba:preSolve(obj,coll)
  colisionadorObj:execute("baba","preSolve",coll,obj,self)
end

return baba