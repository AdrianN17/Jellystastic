local ui = {}

ui.img = {}
ui.img[1] = love.graphics.newImage("assets/img/UI/icono_mundo.png")

ui.dimensions = {}

for i,img in ipairs(ui.img) do
  local w,h = img:getDimensions()
  ui.dimensions[i] = {w=w,h=h}
end

return ui 