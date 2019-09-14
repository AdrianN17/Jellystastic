local imagedata={}

imagedata["spritesheet"]=love.graphics.newImage("assets/img/spritesheet.png")
imagedata["pj1"]={}
imagedata["pj1"][1]=love.graphics.newQuad(105,194,100,140,imagedata["spritesheet"]:getDimensions())
imagedata["pj1"][2]=love.graphics.newQuad(210,194,100,140,imagedata["spritesheet"]:getDimensions())
imagedata["pj1"][3]=love.graphics.newQuad(105,647,100,140,imagedata["spritesheet"]:getDimensions())
imagedata["pj1"][4]=love.graphics.newQuad(105,339,100,140,imagedata["spritesheet"]:getDimensions())


imagedata["pj2"]={}
imagedata["pj2"][1]=love.graphics.newQuad(0,1,100,152,imagedata["spritesheet"]:getDimensions())
imagedata["pj2"][2]=love.graphics.newQuad(0,160,100,152,imagedata["spritesheet"]:getDimensions())
imagedata["pj2"][3]=love.graphics.newQuad(0,641,100,152,imagedata["spritesheet"]:getDimensions())
imagedata["pj2"][4]=love.graphics.newQuad(0,318,100,152,imagedata["spritesheet"]:getDimensions())

imagedata["npc"]={}
imagedata["npc"][1]=love.graphics.newQuad(210,339,100,140,imagedata["spritesheet"]:getDimensions())
imagedata["npc"][2]=love.graphics.newQuad(0,475,100,152,imagedata["spritesheet"]:getDimensions())

imagedata["baba1"]={}
imagedata["baba1"][1]=love.graphics.newQuad(146,0,164,92,imagedata["spritesheet"]:getDimensions())
imagedata["baba1"][2]=love.graphics.newQuad(146,97,164,92,imagedata["spritesheet"]:getDimensions())

imagedata["zombie"]={}
imagedata["zombie"][1]=love.graphics.newQuad(105,484,100,140,imagedata["spritesheet"]:getDimensions())
imagedata["zombie"][2]=love.graphics.newQuad(210,484,100,140,imagedata["spritesheet"]:getDimensions())

imagedata["spritesheet2"]=love.graphics.newImage("assets/img/balas.png")

imagedata["balas"]={}
imagedata["balas"][1]=love.graphics.newQuad(0,0,10,10,imagedata["spritesheet2"]:getDimensions())
imagedata["balas"][2]=love.graphics.newQuad(11,0,10,10,imagedata["spritesheet2"]:getDimensions())
imagedata["balas"][3]=love.graphics.newQuad(22,0,10,10,imagedata["spritesheet2"]:getDimensions())
imagedata["balas"][4]=love.graphics.newQuad(33,0,10,10,imagedata["spritesheet2"]:getDimensions())
imagedata["balas"][5]=love.graphics.newQuad(44,0,10,10,imagedata["spritesheet2"]:getDimensions())

imagedata["spritesheet3"]=love.graphics.newImage("assets/maps/tile.png")

imagedata["arma"]={}
imagedata["arma"][1]=love.graphics.newQuad(0,196,13,13,imagedata["spritesheet3"]:getDimensions())
imagedata["arma"][2]=love.graphics.newQuad(32,195,18,13,imagedata["spritesheet3"]:getDimensions())
imagedata["arma"][3]=love.graphics.newQuad(64,198,25,6,imagedata["spritesheet3"]:getDimensions())
imagedata["arma"][4]=love.graphics.newQuad(97,198,31,7,imagedata["spritesheet3"]:getDimensions())
imagedata["arma"][5]=love.graphics.newQuad(129,197,31,10,imagedata["spritesheet3"]:getDimensions())

imagedata["arma_t"]={{13,13},{18,13},{25,6},{31,7},{31,10}}

imagedata["meteoro"]=love.graphics.newImage("assets/img/meteoro.png")

return imagedata