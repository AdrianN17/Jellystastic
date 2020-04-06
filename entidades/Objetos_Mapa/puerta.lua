local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local puerta = Class{
  __includes = {objetoFisico}
}

function puerta:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  self.puertaValues = {id = properties.id, nivel = properties.nivel}
  

end

return puerta