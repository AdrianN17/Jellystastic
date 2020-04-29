local remove = require "entidades.remove"

local explosion = Class{
  __includes = {remove}
}

function explosion:init(entidad,ox,oy)
  self.entidad = entidad
  self.ox,self.oy = ox,oy

  self.body = love.physics.newBody(entidad.world,self.ox,self.oy,"dynamic")
  self.shape = love.physics.newCircleShape(75)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setSensor(true)

  self.body:setGravityScale(0)

  self.objAlcanzados = {}

  self.entidad:add("sueloMapa",self)
  remove.init(self,entidad,"sueloMapa")

  entidad.timer:after(0.2,function()

    local contacts = self.body:getContacts()

    for _,contact in ipairs(contacts) do
      local explosivoObj =  self.entidad:getUserDataValue(contact,"Es_danoExplosivo")


      if explosivoObj then

        local val = true

        for _,obj in ipairs(self.objAlcanzados) do
          if obj == explosivoObj.obj then
            objetos:remove()
          end
        end

        if val then
          table.insert(self.objAlcanzados,explosivoObj.obj)
        end
      end

    end

    for _,obj in ipairs(self.objAlcanzados) do

      if obj.hp then
        self.entidad:dano(obj,7.5)

        if obj.cambiarEstado then
          obj:cambiarEstado("canon")
        end

      else
        if objetos.remove then
          objetos:remove()
        end
      end
   end

    if not self.body:isDestroyed() then
      self:remove()
    end

  end)
end

return explosion