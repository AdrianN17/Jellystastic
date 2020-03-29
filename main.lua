io.stdout:setvbuf("no")

Class = require "libs.hump.class"
math.vec = require "libs.hump.vector"
Inspect = require "libs.inspect.inspect"
Fsm = require "libs.statemachine.statemachine"
Sti = require "libs.sti"
Timer = require "libs.chrono.Timer"
Switch = require "libs.lua-switch.lua-switch"
Camera = require "libs.cam11.cam11"

require "imgui"

Shader_index = require "assets/shader/index"
Index_img = require "assets.img.index"
Gamestate = require "libs.hump.gamestate" 
Map_index = require "assets.map.index"
Entities_index = require "entidades.index"


Menu = require "gamestates.menu"

function love.load()
  
  Gamestate.registerEvents()
  Gamestate.switch(Menu())
end

function table.empty (obj)
    for _, _ in pairs(obj) do
        return false
    end
    return true
end

function math.round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function math.distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

function Iprint(obj)
  print(Inspect(obj))
end

function sortVertices(obj)
  local vertex = {}

  for _, v in ipairs(obj) do
    table.insert(vertex, v.x)
    table.insert(vertex, v.y)
  end

  return vertex
end

function math.clearPolygonCenter(tabla)
  local ox,oy = 0,0
  local t = {}
  
  for i=1,#tabla,1 do
    table.insert(t,tabla[i].x)
    table.insert(t,tabla[i].y)
    
    ox = ox +tabla[i].x
    oy = oy +tabla[i].y
  end
  
  ox,oy  = (ox/#tabla) , (oy/#tabla)
  
  for i=1,#t,2 do
    t[i] = t[i] -ox
    t[i+1] = t[i+1] -oy
  end
  
  return t, ox,oy
end

function math.calcularDimensiones(tipo,tabla)
  if tipo == "rectangulo_1" then
    return math.abs(tabla[1] - tabla[7]), math.abs(tabla[2] - tabla[4])
  end
end