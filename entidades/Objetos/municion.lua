local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"
local remove = require "entidades.remove"


local municion = Class{
  __includes = {objetoFisico,remove}
}

function municion:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  
  remove.init(self,entidad,properties.tabla)
  
  self.tipo = properties.tipo
  self.cantidad = nil
end

function municion:usar(obj)
  if not self.cantidad then
    self.cantidad = obj.armasValues[self.tipo].max_stock
  end

  if self.tipo == obj.armaIndex then
    self:recargar(obj.armasValues[self.tipo])
  end
end

function municion:recargar(armas)
  if armas.enable then

    if armas.municion + self.cantidad < armas.max_municion then
      armas.municion = armas.municion + self.cantidad
      self.cantidad = 0
      self:remove()
    else
      local muni = armas.max_municion - armas.municion
      armas.municion = armas.municion + muni
      self.cantidad = self.cantidad - muni
    end
    
  end
end

return municion