local Class = require "libs.hump.class"
require "imgui"

local menu = Class{}


function menu:init()
  
  self.player_img =  img_index.personajes[1].img
  self.player_quad =  img_index.personajes[1].quad[1][1]
  
  _,_,self.hx,self.hy = self.player_quad:getViewport()
  
  self.accesorios = img_index.accesorios
  self.accesorios_max = #self.accesorios.quad
  
  self.hsla = {0,0,0,0}
  self.hsla_text = {"h","s","l"}
  self.hsla_status = {false,false,false}
  self.shader_1 = love.graphics.newShader(shader_index.shader_player)
  
  self.iterador_accesorio = 0
  
  self.scale_player = 0.25
  
  self.X,self.Y = love.graphics.getDimensions()
  self.X,self.Y = self.X/2,self.Y/2
end

function menu:draw()
  
  love.graphics.setShader(self.shader_1)
    love.graphics.draw(self.player_img,self.player_quad,600,100,0,self.scale_player,self.scale_player,self.hx/2,self.hy/2)
  love.graphics.setShader()
  
  if self.iterador_accesorio>0 then
    local quad = self.accesorios.quad[self.iterador_accesorio]
    local _,_,w1,h1 = quad:getViewport()
    local y = self.scale_player*self.hy/2.2
    love.graphics.draw(self.accesorios["img"],quad,600,100-y,0,self.scale_player,self.scale_player,w1/2,h1/2)
  end
  
  imgui.Render()
  love.graphics.setColor(1, 1, 1)
  
  
end

function menu:update(dt)
  imgui.NewFrame()
  
  imgui.SetNextWindowPos(self.X-100, self.Y-100)
  imgui.SetNextWindowSize(200, 200)
  
  imgui.Begin("",nil,"ImGuiWindowFlags_NoTitleBar")
  
    if imgui.Button("Empezar") then
      _G.player_values = {self.hsla,self.iterador_accesorio}
      
      Gamestate.switch(Game,1,"crear")
    end
    
  imgui.End()
  
  imgui.SetNextWindowPos(500, 175)
  imgui.SetNextWindowSize(200, 200)
  imgui.Begin("Editor de personaje",nil, {"ImGuiWindowFlags_NoMove","ImGuiWindowFlags_NoResize"})
    
    imgui.Text("Colores")
  
    for i=1,3,1 do
      self.hsla[i],self.hsla_status[i] = imgui.SliderFloat(self.hsla_text[i], self.hsla[i], 0, 1,string.format("%0.2f", self.hsla[i]))
      self.hsla[i] = math.floor(self.hsla[i]*10)/10
    end
    

    if self.hsla_status[1] or self.hsla_status[2] or self.hsla_status[3] then
      self.shader_1:send("color_player",self.hsla)
    end
    
    imgui.Text("Accesorios")
    
    self.iterador_accesorio = imgui.SliderInt("", self.iterador_accesorio, 0, self.accesorios_max)
    
  imgui.End()
  
  
  
end

function menu:quit()
  imgui.ShutDown()
end

function menu:textinput(t)
  imgui.TextInput(t)
  
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function menu:keypressed(key)
  imgui.KeyPressed(key)
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function menu:keyreleased(key)
  imgui.KeyReleased(key)
  if not imgui.GetWantCaptureKeyboard() then
      -- Pass event to the game
  end
end

function menu:mousemoved(x, y)
  imgui.MouseMoved(x, y)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function menu:mousepressed(x, y, button)
  imgui.MousePressed(button)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function menu:mousereleased(x, y, button)
  imgui.MouseReleased(button)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

function menu:wheelmoved(x, y)
  imgui.WheelMoved(y)
  if not imgui.GetWantCaptureMouse() then
      -- Pass event to the game
  end
end

return menu