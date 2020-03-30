local Misil = require "entities.Balas.misil"
local Bala = require "entities.Balas.bala"

local tipo_bala = {}

--pistola normal
tipo_bala[1] = {stock = 0, max_stock = 14, municion = 0, max_municion = 70, enable = false, dano = 1, tiempo = 0.5, tiempo_recarga = 0.7,clase = Bala,tipo = 1}
  --desert eagle
tipo_bala[2] = {stock = 0, max_stock = 8, municion = 0, max_municion = 40, enable = false, dano = 2, tiempo = 0.9, tiempo_recarga = 0.9,clase = Bala,tipo = 2}
  --uzi
tipo_bala[3] = {stock = 0, max_stock = 30, municion = 0, max_municion = 120, enable = false, dano = 0.75, tiempo = 0.15, tiempo_recarga = 0.5,clase = Bala,tipo = 3}
  --m4a1
tipo_bala[4] = {stock = 0, max_stock = 30, municion = 0, max_municion = 90, enable = false, dano = 1.5, tiempo = 0.35, tiempo_recarga = 0.8,clase = Bala,tipo = 4}
  --escopeta
tipo_bala[5] = {stock = 0, max_stock = 8, municion = 0, max_municion = 56, enable = false, dano = 1.5, tiempo = 1.2, tiempo_recarga = 1.2,clase = Bala,tipo = 5, funcion = function(clase,entidad,spritesheet,cx,cy,radio,creador,dano,tipo)
    local dr = math.rad(2.5)
    clase(entidad,spritesheet,cx,cy,radio-dr,creador,dano,tipo)
    clase(entidad,spritesheet,cx,cy,radio+dr,creador,dano,tipo)
  end}
  
  --lanzagranadas
tipo_bala[6] = {stock = 0, max_stock = 5, municion = 0, max_municion = 10, enable = false, dano = 5, tiempo = 1 ,tiempo_recarga = 2,clase = Misil,tipo = 6}

return tipo_bala