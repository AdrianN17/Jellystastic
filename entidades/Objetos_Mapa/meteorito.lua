local remove = require "entidades.remove"
local visible = require "entidades.visible" 

local meteorito = Class{
  __includes ={remove,visible}
}

function meteorito:init(entidad,body,shape,fixture,ox,oy,radio,properties,width,height)

  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.radio = radio
  
  self.entidad = entidad
  
  entidad:add(properties.tabla,self)
  
  self.spritesheet = Index_img[properties.img]
  
  local quadNombre = tonumber(properties.quad) or properties.quad
  
  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad[quadNombre]
  self.dimension = self.spritesheet.viewport[quadNombre]
  
  self.quadEstela = self.spritesheet.quad[properties.quadEstela]
  self.dimensionEstela = self.spritesheet.viewport[properties.quadEstela]
  
  self.width,self.height = width,height
  
  self.direccion = properties.direccion
  
  self.wi,self.hi = self.width/self.dimension.w,self.height/self.dimension.h 
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.oxInicial,self.oyInicial = ox,oy
  
  self.grupo = properties.grupo
  
  self.hp = properties.hp
  
  remove.init(self,entidad,properties.tabla)
  
  self.timerPosicionamiento = nil
  
  self.objetivosEnemigos = {"humano","humano_enemigo","infectado"}
  
  visible.init(self)
end

function meteorito:draw()
  love.graphics.draw(self.img,self.quadEstela,self.ox,self.oy,self.radio,self.wi*self.direccion,self.hi,
    self.dimensionEstela.w/2,(self.dimensionEstela.h/2) + self.dimensionEstela.h/5)

  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi,self.hi,self.dimension.w/2,self.dimension.h/2)
end

function meteorito:update(dt)
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self:checkVida()
  
end

function meteorito:preSolve(obj,coll)
  
  if obj.Es_tierra and not self.timerPosicionamiento then
    self.timerPosicionamiento = self.entidad.timer:after(1, function()
      if self and self.body and not self.body:isDestroyed() then
        self.body:setPosition(self.oxInicial,self.oyInicial)
        self.body:setLinearVelocity(0,0)
        
        self.timerPosicionamiento = nil
      end
    end)
  end 
  
  if obj.grupo == self.grupo then
    coll:setEnabled(false)
  else
    for _,grupo in ipairs(self.objetivosEnemigos) do
      if grupo == obj.grupo then
        
        coll:setEnabled(false)
        
        if obj.acciones and not obj.acciones.invulnerable then
          self.entidad:dano(obj,5)

          if obj.cambiarEstado then
            obj:cambiarEstado("canon")
          end
          
          obj.acciones.invulnerable = true
          
          self.entidad.timer:after(1,function() 
            if obj then
              obj.acciones.invulnerable=false
            end
          end)
          
        end
      end
    end
  end
  
end


return meteorito