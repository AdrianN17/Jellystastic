local capa_3 = {}

capa_3.img = {}
capa_3.img[1] = love.graphics.newImage("assets/img/Capa_3/CieloDia.png")
capa_3.img[2] = love.graphics.newImage("assets/img/Capa_3/CieloTarde.png")
capa_3.img[3] = love.graphics.newImage("assets/img/Capa_3/CieloNoche.png")

capa_3.dimensions = {}

for i,img in pairs(capa_3.img) do
  local w,h = img:getDimensions()
  capa_3.dimensions[i] = {w=w,h=h}
end

return capa_3