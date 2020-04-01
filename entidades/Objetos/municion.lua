local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local municion = Class{
  __includes = {objetoFisico}
}

function municion:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  self.tipo = properties.quad
end

return municion