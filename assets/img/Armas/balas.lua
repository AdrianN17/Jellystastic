local balas = {}

balas.img = love.graphics.newImage("assets/img/Armas/armas.png")

balas.quad={}

balas.quad[1] = love.graphics.newQuad(713,47,65,27,balas.img:getDimensions())
balas.quad[2] = love.graphics.newQuad(280,427,68,30,balas.img:getDimensions())
balas.quad[3] = love.graphics.newQuad(373,58,83,29,balas.img:getDimensions())
balas.quad[4] = love.graphics.newQuad(1386,240,105,22,balas.img:getDimensions())
balas.quad[5] = love.graphics.newQuad(534,256,88,31,balas.img:getDimensions())
balas.quad[6] = love.graphics.newQuad(1373,49,118,55,balas.img:getDimensions())


balas.scale ={}
balas.scale[1] = {x = 0.30,y=0.35}
balas.scale[2] = {x = 0.30,y=0.35}
balas.scale[3] = {x = 0.30,y=0.35}
balas.scale[4] = {x = 0.30,y=0.35}
balas.scale[5] = {x = 0.30,y=0.35}
balas.scale[6] = {x = 0.35,y=0.35}

balas.viewport = {}

for i,quad in pairs(balas.quad) do
  local _,_,w,h = quad:getViewport()
  balas.viewport[i] = {w=w,h=h}
end

return balas