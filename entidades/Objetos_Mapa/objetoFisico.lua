local objeto = require "entidades.Objetos_Mapa.objeto"
local visible = require "entidades.visible" 

local objetoFisico = Class{
  __includes = {objeto,visible}
}

function objetoFisico:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.entidad = entidad
  
  objeto.init(self,entidad,ox,oy,radio,shapeTableClear,properties,width,height)
  
  visible.init(self)
end

return objetoFisico