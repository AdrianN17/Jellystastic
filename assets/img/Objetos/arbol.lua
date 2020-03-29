local arbol = {}

arbol.img = love.graphics.newImage("assets/img/Objetos/arbol_spritesheet.png")

arbol.quad = {}

arbol.quad[1] = love.graphics.newQuad(31,17,254,400,arbol.img:getDimensions())


arbol.viewport = {}

for i,quad in pairs(arbol.quad) do
  local _,_,w,h = quad:getViewport()
  arbol.viewport[i] = {w=w,h=h}
end

return arbol
