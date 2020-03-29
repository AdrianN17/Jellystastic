local adornos = {}

adornos.img = love.graphics.newImage("assets/img/Adornos/adornos_spritesheet.png")

adornos.quad = {}

adornos.quad["dulce_1"] = love.graphics.newQuad(69,3030,82,73,adornos.img:getDimensions())
adornos.quad["dulce_2"] = love.graphics.newQuad(0,3030,64,68,adornos.img:getDimensions())
adornos.quad["dulce_3"] = love.graphics.newQuad(156,3030,70,69,adornos.img:getDimensions())
adornos.quad["luz"] = love.graphics.newQuad(0,0,500,500,adornos.img:getDimensions())
adornos.quad["dulce_ladrillo_1"] = love.graphics.newQuad(0,505,500,500,adornos.img:getDimensions())
adornos.quad["dulce_ladrillo_2"] = love.graphics.newQuad(0,1010,500,500,adornos.img:getDimensions())
adornos.quad["dulce_ladrillo_3"] = love.graphics.newQuad(0,1515,500,500,adornos.img:getDimensions())
adornos.quad["dulce_ladrillo_4"] = love.graphics.newQuad(0,2020,500,500,adornos.img:getDimensions())
adornos.quad["suelo_1"] = love.graphics.newQuad(0,2525,500,500,adornos.img:getDimensions())
adornos.quad["suelo_2"] = love.graphics.newQuad(0,3108,500,500,adornos.img:getDimensions())

adornos.viewport = {}

for i,quad in pairs(adornos.quad) do
  local _,_,w,h = quad:getViewport()
  adornos.viewport[i] = {w=w,h=h}
end

return adornos