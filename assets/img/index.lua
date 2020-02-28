local index = {}

index.personajes = {}

index.personajes[1] = {}
index.personajes[1].img = love.graphics.newImage("assets/img/Jugadores/sprite.png")
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
index.personajes[1].quad[2][2] = love.graphics.newQuad(300,370,219,329,index.personajes[1].img:getDimensions())
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

index.baba = {}
index.baba.img = love.graphics.newImage("assets/img/Enemigos/enemigo1.png")

index.baba.quad = {}
index.baba.quad[1]=love.graphics.newQuad(21,97,329,378,index.baba.img:getDimensions())
index.baba.quad[2]=love.graphics.newQuad(395,97,313,383,index.baba.img:getDimensions())
index.baba.quad[3]=love.graphics.newQuad(736,101,311,374,index.baba.img:getDimensions())
index.baba.quad[4]=love.graphics.newQuad(21,558,309,377,index.baba.img:getDimensions())
index.baba.quad[5]=love.graphics.newQuad(381,558,323,377,index.baba.img:getDimensions())
index.baba.quad[6]=love.graphics.newQuad(756,838,263,103,index.baba.img:getDimensions())
  
index.baba.scale = {x = 0.25,y=0.25}

index.baba.saliva=love.graphics.newQuad(879,588,103,119,index.baba.img:getDimensions())

index.accesorios={}
index.accesorios.img = love.graphics.newImage("assets/img/Items/accesorios.png")
index.accesorios.quad = {}
index.accesorios.quad[1] = love.graphics.newQuad(229,104,242,137,index.accesorios.img:getDimensions())
index.accesorios.quad[2] = love.graphics.newQuad(290,310,145,135,index.accesorios.img:getDimensions())

index.accesorios.scale = {x = 0.2,y=0.2}

index.vidas = {}

index.vidas.img = index.accesorios.img
index.vidas.quad = {}
index.vidas.quad[1] = love.graphics.newQuad(75,485,183,152,index.vidas.img:getDimensions())
index.vidas.quad[2] = love.graphics.newQuad(435,485,183,152,index.vidas.img:getDimensions())

index.vidas.scale = {x = 0.3,y=0.3}

index.texturas = {}
    
index.texturas["gelatina"] = love.graphics.newImage("assets/img/Texturas/suelo3.png")
index.texturas["gelatina"]:setWrap("repeat")

index.texturas.casa = {}

index.texturas.casa[1] = love.graphics.newImage("assets/img/Texturas/wafer.png")
index.texturas.casa[1]:setWrap("repeat")

index.texturas.casa[2] = love.graphics.newImage("assets/img/Texturas/wafer2.png")
index.texturas.casa[2]:setWrap("repeat")

index.texturas.casa[3] = love.graphics.newImage("assets/img/Texturas/wafer_profundidad.png")
index.texturas.casa[3]:setWrap("repeat")

index.cosas = {}

index.cosas["ventana"]={}
index.cosas["ventana"][1] = love.graphics.newImage("assets/img/Objetos/ventana.png")
index.cosas["ventana"][2] = love.graphics.newImage("assets/img/Objetos/ventana2.png")
index.cosas["ventana"][3] = love.graphics.newImage("assets/img/Objetos/ventana3.png")
index.cosas["ventana"][4] = love.graphics.newImage("assets/img/Objetos/ventana4.png")

index.cosas["ventana_data"] = {}
index.cosas["ventana_data"].x = 0.12
index.cosas["ventana_data"].y = 0.12

index.cosas["confite"]={}
index.cosas["confite"][1] = love.graphics.newImage("assets/img/Efectos/ladrilloEfecto.png")
index.cosas["confite"][2] = love.graphics.newImage("assets/img/Efectos/ladrilloEfecto2.png")
index.cosas["confite"][3] = love.graphics.newImage("assets/img/Efectos/ladrilloEfecto3.png")
index.cosas["confite"][4] = love.graphics.newImage("assets/img/Efectos/ladrilloEfecto4.png")

index.cosas["confite_data"] = {}
index.cosas["confite_data"].x = 0.1
index.cosas["confite_data"].y = 0.1

index.cosas["puerta"] = {}
index.cosas["puerta"][1] = love.graphics.newImage("assets/img/Objetos/puertas.png")

index.cosas["puerta_data"] = {}
index.cosas["puerta_data"].x = 0.2
index.cosas["puerta_data"].y = 0.2


index.cosas["adorno_mapa"] = {}
index.cosas["adorno_mapa"][1] = love.graphics.newImage("assets/img/Efectos/efectoestandar.png")
index.cosas["adorno_mapa"][2] = love.graphics.newImage("assets/img/Efectos/sueloefecto1.png")
index.cosas["adorno_mapa"][3] = love.graphics.newImage("assets/img/Efectos/sueloefecto2.png")

index.cosas["adorno_mapa_data"] = {}
index.cosas["adorno_mapa_data"].x = 0.2
index.cosas["adorno_mapa_data"].y = 0.2

index.redimensionable = {}
index.redimensionable[1] = love.graphics.newImage("assets/img/Objetos/techo2.png")

index.armas = {}

index.armas.img = love.graphics.newImage("assets/img/Armas/armas.png")

index.armas.quad={}
index.armas.quad[1] = love.graphics.newQuad(402,43,157,111,index.armas.img:getDimensions())
index.armas.quad[2] = love.graphics.newQuad(47,423,211,120,index.armas.img:getDimensions())
index.armas.quad[3] = love.graphics.newQuad(42,35,315,153,index.armas.img:getDimensions())
index.armas.quad[4] = love.graphics.newQuad(602,210,531,146,index.armas.img:getDimensions())
index.armas.quad[5] = love.graphics.newQuad(21,245,491,121,index.armas.img:getDimensions())
index.armas.quad[6] = love.graphics.newQuad(598,23,503,156,index.armas.img:getDimensions())

index.armas.balas={}
index.armas.balas.quad={}
index.armas.balas.quad[1] = love.graphics.newQuad(1110,49,118,55,index.armas.img:getDimensions())

index.armas.scale ={}
index.armas.scale[1] = {x = 0.25,y=0.25}
index.armas.scale[2] = {x = 0.25,y=0.25}
index.armas.scale[3] = {x = 0.20,y=0.20}
index.armas.scale[4] = {x = 0.28,y=0.28}
index.armas.scale[5] = {x = 0.25,y=0.25}
index.armas.scale[6] = {x = 0.25,y=0.25}

index.armas.scale_screen={}
index.armas.scale_screen[1] = {x = 0.35,y=0.35}
index.armas.scale_screen[3] = {x = 0.3,y=0.3}
index.armas.scale_screen[6] = {x = 0.25,y=0.25}

index.armas.balas.scale ={}
index.armas.balas.scale[1] = {x = 0.25,y=0.25}

index.municion = {}
index.municion.quad = love.graphics.newQuad(1283,20,233,206,index.armas.img:getDimensions())
index.municion.scale = {x = 0.25,y=0.25}

index.skybox = {}
index.skybox[1] = love.graphics.newImage("assets/img/Capa_3/CieloDia.png")
index.skybox[2] = love.graphics.newImage("assets/img/Capa_3/CieloDia.png")
index.skybox[3] = love.graphics.newImage("assets/img/Capa_3/CieloDia.png")

index.background={}
index.background[1] = love.graphics.newImage("assets/img/Capa_2/Fondo1.png")

return  index