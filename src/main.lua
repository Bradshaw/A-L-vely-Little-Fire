

function love.load(arg)

	diplodocus = require "diplodocus"


	useful = diplodocus.useful
	gstate = require "gamestate"
	game = require "game"
	faya = require "faya"
	spark = require "spark"
	gstate.registerEvents()
	gstate.switch(game)
end