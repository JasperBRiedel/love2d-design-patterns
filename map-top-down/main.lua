function love.load()
  local spritesheet = love.graphics.newImage("tileset.png")
  map = new_map(10, 10, spritesheet, 12, 21)
  map:set_tile(1,1,2,1)
  map:set_tile(5,4,3,1)
  map:set_tile(6,2,2,4)
  map:set_tile(2,7,2,1)

end

function love.draw()
  map:draw(0, 0, 2)

end

function love.update(dt)

end

function new_map(map_width, map_height, spritesheet, horizontal_tile_count, vertical_tile_count)
  local tile_map = {}
  tile_map.width = map_width
  tile_map.height = map_height

  tile_map.spritesheet = spritesheet
  tile_map.tile_width = spritesheet:getWidth() / horizontal_tile_count
  tile_map.tile_height = spritesheet:getHeight() / vertical_tile_count

  local spritesheet_width = spritesheet:getWidth()
  local spritesheet_height = spritesheet:getHeight()

  -- create a quad for each tile
  tile_map.tiles = {}
  for x = 1, horizontal_tile_count, 1 do
    tile_map.tiles[x] = {}
    for y = 1, vertical_tile_count, 1 do

      -- print(x * tile_map.tile_width, y * tile_map.tile_height)
      local tile_width = tile_map.tile_width
      local tile_height = tile_map.tile_height
      local tile_x = (x - 1) * tile_width
      local tile_y = (y - 1) * tile_height
      
      tile_map.tiles[x][y] = love.graphics.newQuad(tile_x, tile_y, 
        tile_width, tile_height, spritesheet_width, spritesheet_height)
    end
  end

  -- initialise map
  tile_map.map = {}
  for x = 1, map_width, 1 do
    tile_map.map[x] = {}
    for y = 1, map_height, 1 do
      tile_map.map[x][y] = {x = 1, y = 1}
    end
  end

  function tile_map:set_tile(x, y, tile_x, tile_y)
    self.map[x][y] = {x = tile_x, y = tile_y}
  end

  function tile_map:draw(x, y, scale)
    for x = 1, self.width, 1 do
      for y = 1, self.height, 1 do
        local tile = self.map[x][y]
        love.graphics.draw(self.spritesheet, self.tiles[tile.x][tile.y], 
          (x - 1) * self.tile_width * scale, (y - 1) * self.tile_height * scale, 0,
          scale, scale)
      end
    end
  end

  return tile_map
end
