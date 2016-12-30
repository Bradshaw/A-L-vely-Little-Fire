local vector = {}
local v2methods = {}
--local v3methods = {}
local vector2_mt = {__index = v2methods}
--local vector3_mt = {__index = v3methods}

function vector.two(x, y)
	local self = setmetatable({},vector2_mt)
	self.x = x or 0
	self.y = y or 0
	return self
end

v2methods.vector2 = "true"

function v2methods:clone()
	return vector.two(self.x, self.y)
end

function v2methods:magnitude()
	return math.sqrt(self.x*self.x+self.y*self.y)
end

function v2methods:normalise()
	local mag = self:magnitude()
	self.x = self.x/mag
	self.y = self.y/mag
	return self
end

math.oldabs = math.abs
function math.abs(v)
	if type(v) == "table" and v.vector2 then
		return v:magnitude()
	else
		return math.oldabs(v)
	end
end

function vector2_mt:__add(other)
	if type(other) == "table" and other.vector2 then
		return vector.two(self.x + other.x, self.y + other.y)
	else
		return vector.two(self.x + other, self.y + other)
	end
end

function vector2_mt:__mul(other)
	if type(other) == "table" and other.vector2 then
		return vector.two(self.x * other.x, self.y * other.y)
	else
		return vector.two(self.x * other, self.y * other)
	end
end

function vector2_mt:__sub(other)
	if type(other) == "table" and other.vector2 then
		return vector.two(self.x - other.x, self.y - other.y)
	else
		return vector.two(self.x - other, self.y - other)
	end
end

function vector2_mt:__tostring()
	return "(x: "..self.x..", y: "..self.y..")"
end

return vector