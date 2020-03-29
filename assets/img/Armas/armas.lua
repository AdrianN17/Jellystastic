local armas = {}

armas.img = love.graphics.newImage("assets/img/Armas/armas.png")

armas.quad={}
armas.quad[1] = love.graphics.newQuad(536,43,157,111,armas.img:getDimensions())
armas.quad[2] = love.graphics.newQuad(47,423,211,128,armas.img:getDimensions())
armas.quad[3] = love.graphics.newQuad(41,35,316,153,armas.img:getDimensions())
armas.quad[4] = love.graphics.newQuad(833,210,531,146,armas.img:getDimensions())
armas.quad[5] = love.graphics.newQuad(21,245,491,121,armas.img:getDimensions())
armas.quad[6] = love.graphics.newQuad(861,23,503,156,armas.img:getDimensions())

armas.scale ={}
armas.scale[1] = {x = 0.25,y=0.25}
armas.scale[2] = {x = 0.25,y=0.25}
armas.scale[3] = {x = 0.20,y=0.20}
armas.scale[4] = {x = 0.28,y=0.28}
armas.scale[5] = {x = 0.25,y=0.25}
armas.scale[6] = {x = 0.25,y=0.25}

armas.viewport = {}

for i,quad in pairs(armas.quad) do
  local _,_,w,h = quad:getViewport()
  armas.viewport[i] = {w=w,h=h}
end

return armas