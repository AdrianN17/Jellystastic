local helado = {}

helado.img = love.graphics.newImage("assets/img/Objetos/helado_spritesheet.png")

helado.quad = {}
helado.quad["helado_1"] = love.graphics.newQuad(19,14,250,373,helado.img:getDimensions())
helado.quad["helado_2"] = love.graphics.newQuad(19,420,250,373,helado.img:getDimensions())
helado.quad["helado_3"] = love.graphics.newQuad(19,826,250,373,helado.img:getDimensions())
helado.quad["helado_4"] = love.graphics.newQuad(19,1232,250,373,helado.img:getDimensions())

helado.viewport = {}

for i,quad in pairs(helado.quad) do
  local _,_,w,h = quad:getViewport()
  helado.viewport[i] = {w=w,h=h}
end


return helado
