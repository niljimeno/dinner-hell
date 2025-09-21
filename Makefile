run:
	mkdir -p fnl/scenes
	mkdir -p lua/scenes
	fennel --compile fnl/main.fnl > lua/main.lua
	fennel --compile fnl/player.fnl > lua/player.lua
	fennel --compile fnl/scenes/game.fnl > lua/scenes/game.lua
	fennel --compile fnl/sprites.fnl > lua/sprites.lua
	love ./lua/
