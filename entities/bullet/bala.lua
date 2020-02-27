local Class = require "libs.hump.class"
local Misil = require "entities.bullet.misil"

local bala = Class{
  __include = {}
}

function bala:init(target)
  self.bx,self.by = 0,0
  self.max_distancia_bala = 1500
  
  self.bala_objetivos = {}
  self.target = target
  
  if self.direccion == -1 then
    self.bala_radio = math.rad(180)
  else
    self.bala_radio = math.rad(0)
  end
  
  --armas
  
  self.arma_index = 0
  
  self.armas_values = {}
  --pistola
  self.armas_values[1] = {stock = 0, max_stock = 14, municion = 0, max_municion = 70, enable = false, dano = 1, tiempo = 0.5, tiempo_recarga = 0.7, raycast = true}
  --desert eagle
  self.armas_values[2] = {stock = 0, max_stock = 8, municion = 0, max_municion = 40, enable = false, dano = 1.2, tiempo = 0.9, tiempo_recarga = 0.9, raycast = true}
  --uzi
  self.armas_values[3] = {stock = 0, max_stock = 30, municion = 0, max_municion = 120, enable = false, dano = 0.5, tiempo = 0.15, tiempo_recarga = 0.5, raycast = true}
  
  --lanzagranadas
  self.armas_values[6] = {stock = 0, max_stock = 2, municion = 0, max_municion = 6, enable = false, dano = 10, tiempo = 1 ,tiempo_recarga = 1.5, raycast = false, index_bala= 1}
  
  --timer
  
  self.timer_balas = nil
  self.timer_recarga = nil
  
  self.raycast_bala_disparo = function (fixture, x, y, xn, yn, fraction)
    if not fixture:isSensor( ) then
      local tipo_obj=fixture:getUserData()
      
      if tipo_obj then
        table.insert(self.bala_objetivos,{x=x,y=y,name = tipo_obj.data, obj = tipo_obj.obj})
      end
    end
    
    return 1
  end
  
  --otros
  self.rf = 1
  
  self.df = 1
  self.min_angle = {}
  self.min_angle[-1] =  math.rad(110)
  self.min_angle[1] =  math.rad(-70)
  self.max_angle = {}
  self.max_angle[-1] = math.rad(250)
  self.max_angle[1] = math.rad(70)
  
  
end

function bala:update_bala_player()
  if love.system.getOS( ) == "Windows" or love.system.getOS( ) == "Linux" or love.system.getOS( ) == "OS X" then
    self:update_bala_desktop()
  else
    self:update_bala_android()
  end
end

function bala:update_bala_enemigo(dt)
  
  if self.acciones.current == "mover" then
    self.bala_radio = (self.bala_radio +dt*self.df)
    
    if self.bala_radio>self.max_angle[self.direccion] or self.bala_radio<self.min_angle[self.direccion] then
      self.df = self.df*-1
      
    end
    
  elseif self.acciones.current == "atacar" then
    
    local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
    self.bala_radio = math.atan2(cy- self.obj_presa.oy,cx- self.obj_presa.ox)+math.pi
    
  end
  
  local bx = math.cos(self.bala_radio)
    
  if bx>0 then
    self.rf = 1
  else
    self.rf = -1
  end
  
end

function bala:update_bala_desktop()
  if self.arma_index>0 then
    self.bx,self.by = self.entidad.cam:toWorld(love.mouse.getX(),love.mouse.getY())
    local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
    
    
    if self.bx>cx then
      self.rf = 1
    else
      self.rf = -1
    end
    
    
    self.bala_radio = math.atan2(cy-self.by,cx-self.bx)+math.pi
  end
end

function bala:update_bala_android()
  if self.arma_index>0 then
    self.bx,self.by = self.entidad:analogico()
    
    if self.bx>=0 then
      self.rf = 1
    else
      self.rf = -1
    end
    

    self.bala_radio = math.atan2(self.by,self.bx)
  end
 
end

function bala:draw_bala()
  
  local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
  
  
  love.graphics.line(cx, cy,cx + math.cos(self.bala_radio)*self.max_distancia_bala,cy + math.sin(self.bala_radio)*self.max_distancia_bala)
  
  if self.arma_index > 0 and self.armas_values[self.arma_index].enable then

    local quad = self.spritesheet_arma.quad[self.arma_index]
    local scale = self.spritesheet_arma.scale[self.arma_index]
    local x,y,w,h = quad:getViewport()
    
    love.graphics.draw(self.spritesheet_arma["img"],quad,cx,cy,self.bala_radio,scale.x,scale.y*self.rf,w/2,h/2)
    
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
    
    if obj_name == "enemy" then
      local x = obj_target.ox - self.ox
      
      if (x<0 and obj_target.direccion<0 ) or (x>0 and obj_target.direccion>0) then
        
        obj_target.direccion = obj_target.direccion*-1
        
        if obj_target.voltear then
          obj_target:voltear()
        end
      end
      
    elseif obj_name == "player" then
      obj_target:cambiar_estado("agujereado")
    end
    
  end
  
end

function bala:generar_bala_raycast()
  
  local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
  
    self.entidad.world:rayCast(cx,cy,cx + math.cos(self.bala_radio)*self.max_distancia_bala,cy + math.sin(  self.bala_radio)*self.max_distancia_bala,self.raycast_bala_disparo)
    
    self:unico_target()
    
    self.bala_objetivos = {}
end




function bala:recarga(arma_index)
  local arma = self.armas_values[arma_index]
    
    if arma.max_stock>arma.stock and arma.municion>0 then
      if arma.municion + arma.stock < arma.max_stock then
        arma.stock=arma.municion+arma.stock
        arma.municion=0
      else
        local carga=arma.max_stock-arma.stock
        arma.stock=arma.stock+carga
        arma.municion=arma.municion-carga
      end
    end
end

function bala:disparo(arma_index)
  local arma = self.armas_values[arma_index]
    
    if arma.stock>=1 then
      
      if arma.raycast then
        self:generar_bala_raycast()
      else
        --arma fisica
        local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
        Misil(self.entidad,self.spritesheet_arma,cx,cy,self.bala_radio,self.creador,self.armas_values[self.arma_index].index_bala,self.armas_values[self.arma_index].dano)
      end
      
      arma.stock = arma.stock-1
    end
    
    if arma.tiempo ~= 0 then
      self.timer_balas = nil
      self.timer_balas = self.timer:every(arma.tiempo,
        function()
          if arma.stock>=1 then
            
            if arma.raycast then
              self:generar_bala_raycast()
            else
              --arma fisica
              local cx, cy = self.body2:getWorldPoints(self.mano_fisica.shape_mano:getPoint())
              Misil(self.entidad,self.spritesheet_arma,cx,cy,self.bala_radio,self.creador,self.armas_values[self.arma_index].index_bala,self.armas_values[self.arma_index].dano)
            end
            
            arma.stock = arma.stock-1
          end
        end)
    end
end

function bala:restaurar_radio()
  if self.direccion == -1 then
    self.bala_radio = math.rad(180)
  else
    self.bala_radio = math.rad(0)
  end
end

function bala:recargar_arma()
  
  if self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
    local balas = self.armas_values[self.arma_index]
  
    if balas.stock<balas.max_stock and balas.municion>0 then
      self.timer_recarga = nil
      self.timer_recarga = self.timer:after(self.armas_values[self.arma_index].tiempo_recarga, function()
        self:recarga(self.arma_index)
        self.timer:cancel(self.timer_recarga)
        self.timer_recarga = nil
      end)
    end
  end
end

function bala:disparo_balas()
  if self.arma_index > 0 and not self.timer_recarga and not self.timer_balas then
    self:disparo(self.arma_index)
  end
end

function bala:terminar_disparo_balas()
  if self.arma_index > 0 and self.timer_balas then
    self.timer:cancel(self.timer_balas)
    self.timer_balas = nil
  end
end

function bala:recargar_max()
  local bala = self.armas_values[self.arma_index]
  self.armas_values[self.arma_index].stock = bala.max_stock
  self.armas_values[self.arma_index].municion = bala.max_municion
  
  self.armas_values[self.arma_index].enable = true
end
  
return bala
  