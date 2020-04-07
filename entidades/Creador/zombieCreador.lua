local zombieCreador = Class{}
  
function zombieCreador:init(entidad,ox,oy,properties)

  self.entidad = entidad
  self.ox,self.oy = ox,oy
  self.properties = properties
end

function zombieCreador:crearZombie(objData)
  
  local ox,oy,radio,shapeTableClear,width,height = objData.ox,objData.oy,objData.radio,objData.shapeTableClear,objData.width,objData.height
  
  local body = love.physics.newBody(self.entidad.world,self.ox,self.oy,"dynamic")
  local shape = love.physics.newPolygonShape(shapeTableClear)
  local fixture = love.physics.newFixture(body,shape)
  
  body:setPosition(ox,oy)
  body:setLinearVelocity(0,0)
  
  local obj = Entities_index[self.properties.subclase](self.entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,self.properties,width,height)
  
  obj.Es_colisionableAtaque = self.properties.Es_colisionableAtaque
  obj.Es_danoFisico = self.properties.Es_danoFisico
  
  fixture:setUserData({obj = obj})
  
end
  
return zombieCreador