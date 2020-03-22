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

index.texturas.casa[2] = love.graphics.newImage("assets/img/Texturas/wafer1.png")
index.texturas.casa[2]:setWrap("repeat")

index.texturas.casa[3] = love.graphics.newImage("assets/img/Texturas/wafer2.png")
index.texturas.casa[3]:setWrap("repeat")

index.texturas.casa[4] = love.graphics.newImage("assets/img/Texturas/wafer3.png")
index.texturas.casa[4]:setWrap("repeat")

index.texturas.casa[5] = love.graphics.newImage("assets/img/Texturas/wafer4.png")
index.texturas.casa[5]:setWrap("repeat")

index.texturas.pared = {}
index.texturas.pared[1] = love.graphics.newImage("assets/img/Texturas/wafer_choco1.png")
index.texturas.pared[1]:setWrap("repeat")

index.texturas.pared[2] = love.graphics.newImage("assets/img/Texturas/wafer_choco1.png")
index.texturas.pared[2]:setWrap("repeat")

index.texturas.pared[3] = love.graphics.newImage("assets/img/Texturas/wafer_vainilla.png")
index.texturas.pared[3]:setWrap("repeat")

index.texturas.pared[4] = love.graphics.newImage("assets/img/Texturas/wafer_vainilla.png")
index.texturas.pared[4]:setWrap("repeat")

index.texturas.liquido = {}

index.texturas.liquido[1] = love.graphics.newImage("assets/img/Texturas/agua.png")
index.texturas.liquido[1]:setWrap("repeat")

index.cosas = {}

index.cosas.img = love.graphics.newImage("assets/img/Adornos/spritesheet.png")
index.cosas.quad = {}


index.cosas.quad["dulce_1"] = love.graphics.newQuad(144,2710,82,73,index.cosas.img:getDimensions())
index.cosas.quad["dulce_2"] = love.graphics.newQuad(0,2710,64,68,index.cosas.img:getDimensions())
index.cosas.quad["dulce_3"] = love.graphics.newQuad(69,2710,70,69,index.cosas.img:getDimensions())
index.cosas.quad["reflejo"] = love.graphics.newQuad(0,2205,500,500,index.cosas.img:getDimensions())
index.cosas.quad["pared_1"] = love.graphics.newQuad(0,2788,500,500,index.cosas.img:getDimensions())
index.cosas.quad["pared_2"] = love.graphics.newQuad(0,3638,500,500,index.cosas.img:getDimensions())
index.cosas.quad["pared_3"] = love.graphics.newQuad(0,4143,500,500,index.cosas.img:getDimensions())
index.cosas.quad["pared_4"] = love.graphics.newQuad(0,4648,500,500,index.cosas.img:getDimensions())
index.cosas.quad["suelo_1"] = love.graphics.newQuad(0,5153,500,500,index.cosas.img:getDimensions())
index.cosas.quad["suelo_2"] = love.graphics.newQuad(0,6003,500,500,index.cosas.img:getDimensions())
index.cosas.quad["ventana_1"] = love.graphics.newQuad(0,1010,500,340,index.cosas.img:getDimensions())
index.cosas.quad["ventana_2"] = love.graphics.newQuad(0,1355,500,340,index.cosas.img:getDimensions())
index.cosas.quad["ventana_3"] = love.graphics.newQuad(0,3293,500,340,index.cosas.img:getDimensions())
index.cosas.quad["ventana_4"] = love.graphics.newQuad(0,5658,500,340,index.cosas.img:getDimensions())

index.cosas.scale = {}

index.cosas.scale["dulce"] = {0.5,0.5}
index.cosas.scale["reflejo"] = {0.2,0.2}
index.cosas.scale["pared"] = {0.1,0.1}
index.cosas.scale["suelo"] = {0.2,0.2}
index.cosas.scale["ventana"] = {x=0.12,y=0.12}


index.objetos_mapa = {}
index.objetos_mapa.img = love.graphics.newImage("assets/img/Objetos/Adornos_Mapa.png")
index.objetos_mapa.arbol = love.graphics.newQuad(839,17,254,400,index.objetos_mapa.img:getDimensions())
index.objetos_mapa.helado = love.graphics.newQuad(522,59,244,338,index.objetos_mapa.img:getDimensions())
index.objetos_mapa.vaso_helado = love.graphics.newQuad(1195,17,250,373,index.objetos_mapa.img:getDimensions())

index.redimensionable = {}
index.redimensionable[1] = love.graphics.newImage("assets/img/Objetos/techo2.png")
index.redimensionable[2] = love.graphics.newImage("assets/img/Objetos/techo1.png")

index.armas = {}

index.armas.img = love.graphics.newImage("assets/img/Armas/armas.png")

index.armas.quad={}
index.armas.quad[1] = love.graphics.newQuad(536,43,157,111,index.armas.img:getDimensions())
index.armas.quad[2] = love.graphics.newQuad(47,423,211,128,index.armas.img:getDimensions())
index.armas.quad[3] = love.graphics.newQuad(41,35,316,153,index.armas.img:getDimensions())
index.armas.quad[4] = love.graphics.newQuad(833,210,531,146,index.armas.img:getDimensions())
index.armas.quad[5] = love.graphics.newQuad(21,245,491,121,index.armas.img:getDimensions())
index.armas.quad[6] = love.graphics.newQuad(861,23,503,156,index.armas.img:getDimensions())

index.armas.balas={}
index.armas.balas.quad={}

index.armas.balas.quad[1] = love.graphics.newQuad(713,47,65,27,index.armas.img:getDimensions())
index.armas.balas.quad[2] = love.graphics.newQuad(280,427,68,30,index.armas.img:getDimensions())
index.armas.balas.quad[3] = love.graphics.newQuad(373,58,83,29,index.armas.img:getDimensions())
index.armas.balas.quad[4] = love.graphics.newQuad(1386,240,105,22,index.armas.img:getDimensions())
index.armas.balas.quad[5] = love.graphics.newQuad(534,256,88,31,index.armas.img:getDimensions())
index.armas.balas.quad[6] = love.graphics.newQuad(1373,49,118,55,index.armas.img:getDimensions())

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
index.armas.balas.scale[1] = {x = 0.30,y=0.35}
index.armas.balas.scale[2] = {x = 0.30,y=0.35}
index.armas.balas.scale[3] = {x = 0.30,y=0.35}
index.armas.balas.scale[4] = {x = 0.30,y=0.35}
index.armas.balas.scale[5] = {x = 0.30,y=0.35}
index.armas.balas.scale[6] = {x = 0.35,y=0.35}

index.municion = {}
index.municion.quad = love.graphics.newQuad(1271,754,233,206,index.armas.img:getDimensions())
index.municion.scale = {x = 0.25,y=0.25}

index.skybox = {}
index.skybox[1] = love.graphics.newImage("assets/img/Capa_3/CieloDia.png")
index.skybox[2] = love.graphics.newImage("assets/img/Capa_3/CieloTarde.png")
index.skybox[3] = love.graphics.newImage("assets/img/Capa_3/CieloNoche.png")

index.background={}
index.background[1] = love.graphics.newImage("assets/img/Capa_2/Fondo1.png")


index.movible = {}
index.movible[1] = love.graphics.newImage("assets/img/Objetos/Caja.png")

index.meteorito = {}
index.meteorito.img = love.graphics.newImage("assets/img/Meteorito/meteorito_spritesheet.png")
index.meteorito.quad = {}
index.meteorito.quad[1] = love.graphics.newQuad(634,29,431,422,index.meteorito.img:getDimensions())
index.meteorito.quad[2] = love.graphics.newQuad(1106,29,431,422,index.meteorito.img:getDimensions())
index.meteorito.quad[3] = love.graphics.newQuad(1578,28,431,423,index.meteorito.img:getDimensions())
index.meteorito.quad[4] = love.graphics.newQuad(634,592,431,422,index.meteorito.img:getDimensions())
index.meteorito.quad[5] = love.graphics.newQuad(1106,592,431,422,index.meteorito.img:getDimensions())
index.meteorito.quad[6] = love.graphics.newQuad(1578,591,431,422,index.meteorito.img:getDimensions())


index.meteorito.fuego = love.graphics.newQuad(0,0,611,1026,index.meteorito.img:getDimensions())

index.burbujas = {}
index.burbujas.img = index.cosas.img
index.burbujas.quad = {}
index.burbujas.quad[1] = love.graphics.newQuad(0,0,500,500,index.burbujas.img:getDimensions())
index.burbujas.quad[2] = love.graphics.newQuad(0,505,500,500,index.burbujas.img:getDimensions())
index.burbujas.quad[3] = love.graphics.newQuad(0,1700,500,500,index.burbujas.img:getDimensions())

index.ui = {}
index.ui.boton_1 = love.graphics.newImage("assets/img/UI/icono_mundo.png")

index.puerta = love.graphics.newImage("assets/img/Objetos/puertas.png")

return  index