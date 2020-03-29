local utils = Class{}

function utils:init()
  self.multiple = {}
end

function utils:create_objects(entidades)
  
  for _, layer in pairs(self.map.layers) do
    
    for _,object in pairs(layer.objects) do
      local clase = object.properties.clase

      if entidades[clase] then
        
        local shapeData = object[object.shape]
        
        local shapeTableClear,ox,oy = math.clearPolygonCenter(shapeData)
        local properties = object.properties
        local radio = math.rad(object.rotation)
        
        if properties.tipoCalculoDimensiones then
          object.width,object.height = math.calcularDimensiones(properties.tipoCalculoDimensiones,shapeTableClear)
        end

        if object.type == "none" then
          entidades[clase](self,ox,oy,radio,shapeTableClear,properties,object.width,object.height)
        else
          local body = love.physics.newBody(self.world,ox,oy,object.type)
          local shape = nil
          
          if object.shape == "rectangle" or object.shape == "polygon" or object.shape == "ellipse" then
            shape = love.physics.newPolygonShape(shapeTableClear)
          elseif object.shape == "polyline" then
            shape = love.physics.newEdgeShape(shapeTableClear:unpack())
          end

          local fixture = love.physics.newFixture(body,shape)
          
          if properties.sensor then
            fixture:setSensor(true)
          end
          
          entidades[clase](self,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,object.width,object.height)
      
        end
      end
    end
  end
end

function utils:add(name,tabla)
  if self.gameobject[name] then
    table.insert(self.gameobject[name],tabla)
  else 
    self.gameobject[name] = {}
    self:add(name,tabla)
  end
end

function utils:remove(name,tabla)
  for i=#self.gameobject[name],1,-1 do
    local obj = self.gameobject[name][i]
    if obj == tabla then
      table.remove(self.gameobject[name],i)
      return
    end
  end
end




return utils