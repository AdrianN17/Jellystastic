local textura = require "entidades.Objetos_Mapa.textura"
local visible = require "entidades.visible"

local texturaFisica = Class{
  __includes = {textura,visible}
}

function texturaFisica:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture

  self.entidad = entidad

  textura.init(self,entidad,ox,oy,radio,shapeTableClear,properties,width,height)

  visible.init(self)
end

return texturaFisica