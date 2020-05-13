local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"
local remove = require "entidades.remove"

local item = Class{
    __includes = {objetoFisico}
}

function item:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
    objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

    remove.init(self,entidad,properties.tabla)

    self.itemTipo = tonumber(properties.quad)

end

function item:usar(obj)
    obj:terminarDisparoArma()
    obj:terminarRecargaArma()

    if obj.itemManoIndex==1 then
        obj.itemManoIndex=2
    end


    if obj.itemsManos.itemIndex==0 then

        self:remove()
    elseif obj.itemsManos.itemIndex ~= self.itemTipo then

        self:remove()
    end
end

return item