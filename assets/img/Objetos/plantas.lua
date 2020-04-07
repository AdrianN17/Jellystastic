local plantas = {}

plantas.img = love.graphics.newImage("assets/img/Objetos/plantas_spritesheet.png")

plantas.quad = {}

plantas.quad[1] = love.graphics.newQuad(31,17,254,400,plantas.img:getDimensions())
plantas.quad[2] = love.graphics.newQuad(370,30,190,428,plantas.img:getDimensions())

plantas.viewport = {}

for i,quad in pairs(plantas.quad) do
  local _,_,w,h = quad:getViewport()
  plantas.viewport[i] = {w=w,h=h}
end

return plantas
