local Class = require "libs.hump.class"

local box2d_conf = Class{}

function box2d_conf:callbacks()
  local beginContact =  function(a, b, coll)
    
    local obj1, obj2 = self:validar_pos(a,b)
   
    if obj1 and obj2 then
      if (obj1.data == "player" or obj1.data == "enemy") and obj2.data == "map_object" then
        local x,y = coll:getNormal()
        
        local r = self:round(math.deg(math.atan2(y,x)))
        
        
        
        local r_abs = math.abs(r) 
        
        if(r_abs < 115 and r_abs > 65 and r<0) then
          r = math.rad(r)

          self.timer:after(0.01, 
            function()  
              if obj1.obj then
                obj1.obj.body:setAngle(r+math.pi/2) 
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

      elseif obj1.data == "player" and obj2.data == "enemy_bullet" then
        self:dano(obj1.obj,obj2.obj.dano)
        obj2.obj:remove()
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

      if obj1.data == "player" and obj2.data == "enemy" then
        coll:setEnabled( false )
        if not obj1.obj.acciones.invulnerable then
          self:dano(obj1.obj,2)
          obj1.obj.acciones.invulnerable = true
          self.timer:after(1,function() 
            if obj1.obj then
              obj1.obj.acciones.invulnerable=false
            end
          end)
        end
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