local mundoGenerico = require "gamestates.mundo_generico"

local mundoSecundario = Class{
  __includes ={mundoGenerico}
}

function mundoSecundario:init()
  self.mainMapa = nil
end

function mundoSecundario:enter(from,dataExtra)

  self.mainMapa = from
  
  if dataExtra then
    
    local puertaData = dataExtra.puertaData
    local playerData = dataExtra.playerData
    
    if puertaData and  playerData then
      
      
      if not self.mainMapa.mundoGuardado[puertaData.nivel] then
        
        self.mainMapa.mundoGuardado[puertaData.nivel] = self
        
        mundoGenerico.init(self,Map_index.campana[self.mainMapa.mapaIndex][puertaData.nivel])
        
        local puerta = self:buscarPuertas(puertaData)
        
        if puerta then
          
          local x,y = puerta.ox,puerta.oy
          local dataCreacion = playerData.dataCreacion 
          
          local body = love.physics.newBody(self.world,dataCreacion.ox,dataCreacion.oy,"dynamic")
          local shape = love.physics.newPolygonShape(dataCreacion.shapeTableClear)
          local fixture = love.physics.newFixture(body,shape)
          
          local player = Entities_index.player(self,body,shape,fixture,dataCreacion.ox,dataCreacion.oy,dataCreacion.radio,dataCreacion.shapeTableClear,dataCreacion.properties,dataCreacion.width,dataCreacion.height)
          
          fixture:setUserData({obj = player, nombre = dataCreacion.properties.userdataNombre})
          
          local x,y = puerta.ox,puerta.oy
          
          if player then
            player.body:setLinearVelocity(0,0)
            player.body:setPosition( x, y )
          end
          
        end
      else
        local puerta = self:buscarPuertas(puertaData)
        if puerta then
          
          local x,y = puerta.ox,puerta.oy
          local player = self.gameobject.jugadores[self.indexPlayer]
          
          if player then
            player.body:setLinearVelocity(0,0)
            player.body:setPosition( x, y )
          end
        end
        
      end
      
      local player = self.gameobject.jugadores[self.indexPlayer]
      
      if player then
        player:set(playerData)
      end
      
      
    end
  end
  
end

function mundoSecundario:cambiarSubnivel(puertaData)
  local player = self.gameobject.jugadores[self.indexPlayer]
  
  if player then
    player:limpiarMovimiento()
    
    local dataExtra = {playerData = player:get(),puertaData = puertaData}
    
    player:clearPuerta()
    
    Gamestate.push(self.mainMapa,{mapaIndex = index,accion = "cambiarPosicion"},dataExtra)
    
  end
  
end


function mundoSecundario:limpiar()
  Gamestate.push(self.mainMapa,_,"limpiar")
end

return mundoSecundario