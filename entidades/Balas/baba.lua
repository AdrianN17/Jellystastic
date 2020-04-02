local baba = Class{}

function baba:init(entidad,objeto,ox,oy,radio)
  self.entidad = entidad
  self.objeto = objeto
  self.ox,self.oy = ox,oy
  self.radio = radio
  self.dano = dano
  
  self.velocidad = 200
  
  self.spritesheet = Index_img.baba
  self.img = self.spritesheet.img 
  self.quad = self.spritesheet.quad["baba"]
  self.dimension = self.spritesheet.viewport["baba"]
  
  self.entidad:add("balas",self)
  
  self.width,self.height = 36,36
  
  self.wi,self.hi = self.width/self.dimension.w,self.height/self.dimension.h 
  
  self.body = love.physics.newBody(entidad.world,ox,oy,"dynamic")
  self.shape = love.physics.newCircleShape(18)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  self.fixture:setRestitution(0.5)
  
  self.body:setBullet(true)
  self.body:setMass(0)
  self.body:setLinearDamping( 1 )
  self.fixture:setFriction(1)
  self.fixture:setDensity(1)
  self.body: setFixedRotation (true)
  
  self.body:applyLinearImpulse(self.velocidad*math.cos(radio),self.velocidad*math.sin(radio))
  
end

function baba:draw()
  love.graphics.draw(self.img,self.quad,self.ox,self.oy,self.radio,self.wi,self.hi,self.dimension.w/2,self.dimension.h/2)
end

function baba:update(dt)

  self.radio = self.body:getAngle()
  
  self.ox,self.oy = self.body:getX(),self.body:getY()
end

return baba