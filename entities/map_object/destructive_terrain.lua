local Class = require "libs.hump.class"

local Destructive = require "entities.map_object.destructive"

local destructive_terrain = Class{
    __includes = {Destructive}
}

function destructive_terrain:init(poligono,img,uv_scale)
  
  Destructive.init(self)
  
  self.mesh = self:poly2mesh(poligono, uv_scale)
  self.mesh:setTexture(img)
  
  self.poligonos_tabla={}
  
  
  --self.body = love.physics.newBody(self.entidad.world,0,0,"kinematic")
  self.poligono_main_index=1
  self:crear_poligonos_fisica(poligono)
  
end

function destructive_terrain:draw_obj()
  love.graphics.draw(self.mesh)
end

function destructive_terrain:update_obj(dt)
  
end

function destructive_terrain:poly2mesh(points,uv_scale)
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


return destructive_terrain