io.stdout:setvbuf("no")

_G.Class = require "libs.hump.class"
_G.math.vec = require "libs.hump.vector"
_G.Inspect = require "libs.inspect.inspect"
_G.Fsm = require "libs.statemachine.statemachine"
_G.Sti = require "libs.sti"
_G.Timer = require "libs.chrono.Timer"
_G.Switch = require "libs.lua-switch.src.switch"
_G.Camera = require "libs.cam11.cam11"
_G.Gamera = require "libs.gamera.gamera"

require "imgui"

_G.Shader_index = require "assets/shader/index"
_G.Index_img = require "assets.img.index"
_G.Gamestate = require "libs.hump.gamestate" 
_G.Map_index = require "assets.map.index"
_G.Entities_index = require "entidades.index"

require "libs.utils"

_G.Menu = require "gamestates.menu"
_G.Pausa = require "gamestates.pausa"

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


function math.calcularDistancia(x1,y1,x2,y2)
  local a,b = x2 - x1, y2 - y1
  return math.sqrt(math.pow(a,2)+math.pow(b,2))
end

function poly2mesh(points,uv_scale)
  local polypts = love.math.triangulate(points)
  local tlist

  local vnums = {}
  local vcoords = {}
  do
    local verthash = {}
    local n = 0
    local v
    -- use unique vertices by using a coordinate hash table
    for i = 1, #polypts do
      for j = 1, 3 do
        local px = polypts[i][j * 2 - 1]
        local py = polypts[i][j * 2]
        if not verthash[px] then
          verthash[px] = {}
        end
        if not verthash[px][py] then
          n = n + 1
          verthash[px][py] = n
          vcoords[n * 2 - 1] = px
          vcoords[n * 2] = py
          v = n
        else
          v = verthash[px][py]
        end
        vnums[(i - 1) * 3 + j] = v
      end
    end
  end



  local mesh = love.graphics.newMesh(#vcoords, "triangles", "static")
  for i = 1, #vcoords / 2 do
    local x, y = vcoords[i * 2 - 1], vcoords[i * 2]

    -- Here's where the UVs are assigned
    mesh:setVertex(i, x, y, x / (50 * uv_scale), y / (50 * uv_scale))
  end
  mesh:setVertexMap(vnums)
  return mesh
end

function math.getPointAngle(cx,cy,cr,distancia,radio)
  local r = math.rad(radio)+cr

  local ox = cx + math.cos(r) * distancia
  local oy = cy + math.sin(r) * distancia
  
  return ox,oy
end

function math.sign(number)
  if number>0 then
    return 1
  else
    return -1
  end
end

function checkStringInTable(string,tabla)
  for i,k in ipairs(tabla) do
    if k == string then
      return true
    end
  end
  
  return false
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.lowmemory()
    collectgarbage()
end

