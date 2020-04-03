local utils = Class{}

function utils:init()

end

function utils:create_objects(entidades)

  local lon = #self.map.layers

  for index = 1,lon,1 do
    
    local layer = self.map.layers[index]
    
    local layerProperties = layer.properties
    
    for _,object in pairs(layer.objects) do
      local clase = object.properties.clase

      if entidades[clase] then

        local shapeData = object[object.shape]
        
        for nombreParametro,valor in pairs(layerProperties) do
          object.properties[nombreParametro] = valor
        end
        
        local shapeTableClear,ox,oy = math.clearPolygonCenter(shapeData)
        local properties = object.properties
        local radio = math.rad(object.rotation)
        
        
        if properties.tipoCalculoDimensiones then
          local tipoDimension = properties.tipoCalculoDimensiones
          if tipoDimension == "linea" then
            object.width,object.height = properties.width or math.abs(shapeTableClear[1]-shapeTableClear[3]),properties.height or math.abs(shapeTableClear[2]-shapeTableClear[4])
          else
            object.width,object.height = math.calcularDimensiones(tipoDimension,shapeTableClear)
          end
        end

        if object.type == "none" then
          entidades[clase](self,ox,oy,radio,shapeTableClear,properties,object.width,object.height)
        else
          local body = love.physics.newBody(self.world,ox,oy,object.type)
          local shape = nil
          
          if object.shape == "rectangle" or object.shape == "polygon" then
            shape = love.physics.newPolygonShape(shapeTableClear)
          elseif object.shape == "ellipse" then
            shape = love.physics.newChainShape(true,shapeTableClear)
          elseif object.shape == "polyline" then
            shape = love.physics.newEdgeShape(shapeTableClear[1],shapeTableClear[2],shapeTableClear[3],shapeTableClear[4])
          end

          local fixture = love.physics.newFixture(body,shape)
          
          if properties.sensor then
            fixture:setSensor(true)
          end
          
          local obj = entidades[clase](self,body,shape,fixture,ox,oy,radio,shapeTableClear,properties,object.width,object.height)
          
          if properties.userdataNombre then
            self:addproperties(obj,properties)
            fixture:setUserData({obj = obj, nombre = properties.userdataNombre})
          end
          
        end
      end
    end

    self:crearNuevoLayer(index,layerProperties.tabla)
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

function utils:crearNuevoLayer(index,tabla)
  
  self.map:removeLayer(index)
  local newLayer = self.map:addCustomLayer (tabla,index )
  
  newLayer.draw = function(obj)
    self:drawGameobjects(tabla)
  end
  
  newLayer.update = function(obj,dt)
    self:updateGameobjects(tabla, dt)
  end
end

function utils:updateGameobjects(nombre,dt)
  
  if self.gameobject[nombre] ~= nil then
    for _, obj_data in ipairs(self.gameobject[nombre]) do
      if obj_data.update then
        obj_data:update(dt)
      end
    end
  end

end

function utils:drawGameobjects(nombre)
  
  if self.gameobject[nombre] ~= nil then
    for _, obj_data in ipairs(self.gameobject[nombre]) do
      if obj_data.draw then
        obj_data:draw()
      end
    end
  end
  
end

function utils:drawBox2d()
  for _, body in pairs(self.world:getBodies()) do
    for _, fixture in pairs(body:getFixtures()) do
        local shape = fixture:getShape()
 
        if shape:typeOf("CircleShape") then
            local cx, cy = body:getWorldPoints(shape:getPoint())
            love.graphics.circle("line", cx, cy, shape:getRadius())
        elseif shape:typeOf("PolygonShape") then
            love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
        else
            love.graphics.line(body:getWorldPoints(shape:getPoints()))
        end
    end
  end
end

function utils:getUserData(contact,nombre)
  local a,b = contact:getFixtures()
  local u1 = a:getUserData()
  local u2 = b:getUserData()
  
  if u1 and u1.nombre == nombre then
    return u1
  elseif u2 and u2.nombre == nombre then
    return u2
  end
  
  return nil
end

function utils:getUserDataValue(contact,value)
  local a,b = contact:getFixtures()
  local u1 = a:getUserData()
  local u2 = b:getUserData()

  if u1 and u1.obj and u1.obj[value] then
    return u1
  elseif u2 and u2.obj and u2.obj[value] then
    return u2
  end
  
  return nil
end

function utils:addproperties(obj,properties)
  for str,k in pairs(properties) do
    if string.match(str, "Es_") then
      obj[str] = k
    end
  end
end

function utils:setCallbacks()
  
  local beginContact =  function(a, b, coll)
    local u1 = a:getUserData()
    local u2 = b:getUserData()
    
    if u1 and u1.obj and u2 and u2.obj then
      if u1.obj.beginContact then
        u1.obj:beginContact(u2.nombre,u2.obj,coll)
      end
      if u2.obj.beginContact then
        u2.obj:beginContact(u1.nombre,u1.obj,coll)
      end
    end
  end
  
  local endContact =  function(a, b, coll)
    local u1 = a:getUserData()
    local u2 = b:getUserData()
    
    if u1 and u1.obj and u2 and u2.obj then
      if u1.obj.endContact then
        u1.obj:endContact(u2.nombre,u2.obj,coll)
      end
      if u2.obj.endContact then
        u2.obj:endContact(u1.nombre,u1.obj,coll)
      end
    end
  end
  
  local preSolve =  function(a, b, coll)
    local u1 = a:getUserData()
    local u2 = b:getUserData()

    if u1 and u1.obj and u2 and u2.obj then
      if u1.obj.preSolve then
        u1.obj:preSolve(u2.nombre,u2.obj,coll)
      end
      if u2.obj.preSolve then
        u2.obj:preSolve(u1.nombre,u1.obj,coll)
      end
    end
  end
  
  local postSolve =  function(a, b, coll, normalimpulse, tangentimpulse)
    local u1 = a:getUserData()
    local u2 = b:getUserData()
    
     if u1 and u1.obj and u2 and u2.obj then
      if u1.obj.postSolve then
        u1.obj:postSolve(u2.nombre,u2.obj,coll)
      end
      if u2.obj.postSolve then
        u2.obj:postSolve(u1.nombre,u1.obj,coll)
      end
    end
  end
  
  self.world:setCallbacks(beginContact,endContact,preSolve,postSolve)
end

function utils:dano(obj,dano)
  obj.hp = obj.hp - dano
end


return utils