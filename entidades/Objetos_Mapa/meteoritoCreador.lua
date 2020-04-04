local meteorito = require "entidades.Objetos_Mapa.meteorito"

local meteoritoCreador = Class{}
  
function meteoritoCreador:init(entidad,ox,oy,properties)

  local body = love.physics.newBody(entidad.world,ox,oy,"dynamic")
  local shape = love.physics.newCircleShape(25)
  local fixture = love.physics.newFixture(body,shape)
  
  meteorito(entidad,body,shape,fixture,ox,oy,0,properties,50,50)
end
  
return meteoritoCreador