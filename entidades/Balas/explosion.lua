local remove = require "entidades.remove"

local explosion = Class{
  __includes = {remove}
}

function explosion:init(entidad,ox,oy)
  self.entidad = entidad
  self.ox,self.oy = ox,oy
  self.radio = 76

  entidad.timer:after(0.1,function()

    local lista = queryObj:circle(self.entidad.world,self.ox,self.oy,self.radio)

    for _,fixture in ipairs(lista) do
      local userdata = fixture:getUserData()

      if userdata.obj then
        local obj = userdata.obj

        if obj.hp then
          self.entidad:dano(obj,7.5)

          if obj.cambiarEstado then
            obj:cambiarEstado("canon")
          end

        else
          if obj.remove then
            obj:remove()
          end
        end
      end
    end

  end)

end

return explosion