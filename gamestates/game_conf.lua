local Class = require "libs.hump.class"
img_index = require "assets/img/index"

local game_conf_default = require "gamestates.game_conf_default"

local game_conf = Class{
  __includes = {game_conf_default}
}

function game_conf:init(nombreMapa)
  game_conf_default.init(self,nombreMapa)
end

function game_conf:ir_a_subnivel()
  
end

return game_conf