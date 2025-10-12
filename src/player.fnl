(local sprites (require "sprites"))
(local (w h) (love.window.getMode))
(global player_state {:x 10 :y 10})

(fn move []
  (let [move-x (- (if (love.keyboard.isDown "right") 1 0)
                  (if (love.keyboard.isDown "left") 1 0))
        move-y (- (if (love.keyboard.isDown "down") 1 0)
                  (if (love.keyboard.isDown "up") 1 0))]
    (set player_state.x (+ player_state.x move-x))
    (set player_state.y (+ player_state.y move-y))))

(fn update []
  (move))

(fn draw []
  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 1 1)
    (. player_state :x)
    (. player_state :y)
    0 4))

{
  :update update
  :draw draw
}
