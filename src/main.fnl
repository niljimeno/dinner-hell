(love.graphics.setDefaultFilter "nearest")

(local player (require "player"))
(local sprites (require "sprites"))

(fn love.load []
  (sprites.load))

(fn love.update []
  (player.update))

(fn love.draw []
  (player.draw))
