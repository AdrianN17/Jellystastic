local Class = require "libs.hump.class"
local explosion = Class{}

function explosion:init(entidad,x,y,scale,dano)

  self.x,self.y=x,y
  self.body = love.physics.newBody(entidad.world,x,y,"dynamic")
  self.shape = love.physics.newCircleShape(50*scale)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  self.body:resetMassData()
  self.fixture:setUserData( {data="explosion",obj = self, pos=orden.explosion} )
  
  self.dano =dano
  self.entidad = entidad
  self.body:setGravityScale( 0 )
  
  
  self.objetivos = {}
  
  
  self.entidad.timer:after(0.05,function()
      
    for _, k in pairs(self.objetivos) do
      if k then
        if k.data == "enemy" or k.data == "player" then
          self.entidad:dano(k.obj,self.dano)
          
          if k.data == "player" then
            k.obj:cambiar_estado("canon")
          end
          
        elseif k.data == "map_object" then
          k.obj:hacer_hueco(k.id_poligono,self.entidad:poligono_para_destruir(self.x,self.y),self.x,self.y) 
        elseif k.data == "enemy_bullet" or k.data == "object" then
          k.obj:remove()
        elseif k.data == "door" then
          k.obj:colisiona_centro(self.fixture)
        end
      end
    end
      
      
    self.body:destroy()
  end)


end

function explosion:guardar(obj)
  
  if #self.objetivos == 0 then
    table.insert(self.objetivos,obj)
  else
    for _, e in ipairs(self.objetivos) do
      if e == obj then
        return
      end
    end
    
    table.insert(self.objetivos,obj)
  end
  
  
  
end

function explosion:update()
  
  
end

function explosion:draw()
  
end

return explosion


