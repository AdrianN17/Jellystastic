local baba = {}

baba.img = love.graphics.newImage("assets/img/Enemigos/baba.png")

baba.quad = {}
baba.quad[1]=love.graphics.newQuad(21,97,329,378,baba.img:getDimensions())
baba.quad[2]=love.graphics.newQuad(395,97,313,383,baba.img:getDimensions())
baba.quad[3]=love.graphics.newQuad(736,101,311,374,baba.img:getDimensions())
baba.quad[4]=love.graphics.newQuad(21,558,309,377,baba.img:getDimensions())
baba.quad[5]=love.graphics.newQuad(381,558,323,377,baba.img:getDimensions())
baba.quad[6]=love.graphics.newQuad(756,838,263,103,baba.img:getDimensions())

baba.viewport = {}

for i,quad in ipairs(baba.quad) do
  local _,_,w,h = quad:getViewport()
  baba.viewport[i] = {w=w,h=h}
end

return baba