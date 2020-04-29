local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"
local remove = require "entidades.remove"

local arma = Class{
  __includes = {objetoFisico,remove}
}

function arma:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  remove.init(self,entidad,properties.tabla)
  
  self.tipo = tonumber(properties.quad)
  
  

end

function arma:usar(obj)
  
  if obj.armaIndex==0 and obj.armaIndexRespaldo>0 then
    obj.armaIndex=obj.armaIndexRespaldo
    obj.armaIndexRespaldo = 0
  end
  
  if obj.armaIndex>0 and obj.armaIndex ~=  self.tipo then
    
    obj.armasValues[obj.armaIndex].enable = false
    obj.armasValues[obj.armaIndex].stock = 0
    obj.armasValues[obj.armaIndex].municion = 0
    
    obj.cooldown = false
    
    obj:terminarDisparoArma()
    obj:terminarRecargaArma()
    
  
    local balas = obj.armasValues[self.tipo]
    
    obj.armasValues[self.tipo].enable = true
    obj.armasValues[self.tipo].stock = balas.max_stock
    
    obj.armaIndex = self.tipo
    
    self:remove()
  end
end

return arma