local ventanas = {}

ventanas.img = love.graphics.newImage("assets/img/Adornos/ventana_spritesheet.png")

ventanas.quad = {}
ventanas.quad[1] = love.graphics.newQuad(0,0,500,340 ,ventanas.img:getDimensions())
ventanas.quad[2] = love.graphics.newQuad(0,355,500,340 ,ventanas.img:getDimensions())
ventanas.quad[3] = love.graphics.newQuad(0,710,500,340 ,ventanas.img:getDimensions())
ventanas.quad[4] = love.graphics.newQuad(0,1065,500,340 ,ventanas.img:getDimensions())

ventanas.viewport = {}

for i,quad in ipairs(ventanas.quad) do
  local _,_,w,h = quad:getViewport()
  ventanas.viewport[i] = {w=w,h=h}
end

return ventanas 