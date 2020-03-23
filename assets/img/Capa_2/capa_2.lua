local capa_2 = {}

capa_2.img = {}

capa_2.img.background = {}
capa_2.img.background[1] = love.graphics.newImage("assets/img/Capa_2/Fondo1.png")

capa_2.img.nube = {}
capa_2.img.nube[1] = love.graphics.newImage("assets/img/Capa_2/nube1.png")
capa_2.img.nube[2] = love.graphics.newImage("assets/img/Capa_2/nube2.png")
capa_2.img.nube[3] = love.graphics.newImage("assets/img/Capa_2/nube3.png")

capa_2.dimensions = {}

for i,img_data in ipairs(capa_2.img) do
  for j,img in (img_data) do
    
    if capa_2.dimensions[i] == nil then
      capa_2.dimensions[i] = {}
    end
    
    local w,h = img:getDimensions()
    capa_2.dimensions[i][j] = {w=w,h=h}
  end
end

return capa_2