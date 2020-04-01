local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local movible = Class{
  __includes = {objetoFisico}
}


function movible:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
end

function movible:update()
  self.ox,self.oy = self.body:getX(), self.body:getY()
end

return movible