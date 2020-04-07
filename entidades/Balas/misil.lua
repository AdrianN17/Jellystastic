local remove = require "entidades.remove"

local misil = Class{
  __includes = {remove}
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
  
  self.entidad:add("balas",self)
  
  local cx,cy = math.cos(radio), math.sin(radio)
  self.body:applyLinearImpulse( cx*self.mass*self.velocidad,cy*self.mass*self.velocidad)
  
  remove.init(self,entidad,"balas")
  
  self.grupo = "bala"
end

function misil:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.scale.x,self.scale.y,self.dimension.w/2,self.dimension.h/2)
end

function misil:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
end

function misil:preSolve(obj,coll)
  
  coll:setEnabled(false)
  
  if obj.Es_tierra then
    self:remove()
  elseif obj.grupo == self.grupo and obj ~= self.objeto then
    self:remove()
    obj:remove()
  elseif obj.grupo ~= self.grupo and obj ~= self.objeto then
    
    if obj.grupo == "meteorito" then
      self.entidad:dano(obj,self.dano)
    else
      for _,grupo in ipairs(self.objeto.objetivosEnemigos) do
        if obj.grupo == grupo then
          self.entidad:dano(obj,self.dano)
          self:remove()
          
          if obj.cambiarEstado then
            obj:cambiarEstado("agujereado")
          end
          
          local x,y = coll:getPositions()

          if obj.direccion == math.sign(x-self.ox) then
            
            if obj.cambiarDeDireccion then
              obj:cambiarDeDireccion()
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

return misil