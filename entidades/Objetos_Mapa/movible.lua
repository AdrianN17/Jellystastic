local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"

local movible = Class{
  __includes = {objetoFisico}
}


function movible:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

  if not properties.Es_movibleFacil then
    self.body:setMass(math.sqrt( width*height )/2)
  end

  self.fixture:setFriction(1)
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