local nubes = {}

nubes.img = love.graphics.newImage("assets/img/Capa_2/nubes_spritesheet.png")

nubes.quad = {}

nubes.quad[1] = love.graphics.newQuad(0,0,811,248,nubes.img:getDimensions())
nubes.quad[2] = love.graphics.newImage(0,253,811,248,nubes.img:getDimensions())
nubes.quad[3] = love.graphics.newImage(0,506,811,248,nubes.img:getDimensions())

nubes.viewport = {}

for i,quad in pairs(nubes.quad) do
  local _,_,w,h = quad:getViewport()
  nubes.viewport[i] = {w=w,h=h}
end

return nubes