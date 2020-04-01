local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local vida = Class{
  __includes = {objetoFisico}
}

function vida:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  self.tipo = properties.quad
end

return vida