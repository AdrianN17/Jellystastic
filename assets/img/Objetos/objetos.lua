local objetos = {}

objetos.img = love.graphics.newImage("assets/img/Objetos/objetos_spritesheet.png")

objetos.quad = {}

objetos.quad["puerta"] = love.graphics.newQuad(0,1,300,499, objetos.img:getDimensions())
objetos.quad["dulce_parte1"] = love.graphics.newQuad(764,76,306,280, objetos.img:getDimensions())
objetos.quad["dulce_parte2"] = love.graphics.newQuad(769,359,973,164, objetos.img:getDimensions())

objetos.quad["chocolate"] = love.graphics.newQuad(763,0,966,75, objetos.img:getDimensions())
objetos.quad["caja"] = love.graphics.newQuad(305,119,417,409, objetos.img:getDimensions())
objetos.quad["chicle"] = love.graphics.newQuad(564,40,170,15, objetos.img:getDimensions())
objetos.quad["maiz"] = love.graphics.newQuad(461,15,40,78, objetos.img:getDimensions())
objetos.quad["menta"] = love.graphics.newQuad(324,30,89,22, objetos.img:getDimensions())


objetos.viewport = {}

for i,quad in pairs(objetos.quad) do
  local _,_,w,h = quad:getViewport()
  objetos.viewport[i] = {w=w,h=h}
end

return objetos
