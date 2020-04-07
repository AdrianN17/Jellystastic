local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"
local remove = require "entidades.remove"


local vida = Class{
  __includes = {objetoFisico}
}

function vida:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  remove.init(self,entidad,properties.tabla)
  
  self.tipo = tonumber(properties.quad)
  
end

function vida:usar(obj)
  if self.tipo == 1 then
    self:subirVida(obj)
  elseif self.tipo == 2 then
    self:extenderVida(obj)
  end
  
  obj:cambiarEstado()
end


function vida:subirVida(obj)
  
  if obj.hp ~= obj.maxHp then
    obj.hp = obj.hp + obj.maxHp * 0.15
    obj.hp = math.min(obj.hp,obj.maxHp)
    obj.hp = math.floor(obj.hp)
    
    self:remove()
  end
end

function vida:extenderVida(obj)
  obj.maxHp = obj.maxHp + obj.maxHp * 0.2
  obj.hp = obj.maxHp
  
  self:remove()
end

return vida