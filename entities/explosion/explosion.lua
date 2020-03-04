local Class = require "libs.hump.class"
local explosion = Class{}

function explosion:init(entidad,x,y)
  self.entidad = entidad


  self.x,self.y=x,y
  self.body = love.physics.newBody(entidad.world,x,y,"dynamic")
  self.shape = love.physics.newCircleShape(50*self.entidad.explosion_scale)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)
  self.body:resetMassData()
  self.fixture:setUserData( {data="explosion",obj = self, pos=orden.explosion} )
  
  self.dano =10
  
  self.body:setGravityScale( 0 )
  
  
  self.objetivos = {}
  
  
  self.entidad.timer:after(0.05,function()
      
    for _, k in pairs(self.objetivos) do
      if k then
        if k.data == "baba" or k.data == "player" or k.data=="soldier" or k.data == "npc" then
          self.entidad:dano(k.obj,self.dano)
          
          if k.obj.cambiar_estado then
            k.obj:cambiar_estado("canon")
          end
        elseif k.data == "enemy_bullet" or k.data == "object" then
          k.obj:remove()
        elseif k.data == "door" then
          k.obj:colisiona_centro(self.fixture)
        end
      end
    end
      
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
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


