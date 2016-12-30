math.randomseed(os.time())
for _=1,1000 do
	math.random()
end

glitchy = math.random()>0.95
function reroll()
	slowmo = math.random()>(glitchy and 0.75 or 0.95)
	pink = math.random()>(glitchy and 0.75 or 0.95)
	edgelord = math.random()>(glitchy and 0.75 or 0.95)
end
reroll()
pinkness = pink and 1 or 0
function psides()
	csides = math.random(2,4)*2
end
psides()
local kirk = love.graphics.circle
love.graphics.circle = function(style, x, y, r, segs, ...)
	if edgelord then
		kirk(style, x, y, r, segs or csides, ...)
	else
		kirk(style, x, y, r, segs, ...)
	end
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