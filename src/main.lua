math.randomseed(os.time())
for _=1,1000 do
	math.random()
end

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