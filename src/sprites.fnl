(global tileset (love.graphics.newImage "assets/dinner-hell.png"))
(global sprites {})

(fn loadSprites []
  (for [y 1 3] (let [row {}]
    (for [x 1 3]
      (table.insert row (love.graphics.newQuad
        (* (- x 1) 16) (* (- y 1) 16) 16 16
        (tileset.getDimensions tileset))))
    (table.insert sprites row))))

(fn get [a b]
  (. (. sprites a) b))

{
  :load loadSprites
  :tileset tileset
  :sprites sprites
  :get get
}
