local vida = {}

vida.img = love.graphics.newImage("assets/img/Items/Vida.png")

vida.quad = {}
vida.quad[1] = love.graphics.newQuad(56,37,183,152,vida.img:getDimensions())
vida.quad[2] = love.graphics.newQuad(416,37,183,152,vida.img:getDimensions())

vida.viewport = {}

for i,quad in pairs(vida.quad) do
  local _,_,w,h = quad:getViewport()
  vida.viewport[i] = {w=w,h=h}
end

return vida 