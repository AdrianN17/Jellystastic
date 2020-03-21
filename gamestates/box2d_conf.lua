local Class = require "libs.hump.class"

local box2d_conf = Class{}

function box2d_conf:callbacks()
  local beginContact =  function(a, b, coll)
    
    local obj1, obj2 = self:validar_pos(a,b)
   
    if obj1 and obj2 then
      if (obj1.data == "player" or obj1.data == "baba" or obj1.data=="soldier" or obj1.data=="npc") and (obj2.data == "map_object" or obj2.data == "bajada") then
        
        local x,y = coll:getNormal()
        
        if y < 0 then
          
          local r = math.round(math.deg(math.atan2(y,x)))
                  
          local r_abs = math.abs(r) 
          
          if(r_abs < 125 and r_abs > 75) then
            r = math.rad(r)

            self.timer:after(0.01, 
              function()  
                if obj1.obj then
                  obj1.obj.body:setAngle(r+math.pi/2) 
                  obj1.obj.body2:setAngle(r+math.pi/2) 
                end
              end)
          end
          
          
        end
          
      elseif obj1.data == "enemy_bullet" and (obj2.data == "map_object" or obj2.data == "bedrock" or obj2.data == "movible" or obj2.data == "bajada") then
        local x,y = coll:getPositions()
        
        self.timer:after(2.5,function()  
          if obj1.obj then
            obj1.obj:remove()
          end
        end)

      elseif (obj1.data == "player" or obj1.data == "soldier" or obj1.data=="npc") and obj2.data == "enemy_bullet" then
        
        if obj2.obj.direccion == obj1.obj.direccion then
          
          if obj1.data ~= "player" then
            obj1.obj.direccion=obj1.obj.direccion*-1
          end
          
          if obj1.obj.voltear then
            obj1.obj:voltear()
          end
        end
        
        self:dano(obj1.obj,obj2.obj.dano)
        obj2.obj:remove()
        obj1.obj:cambiar_estado("semizombie")
        
      elseif (obj1.data == "baba" or obj1.data == "soldier" or obj1.data == "player" or obj1.data == "object" or obj1.data == "enemy_bullet" or obj1.data == "door" or obj1.data=="npc") and obj2.data == "explosion" then
        obj2.obj:guardar(obj1)
      elseif obj1.data == "player" and obj2.data == "object" then
        obj1.obj.item_touch = obj2.obj
      elseif obj1.data == "player" and obj2.data == "movible" then
        if not obj1.obj.objetivo_movible then
          local x,y = coll:getNormal()
          
          if math.abs(x)>0.89 and math.abs(y)<0.1 then
            local cx,cy = coll:getPositions()
            
            obj1.obj.objetivo_movible = {obj = obj2.obj, x = cx, y = cy}
          end

        end
      elseif obj1.data == "pierna" and (obj2.data == "map_object" or obj2.data == "movible" or obj2.data == "bajada") then
        self.timer:after(0.001, function()
          if obj1.obj.body:getType() == "dynamic" then
            obj1.obj.body:setType( "static" )
          end
        end)
      end    
    end
  end
  
  local endContact =  function(a, b, coll)
    local obj1, obj2 = self:validar_pos(a,b)
    
    if obj1 and obj2 then
      if obj1.data == "player" and obj2.data == "liquido" then
        obj2.obj:eliminar(obj1.obj)
      elseif obj1.data == "player" and obj2.data == "object" then
        obj1.obj.item_touch = nil
      elseif obj1.data == "player" and obj2.data == "movible" then
        obj1.obj.objetivo_movible = false
      end   
    end
  end
  
  local preSolve =  function(a, b, coll)
    local obj1, obj2 = self:validar_pos(a,b)
    
    if obj1 and obj2 then

      if (obj1.data == "player" or obj1.data == "npc" or obj1.data == "soldier") and obj2.data == "baba" then
        if obj2.obj.multi_ataque and obj2.obj.obj_presa == obj1.obj then
          
          if obj2.obj.direccion == obj1.obj.direccion then
            
            if obj1.data ~= "player" then
              obj1.obj.direccion=obj1.obj.direccion*-1
            end
            
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
      elseif obj1.data == "baba" and obj2.data == "enemy_bullet" then
        --if obj1.obj.creador == obj2.obj.creador then
          coll:setEnabled( false )
        --end
      elseif obj1.data == "player" and obj2.data == "npc" then
        coll:setEnabled( false )
        self.timer:after(0.1,function() 
          obj2.obj:save_remove()
        end)
      elseif obj1.data ==  obj2.data then
        coll:setEnabled( false )
      elseif obj1.data == "player" and obj2.data == "liquido" then
        obj2.obj:buoyancy(25,obj2.obj.fixture,obj1.obj.fixture,coll)
      elseif obj1.data == "bullet" and (obj2.data == "bedrock" or obj2.data == "map_object" or obj2.data == "movible" or obj2.data == "bajada") then
        coll:setEnabled( false )
        local x,y = coll:getPositions()
        obj1.obj:remove(x,y)
        coll:release( )
      elseif (obj1.data == "player" or obj1.data == "baba" or  obj1.data == "soldier" or obj1.data == "enemy_bullet"  or obj1.data=="npc") and obj2.data == "bullet" then

        local x,y = coll:getPositions()
        coll:setEnabled( false )
        
        if obj2.obj.direccion == obj1.obj.direccion then
          
          if obj1.data ~= "player" then
            obj1.obj.direccion=obj1.obj.direccion*-1
          end
          
          if obj1.obj.voltear then
            obj1.obj:voltear()
          end
        end
        
        if obj1.obj.cambiar_estado then
          obj1.obj:cambiar_estado("agujereado")
        end
          
        if obj1.data == "enemy_bullet" then
          obj1.obj:remove()
          obj2.obj:remove()
        elseif obj1.data == "player" or obj1.data == "baba" or  obj1.data == "soldier" then
          if obj1.obj.creador ~= obj2.obj.creador then

            self:dano(obj1.obj,obj2.obj.dano)
             
            obj2.obj:remove(x,y)
          end
        end
        
        coll:release( )
      elseif (obj1.data == "map_object" or obj1.data == "bedrock" or obj2.data == "bajada") and obj2.data == "meteorito" then
        obj2.obj:mover()
      elseif (obj1.data == "player" or obj1.data == "baba" or  obj1.data == "soldier" or obj1.data == "npc") and obj2.data == "meteorito" then
        
        coll:setEnabled( false )
        
        if not obj1.obj.acciones.invulnerable then
          self:dano(obj1.obj,obj2.obj.dano)
          
          obj1.obj.acciones.invulnerable = true
          
          if obj1.obj.cambiar_estado then
            obj1.obj:cambiar_estado("canon")
          end
          
          self.timer:after(1,function() 
            if obj1.obj then
              obj1.obj.acciones.invulnerable=false
            end
          end)
        end
      elseif obj1.data == "player" and obj2.data == "bajada" then
        local x,y = coll:getNormal()
        if y>0 then
          coll:setEnabled( false )
        else
          if obj1.obj.movimiento.s then
            coll:setEnabled( false )
          end
        end
      elseif obj1.data == "movible" and obj2.data == "bajada" then
        local x,y = coll:getNormal()
        
        if obj1.obj.is_joint then
          coll:setEnabled( false )
        elseif  y>0 then
          coll:setEnabled( false )
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