local remove = require "entidades.remove"

local bala = Class{
  __includes = {remove}
}

function bala:init(entidad,objeto,ox,oy,radio,dano,index)
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
  
  self.fixture:setUserData({obj=self,nombre = "bala"})
  
  self.body:setAngle(self.radio)
  self.body:setBullet(true)
  
  self.body:setMass(0)
  self.body:setFixedRotation(true)
  self.body:setLinearDamping(0)
  self.fixture:setRestitution(0.6)

  self.mass= self.body:getMass()*self.body:getMass()
  
  self.velocidad=1500
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.entidad:add("balas",self)
  
  self.body:setGravityScale( 0 )
  
  self.cx,self.cy = math.cos(radio), math.sin(radio)
  
  remove.init(self,entidad,"balas")
  
  self.direccion = math.sign(self.cx)
  
  self.grupo = "bala"
end

function bala:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.scale.x,self.scale.y,self.dimension.w/2,self.dimension.h/2)
end

function bala:update(dt)
  self.body:applyForce( self.cx*self.velocidad, self.cy*self.velocidad)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  self.radio = self.body:getAngle()
end

function bala:preSolve(nombre,obj,coll)
  if obj.Es_tierra then
    self:remove()
  end
  
  if obj == self.objeto then
    coll:setEnabled(false)
  else
    for _,grupo in ipairs(self.objeto.objetivosEnemigos) do
      if obj.grupo == grupo then
        self.entidad:dano(obj,self.dano)
        self:remove()
        
        if obj.cambiarEstado then
          obj:cambiarEstado("agujereado")
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
  
  if obj.grupo == self.grupo then
    self:remove()
    obj:remove()
  end
  
end

return bala