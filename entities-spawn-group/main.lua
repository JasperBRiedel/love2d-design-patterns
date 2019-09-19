function love.load()
  entities = {}
end

function love.mousepressed(x, y, button)
  create_entity_wave(x, y)
end

function love.update(dt)
  for index, entity in ipairs(entities) do
    if entity.update ~= nil then
      entity:update(dt)
    end

    if not entity.alive then
      table.remove(entities, index)
    end
  end
end

function love.draw()
  for index, entity in ipairs(entities) do
    if entity.draw ~= nil then
      entity:draw()
    end
  end

  love.graphics.setColor(1.0, 1.0, 1.0)
  love.graphics.print("click the screen to spawn a wave of entities - " ..
    "entities die if they leave the screen - " ..
    #entities .. " alive entitie(s)")
end

function create_entity_wave(x, y) 
  create_entity(x - 40, y - 40, 200, 2)
  create_entity(x - 40, y + 40, 200, 2)
  create_entity(x + 40, y - 40, 200, 2)
  create_entity(x + 40, y + 40, 200, 2)
end

function create_entity(x, y, speed, turn_frequency)
  local entity = {
    x = x,
    y = y,
    alive = true,
    width = 40,
    height = 40,
    speed = speed,
    direction = 0,
    turn_timer = 0,
    turn_frequency = turn_frequency,
  }

  function entity:draw()
    love.graphics.setColor(1.0, 0.0, 0.0)
    love.graphics.rectangle("fill", 
      self.x - self.width / 2, self.y - self.height / 2, 
      self.width, self.height
      )

    love.graphics.setColor(0.0, 1.0, 0.0)
    love.graphics.line(self.x, self.y, 
      self.x + math.cos(self.direction) * 20, 
      self.y + math.sin(self.direction) * 20)

  end

  function entity:update(dt)
    self.turn_timer = self.turn_timer + dt

    self.x = self.x + math.cos(self.direction) * self.speed * dt
    self.y = self.y + math.sin(self.direction) * self.speed * dt

    if self.turn_timer >= self.turn_frequency then
      self.turn_timer = self.turn_timer - self.turn_frequency
      self.direction = (math.pi / 8) * math.random(16) 
    end

    if self.x < 0 or self.x > love.graphics.getWidth() then
      self.alive = false
    end

    if self.y < 0 or self.y > love.graphics.getHeight() then
      self.alive = false
    end
  end

  table.insert(entities, entity)
end
