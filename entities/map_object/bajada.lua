local Class = require "libs.hump.class"

local bajada = Class{}

function bajada:init(entidad,posicion,img,radio,tipo,propiedad)
  
  self.entidad = entidad
  
  self.body = love.physics.newBody(self.entidad.world,0,0)
  self.shape = love.physics.newEdgeShape(posicion[1],posicion[2],posicion[3],posicion[4])
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setUserData( {data="bajada",obj=self, pos=orden.bajada} )

end

function bajada:draw()
  
end

function bajada:update(dt)
  
end


return bajada