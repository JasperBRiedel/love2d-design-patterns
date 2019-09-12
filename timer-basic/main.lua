function love.load()
  timer_accumulator = 0
  timer_interval = 5

  counter_value = 0
end

function love.update(delta_time) 

  timer_accumulator = timer_accumulator + delta_time
  if timer_accumulator >= timer_interval then
    timer_accumulator = timer_accumulator - timer_interval
    timer_action()
  end

end

function timer_action()
  counter_value = counter_value + 1
end

function love.draw() 
  love.graphics.print("timer_accumulator: " .. timer_accumulator, 0, 0)
  love.graphics.print("timer_interval: " .. timer_interval, 0, 16)
  love.graphics.print("counter: " .. counter_value, 0, 32)
end
