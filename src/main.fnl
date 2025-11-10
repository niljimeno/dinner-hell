(love.graphics.setDefaultFilter "nearest")

(local player (require "player"))
(local sprites (require "sprites"))
(local enemies (require "enemies"))

(fn love.load []
  (sprites.load)
  (enemies.spawn-enemy))

(fn love.update []
  (player.update)
  (enemies.update))

(fn love.draw []
  (player.draw)
  (enemies.draw))
