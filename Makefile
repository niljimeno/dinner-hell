default:
	mkdir -p src/scenes
	mkdir -p lua/scenes

	fennel --compile src/main.fnl > lua/main.lua
	fennel --compile src/player.fnl > lua/player.lua
	fennel --compile src/enemies.fnl > lua/enemies.lua
	fennel --compile src/scenes/game.fnl > lua/scenes/game.lua
	fennel --compile src/sprites.fnl > lua/sprites.lua

	cp -r ./assets/ ./lua/assets/

run:
	fennel --compile src/main.fnl > lua/main.lua
	fennel --compile src/player.fnl > lua/player.lua
	fennel --compile src/enemies.fnl > lua/enemies.lua
	fennel --compile src/scenes/game.fnl > lua/scenes/game.lua
	fennel --compile src/sprites.fnl > lua/sprites.lua

	love ./lua/
