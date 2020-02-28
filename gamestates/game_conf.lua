local Class = require "libs.hump.class"

local game_conf_default = require "gamestates.game_conf_default"
local game_conf_subnivel = require "gamestates.game_conf_subnivel"

local game_conf = Class{
  __includes = {game_conf_default}
}

function game_conf:init()
  self.mundos = {}
  
  
  
end

function game_conf:enter(_,nombreMapa,accion,data,data_player)
  
  if nombreMapa then
    self.nombreMapa = nombreMapa
    game_conf_default.init(self,map_index.campana[nombreMapa]["main"])
    
    if self.gameobject.player[self.index_player] and love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" and not joy_movimiento and not joy_disparo then
  
    local style = {
      showBorder = true,
      bgColor = {0, 0, 0,0.2}
    }
    gooi.setStyle(style)
    
    
    joy_movimiento = gooi.newJoy({size = 150*self.scale,  x = 150*self.scale,y = self.screen_y_normal - 150*self.scale, deadZone = 0.2}):setDigital():setStyle({showBorder = true}):setImage("assets/img/joystick.png")
    joy_disparo = gooi.newJoy({size = 150*self.scale, x = self.screen_x - 300*self.scale,y = self.screen_y_normal - 150*self.scale, deadZone = 0.2}):setStyle({showBorder = true}):setImage("assets/img/joystick.png"):noSpring() 
    end
    
  end
  
  
  
  if accion == "limpiar" then
    self:clear()
  elseif accion == "cambiar_pos" then
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

function game_conf:ir_a_otro_nivel(data_puerta)
  if joy_movimiento then
    joy_movimiento:restore()
  end
  
  self.gameobject.player[self.index_player]:limpiar_movimiento()
  
  if not self.mundos[data_puerta.id_mapa] then
    if map_index.campana[self.nombreMapa][data_puerta.id_mapa] then
      local player = self.gameobject.player[self.index_player]
      local data_player = {bala = player.armas_values,arma_index = player.arma_index, hp = player.hp, iterador = player.iterador,
      cooldown = player.cooldown, cooldown_iterador = player.cooldown_iterador}
      
      player:clear_puerta()
      Gamestate.switch(game_conf_subnivel,data_puerta,data_player)
      
    end
  else
    local player = self.gameobject.player[self.index_player]
    local data_player = {bala = player.armas_values,arma_index = player.arma_index, hp = player.hp, iterador = player.iterador,
      cooldown = player.cooldown, cooldown_iterador = player.cooldown_iterador}
    
    
    player:clear_puerta()
    Gamestate.push(self.mundos[data_puerta.id_mapa],data_puerta,data_player)
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