function love.load()
  local animated_guy_spritesheet = love.graphics.newImage("player-spritesheet.png")
  animated_guy = new_animation(animated_guy_spritesheet, 6)
end

function love.draw()
  animated_guy:draw(0, 0, 0, 5, 5)
end

function love.update(dt)
  animated_guy:update(0.2, dt)
end

function new_animation(spritesheet, frame_count)
  local animation = {}

  animation.spritesheet = spritesheet
  animation.sprite_width = spritesheet:getWidth() / frame_count
  animation.sprite_height = spritesheet:getHeight() 

  animation.frame_count = frame_count
  animation.current_frame = 1
  animation.accumulator = 0

  local spritesheet_width = spritesheet:getWidth()
  local spritesheet_height = spritesheet:getHeight()

  animation.frames = {}
  for frame_index = 1, frame_count, 1 do
    animation.frames[frame_index] = love.graphics.newQuad(
      (frame_index - 1) * animation.sprite_width, 0,
      animation.sprite_width, animation.sprite_height,
      spritesheet_width, spritesheet_height
    )
  end

  function animation:draw(x, y, r, sx, sy)
    love.graphics.draw(self.spritesheet, self.frames[self.current_frame],
      x, y, r, sx, sy)
  end

  function animation:update(speed, dt)
    self.accumulator = self.accumulator + dt

    if self.accumulator > speed then
      self.accumulator = self.accumulator - speed

      if self.current_frame < self.frame_count then
        self.current_frame = self.current_frame + 1
      else
        self.current_frame = 1
      end
    end
  end

  return animation
end
