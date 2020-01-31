local Class = require "libs.hump.class"
local vector= require "libs.hump.vector"
local polybool = require "libs.polygon.polybool"

local destructive_terrain = Class{
    __includes = {}
}

function destructive_terrain:init(poligono,img)
  self.mesh = self:poly2mesh(poligono)
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

function destructive_terrain:hacer_hueco(index,poligono_destruir,cx,cy)

  
  
  local index_buscar=self:buscar(index)
  
  if index_buscar ==-1 then
    return
  end
  table.insert(self.entidad.gameobject.holes,{x=cx,y=cy})
  
  local poligono_generado = polybool(self.poligonos_tabla[index_buscar].poligono, poligono_destruir, "not")
  
  
  local t = self.poligonos_tabla[index_buscar]
  t.body:destroy()
  table.remove(self.poligonos_tabla,index_buscar)
  
  
  if #poligono_generado<4 then
    
    
    --print(Inspect(poligono_generado))
    
    for i=1, #poligono_generado ,1 do
      
      
      
      local poligono_validado = self:validar_poligono_box2d(poligono_generado[i])
      
      
      
      if #poligono_validado>=6 and #poligono_validado%2==0 then
        self:crear_poligonos_fisica(poligono_validado)
      end
      
    end
    
  end
  
  
  
  
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

function destructive_terrain:crear_poligonos_fisica(poligono)
  
  local t = {}
  
  --print(Inspect(poligono))
  t.body = love.physics.newBody(self.entidad.world,0,0,"kinematic")
  t.shape = love.physics.newChainShape(true,poligono)
  t.fixture = love.physics.newFixture(t.body,t.shape)
  
  t.poligono = poligono
  t.id_poligono = self.poligono_main_index
  
   
  t.fixture:setUserData( {data="map_object",obj=self, pos=5, id_poligono =  self.poligono_main_index} )
  
  table.insert(self.poligonos_tabla,t)
  
  self.poligono_main_index=self.poligono_main_index + 1

end


function destructive_terrain:get_area_poligono(poligono)
  local area = 0

  local x1=poligono[1]
  local y1=poligono[2]
    
  for i=3,#poligono,2 do

      x2,y2 = poligono[i],poligono[i+1]

      local d1 = math.pow(x2-x1,2)
      local d2 = math.pow(y2-y1,2)
      local distance = math.sqrt(d1+d2)
      area = area+distance
  end

  return area
end

function destructive_terrain:poligono_floor(poligono_decimal)
  local poligono = poligono_decimal
  for i=1,#poligono,1 do
    poligono[i] = math.floor(poligono[i])
  end

  return poligono
end


function destructive_terrain:validar_poligono_box2d(poligono)
  local poligono_final=self:poligono_floor(poligono)
  local lista_negra={}

  repeat 
    lista_negra = self:iterador_validador(poligono_final)
    poligono_final = self:descartar_puntos_muertos(poligono_final,lista_negra)
    poligono_final = self:validar_primeros(poligono_final)
    lista_negra = self:iterador_validador(poligono_final)
  until #lista_negra==0

  return poligono_final

end

function destructive_terrain:iterador_validador(poligono)
  local lista={}

  for i=3,#poligono,2 do
    local v1 =  vector.new(poligono[i-2],poligono[i-1])
    local v2 =  vector.new(poligono[i],poligono[i+1])

    local validar = self:distance_squared(v1, v2) 


    if validar > 0.01 then

    else

      table.insert(lista,i)
      table.insert(lista,i+1)
    end
  
  end

  return lista
end

function destructive_terrain:descartar_puntos_muertos(poligono,lista)
  local poligono_final=poligono

  for i=#lista,1,-1 do
    table.remove(poligono_final,lista[i])
  end


  return poligono_final


end

function destructive_terrain:validar_primeros(poligono)
  local mipoligono = poligono

  local v1 =  vector.new(mipoligono[1],mipoligono[2])
  local v2 =  vector.new(mipoligono[#mipoligono-1],mipoligono[#mipoligono])

  local validar = self:distance_squared(v1, v2) 

  if validar > 0.01 then

  else
    table.remove(mipoligono,2)
    table.remove(mipoligono,1)
    
  end 

  return mipoligono

end


function destructive_terrain:distance_squared(a,b)
  local c = a-b
  return self:dot(c,c)
end

function destructive_terrain:dot(a,b)
  return a.x * b.x + a.y * b.y
end

function destructive_terrain:buscar(index)
  for i,e in ipairs(self.poligonos_tabla) do
    if e.id_poligono == index then
      return i
    end
  end

  return -1
end




return destructive_terrain