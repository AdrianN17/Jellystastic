local Class = require "libs.hump.class"
local vector= require "libs.hump.vector"
local polybool = require "libs.polygon.polybool"

local destructive = Class{}

function destructive:init()
  
end

function destructive:hacer_hueco(index,poligono_destruir,cx,cy)


  pcall( function()
    local index_buscar=self:buscar(index)
    
    if index_buscar ==-1 then
      return
    end
    
    local poligono_generado = polybool(self.poligonos_tabla[index_buscar].poligono, poligono_destruir, "not")
    
    
    if type(poligono_generado[1]) == "number" then
      
      local t = self.poligonos_tabla[index_buscar]
    
      table.insert(self.entidad.gameobject.holes,{x=cx,y=cy})
    
      if(#poligono_generado<46) then
        t.body:destroy()
        table.remove(self.poligonos_tabla,index_buscar)
      end
      
    else
      table.insert(self.entidad.gameobject.holes,{x=cx,y=cy})
    
      local t = self.poligonos_tabla[index_buscar]
      
      t.body:destroy()

      table.remove(self.poligonos_tabla,index_buscar)
      
    
      for i=1, #poligono_generado ,1 do

        local poligono_validado = self:validar_poligono_box2d(poligono_generado[i])

        if #poligono_validado>=6 and #poligono_validado%2==0 then
          self:crear_poligonos_fisica(poligono_validado)
        end
      end
    end

  end)
end


function destructive:crear_poligonos_fisica(poligono)
  
  local t = {}

  t.body = love.physics.newBody(self.entidad.world,0,0,"kinematic")
  t.shape = love.physics.newChainShape(true,poligono)
  t.fixture = love.physics.newFixture(t.body,t.shape)
  
  t.poligono = poligono
  t.id_poligono = self.poligono_main_index
  
   
  t.fixture:setUserData( {data="map_object",obj=self, pos=orden.destructive_terrain, id_poligono =  self.poligono_main_index} )
  
  table.insert(self.poligonos_tabla,t)
  
  self.poligono_main_index=self.poligono_main_index + 1

end


function destructive:get_area_poligono(poligono)
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

function destructive:poligono_floor(poligono_decimal)
  local poligono = poligono_decimal
  for i=1,#poligono,1 do
    poligono[i] = math.floor(poligono[i])
  end

  return poligono
end


function destructive:validar_poligono_box2d(poligono)
  
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

function destructive:iterador_validador(poligono)
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

function destructive:descartar_puntos_muertos(poligono,lista)
  local poligono_final=poligono

  for i=#lista,1,-1 do
    table.remove(poligono_final,lista[i])
  end


  return poligono_final


end

function destructive:validar_primeros(poligono)
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


function destructive:distance_squared(a,b)
  local c = a-b
  return self:dot(c,c)
end

function destructive:dot(a,b)
  return a.x * b.x + a.y * b.y
end

function destructive:cross(x_a,y_a,x_b,y_b)
  return x_a * y_b - y_a * x_b
end

function destructive:buscar(index)
  for i,e in ipairs(self.poligonos_tabla) do
    if e.id_poligono == index then
      return i
    end
  end

  return -1
end

function destructive:area(poligono)
  local area = 0
  for i = 1,#poligono, 2 do
    if poligono[i+2] and poligono[i+3] then
      area = area + self:cross(poligono[i],poligono[i+1],poligono[i+2],poligono[i+3])
    end
  end
  
  return math.abs(area)/2
end


return destructive