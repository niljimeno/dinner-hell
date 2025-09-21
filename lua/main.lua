love.graphics.setDefaultFilter("nearest")
local player = require("player")
local sprites = require("sprites")
love.load = function()
  return sprites.load()
end
love.draw = function()
  love.graphics.draw(sprites.tileset, sprites.get(1, 1), 0, 0, 0, 4)
  return love.graphics.print("Hello World!", 400, 300)
end
return love.draw
