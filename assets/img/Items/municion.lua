local municion = {}

municion.img = love.graphics.newImage("assets/img/Items/Municion.png")

municion.quad = {}

municion.quad[1] = love.graphics.newQuad(0,0,233,206,municion.img:getDimensions())

municion.viewport = {}

for i,quad in pairs(municion.quad) do
  local _,_,w,h = quad:getViewport()
  municion.viewport[i] = {w=w,h=h}
end

return municion