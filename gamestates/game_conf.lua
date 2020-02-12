local Class = require "libs.hump.class"
img_index = require "assets/img/index"

local game_conf_default = require "gamestates.game_conf_default"
local game_conf_subnivel = require "gamestates.game_conf_subnivel"

local game_conf = Class{
  __includes = {game_conf_default}
}

function game_conf:init()
  self.mundos = {}
end

function game_conf:enter(_,nombreMapa,accion,data)
  
  if nombreMapa then
    self.nombreMapa = nombreMapa
    game_conf_default.init(self,map_index.campana[nombreMapa]["main"])
  end
  
  if accion == "limpiar" then
    self:clear()
  elseif accion == "cambiar_pos" then
    local puerta = self.gameobject.door[data.id_puerta]

    local x,y = puerta.ox,puerta.oy
    
    local player = self.gameobject.player[self.index_player]
      
    if player then
      player.body:setPosition( x, y )
    end
  end
end

function game_conf:ir_a_otro_nivel(data_puerta)
  if not self.mundos[data_puerta.id_mapa] then
    if map_index.campana[self.nombreMapa][data_puerta.id_mapa] then
      Gamestate.switch(game_conf_subnivel,data_puerta)
    end
  else
    Gamestate.push(self.mundos[data_puerta.id_mapa],data_puerta)
  end
end

function game_conf:clear()
  for _,k in pairs(self.mundos) do
    if k then
      k:default_clear()
    end
  end
  
  self.mundos = {}
  
  self:default_clear()
  
  self:enter(_,self.nombreMapa)
end

function game_conf:cambiar_mundo()
  if map_index.campana[self.nombreMapa+1] and map_index.campana[self.nombreMapa+1]["main"] then
    Gamestate.switch(game_conf,self.nombreMapa+1)
  end
end

return game_conf