local mundoSecundario = require "gamestates.mundo_secundario"
local mundoGenerico = require "gamestates.mundo_generico"

local mundoPrincipal = Class{
  __includes = {mundoGenerico}
}

function mundoPrincipal:init()
  
  self.mundoGuardado = {}
  
end

function mundoPrincipal:enter(_,data)
  
  Switch(data.accion, {
    
    crear = function()
      if data.mapaIndex then
        self.mapaIndex = data.mapaIndex
        
        mundoGenerico.init(self,Map_index.campana[self.mapaIndex]["main"])
      end
    end,
    limpiar = function()
      self:limpiar()
    end,
    cambiarPosicion = function()
      
    end
    
  })
    
end

function mundoPrincipal:limpiar()
  
end

function mundoPrincipal:regresar()
  
end

function mundoPrincipal:cambiarMapa()
  
end

return mundoPrincipal