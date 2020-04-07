local piedra = {}

piedra.img = love.graphics.newImage("assets/img/Objetos/piedra_spritesheet.png")

piedra.quad = {}
piedra.quad[1] = love.graphics.newQuad(30,14,450,245,piedra.img:getDimensions())

piedra.viewport = {}

for i,quad in pairs(piedra.quad) do
  local _,_,w,h = quad:getViewport()
  piedra.viewport[i] = {w=w,h=h}
end


return piedra
