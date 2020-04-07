local mundoSecundario = require "gamestates.mundo_secundario"
local mundoGenerico = require "gamestates.mundo_generico"

local mundoPrincipal = Class{
  __includes = {mundoGenerico}
}

function mundoPrincipal:init()
  
  self.mundoGuardado = {}
  
end

function mundoPrincipal:enter(_,data,dataExtra)

  Switch(data.accion, {
    
    crear = function()
      if data.mapaIndex then
        self.mapaIndex = data.mapaIndex
        
        mundoGenerico.init(self,Map_index.campana[self.mapaIndex]["main"])
        
      end
    end,
    
    limpiar = function()
      self:limpiar()
    end,
    
    cambiarPosicion = function()
      
      local puertaData = dataExtra.puertaData
      local playerData = dataExtra.playerData
      
      local puerta = self:buscarPuertas(puertaData)
      
      local player = self.gameobject.jugadores[self.indexPlayer]

      if puerta then
        local x,y = puerta.ox,puerta.oy
          
        if player then
          player.body:setLinearVelocity(0,0)
          player.body:setPosition( x, y )
        end
      end
      
      if playerData then
        player:set(playerData)
      end
      
    end
    
  })
    
end

function mundoPrincipal:limpiar()
  for _,k in pairs(self.mundoGuardado) do
    if k then
      k:limpiarEscenario()
    end
  end
  
  self.mundoGuardado = {}
  
  self:limpiarEscenario()
  
  self:enter(_,self.mapaIndex)
  
end

function mundoPrincipal:cambiarSubnivel(puertaData)
  local player = self.gameobject.jugadores[self.indexPlayer]
  
  if player then
    
    player:limpiarMovimiento()
    
    local dataExtra = {playerData = player:get(),puertaData = puertaData}
    
    if not self.mundoGuardado[puertaData.id_mapa] then
      
      if Map_index.campana[self.mapaIndex][puertaData.nivel] then
        
        Gamestate.switch(mundoSecundario,dataExtra)
        
      end
    else
      
      player:clearPuerta()
      Gamestate.push(self.mundoGuardado[puertaData.nivel],dataExtra)
    end
  end
end

function mundoPrincipal:cambiarNivel()
  if Map_index.campana[self.mapaIndex+1] and map_index.campana[self.mapaIndex+1]["main"] then
    Gamestate.switch(mundoSecundario,self.mapaIndex+1)
  end
end


return mundoPrincipal