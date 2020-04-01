local meteorito = {}

meteorito.img = love.graphics.newImage("assets/img/Meteorito/meteorito_spritesheet.png")

meteorito.quad = {}

meteorito.quad["estela_1"] = love.graphics.newQuad(0,0,611,1026,meteorito.img:getDimensions())

meteorito.quad[1] = love.graphics.newQuad(634,29,431,422,meteorito.img:getDimensions())
meteorito.quad[2] = love.graphics.newQuad(1106,29,431,422,meteorito.img:getDimensions())
meteorito.quad[3] = love.graphics.newQuad(1578,28,431,423,meteorito.img:getDimensions())
meteorito.quad[4] = love.graphics.newQuad(634,592,431,422,meteorito.img:getDimensions())
meteorito.quad[5] = love.graphics.newQuad(1106,592,431,422,meteorito.img:getDimensions())
meteorito.quad[6] = love.graphics.newQuad(1578,591,431,422,meteorito.img:getDimensions())



meteorito.viewport = {}

for i,quad in pairs(meteorito.quad) do
  local _,_,w,h = quad:getViewport()
  meteorito.viewport[i] = {w=w,h=h}
end

return meteorito
