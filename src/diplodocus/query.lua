local query = {}
local query_mt = {}


function query.new(t)
	local self = setmetatable({},{__index=query_mt})
	local index = 1
	local t = t
	self.it = function()
		index = index+1
		return t[index]
	end
	return self
end

