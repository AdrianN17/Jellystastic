local mundoPrincipal = require "gamestates.mundo_principal"
local mundoSecundario = require "gamestates.mundo_secundario"
local mundoGenerico = require "gamestates.mundo_generico"

local Menu = Class{}

function Menu:init()
  self.playerImgData = Index_img.jugador 
  self.playerScale = {x = 0.25, y = 0.25}
  
  self.hsla= {
    vector = {0,0,0,0},
    text = {"h","s","l"},
    status = {false,false,false,false}
  }
  
  self.shader = love.graphics.newShader(Shader_index.shader_player)
  
  self.iteradorAccesorio = 0
  
  self.accesoriosImgData = Index_img.accesorios
  
  self.iteradorMapa = 1
  
  self.X,self.Y = love.graphics.getDimensions()
  self.X,self.Y = self.X/2,self.Y/2
  
  _G.teclas = {up = "w", down = "s", left="a", right = "d", get = "e", changeWeapon = "q", getBox = "g"}  
  
end

function Menu:draw()
  local player = self.playerImgData
  local scale = self.playerScale
  local viewport = player.viewport[1][1]

  love.graphics.setShader(self.shader)
    love.graphics.draw(player.img,player.quad[1][1],600,100,0,scale.x,scale.y,viewport.w/2,viewport.h/2)
  love.graphics.setShader()
  
  if self.iteradorAccesorio>0 then
    
    local y = (self.playerScale.y*viewport.h)/2.2
    local accesorio = self.accesoriosImgData
    local viewport = accesorio.viewport[self.iteradorAccesorio]
    
    love.graphics.draw(accesorio.img,accesorio.quad[self.iteradorAccesorio],600,100-y,0,scale.x,scale.y,viewport.w/2,viewport.h/2)
  end
  
  imgui.Render()
  love.graphics.setColor(1, 1, 1)
end

function Menu:update(dt)
  imgui.NewFrame()
  
  imgui.SetNextWindowPos(self.X-250, self.Y-100)
  imgui.SetNextWindowSize(250, 200)
  
  imgui.Begin("Iniciar Juego",nil)
  
  self.iteradorMapa = imgui.SliderInt("Niveles", self.iteradorMapa, 1, 4)
  
    for i=3,1,-1 do
      if imgui.ImageButton(Index_img.ui.img[1], 65,50) then
        _G.playerValues = {self.hsla.vector,self.iteradorAccesorio}
        
        local index = self.iteradorMapa*3 - i+1
        
        Gamestate.switch(mundoPrincipal,{mapaIndex = index,accion = "crear"})
      end
      imgui.SameLine()
    end
  
  imgui.End()
  
  imgui.SetNextWindowPos(500, 175)
  imgui.SetNextWindowSize(200, 200)
  imgui.Begin("Editor de personaje",nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})
    
    imgui.Text("Colores")
  
    for i=1,2,1 do
      self.hsla.vector[i],self.hsla.status[i] = imgui.SliderFloat(self.hsla.text[i], self.hsla.vector[i], 0, 1,string.format("%0.2f", self.hsla.vector[i]))
    end
    
    if self.hsla.status[1] or self.hsla.status[2] or self.hsla.status[3] then
      self.shader:send("color_player",self.hsla.vector)
    end
    
    imgui.Text("Accesorios")
    
    self.iteradorAccesorio = imgui.SliderInt("", self.iteradorAccesorio, 0, #self.accesoriosImgData.quad)
    
  imgui.End()
  
end

function Menu:quit()
  imgui.ShutDown()
end

function Menu:textinput(t)
  imgui.TextInput(t)
  
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function Menu:keypressed(key)
  imgui.KeyPressed(key)
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function Menu:keyreleased(key)
  imgui.KeyReleased(key)
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function Menu:mousemoved(x, y)
  imgui.MouseMoved(x, y)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function Menu:mousepressed(x, y, button)
  imgui.MousePressed(button)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function Menu:mousereleased(x, y, button)
  imgui.MouseReleased(button)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function Menu:wheelmoved(x, y)
  imgui.WheelMoved(y)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

return Menu