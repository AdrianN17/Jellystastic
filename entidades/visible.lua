local visible = Class{}

function visible:init()

  if not self.fixture then
    self.visibleAABB = {}

    self.visibleAABB.x,self.visibleAABB.y,self.visibleAABB.w,self.visibleAABB.h = self:calculateAABB(self.shapeTableClear)
  end
end

function visible:getBoundingBox()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = 0,0,0,0
  
  if self.fixture then
    topLeftX, topLeftY, bottomRightX, bottomRightY = self.fixture:getBoundingBox( 1 )
  else
    topLeftX, topLeftY, bottomRightX, bottomRightY = self.visibleAABB.x,self.visibleAABB.y,self.visibleAABB.w,self.visibleAABB.h
  end

  return topLeftX, topLeftY, bottomRightX, bottomRightY
end

function visible:checkVisible(x,y,w,h)
  local topLeftX, topLeftY, bottomRightX, bottomRightY = self:getBoundingBox()

  return CheckCollision(x,y,w,h, topLeftX, topLeftY, bottomRightX, bottomRightY)

end

function visible:calculateAABB(shapeTableClear)

  local minX, maxX, minY, maxY = 99999,-99999,99999,-99999

  for i=1,#shapeTableClear,2 do
    local x,y = shapeTableClear[i], shapeTableClear[i+1]
    minX = math.min(minX, x)
    maxX = math.max(maxX, x)
    minY = math.min(minY, y)
    maxY = math.max(maxY, y)
  end



  return minX+self.ox,minY+self.oy, maxX+self.ox,maxY+self.oy

end

--[[function visible:draw_debug()
  local topLeftX, topLeftY, bottomRightX, bottomRightY = self:getBoundingBox()

  love.graphics.circle("fill",topLeftX, topLeftY,10)
  love.graphics.circle("fill",bottomRightX, bottomRightY,10)
  love.graphics.circle("fill",self.ox,self.oy,10)

  print(topLeftX, topLeftY, bottomRightX, bottomRightY,self.ox,self.oy)
end]]





return visible