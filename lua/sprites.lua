tileset = love.graphics.newImage("assets/dinner-hell.png")
sprites = {}
local function loadSprites()
  for y = 1, 3 do
    local row = {}
    for x = 1, 3 do
      table.insert(row, love.graphics.newQuad(((x - 1) * 16), ((y - 1) * 16), 16, 16, tileset.getDimensions(tileset)))
    end
    table.insert(sprites, row)
  end
  return nil
end
local function get(a, b)
  return sprites[a][b]
end
return {load = loadSprites(), tileset = tileset, sprites = sprites, get = get}
