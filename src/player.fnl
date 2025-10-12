(local sprites (require "sprites"))
(local (w h) (love.window.getMode))
(local bullet-speed 10)
(local reload-time 10)

(local bullets {})

(local size (* 16 4))
(local speed 2)

(global player-state {
  :x (- (/ w 2) (/ size 2))
  :y (- (/ h 2) (/ size 2))
  :next-bullet reload-time
})


(fn move []
  (let [move-x (- (if (or (love.keyboard.isDown "right") (love.keyboard.isDown "l")) 1 0)
                  (if (or (love.keyboard.isDown "left") (love.keyboard.isDown "h")) 1 0))
        move-y (- (if (or (love.keyboard.isDown "down") (love.keyboard.isDown "j")) 1 0)
                  (if (or (love.keyboard.isDown "up") (love.keyboard.isDown "k")) 1 0))]
    (set player-state.x (+ player-state.x (* speed move-x)))
    (set player-state.y (+ player-state.y (* speed move-y)))))

(fn create-bullet []
  (table.insert bullets {
    :x player-state.x
    :y player-state.y
  }))

(fn shoot []
  (set player-state.next-bullet (- player-state.next-bullet 1))
  (if (and (love.keyboard.isDown "z") (< player-state.next-bullet 0)) (do
    (set player-state.next-bullet reload-time)
    (create-bullet))))

(fn update-bullet [bullet]
  (set bullet.y (- bullet.y bullet-speed)))

(fn is-out-of-bounds [bullet]
  (< bullet (- (/ size 2))))

(fn update-bullets []
  (each [i bullet (pairs bullets)]
    (update-bullet bullet)
    (if (is-out-of-bounds bullet)
      (table.remove bullets i))
    ))

(fn draw-bullet [bullet]
  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 1 2)
    (. bullet :x)
    (. bullet :y)
    0 4))


(fn draw-bullets []
  (each [_ bullet (pairs bullets)]
    (draw-bullet bullet)))

(fn update []
  (move)
  (shoot)
  (update-bullets))

(fn draw []
  (draw-bullets)
  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 1 1)
    (. player-state :x)
    (. player-state :y)
    0 4))


{
  :update update
  :draw draw
}
