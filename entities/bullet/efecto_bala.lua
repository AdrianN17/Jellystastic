local Class = require "libs.hump.class"

local efecto_bala = Class{}

function efecto_bala:init(entidad,x,y,radio,funcion,target,obj)
  self.entidad = entidad
  
  self.img = img_index.bala.img 
  self.scale = img_index.bala.scale
  
  self.ox,self.oy = x,y
  self.wi,self.hi = self.img:getDimensions()
  self.w,self.h = self.wi * self.scale.x,self.hi * self.scale.y

  self.entidad:add_obj("bullet",self)
  
  self.radio = radio - math.pi/2
  self.cx,self.cy = math.cos(radio),math.sin(radio)

  
  self.velocidad = 1500
  
  self.distance = self.hi
  
  self.ix,self.iy = x,y
  self.fx,self.fy = self.ox +(self.distance * self.cx),self.oy +(self.distance * self.cy)
  
  --datos del padre
  
  self.funcion = funcion
  self.target = target
  self.obj = obj
  
  self.bala_objetivos = {}
  
  self.raycast_buscar = function (fixture, x, y, xn, yn, fraction)
    if not fixture:isSensor( ) then
      local tipo_obj=fixture:getUserData()
      
      if tipo_obj then
        table.insert(self.bala_objetivos,{x=x,y=y,name = tipo_obj.data, obj = tipo_obj.obj})
      end
    end
    
    return 1
  end
  
  

  self.max_distancia_bala = 1500
  
end

function efecto_bala:unico_target()
  if #self.bala_objetivos<1 then
    return
  end
  
  local distance = 9999
  local obj_target = nil
  local obj_name = ""
  
  for _,obj in ipairs(self.bala_objetivos) do
    local d = math.distance(self.ox,self.oy,obj.x,obj.y) 

    for _, target_name in ipairs(self.target) do

      if distance>d and obj.name == target_name and obj.obj ~= self.obj then
        distance = d 
        obj_target = obj.obj
        obj_name = obj.name
      end
    end
  end
  
  if obj_target then
    print(obj_name)
    self:funcion()

    self.entidad:remove_obj("bullet",self)
  end
end

function efecto_bala:update(dt)
  
  self.ox = self.ox + (self.cx * self.velocidad)*dt
  self.oy = self.oy + (self.cy * self.velocidad)*dt
  
  self.entidad.world:rayCast(self.ox,self.oy,self.fx,self.fy,self.raycast_buscar)
  self:unico_target()
  self.bala_objetivos = {}
  
  self.fx,self.fy = self.ox +(self.distance * self.cx),self.oy +(self.distance * self.cy)
  
  local distance = math.distance(self.ix,self.iy,self.fx,self.fy)
  
  if distance>self.max_distancia_bala then

    self.entidad:remove_obj("bullet",self)
  end
  
end

function efecto_bala:draw()
  love.graphics.draw(self.img,self.ox,self.oy,self.radio,self.scale.x,self.scale.y,self.wi/2,0)
  

  --love.graphics.line(self.ox,self.oy,self.ox +(self.distance * self.cx),self.oy +(self.distance * self.cy))

end

return efecto_bala 