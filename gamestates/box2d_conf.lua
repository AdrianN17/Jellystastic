local Class = require "libs.hump.class"

local box2d_conf = Class{}

function box2d_conf:callbacks()
  local beginContact =  function(a, b, coll)
    
    local obj1, obj2 = self:validar_pos(a,b)
   
    if obj1 and obj2 then
      if (obj1.data == "player" or obj1.data == "baba" or obj1.data=="soldier" or obj1.data=="npc") and obj2.data == "map_object" then
        local x,y = coll:getNormal()
    
        local r = self:round(math.deg(math.atan2(y,x)))
        
        local r_abs = math.abs(r) 
        
        if(r_abs < 115 and r_abs > 65 and r<0) then
          r = math.rad(r)

          self.timer:after(0.01, 
            function()  
              if obj1.obj then
                obj1.obj.body:setAngle(r+math.pi/2) 
                obj1.obj.body2:setAngle(r+math.pi/2) 
              end
            end)
        end
          
      elseif obj1.data == "enemy_bullet" and obj2.data == "map_object" then
        local x,y = coll:getPositions()
        
        self.timer:after(2.5,function()  
          if obj1.obj then
            obj1.obj:remove()
          end
        end)

      elseif (obj1.data == "player" or obj1.data == "soldier" or obj1.data=="npc") and obj2.data == "enemy_bullet" then
        
        if obj2.obj.direccion == obj1.obj.direccion then
          obj1.obj.direccion=obj1.obj.direccion*-1
          
          if obj1.obj.voltear then
            obj1.obj:voltear()
          end
        end
        
        self:dano(obj1.obj,obj2.obj.dano)
        obj2.obj:remove()
        obj1.obj:cambiar_estado("semizombie")
        
      elseif (obj1.data == "baba" or  obj1.data == "soldier" or obj1.data == "map_object" or obj1.data == "enemy_bullet" or obj1.data=="npc") and obj2.data == "destructive_bullet" then
        local x,y = coll:getPositions()
        
        if obj2.obj.direccion == obj1.obj.direccion then
          obj1.obj.direccion=obj1.obj.direccion*-1
          
          if obj1.obj.voltear then
            obj1.obj:voltear()
          end
        end
        
        
          self.timer:after(0.01,function()
            obj2.obj:crear_circulo(x,y,self.explosion_scale)
          end)
      elseif (obj1.data == "baba" or obj1.data == "soldier" or obj1.data == "player" or obj1.data == "map_object" or obj1.data == "object" or obj1.data == "enemy_bullet" or obj1.data == "door" or obj1.data=="npc") and obj2.data == "explosion" then
        obj2.obj:guardar(obj1)
      elseif obj1.data == "player" and obj2.data == "object" then
        obj2.obj:usar(obj1.obj)
      end
      
      
    end
  end
  
  local endContact =  function(a, b, coll)
    local obj1, obj2 = self:validar_pos(a,b)
    
    if obj1 and obj2 then

    end
  end
  
  local preSolve =  function(a, b, coll)
    local obj1, obj2 = self:validar_pos(a,b)
    
    if obj1 and obj2 then

      if (obj1.data == "player" or obj1.data == "npc" or obj1.data == "soldier") and obj2.data == "baba" then
        if obj2.obj.multi_ataque and obj2.obj.obj_presa == obj1.obj then
          
          if obj2.obj.direccion == obj1.obj.direccion then
            obj1.obj.direccion=obj1.obj.direccion*-1
            
            if obj1.obj.voltear then
              obj1.obj:voltear()
            end
          end
          
        else
           coll:setEnabled( false )
        end
        
        if not obj1.obj.acciones.invulnerable and obj2.obj.dano_tocar then
          self:dano(obj1.obj,2)
          obj1.obj.acciones.invulnerable = true
          obj1.obj:cambiar_estado("semizombie")
          self.timer:after(1,function() 
            if obj1.obj then
              obj1.obj.acciones.invulnerable=false
            end
          end)
        end
      elseif (obj1.data == "player" or obj1.data == "npc" or obj1.data == "soldier") and obj2.data == "soldier" then
        coll:setEnabled( false )
      elseif obj1.data == "soldier" and obj2.data == "baba" then
        coll:setEnabled( false )
      elseif (obj1.data == "player" or obj1.data == "soldier") and obj2.data == "destructive_bullet" then
        if obj1.obj.creador == obj2.obj.creador then
          coll:setEnabled( false )
        end
      elseif obj1.data == "baba" and obj2.data == "enemy_bullet" then
        if obj1.obj.creador == obj2.obj.creador then
          coll:setEnabled( false )
        end
      elseif obj1.data == "player" and obj2.data == "npc" then
        coll:setEnabled( false )
        obj2.obj:remove()
      elseif obj1.data ==  obj2.data then
        coll:setEnabled( false )
      end
    end
  end
  
  local postSolve =  function(a, b, coll, normalimpulse, tangentimpulse)
    local obj1, obj2 = self:validar_pos(a,b)
    
    if obj1 and obj2 then
      
    end
	end

	return beginContact,endContact,preSolve,postSolve
end

return box2d_conf