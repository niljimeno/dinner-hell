(love.graphics.setDefaultFilter "nearest")

(local player (require "player"))
(local sprites (require "sprites"))

(fn love.load []
  (. sprites :load))

(fn love.draw []
  (love.graphics.draw (. sprites :tileset) ((. sprites :get) 1 1) 0 0 0 4)
  (love.graphics.print "Hello World!" 400 300))
