local Class = require "libs.hump.class"

local destructive_terrain = Class{
    __includes = {}
}

function destructive_terrain:init(poligono,img)
  self.mesh = self:poly2mesh(poligono)
  self.mesh:setTexture(img)
  
end

function destructive_terrain:draw_obj()
  love.graphics.draw(self.mesh)
end

function destructive_terrain:update_obj(dt)
  
end



function destructive_terrain:poly2mesh(points)
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
    mesh:setVertex(i, x, y, x / 50, y / 50)
  end
  mesh:setVertexMap(vnums)
  return mesh
end

return destructive_terrain