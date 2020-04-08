local pausa = Gamestate.new()

function pausa:enter(from)
  self.from = from 
end

function pausa:draw()
  self.from:draw()
  local w, h = self.from.screenX,self.from.screenY
  
  love.graphics.setColor(0,0,0,0.5)
  love.graphics.rectangle('fill', 0,0, w,h)
  love.graphics.setColor(1,1,1)
  love.graphics.printf('Pausa', 0, h/2, w, 'center')
end

function pausa:keypressed(key)
  if key == 'p' then
    return Gamestate.push(self.from) 
  end
end

return pausa