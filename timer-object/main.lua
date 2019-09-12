function love.load()
  counter_1 = 0
  counter_2 = 0

  timer_1 = new_timer(1, function() 
    counter_1 = counter_1 + 1
  end)

  timer_2 = new_timer(5, function()
    counter_2 = counter_2 + 1
  end)
end

function love.update(delta_time) 
  timer_1:service(delta_time)
  timer_2:service(delta_time)
end

function love.draw() 
  love.graphics.print("timer_accumulator: " .. timer_1.accumulator, 0, 0)
  love.graphics.print("timer_interval: " .. timer_1.interval, 0, 16)
  love.graphics.print("counter_1: " .. counter_1, 0, 32)

  love.graphics.print("timer_accumulator: " .. timer_2.accumulator, 400, 0)
  love.graphics.print("timer_interval: " .. timer_2.interval, 400, 16)
  love.graphics.print("counter_2: " .. counter_2, 400, 32)
end

function new_timer(interval, action)
  timer_object = {
    accumulator = 0,
    interval = interval,
    action = action
  }

  function timer_object:service(delta_time)
    self.accumulator = self.accumulator + delta_time
    if self.accumulator >= self.interval then
      self.accumulator = self.accumulator - self.interval
      self.action()
    end
  end

  return timer_object
end
