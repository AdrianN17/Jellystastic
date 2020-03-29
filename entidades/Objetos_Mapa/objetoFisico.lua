local objeto = require "entidades.Objetos_Mapa.objeto"

local objetoFisico = Class{
  __includes = {objeto}
}

function objetoFisico:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  
  objeto.init(self,entidad,ox,oy,radio,shapeTableClear,properties,width,height)
  
end

return objetoFisico