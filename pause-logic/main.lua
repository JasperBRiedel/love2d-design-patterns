function love.load()
  paused = false
  game_time = 0

  pause_text = "The game is paused, press [SPACE] to resume"
  pause_font = love.graphics.newFont(24)
  pause_width = pause_font:getWidth(pause_text)
  pause_height = pause_font:getHeight()
end

function pause_update(dt)

end

function game_update(dt)
  game_time = game_time + dt
end

function love.update(dt)
  if paused then
    pause_update(dt)
  else
    game_update(dt)
  end
end

function love.draw()
  love.graphics.print("press [SPACE] to pause"
    .. ", paused = " .. tostring(paused) .. ", game_time = " .. game_time)

  center_x = love.graphics.getWidth() / 2
  center_y = love.graphics.getHeight() / 2

  x = (math.cos(game_time * 5) * 100) + center_x
  y = (math.sin(game_time * 5) * 100) + center_y

  love.graphics.circle("fill", x, y, 100)

  if paused then
    default_font = love.graphics.getFont()
    love.graphics.setFont(pause_font)

    love.graphics.setColor(0.0, 0.0, 1.0)
    love.graphics.print(pause_text, center_x - pause_width / 2, center_y - pause_height / 2)
    love.graphics.setColor(1.0, 1.0, 1.0)

    love.graphics.setFont(default_font);
  end
end

function love.keypressed(key)
  if key == "space" then
    paused = not paused;
  end
end
