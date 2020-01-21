local Class = require "libs.hump.class"

local bala = Class{
  __include = {}
}

function bala:init(target)
  self.bx,self.by = self.entidad.cam:toWorld(love.mouse.getX(),love.mouse.getY())
  self.max_distancia_bala = 1000
  self.bala_radio = 0
  self.bala_objetivos = {}
  self.target = target
  
  --armas
  
  self.arma_index = 0
  
  self.armas_values = {}
  --pistola
  self.armas_values[1] = {stock = 14, max_stock = 14, municion = 70, max_municion = 70, enable = true, dano = 1, tiempo = 0, raycast = true}
  --desert eagle
  self.armas_values[2] = {stock = 8, max_stock = 8, municion = 40, max_municion = 40, enable = false, dano = 1.5, tiempo = 0, raycast = true}
  --uzi
  self.armas_values[3] = {stock = 30, max_stock = 30, municion = 120, max_municion = 120, enable = true, dano = 0.5, tiempo = 0.05, raycast = true}
  
  --lanzagranadas
  self.armas_values[6] = {stock = 2, max_stock = 2, municion = 5, max_municion = 5, enable = true, dano = 0.5, tiempo = 0, raycast = false}
  
  --timer
  
  self.timer_balas = nil
  
  self.raycast_bala_disparo = function (fixture, x, y, xn, yn, fraction)
    local tipo_obj=fixture:getUserData()
    
    if tipo_obj then
        table.insert(self.bala_objetivos,{x=x,y=y,name = tipo_obj.data, obj = tipo_obj.obj})
    end
    
    return 1
    
  end
end

function bala:update_bala()
  self.bx,self.by = self.entidad.cam:toWorld(love.mouse.getX(),love.mouse.getY())
  
  self.bala_radio = math.atan2(self.oy-self.by,self.ox-self.bx)+math.pi

end

function bala:draw_bala()
  
  local cx, cy = self.body:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
  
  
  love.graphics.line(cx, cy,cx + math.cos(self.bala_radio)*self.max_distancia_bala,cy + math.sin(self.bala_radio)*self.max_distancia_bala)
  
  if self.arma_index > 0 and self.armas_values[self.arma_index].enable then

    local quad = self.spritesheet_arma.quad[self.arma_index]
    local scale = self.spritesheet_arma.scale[self.arma_index]
    local x,y,w,h = quad:getViewport()
    
    
    love.graphics.print(math.deg(self.bala_radio),self.ox,self.oy-200)
    
    local rf = 1
    local rad = math.deg(self.bala_radio)
    if rad<270 and rad>90 then
      rf = -1
    end
  
    
    love.graphics.draw(self.spritesheet_arma["img"],quad,cx,cy,self.bala_radio,scale.x,scale.y*rf,w/2,h/2)
  end
  
end

function bala:unico_target()
  if #self.bala_objetivos<1 then
    return
  end
  
  
  local distance = 9999
  local obj_target = nil
  local obj_name = ""
  
  for _,obj in ipairs(self.bala_objetivos) do
    local d = self.entidad:distance(self.ox,self.oy,obj.x,obj.y) 
    
    if distance>d then
      distance = d 
      obj_target = obj.obj
      obj_name = obj.name
    end
  end
  
  if obj_target and obj_name == self.target then
    local arma = self.armas_values[self.arma_index]
    obj_target.hp = obj_target.hp -arma.dano
  end
  
end
  
return bala
  