local index = {}

index.personajes = {}

index.personajes[1] = {}
index.personajes[1].img = love.graphics.newImage("assets/img/sprite.png")
index.personajes[1].quad = {}

--normal
index.personajes[1].quad[1] = {}
index.personajes[1].quad[1][1] = love.graphics.newQuad(26,21,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[1][2] = love.graphics.newQuad(300,26,219,329,index.personajes[1].img:getDimensions())
index.personajes[1].quad[1][3] = love.graphics.newQuad(566,21,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[1][4] = love.graphics.newQuad(840,21,250,336,index.personajes[1].img:getDimensions())

--agujeros
index.personajes[1].quad[2] = {}
index.personajes[1].quad[2][1] = love.graphics.newQuad(26,365,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[2][2] = love.graphics.newQuad(300,270,219,329,index.personajes[1].img:getDimensions())
index.personajes[1].quad[2][3] = love.graphics.newQuad(566,365,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[2][4] = love.graphics.newQuad(840,365,250,336,index.personajes[1].img:getDimensions())

--cortado
index.personajes[1].quad[3] = {}
index.personajes[1].quad[3][1] = love.graphics.newQuad(26,725,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[3][2] = love.graphics.newQuad(300,730,219,329,index.personajes[1].img:getDimensions())
index.personajes[1].quad[3][3] = love.graphics.newQuad(566,725,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[3][4] = love.graphics.newQuad(840,725,229,336,index.personajes[1].img:getDimensions())

--zombificado 50%
index.personajes[1].quad[4] = {}
index.personajes[1].quad[4][1] = love.graphics.newQuad(26,1088,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[4][2] = love.graphics.newQuad(300,1091,219,329,index.personajes[1].img:getDimensions())
index.personajes[1].quad[4][3] = love.graphics.newQuad(566,1086,219,336,index.personajes[1].img:getDimensions())
index.personajes[1].quad[4][4] = love.graphics.newQuad(840,1086,250,336,index.personajes[1].img:getDimensions())

--zombificado 100%
index.personajes[1].quad[5] = {}
index.personajes[1].quad[5][1] = love.graphics.newQuad(16,1455,232,341,index.personajes[1].img:getDimensions())
index.personajes[1].quad[5][2] = love.graphics.newQuad(290,1455,232,342,index.personajes[1].img:getDimensions())
index.personajes[1].quad[5][3] = love.graphics.newQuad(561,1455,232,341,index.personajes[1].img:getDimensions())

--incinerado
index.personajes[1].quad[6] = {}
index.personajes[1].quad[6][1] = love.graphics.newQuad(851,1475,218,96,index.personajes[1].img:getDimensions())
index.personajes[1].quad[6][2] = love.graphics.newQuad(851,1603,218,81,index.personajes[1].img:getDimensions())
index.personajes[1].quad[6][3] = love.graphics.newQuad(839,1699,233,97,index.personajes[1].img:getDimensions())

index.personajes[1].scale = {x = 0.25,y=0.25}


index.texturas = {}
    
index.texturas["gelatina"] = love.graphics.newImage("assets/img/suelo.png")
index.texturas["gelatina"]:setWrap("repeat")
    

return  index





