local burbujas = {}

burbujas.img = love.graphics.newImage("assets/img/Adornos/burbujas_spritesheet.png")

burbujas.quad = {}
burbujas.quad[1] = love.graphics.newQuad(0,0,500,500 ,burbujas.img:getDimensions())
burbujas.quad[2] = love.graphics.newQuad(0,505,500,500 ,burbujas.img:getDimensions())
burbujas.quad[3] = love.graphics.newQuad(0,1010,500,500 ,burbujas.img:getDimensions())

burbujas.viewport = {}

for i,quad in pairs(burbujas.quad) do
  local _,_,w,h = quad:getViewport()
  burbujas.viewport[i] = {w=w,h=h}
end

return burbujas 