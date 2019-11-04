function lerp(a,b,t) 
  return a+(b-a)*t 
end

function love.load()
  current_x = 0
  current_y = 0
end

function love.update(dt)
  target_x, target_y = love.mouse.getPosition()

  current_x = lerp(current_x, target_x, dt)
  current_y = lerp(current_y, target_y, dt)
end

function love.draw()
  love.graphics.rectangle("fill", current_x - 50, current_y - 50, 100, 100)
end


