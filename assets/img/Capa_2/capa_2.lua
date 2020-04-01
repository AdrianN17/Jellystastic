local capa_2 = {}

capa_2.img = {}

capa_2.img[1] = love.graphics.newImage("assets/img/Capa_2/Fondo1.png")

capa_2.dimensions = {}

for i,img in pairs(capa_2.img) do
  local w,h = img:getDimensions()
  capa_2.dimensions[i] = {w=w,h=h}
end

return capa_2