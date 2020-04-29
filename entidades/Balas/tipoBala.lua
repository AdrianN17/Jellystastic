local Misil = require "entidades.Balas.misil"
local Bala = require "entidades.Balas.bala"

local tipoBala = Class{}

function tipoBala:init()

  self.armasValues = {}

  --pistola normal
  self.armasValues[1] = {stock = 0, max_stock = 14, municion = 0, max_municion = 70, enable = false, dano = 1, tiempo = 0.5, tiempo_recarga = 0.7,clase = Bala,tipo = 1}
    --desert eagle
  self.armasValues[2] = {stock = 0, max_stock = 8, municion = 0, max_municion = 40, enable = false, dano = 2, tiempo = 0.9, tiempo_recarga = 0.9,clase = Bala,tipo = 2}
    --uzi
  self.armasValues[3] = {stock = 0, max_stock = 30, municion = 0, max_municion = 120, enable = false, dano = 0.75, tiempo = 0.15, tiempo_recarga = 0.5,clase = Bala,tipo = 3}
    --m4a1
  self.armasValues[4] = {stock = 0, max_stock = 30, municion = 0, max_municion = 90, enable = false, dano = 1.5, tiempo = 0.35, tiempo_recarga = 0.8,clase = Bala,tipo = 4}
    --escopeta
  self.armasValues[5] = {stock = 0, max_stock = 8, municion = 0, max_municion = 56, enable = false, dano = 1.5, tiempo = 1.2, tiempo_recarga = 1.2,clase = Bala,tipo = 5, multibala = true, radios = {math.rad(-2.5),math.rad(2.5)} }

    --lanzagranadas
  self.armasValues[6] = {stock = 0, max_stock = 5, municion = 0, max_municion = 10, enable = false, dano = 7.5, tiempo = 1 ,tiempo_recarga = 2,clase = Misil,tipo = 6}


  self.spritesheetArmas = Index_img.armas
  self.imgArmas = self.spritesheetArmas.img
  self.quadArmas = self.spritesheetArmas.quad
  self.dimensionArmas = self.spritesheetArmas.viewport
  self.scaleArmas = self.spritesheetArmas.scale


  self.oxBala,self.oyBala = math.getPointAngle(self.ox,self.oy,self.radio,22,10)
  self.vistaX=1

  self.radioBala = 0
end

function tipoBala:drawArma()
  if self.armaIndex > 0 and self.armasValues[self.armaIndex].enable then
    local dimensionArmas = self.dimensionArmas[self.armaIndex]
    local scaleArmas = self.scaleArmas[self.armaIndex]

    self.oxBala,self.oyBala = math.getPointAngle(self.ox,self.oy,self.radio,22,10)

    love.graphics.draw(self.imgArmas,self.quadArmas[self.armaIndex],self.oxBala,self.oyBala,self.radioBala,scaleArmas.x,scaleArmas.y*self.vistaX,dimensionArmas.w/2,dimensionArmas.h/2)
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

function tipoBala:recargarArma()

  if self.armaIndex > 0 and not self.timerRecarga and not self.timerBalas then
    local balas = self.armasValues[self.armaIndex]

    if balas.stock<balas.max_stock and balas.municion>0 then
      self.timerRecarga = nil
      self.timerRecarga = self.timer:after(balas.tiempo_recarga, function()
        self:recarga(self.armaIndex)
        self:terminarRecargaArma()
      end)
    end
  end
end

function tipoBala:dispararArma()
  if self.armaIndex > 0 and not self.timerRecarga and not self.timerBalas then
    self:disparo(self.armaIndex)
  end
end

function tipoBala:terminarDisparoArma()
  if self.armaIndex > 0 and self.timerBalas then
    self.timer:cancel(self.timerBalas)
    self.timerBalas = nil
  end
end

function tipoBala:terminarRecargaArma()
  if self.timerRecarga then
    self.timer:cancel(self.timerRecarga)
    self.timerRecarga = nil
  end
end

function tipoBala:disparo(armaIndex)
  local arma = self.armasValues[armaIndex]

    self:disparoIndividual(arma)

    if arma.tiempo ~= 0 then
      self.timerBalas = nil
      self.timerBalas = self.timer:every(arma.tiempo,
        function()
          self:disparoIndividual(arma)
        end)
    end
end

function tipoBala:disparoIndividual(arma)
  if arma.stock>=1 then
    arma.clase(self.entidad,self,self.oxBala,self.oyBala,self.radioBala,arma.dano,self.armaIndex)

    if arma.multibala and arma.radios then
      for i=1,#arma.radios,1 do
        arma.clase(self.entidad,self,self.oxBala,self.oyBala,self.radioBala+arma.radios[i],arma.dano,self.armaIndex)
      end
    end


    arma.stock = arma.stock-1
  end
end

function tipoBala:recargarMax()
  local bala = self.armasValues[self.armaIndex]
  self.armasValues[self.armaIndex].stock = bala.max_stock
  self.armasValues[self.armaIndex].municion = bala.max_municion

  self.armasValues[self.armaIndex].enable = true
end

function tipoBala:recargarDoble()
  local bala = self.armasValues[self.armaIndex]
  self.armasValues[self.armaIndex].stock = bala.max_stock
  self.armasValues[self.armaIndex].municion = bala.max_stock

  self.armasValues[self.armaIndex].enable = true
end

return tipoBala