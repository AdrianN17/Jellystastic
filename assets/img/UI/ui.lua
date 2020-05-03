local ui = {}

ui.img = {}
ui.img[1] = love.graphics.newImage("assets/img/UI/icono_mundo.png")


ui.img["aliadosSalvados"] = love.graphics.newImage("assets/img/UI/Icono.png")
ui.img["logo"] = love.graphics.newImage("assets/img/UI/logo_oficial.png")

ui.dimensions = {}

for i,img in pairs(ui.img) do
  local w,h = img:getDimensions()
  ui.dimensions[i] = {w=w,h=h}
end

return ui
