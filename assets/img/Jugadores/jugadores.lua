local jugadores = {}

jugadores.img = love.graphics.newImage("assets/img/Jugadores/sprite.png")
jugadores.quad = {}

--normal
jugadores.quad[1] = {}
jugadores.quad[1][1] = love.graphics.newQuad(26,21,219,336,jugadores.img:getDimensions())
jugadores.quad[1][2] = love.graphics.newQuad(300,26,219,329,jugadores.img:getDimensions())
jugadores.quad[1][3] = love.graphics.newQuad(566,21,219,336,jugadores.img:getDimensions())
jugadores.quad[1][4] = love.graphics.newQuad(840,21,250,336,jugadores.img:getDimensions())

--agujeros
jugadores.quad[2] = {}
jugadores.quad[2][1] = love.graphics.newQuad(26,365,219,336,jugadores.img:getDimensions())
jugadores.quad[2][2] = love.graphics.newQuad(300,370,219,329,jugadores.img:getDimensions())
jugadores.quad[2][3] = love.graphics.newQuad(566,365,219,336,jugadores.img:getDimensions())
jugadores.quad[2][4] = love.graphics.newQuad(840,365,250,336,jugadores.img:getDimensions())

--cortado
jugadores.quad[3] = {}
jugadores.quad[3][1] = love.graphics.newQuad(26,725,219,336,jugadores.img:getDimensions())
jugadores.quad[3][2] = love.graphics.newQuad(300,730,219,329,jugadores.img:getDimensions())
jugadores.quad[3][3] = love.graphics.newQuad(566,725,219,336,jugadores.img:getDimensions())
jugadores.quad[3][4] = love.graphics.newQuad(840,725,229,336,jugadores.img:getDimensions())

--zombificado 50%
jugadores.quad[4] = {}
jugadores.quad[4][1] = love.graphics.newQuad(26,1088,219,336,jugadores.img:getDimensions())
jugadores.quad[4][2] = love.graphics.newQuad(300,1091,219,329,jugadores.img:getDimensions())
jugadores.quad[4][3] = love.graphics.newQuad(566,1086,219,336,jugadores.img:getDimensions())
jugadores.quad[4][4] = love.graphics.newQuad(840,1086,250,336,jugadores.img:getDimensions())

--zombificado 100%
jugadores.quad[5] = {}
jugadores.quad[5][1] = love.graphics.newQuad(16,1455,232,341,jugadores.img:getDimensions())
jugadores.quad[5][2] = love.graphics.newQuad(290,1455,232,342,jugadores.img:getDimensions())
jugadores.quad[5][3] = love.graphics.newQuad(561,1455,232,341,jugadores.img:getDimensions())

--incinerado
jugadores.quad[6] = {}
jugadores.quad[6][1] = love.graphics.newQuad(851,1475,218,96,jugadores.img:getDimensions())
jugadores.quad[6][2] = love.graphics.newQuad(851,1603,218,81,jugadores.img:getDimensions())
jugadores.quad[6][3] = love.graphics.newQuad(839,1699,233,97,jugadores.img:getDimensions())


jugadores.viewport = {}

for i,quad_list in pairs(jugadores.quad) do
  
  for j, quad in pairs(quad_list) do
    
    if jugadores.viewport[i] == nil then
      jugadores.viewport[i] = {}
    end
    
    local _,_,w,h = quad:getViewport()
    
    jugadores.viewport[i][j] = {w=w,h=h}
  end
end


return jugadores