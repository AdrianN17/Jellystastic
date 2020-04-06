local remove = {}

function remove:init(entidad,tabla,funcion)
  self.remove = function()
    if not self.body:isDestroyed() then
      self.body:destroy()
      
      if funcion then
        funcion()
      end
      
      if self.timer then
        self.timer:destroy()
      end
      
      entidad:remove(tabla,self)
    end
  end
end

function remove:checkVida()
  if self.hp < 0.1 then
    self:remove()
  end
end

return remove