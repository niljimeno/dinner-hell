(local sprites (require "sprites"))
(local player (require "player"))
(local (w h) (love.window.getMode))
(local bullet-speed 10)
(local reload-time 10)

(local size (* 16 4))

(local enemies {})

(fn trigonometry [object object2]
  (let [ diffx (- object2.x object.x)
         diffy (- object2.y object.y)
         h (math.sqrt (+ (^ diffx 2) (^ diffy 2)))
         normalizer (/ h 1.6)]
    {
      :x (/ diffx normalizer)
      :y (/ diffy normalizer)
    }))

(fn create-bullet [enemy]
  (table.insert enemy.bullets {
    :x enemy.x
    :y enemy.y
    :speed (trigonometry enemy (player.position))
  }))

(fn update-bullet [bullet]
  (set bullet.y (+ bullet.y bullet.speed.y))
  (set bullet.x (+ bullet.x bullet.speed.x)))

(fn draw-bullet [bullet]
  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 6 2)
    bullet.x
    bullet.y
    0 4))


(fn spawn-enemy []
  (table.insert enemies {
    :x 0
    :y 0
    :speed 2

    :frames-until-reload 30
    :reload              30

    :bullets {}
    :create-bullet create-bullet
  }))


(fn shoot [enemy]
  (set enemy.frames-until-reload (- enemy.frames-until-reload 1))
  (if (= enemy.frames-until-reload 0) (do
    (set enemy.frames-until-reload enemy.reload)
    (enemy.create-bullet enemy))))

(fn update-enemy [enemy]
  (set enemy.x (+ enemy.x enemy.speed))
  (shoot enemy)
  (each [i bullet (pairs enemy.bullets)]
    (update-bullet bullet)))

(fn draw-enemy [enemy]
  (each [i bullet (pairs enemy.bullets)]
    (draw-bullet bullet))

  (love.graphics.draw
    (. sprites :tileset)
    ((. sprites :get) 6 1)
    enemy.x
    enemy.y
    0 4))

(fn update []
  (each [i enemy (pairs enemies)]
    (update-enemy enemy)))

(fn draw []
  (each [i enemy (pairs enemies)]
    (draw-enemy enemy)))


{
  :spawn-enemy spawn-enemy
  :update update
  :draw draw
}
