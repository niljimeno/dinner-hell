(local sprites (require "sprites"))
(local (w h) (love.window.getMode))

(local bullets {})

(local size (* 16 4))
(local speed 2)

(global player_state {
  :x (- (/ w 2) (/ size 2))
  :y (- (/ h 2) (/ size 2))
})


(fn move []
  (let [move-x (- (if (or (love.keyboard.isDown "right") (love.keyboard.isDown "l")) 1 0)
                  (if (or (love.keyboard.isDown "left") (love.keyboard.isDown "h")) 1 0))
        move-y (- (if (or (love.keyboard.isDown "down") (love.keyboard.isDown "j")) 1 0)
                  (if (or (love.keyboard.isDown "up") (love.keyboard.isDown "k")) 1 0))]
    (set player_state.x (+ player_state.x (* speed move-x)))
    (set player_state.y (+ player_state.y (* speed move-y)))))

(fn create_bullet []
  (table.insert bullets {
    :x player_state.x
    :y player_state.y
  }))

(fn shoot []
  (if (and (love.keyboard.isDown "z") 1)
    (create_bullet)))

(fn update_bullet [bullet]
  (set bullet.y (- bullet.y 4)))

(fn is_out_of_bounds [object]
  (< object.y (- (/ size 2))))

(fn update_bullets []
  (each [i bullet (pairs bullets)]
    (update_bullet bullet)
    (if (is_out_of_bounds bullet)
      (table.remove bullets i))
    ))

(fn draw_bullet [bullet]
  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 1 2)
    (. bullet :x)
    (. bullet :y)
    0 4))


(fn draw_bullets []
  (each [_ bullet (pairs bullets)]
    (draw_bullet bullet)))

(fn update []
  (move)
  (shoot)
  (update_bullets))

(fn draw []
  (draw_bullets)
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
