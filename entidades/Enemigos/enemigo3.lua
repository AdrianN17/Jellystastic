local estandarEnemigos =  require "entidades.Enemigos.estandarEnemigos"
local Timer = require "libs.chrono.Timer"
local tipoBala = require "entidades.Balas.tipoBala"

local enemigo3 = Class{
  __includes = {estandarEnemigos,tipoBala}
}

function enemigo3:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
  self.body = body
  self.shape = shape
  self.fixture = fixture
  
  self.entidad = entidad
  
  self.velocidad = properties.velocidad
  
  self.radio = radio
  
  self.limiteVision = properties.limiteVision
  
  self.spritesheet = Index_img[properties.img]

  self.img = self.spritesheet.img
  self.quad = self.spritesheet.quad
  self.dimension = self.spritesheet.viewport
  
  self.iterador = 1
  self.iteradorEstado = 1
  
  self.idAccesorio = tonumber(properties.quadImgAccesorio) or properties.quadImgAccesorio
  
  self.spritesheetAccesorio = Index_img[properties.imgAccesorio]
  self.imgAccesorio = self.spritesheetAccesorio.img 
  self.quadAccesorio = self.spritesheetAccesorio.quad
  self.dimensionAccesorio = self.spritesheetAccesorio.viewport
  self.scaleAccesorio  = self.spritesheetAccesorio.scale

  self.width,self.height = width,height
  
  self.ox,self.oy = ox,oy
  
  self.fixture:setFriction(0)
  self.fixture:setDensity(1)
  self.body:setLinearDamping( 1 )
  self.body: setFixedRotation (true)
  
  self.body:setMass(50)
  self.mass = self.body:getMass( )
  self.mass=self.mass*self.mass
  
  entidad:add(properties.tabla,self)
  
  self.timer = Timer()
  
  self.direccion = properties.direccion or 1
  
  self.armaIndex = properties.arma
  
  estandarEnemigos.init(self)
  
  tipoBala.init(self)
  
  self:recargarMax()
  
  self.automata = Fsm.create({
   initial = 'mover',
    events ={
      {name = "Fatacar", from = {"recargar","mover"}, to = "atacar"},
      {name = "Fmover", from = {"atacar","recargar"}, to = "mover"},
      {name = "Frecargar", from ={"mover","atacar"}, to =  "recargar"}
    },
  
    callbacks = {
      onFatacar = function(_,event,from,to)

          self:dispararArma()

      end,
      onFmover = function(_,event,from,to)
 
        self:terminarDisparoArma()
        self:restaurarRadio()
      end,
      
      onFrecargar= function(_, event, from, to) 
        if self.timerBalas then
          self.timer:cancel(self.timerBalas)
          self.timerBalas = nil
        end
        
        self:recargarArma()
        
        local bala = self.armasValues[self.armaIndex]
        self.timer:after(bala.tiempo_recarga+0.25,function()
          if self.objPresa then
            self.automata:Fatacar()
          else
            self.automata:Fmover()
          end
        end)
      
      end
    }
  })

  self.timer:every(0.3,function () 
    if self.automata.current == "mover" then
      self.iterador = self.iterador +1
      
      if self.iterador>3 then
        self.iterador=1
      end
    end
    
    if self.armaIndex>0 then
      local bala = self.armasValues[self.armaIndex]
      if bala.stock<1 and bala.municion>0 then
        self.automata:Frecargar()
      end
    end
    
  end)


  self.oxAtaque,self.oyAtaque = math.getPointAngle(self.ox,self.oy,self.radio,self.limiteVision,self.direccionAngulo[self.direccion])
  
  local raycastAtacar = function (fixture, x, y, xn, yn, fraction)
    local tipoObj=fixture:getUserData()
    
    if tipoObj and tipoObj.obj and tipoObj.nombre == "player" then
      
      self.objPresa = tipoObj.obj
      self.posicionAtaque=true

    end
    
    return 0
  end

  
  self.timer:every(0.025,function() 
    self.posicionAtaque=false
    
    self.entidad.world:rayCast(self.ox,self.oy,self.oxAtaque,self.oyAtaque,raycastAtacar)
    if self.posicionAtaque and self.automata.current == "mover" then
      self.automata:Fatacar()
      self.iterador = 1
      self.posicionAtaque=false
    end
  end)
  
  
  self.radioBalaDireccion = 1
  self.minAngle = {}
  self.minAngle[-1] =  math.rad(110)
  self.minAngle[1] =  math.rad(-70)
  self.maxAngle = {}
  self.maxAngle[-1] = math.rad(250)
  self.maxAngle[1] = math.rad(70)
  
  if self.direccion == -1 then
    self.radioBala = math.rad(180)
  else
    self.radioBala = math.rad(0)
  end

  
end

function enemigo3:draw()
  
  local dimension = self.dimension[1][1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h 
  
  love.graphics.setShader(self.entidad.shaderEnemigo)
    love.graphics.draw(self.img,self.quad[self.iteradorEstado][self.iterador],self.ox,self.oy,self.radio,wi,hi,dimension.w/2,dimension.h/2)
  love.graphics.setShader()
  
  if self.idAccesorio>0 then
    local dimensionAccesorio = self.dimensionAccesorio[self.idAccesorio]
    local scaleAccesorio = self.scaleAccesorio[self.idAccesorio]
    
    local ox,oy = math.getPointAngle(self.ox,self.oy,self.radio,35,-90)
    love.graphics.draw(self.imgAccesorio,self.quadAccesorio[self.idAccesorio],ox,oy,self.radio,scaleAccesorio.x*self.direccion,scaleAccesorio.y,dimensionAccesorio.w/2,dimensionAccesorio.h/2)
  end
  
  self:drawArma()
  
end

function enemigo3:update(dt)
  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self:updatePuntos()
  self:updateBalaAutomatica(dt)
  
  self.timer:update(dt)
  
  self:updateEnemigo(dt)
end

function enemigo3:voltear()
  self.radioBala = math.atan2(math.sin(self.radioBala),math.cos(self.radioBala)*-1)
      
  if self.direccion == -1 then
    self.radioBala = math.abs(self.radioBala)
  end
end

function enemigo3:updateBalaAutomatica(dt)
  
  if self.automata.current == "mover" then
    self.radioBala = self.radioBala +dt*self.radioBalaDireccion
    
    if self.radioBala>self.maxAngle[self.direccion] or self.radioBala<self.minAngle[self.direccion] then
      self.radioBalaDireccion = self.radioBalaDireccion*-1
    end
    
  elseif self.automata.current == "atacar" then
    self.radioBala = math.atan2(self.oyBala- self.objPresa.oy,self.oxBala- self.objPresa.ox)+math.pi
  end
  
  local bx = math.cos(self.radioBala)
    
  if bx>0 then
    self.vistaX = 1
  else
    self.vistaX = -1
  end
end

function enemigo3:restaurarRadio()
  if self.direccion == -1 then
    self.radioBala = math.rad(180)
  else
    self.radioBala = math.rad(0)
  end
end



return enemigo3