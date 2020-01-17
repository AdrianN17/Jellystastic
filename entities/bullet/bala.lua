local Class = require "libs.hump.class"

local bala = Class{
  __include = {}
}

function bala:init(target)
  self.bx,self.by = self.entidad.cam:toWorld(love.mouse.getX(),love.mouse.getY())
  self.max_distancia_bala = 1000
  self.bala_radio = 0
  self.bala_objetivos = {}
  
  --armas
  
  self.arma_index = 1
  
  self.armas_values = {}
  self.armas_values[1] = {stock = 30, max_stock = 30, municion = 90, max_municion = 90, enable = true}
  
  
  self.raycast_bala_disparo = function (fixture, x, y, xn, yn, fraction)
    local tipo_obj=fixture:getUserData()
  
    if tipo_obj and tipo_obj.data==target then
      table.insert(self.bala_objetivos,tipo_obj.obj)
    end

    return -1
  end
end

function bala:update_bala()
  self.bx,self.by = self.entidad.cam:toWorld(love.mouse.getX(),love.mouse.getY())
  
  self.bala_radio = math.atan2(self.oy-self.by,self.ox-self.bx)+math.pi

end

function bala:draw_bala()
  --love.graphics.line(self.ox,self.oy,self.ox + math.cos(self.bala_radio)*self.max_distancia_bala,self.oy + math.sin(self.bala_radio)*self.max_distancia_bala)
  
  if self.arma_index > 0 and self.armas_values[self.arma_index].enable then

    local quad = self.spritesheet_arma.quad[self.arma_index]
    local scale = self.spritesheet.scale
    local x,y,w,h = quad:getViewport()
  
    
    love.graphics.draw(self.spritesheet_arma["img"],quad,self.ox,self.oy,self.bala_radio,scale.x,scale.y,w/2,h/2)
  end
  
end

function bala:unico_target()
  if #self.bala_objetivos<1 then
    return
  end
  
  
  local distance = 9999
  local obj_target = nil
  
  for _,obj in ipairs(self.bala_objetivos) do
    local d = self.entidad:distance(self.ox,self.oy,obj.ox,obj.oy) 
    
    if distance>d then
      distance = d 
      obj_target = obj
    end
  end
  
  obj_target.hp = obj_target.hp -1
  
end
  
return bala
  