local Class = require "libs.hump.class"

local liquido = Class{}

function liquido:init(entidad,poligono,img,radio,tipo)
  self.entidad = entidad
  
  self.entidad:add_obj("liquid",self)
  
  texture = img.texturas.liquido[tonumber(tipo)]
  
  self.mesh = self:poly2mesh(poligono,2)
  self.mesh:setTexture(texture)
  
  
  self.body = love.physics.newBody(self.entidad.world,0,0)
  self.shape = love.physics.newPolygonShape(poligono)
  self.fixture = love.physics.newFixture(self.body,self.shape)
  
  self.fixture:setSensor(true)
  
  self.fixture:setUserData( {data="liquid",obj=self, pos=orden.liquido} )
  
  self.ox,self.oy,self.w,self.h = self.fixture:getBoundingBox(1)
  
  self.lista_flote={}
  
end

function liquido:draw()
  love.graphics.draw(self.mesh)
end

function liquido:update()
end

function liquido:poly2mesh(points,uv_scale)
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
    mesh:setVertex(i, x, y, x / (50*uv_scale), y / (50*uv_scale))
  end
  mesh:setVertexMap(vnums)
  return mesh
end

function liquido:agregar(obj)
  for _, data in ipairs(self.lista_flote) do
    if data == obj then
      return
    end
  end
  
  table.insert(self.lista_flote,obj)
  
end

function liquido:eliminar(obj)
  
  local id = -1
  
  for i, data in ipairs(self.lista_flote) do
    if data == obj then
      id = i
    end
  end
  
  if id ~= -1 then
    table.remove(self.lista_flote,id)
  end
  
end

return liquido