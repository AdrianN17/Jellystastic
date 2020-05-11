local objetoFisico = require "entidades.Objetos_Mapa.objetoFisico"
local remove = require "entidades.remove"

local arma = Class{
  __includes = {objetoFisico,remove}
}

function arma:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  objetoFisico.init(self,entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)

  remove.init(self,entidad,properties.tabla)

  self.tipo = tonumber(properties.quad)

  self.properties = properties

  self.stock = 0
  self.municion = 0

end

function arma:usar(obj)

  if obj.itemsManos.armaIndex>0 and obj.itemsManos.armaIndex ~= self.tipo then

    if obj.itemManoIndex==2 then
      obj.itemManoIndex=1
    end

    obj:terminarDisparoArma()
    obj:terminarRecargaArma()

    local tipo = self.tipo

    self:crearNuevaArma(obj.armasValues[obj.itemsManos.armaIndex],obj.itemsManos.armaIndex)

    obj.armasValues[obj.itemsManos.armaIndex].enable = false
    obj.armasValues[obj.itemsManos.armaIndex].stock = 0
    obj.armasValues[obj.itemsManos.armaIndex].municion = 0

    obj.itemsManos.armaIndex = tipo
    obj.armasValues[tipo].enable = true
    obj.armasValues[tipo].stock = self.stock 
    obj.armasValues[tipo].municion = self.municion

    self:remove()
  end

end

function arma:crearNuevaArma(arma,index)

  local body = love.physics.newBody(self.entidad.world,self.ox,self.oy,"static")
  local shape = love.physics.newRectangleShape(arma.width,arma.height)
  local fixture = love.physics.newFixture(body,shape)

  fixture:setSensor(true)

  local shapeTableClear = body:getWorldPoints(shape:getPoints())

  local properties = self.properties
  properties.quad = index


  local obj = Entities_index.arma(self.entidad,body,shape,fixture,self.ox,self.oy,self.radio,shapeTableClear,properties,arma.width,arma.height)
  obj.Es_usable = properties.Es_usable


  obj.stock = arma.stock

  obj.municion = arma.municion

  fixture:setUserData({obj = obj})

end


return arma