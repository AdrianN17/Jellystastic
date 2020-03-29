local Utils = require "gamestates.utils"

local mundoGenerico = Class{
  __includes = {Utils}
}

xg,yg = 0,0

function mundoGenerico:init(mapa)

  Utils.init(self)

  self.gameobject = {}
  
  self.map = Sti(mapa)
  
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0,9.81*64, false)

  
  self.scaleDPI = 1
  self.scale = 1/self.scaleDPI
  
  local x,y=love.graphics.getDimensions( )
  
  self.map:resize(x/self.scale,y/self.scale)
  
  self.cam = Camera.new(0, 0, self.scale, 0,0,0,x,y,0.5,0.5)
  
  
  self:create_objects(Entities_index)
  
  love.graphics.setLineWidth( 2 )
  
end

function mundoGenerico:enter()
  
end

function mundoGenerico:update(dt)
  self.world:update(dt)
  self.map:update(dt)
  
 
end

function mundoGenerico:draw()
  
  local cx,cy,cw,ch=self.cam:getViewport()

  for _,objData in pairs(self.gameobject.objetosMapa) do
    objData:draw()
  end
  
  --self.cam:attach()

  --self.map:draw(-cx,-cy,self.scale,self.scale)
  
  --[[for _, object in ipairs(self.map.layers[1].objects) do

    if object.rectangle then
      local t = {}
      local ox,oy=0,0
      for i=1,#object.rectangle,1 do
        table.insert(t,object.rectangle[i].x)
        table.insert(t,object.rectangle[i].y)
        
        ox = ox +object.rectangle[i].x
        oy = oy + object.rectangle[i].y
        
      end
      
      ox , oy = ox/#object.rectangle, oy/#object.rectangle
      
      
      
      love.graphics.polygon("line",t)
      love.graphics.circle("fill",ox,oy,5)
    end
  end]]
  

  
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
  
  
  --self.cam:detach()
end

function mundoGenerico:keypressed(key)

end

function mundoGenerico:keyreleased(key)
  
end

function mundoGenerico:mousepressed(x,y,button)
  
end

function mundoGenerico:mousereleased(x,y,button)
  
end

return mundoGenerico