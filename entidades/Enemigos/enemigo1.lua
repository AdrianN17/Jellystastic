
local enemigo1 = Class{
  __includes = {}
}

function enemigo1:init(entidad,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,width,height)
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
  
  self.automata = Fsm.create({
   initial = 'mover',
    events ={
      {name = "Fatacar", from = "mover", to = "atacar"},
      {name = "Fmover", from = "atacar", to = "mover"}
    }
  })

  self.timer = Timer()
  
  self.timer:every(0.25,function () 
    if self.automata.current == "mover" then
      self.iterador = self.iterador +1
      
      if self.iterador>3 then
        self.iterador=1
      end
    elseif self.automata.current == "atacar" then
      
      self.iterador = self.iterador +1
      
      if self.iterador == 5 and self.objPresa then
        --lanzar saliva

        --Saliva(self.entidad,self.spritesheet,self.ox,self.oy,self.objPresa.ox,self.obj_presa.oy,self.direccion,self.creador)
      end
      
      if self.iterador>5 then
        self.iterador=4
      end

    end
  end)
  
  self.direccion = properties.direccion or 1
  
  self.direccionAngulo = {}
  self.direccionAngulo[1] = 0
  self.direccionAngulo[-1] = -180
  
  self.oxAtaque,self.oyAtaque = math.getPointAngle(self.ox,self.oy,self.radio,self.limiteVision,self.direccionAngulo[self.direccion])
  self.oxPared,self.oyPared = math.getPointAngle(self.ox,self.oy,self.radio,75,self.direccionAngulo[self.direccion])
  self.oxSuelo,self.oySuelo = math.getPointAngle(self.ox,self.oy,self.radio,150,self.direccionAngulo[self.direccion]+20*self.direccion)
  
  
  
end

function enemigo1:draw()
  local dimension = self.dimension[1]

  local wi,hi = self.width/dimension.w,self.height/dimension.h 

  love.graphics.draw(self.img,self.quad[self.iterador],self.ox,self.oy,self.radio,wi*self.direccion,hi,dimension.w/2,dimension.h/2)

end

function enemigo1:update(dt)
  
  self.radio = self.body:getAngle()
  self.ox,self.oy = self.body:getX(),self.body:getY()
  
  self.timer:update(dt)
  
  self.oxAtaque,self.oyAtaque = math.getPointAngle(self.ox,self.oy,self.radio,self.limiteVision,self.direccionAngulo[self.direccion])
  self.oxPared,self.oyPared = math.getPointAngle(self.ox,self.oy,self.radio,75,self.direccionAngulo[self.direccion])
  self.oxSuelo,self.oySuelo = math.getPointAngle(self.ox,self.oy,self.radio,150,self.direccionAngulo[self.direccion]+20*self.direccion)
end



return enemigo1