local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local movible = Class{
  __includes = {objetoFisico}
}


function movible:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

  self.pasarPlataformas = false
end

function movible:update(dt)
  self.ox,self.oy = self.body:getX(), self.body:getY()
  self.radio = self.body:getAngle()
end

function movible:preSolve(obj,coll)
  colisionadorObj:execute("movible","preSolve",coll,obj,self)
end

return movible