local remove = require "entidades.remove"
local visible = require "entidades.visible"
local explosivo = require "entidades.Balas.explosion"

local misil = Class{
  __includes = {remove,visible}
}

function misil:init(entidad,objeto,ox,oy,radio,dano,index)
  self.entidad = entidad
  self.objeto = objeto
  self.ox,self.oy = ox,oy
  self.radio = radio
  self.dano = dano

  self.spritesheet = Index_img.balas
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad[index]
  self.dimension = self.spritesheet.viewport[index]
  self.scale = self.spritesheet.scale[index]

  self.w,self.h = self.dimension.w*self.scale.x,self.dimension.h*self.scale.y

  self.body = love.physics.newBody(self.entidad.world,ox,oy,"dynamic")
  self.shape = love.physics.newRectangleShape(self.w,self.h)
  self.fixture = love.physics.newFixture(self.body,self.shape, 5)
  self.fixture:setUserData({obj=self})

  self.body:setAngle(self.radio)
  self.body:setBullet(true)

  self.body:setMass(2.5)
  self.body:setLinearDamping(0)
  self.fixture:setRestitution(0.6)

  self.mass= self.body:getMass()*self.body:getMass()

  self.velocidad=300

  self.ox,self.oy = self.body:getX(),self.body:getY()

  self.entidad:add("misil",self)

  local cx,cy = math.cos(radio), math.sin(radio)
  self.body:applyLinearImpulse( cx*self.mass*self.velocidad,cy*self.mass*self.velocidad)

  remove.init(self,entidad,"balas")

  self.tag = "bala"

  visible.init(self)

  self.Es_danoExplosivo = true

  self.timerExplosivo = nil

  self.objetivosEnemigos = self.objeto.objetivosEnemigos
  table.insert(self.objetivosEnemigos,"meteorito")

  self.balasEnemigos = {"baba","bala"}

  self.fixture:setGroupIndex(self.objeto.fixture:getGroupIndex())
end

function misil:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.scale.x,self.scale.y,self.dimension.w/2,self.dimension.h/2)
end

function misil:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
end

function misil:preSolve(obj,coll)

  colisionadorObj:execute("bala","preSolve",coll,obj,self)

end

function misil:crearExplosion(coll)
  if not self.timerExplosivo then
    local x,y = coll:getPositions()
    self.timerExplosivo = self.entidad.timer:after(0.1, function()
      explosivo(self.entidad,x,y)
    end)
  end
end

return misil