local accesorios = {}

accesorios.img = love.graphics.newImage("assets/img/Accesorios/accesorios.png")

accesorios.quad = {}

accesorios.quad[1] = love.graphics.newQuad(20,21,242,137,accesorios.img:getDimensions())
accesorios.quad[2] = love.graphics.newQuad(81,227,145,135,accesorios.img:getDimensions())

accesorios.scale = {}

accesorios.scale[1] = {x = 0.2,y=0.2}
accesorios.scale[2] = {x = 0.2,y=0.2}

accesorios.viewport = {}

for i,quad in ipairs(accesorios.quad) do
  local _,_,w,h = quad:getViewport()
  accesorios.viewport[i] = {w=w,h=h}
end

return accesorios