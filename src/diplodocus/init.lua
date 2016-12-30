local current_folder = (...):gsub('%.init$', '')
local diplodocus = {}
diplodocus.useful = require(current_folder.."/useful")
diplodocus.thing = require(current_folder.."/thing")
diplodocus.query = require(current_folder.."/query")
diplodocus.vector = require(current_folder.."/vector")
diplodocus.event = require(current_folder.."/event")
diplodocus.shade = require(current_folder.."/shade")



math.tau = math.pi*2







return diplodocus