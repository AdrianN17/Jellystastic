local mundoPrincipal = require "gamestates.mundo_principal"

local Menu = Class{}

function Menu:init()

  if self.hsla then return end

  _G.teclas = {up = "w", down = "s", left="a", right = "d", get = "e", changeWeapon = "q", getBox = "g", pause ="p"}
  _G.idioma = 1

  loadDataObj:leerConfiguracion()

  self.StringText = String_index.menu[_G.idioma ]

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

  self.uiImgData = Index_img.ui

  self.cambiarBoton = nil

  

  self.conectarServidor = {ip = "0.0.0.0",port = "22122"}

end

function Menu:draw()


  local dimensions = self.uiImgData.dimensions.logo
  local w,h = dimensions.w,dimensions.h
  love.graphics.draw(self.uiImgData.img.logo,300,100,0,0.30,0.30,w/2,h/2)


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
  imgui.SetNextWindowSize(250, 115)

  imgui.Begin(self.StringText.TituloIniciarJuego,nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})

  self.iteradorMapa = imgui.SliderInt(self.StringText.Niveles, self.iteradorMapa, 1, 4)

    for i=3,1,-1 do
      if imgui.ImageButton(Index_img.ui.img[1], 65,50) then
        _G.playerValues = {self.hsla.vector,self.iteradorAccesorio}

        local index = self.iteradorMapa*3 - i+1
        local nuevoEscenario = mundoPrincipal()

        if Map_index.campana[index] then
          loadDataObj:guardarConfiguracion()
          Gamestate.switch(nuevoEscenario,{mapaIndex = index,accion = "crear"})
        end
      end
      imgui.SameLine()
    end

  imgui.End()

  imgui.SetNextWindowPos(self.X+100, self.Y-100)
  imgui.SetNextWindowSize(200, 150)
  imgui.Begin(self.StringText.TituloEditor,nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})

    imgui.Text(self.StringText.Colores)

    for i=1,2,1 do
      self.hsla.vector[i],self.hsla.status[i] = imgui.SliderFloat(self.hsla.text[i], self.hsla.vector[i], 0, 1,string.format("%0.2f", self.hsla.vector[i]))
    end

    if self.hsla.status[1] or self.hsla.status[2] or self.hsla.status[3] then
      self.shader:send("color_player",self.hsla.vector)
    end

    imgui.Text(self.StringText.Accesorios)

    self.iteradorAccesorio = imgui.SliderInt("", self.iteradorAccesorio, 0, #self.accesoriosImgData.quad)

  imgui.End()

  imgui.SetNextWindowPos(self.X-250, self.Y+50)
  imgui.SetNextWindowSize(250, 150)

  imgui.Begin(self.StringText.TituloControles,nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})

  for i,texto in pairs(teclas) do

    if imgui.Button(self.StringText[i],100,20) and not self.cambiarBoton then
      self.cambiarBoton = i
    end

    imgui.SameLine(150)

    imgui.Text(texto)

  end

  imgui.End()

  imgui.SetNextWindowPos(self.X+100, self.Y+200)
  imgui.SetNextWindowSize(200, 150)

  imgui.Begin("",nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize","ImGuiWindowFlags_NoTitleBar"})

  _G.idioma = imgui.Combo("Combo", _G.idioma, { "Español/Spanish", "Ingles/English"}, 2);

  if imgui.Button(self.StringText.Guardar) then
    self:cambiarIdioma()
    loadDataObj:guardarConfiguracion()
  end

  if imgui.Button(self.StringText.LimpiarData) then
    loadDataObj:limpiarConfiguracion()
    self:cambiarIdioma()
  end

  imgui.End()

  imgui.SetNextWindowPos(self.X+100, self.Y+60)
  imgui.SetNextWindowSize(200, 140)

  imgui.Begin(self.StringText.TituloServidor,nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})


    self.conectarServidor.ip = imgui.InputText("IP", self.conectarServidor.ip, 100);


    self.conectarServidor.port = imgui.InputText("Port", self.conectarServidor.port, 100);

    if imgui.Button(self.StringText.Conectar) then

    end

    if imgui.Button(self.StringText.Listado) then

    end


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
      self:validarTecla(key)
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

function Menu:validarTecla(key)

  if key and self.cambiarBoton and not self:validarTeclaActuales(key) then

    _G.teclas[self.cambiarBoton] = key
    self.cambiarBoton = nil

  end

end

function Menu:validarTeclaActuales(key)
  local validar = false

  for _,tecla in pairs(_G.teclas) do
    if tecla == key then
      validar = true
    end
  end

  return validar
end

function Menu:cambiarIdioma()
  self.StringText = String_index.menu[_G.idioma]
end

return Menu