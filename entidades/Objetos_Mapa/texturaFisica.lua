local textura = require "entidades.Objetos_Mapa.textura"

local texturaFisica = Class{
  __includes = {textura}
}

function texturaFisica:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture

  textura.init(self,entidad,ox,oy,radio,shapeTableClear,properties,width,height)
  
end

return texturaFisica