
local objetoFisicoSolo = Class{}

function objetoFisicoSolo:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.entidad = entidad
  
end

function objetoFisicoSolo:preSolve(obj,coll)
  if self.Es_muerte and obj.remove then
    obj:remove()
  end
end

return objetoFisicoSolo