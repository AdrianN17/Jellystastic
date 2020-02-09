local Class = require "libs.hump.class"

local ui_player = Class {}

function ui_player:init()
  self.aabb_armas={}
  self.validar_aabb_armas = true
  
  local player = self.gameobject.player[1]
  self.weapons = player.spritesheet_arma
  
  self.camera_x_ui = self.screen_x - self.espacio_x
end

function ui_player:draw_ui()
    
    local counter = 0
    
    for i=1,6,1 do
      local quad = self.weapons.quad[i]
    
      if quad then
        local scale = self.weapons.scale_screen[i]
        local x,y,w,h = quad:getViewport()
                
        love.graphics.draw(self.weapons.img,quad,self.camera_x_ui, counter,0,scale.x/self.scale_dpi,scale.y/self.scale_dpi)
        
        if self.validar_aabb_armas then
          table.insert(self.aabb_armas,{x = self.camera_x_ui,y=counter,w=w*(scale.x/self.scale_dpi),h=h*(scale.y/self.scale_dpi),index=tostring(i)})
        end
        
        counter = counter + (h*scale.y)/self.scale_dpi+((h*scale.y)*0.5)/self.scale_dpi
      end
    end
    
    self.validar_aabb_armas = false

  
  for i,k in pairs(self.aabb_armas) do
    love.graphics.rectangle("line",k.x,k.y,k.w,k.h)
  end
  
  if self.gameobject.player[1] and love.system.getOS( ) == "Android" or love.system.getOS( ) == "iOS" then
    love.graphics.rectangle("line",(self.camera_x_ui/2) - (180*self.scale)/2 ,self.screen_y_normal - 100*self.scale ,180*self.scale,100*self.scale)
  end
end

function ui_player:check_arma(x,y,tipo)
  
  local player = self.gameobject.player[1]
  
  if player then
    if tipo == 1 then
      for i,k in pairs(self.aabb_armas) do
        
        if x > k.x and x <k.x+k.w and y > k.y and y <k.y+k.h then

          if k.index == tostring(player.arma_index) then
            -- a futuro presionar donde salga las balas para recargar
            player:recargar_arma()
          else
            player:keypressed(k.index)
          end
        end
      end
    end   
    
    local x_d,y_d = (self.camera_x_ui/2) - (100*self.scale)/2, self.screen_y_normal - 100*self.scale
    local w_d,h_d = 180*self.scale,100*self.scale
    
    if x > x_d and x <x_d+w_d and y > y_d  and y <y_d +h_d then
      if tipo == 1 then
        player:disparo_balas()
      elseif tipo == 2 then
        player:terminar_disparo_balas()
      end
    end
  end
end

return ui_player