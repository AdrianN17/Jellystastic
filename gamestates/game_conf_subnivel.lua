local Class = require "libs.hump.class"

local game_conf_default = require "gamestates.game_conf_default"

local entities = require "entities.index"

local game_conf_subnivel = Class{
  __includes = {game_conf_default}
}

function game_conf_subnivel:init()
  self.main_level = nil
end

function game_conf_subnivel:enter(from,data,data_player)
  
  self.main_level = from
  
  if data then
    
    if not self.main_level.mundos[data.id_mapa] then

      self.main_level.mundos[data.id_mapa] = self
      
      game_conf_default.init(self,map_index.campana[1][1])
      
      local puerta = self.gameobject.door[data.id_puerta]
      
      local x,y = puerta.ox,puerta.oy
      
      entities.Personaje(self,{x,y},img_index)
    else
      
      local puerta = self.gameobject.door[data.id_puerta]
      local x,y = puerta.ox,puerta.oy
      local player = self.gameobject.player[self.index_player]
      
      if player then
        player.body:setLinearVelocity(0,0)
        player.body:setPosition( x, y )
        
      end
      
    end
    
    if data_player then
      local player = self.gameobject.player[self.index_player]
      
      if player then
        player.armas_values = data_player.bala
        player.arma_index = data_player.arma_index
        player.hp = data_player.hp
        player.iterador = data_player.iterador
        player.cooldown = data_player.cooldown
        player.cooldown_iterador = data_player.cooldown_iterador
      end
    end
    
    
  end
  
end

function game_conf_subnivel:ir_a_otro_nivel(data_puerta)
  if joy_movimiento then
    joy_movimiento:restore()
  end
  
  local player = self.gameobject.player[self.index_player]
  local data_player = {bala = player.armas_values,arma_index = player.arma_index, hp = player.hp, iterador = player.iterador,
    cooldown = player.cooldown, cooldown_iterador = player.cooldown_iterador}
    
  player:clear_puerta()
  
  Gamestate.push(self.main_level,_,"cambiar_pos",data_puerta,data_player)
end

function game_conf_subnivel:clear()
  Gamestate.push(self.main_level,_,"limpiar")
end

return game_conf_subnivel