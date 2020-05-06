local mundoSecundario = require "gamestates.mundo_secundario"
local mundoGenerico = require "gamestates.mundo_generico"

local mundoPrincipal = Class{
  __includes = {mundoGenerico}
}

function mundoPrincipal:init()
  if self.mundoGuardado then return end
  self.mundoGuardado = {}
end

function mundoPrincipal:enter(_,data,dataExtra)

  if data then
    Switch(data.accion, {

      crear = function()
        if data.mapaIndex then
          self.mapaIndex = data.mapaIndex

          mundoGenerico.init(self,Map_index.campana[self.mapaIndex]["main"])

          if self.gameobject.jugadores and self.gameobject.jugadores[self.indexPlayer] then
            local player = self.gameobject.jugadores[self.indexPlayer]
            player:setPlayerValues(_G.playerValues)
          end

        end
      end,

      limpiar = function()

        self:limpiar()

      end,

      cambiarMapa = function()
        self:cambiarNivel()
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

end

function mundoPrincipal:limpiarSolo()
  for _,k in pairs(self.mundoGuardado) do
    if k then
      k:limpiarEscenario()
    end
  end

  self.mundoGuardado = {}

  self:limpiarEscenario()

end

function mundoPrincipal:limpiar()
  self:limpiarSolo()

  self:enter(_,{accion="crear",mapaIndex=self.mapaIndex})
end

function mundoPrincipal:updateFisicas(dt)
  for _,mundo in ipairs(self.mundoGuardado) do
    mundo.world:update(dt)
  end
end

function mundoPrincipal:cambiarSubnivel(puertaData)
  local player = self.gameobject.jugadores[self.indexPlayer]

  if player then

    player:limpiarMovimiento()

    local dataExtra = {playerData = player:get(),puertaData = puertaData}

    if not self.mundoGuardado[puertaData.nivel] then
      if Map_index.campana[self.mapaIndex][puertaData.nivel] then
        local nuevoEscenario = mundoSecundario()
        Gamestate.switch(nuevoEscenario,dataExtra)

      end
    else
      Gamestate.push(self.mundoGuardado[puertaData.nivel],dataExtra)
    end
  end
end

function mundoPrincipal:cambiarNivel()

  if Map_index.campana[self.mapaIndex+1] and Map_index.campana[self.mapaIndex+1]["main"] then
    self:limpiarSolo()
    local nuevoEscenario = mundoPrincipal()
    Gamestate.switch(nuevoEscenario,{mapaIndex = self.mapaIndex+1,accion = "crear"})
  end
end


return mundoPrincipal