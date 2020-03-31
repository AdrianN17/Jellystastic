--local Misil = require "entities.Balas.misil"
--local Bala = require "entities.Balas.bala"

local tipoBala = Class{}

function tipoBala:init()

  self.armasValues = {}

  --pistola normal
  self.armasValues[1] = {stock = 0, max_stock = 14, municion = 0, max_municion = 70, enable = true, dano = 1, tiempo = 0.5, tiempo_recarga = 0.7,clase = Bala,tipo = 1}
    --desert eagle
  self.armasValues[2] = {stock = 0, max_stock = 8, municion = 0, max_municion = 40, enable = false, dano = 2, tiempo = 0.9, tiempo_recarga = 0.9,clase = Bala,tipo = 2}
    --uzi
  self.armasValues[3] = {stock = 0, max_stock = 30, municion = 0, max_municion = 120, enable = false, dano = 0.75, tiempo = 0.15, tiempo_recarga = 0.5,clase = Bala,tipo = 3}
    --m4a1
  self.armasValues[4] = {stock = 0, max_stock = 30, municion = 0, max_municion = 90, enable = false, dano = 1.5, tiempo = 0.35, tiempo_recarga = 0.8,clase = Bala,tipo = 4}
    --escopeta
  self.armasValues[5] = {stock = 0, max_stock = 8, municion = 0, max_municion = 56, enable = false, dano = 1.5, tiempo = 1.2, tiempo_recarga = 1.2,clase = Bala,tipo = 5, funcion = function(clase,entidad,spritesheet,cx,cy,radio,creador,dano,tipo)
      local dr = math.rad(2.5)
      clase(entidad,spritesheet,cx,cy,radio-dr,creador,dano,tipo)
      clase(entidad,spritesheet,cx,cy,radio+dr,creador,dano,tipo)
    end}
    
    --lanzagranadas
  self.armasValues[6] = {stock = 0, max_stock = 5, municion = 0, max_municion = 10, enable = false, dano = 5, tiempo = 1 ,tiempo_recarga = 2,clase = Misil,tipo = 6}
  
  
  self.spritesheetArmas = Index_img.armas
  self.imgArmas = self.spritesheetArmas.img 
  self.quadArmas = self.spritesheetArmas.quad
  self.dimensionArmas = self.spritesheetArmas.viewport
  self.scaleArmas = self.spritesheetArmas.scale

end

function tipoBala:drawArma()
  if self.armaIndex > 0 and self.armasValues[self.armaIndex].enable then
    local dimensionArmas = self.dimensionArmas[self.armaIndex]
    local scaleArmas = self.scaleArmas[self.armaIndex]
    
    local ox,oy = math.getPointAngle(self.ox,self.oy,self.radio,22,10)
    
    love.graphics.draw(self.imgArmas,self.quadArmas[self.armaIndex],ox,oy,0,scaleArmas.x,scaleArmas.y,dimensionArmas.w/2,dimensionArmas.h/2)
  end
end

function tipoBala:recarga(armaIndex)
  local arma = self.armasValues[armaIndex]
    
    if arma.max_stock>arma.stock and arma.municion>0 then
      if arma.municion + arma.stock < arma.max_stock then
        arma.stock=arma.municion+arma.stock
        arma.municion=0
      else
        local carga=arma.max_stock-arma.stock
        arma.stock=arma.stock+carga
        arma.municion=arma.municion-carga
      end
    end
end

return tipoBala