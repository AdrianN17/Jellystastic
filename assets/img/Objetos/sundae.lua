local sundae = {}

sundae.img = love.graphics.newImage("assets/img/Objetos/sundae_spritesheet.png")

sundae.quad = {}

sundae.quad["sundae_1"] = love.graphics.newQuad(21,23,244,338,sundae.img:getDimensions())
sundae.quad["sundae_2"] = love.graphics.newQuad(21,410,244,338,sundae.img:getDimensions())
sundae.quad["sundae_3"] = love.graphics.newQuad(21,797,244,338,sundae.img:getDimensions())
sundae.quad["sundae_4"] = love.graphics.newQuad(21,1184,244,338,sundae.img:getDimensions())

sundae.viewport = {}

for i,quad in pairs(sundae.quad) do
  local _,_,w,h = quad:getViewport()
  sundae.viewport[i] = {w=w,h=h}
end

return sundae
