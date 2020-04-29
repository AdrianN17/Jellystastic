local remove = {}

function remove:init(entidad,tabla)
  self.remove = function()
    if not self.body:isDestroyed() then
      self.body:destroy()

      if self.timer then
        self.timer:destroy()
      end

      entidad:remove(tabla,self)
    end
  end
end

function remove:checkVida()
  if self.hp < 0.1 then

    if self.Es_transformarZombie and self.iteradorEstado and self.iteradorEstado == 4  then
      self.entidad.entidadesUnicas.zombieCreador:crearZombie(self)
    end

    if self.triggerRemove then
      self:triggerRemove()
    end

    self:remove()

  end
end

return remove