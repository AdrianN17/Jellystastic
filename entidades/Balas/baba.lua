local remove = require "entidades.remove"

local baba = Class{
  __includes = {remove}
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
  self.fixture:setUserData({obj=self,nombre = "bala"})
  
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
  self.direccion = math.sign(cx)
  self.grupo = "bala"
  
  self.Es_dispersable = true
  self.timerRemove = nil
end

function baba:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi,self.hi,self.dimension.w/2,self.dimension.h/2)
end

function baba:update(dt)

  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

function baba:preSolve(nombre,obj,coll)

  if obj.Es_tierra then
    
    if not self.timerRemove and not self.body:isDestroyed() then
      self.timerRemove = self.entidad.timer:after(10,function()  
        self:remove()
      end)
    end
  else
    
    coll:setEnabled(false)
    
    if obj.grupo == self.grupo and obj ~= self.objeto and obj.Es_dispersable ~= self.Es_dispersable  then
      self:remove()
      obj:remove()
    elseif obj.grupo ~= self.grupo and obj ~= self.objeto then
      for _,grupo in ipairs(self.objeto.objetivosEnemigos) do
        if obj.grupo == grupo then
          self.entidad:dano(obj,self.dano)
          self:remove()
          
          if obj.cambiarEstado then
            obj:cambiarEstado("semizombie")
          end
          
          if obj.direccion == self.direccion then
            if obj.grupo ~= "player" then
              obj.direccion=obj.direccion*-1
            end
            
            if obj.voltear then
              obj:voltear()
            end
          end
        end
      end
    end
  end
end

return baba