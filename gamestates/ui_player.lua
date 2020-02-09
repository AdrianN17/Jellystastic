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
end

function ui_player:check_arma(x,y)
  
  for i,k in pairs(self.aabb_armas) do
    
    if x > k.x and x <k.x+k.w and y > k.y and y <k.y+k.h then

      local player = self.gameobject.player[1]
  
      if k.index == tostring(player.arma_index) then
        player:recargar_arma()
      else
        player:keypressed(k.index)
      end
    end
  end
end

return ui_player