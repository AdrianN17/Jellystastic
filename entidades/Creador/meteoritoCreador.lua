
local meteoritoCreador = Class{}

function meteoritoCreador:init(entidad,ox,oy,properties)

  self.entidad = entidad
  self.ox,self.oy = ox,oy

  self.properties = properties

  self.meteoritoCreado = false

  self.entidad.timer:every(0.5, function()

    if not self.meteoritoCreado then
      self:crearMeteoro()
    end
  end)

end

function meteoritoCreador:crearMeteoro()

  local body = love.physics.newBody(self.entidad.world,self.ox,self.oy,"dynamic")
  local shape = love.physics.newCircleShape(25)
  local fixture = love.physics.newFixture(body,shape)

  local obj = Entities_index[self.properties.subclase](self.entidad,body,shape,fixture,self.ox,self.oy,0,self.properties,50,50)

  fixture:setUserData({obj = obj})

  obj.triggerRemove = function()
    self.meteoritoCreado = false
  end

  self.meteoritoCreado = true

end




return meteoritoCreador