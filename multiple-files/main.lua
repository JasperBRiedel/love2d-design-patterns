local rectangle = require("library_table") -- import a table into this file
local circle_draw = require("function") -- import a function into this file
require("code") -- import whole file into global table

function love.draw()
  rectangle.draw()
  circle_draw()
  line_draw()
end
