local useful = {}
local ID = 0
useful.tau = math.pi*2

function useful.getNumID()
	ID = ID+1
	return ID
end

function useful.getStrID()
	return string.format("%06d",useful.getNumID())
end

local default_upairs_test = function(elem)
	return (type(elem)=="table") and (elem.purge) or false
end

function useful.upairs(t, test, onPurge)
	local index = 1
	local iterator
	local purged = {}
	iterator = function(t)
		if index>#t then
			if onPurge then
				for _,elem in ipairs(purged) do
					onPurge(elem)
				end
			end
			return nil
		else
			if (test or default_upairs_test)(t[index]) then
				local elem = t[index]
				table.remove(t, index)
				table.insert(purged, elem)
				return iterator(t)
			else
				index = index+1
				return index-1, t[index-1]
			end
		end
	end
	return iterator, t
end

function useful.dist2( x1, y1, x2, y2 )
	if type(x1)=="table" then
		return useful.dist2(x1.x, x1.y, y1.x, y1.y)
	end
	if x2 then
		return useful.dist2(x2-x1, y2-y1)
	else
		return (x1*x1 + y1*y1)
	end
end

function useful.sign(a)
	return a < 0 and -1 or 1
end

function useful.lerp(a, b, t)
	return b*t + a*(1-t)
end

function useful.dead(n, zone)
	local zone = zone or 0.3
	return math.abs(n)>zone and n or 0
end

function useful.xyDead(x, y, options)
	local options = options or {}
	local zone = options.zone or 0.3
	local mode = options.mode or "rescaled"
	if useful.dist2(x,y)>zone*zone then
		if mode=="simple" then
			return x, y
		else
			local d = useful.dist(x,y)
			local nx = x/d
			local ny = y/d
			if mode=="rescaled" then
				local dd = (d-zone)/(1-zone)
				return nx*dd,ny*dd
			elseif mode=="digital" then
				return nx, ny
			end
		end
	else
		return 0,0
	end
end

function useful.dist(...)
	return math.sqrt(useful.dist2(...))
end

function useful.nrandom(sigma, mu)
	local sigma = sigma or 1
	local mu = mu or 0
	local u1 = math.random()
	local u2 = math.random()
	local z0 = math.sqrt(-2*math.log(u1)) * math.cos(useful.tau * u2)
	return z0 * sigma + mu, mu
end

function useful.orandom(probability, multiplier)
	local probability = probability or 0.1
	local multiplier = multiplier or 10
	return math.random()*(math.random()<probability and multiplier or 1)
end

--[[
	Iterates a function into itself

	To achieve f(f(f(a))) do useful.iterate(f, 3, a)

	Ideally the iterated function should return as many value as it has parameters, and in a semantically identical order.
]]
function useful.iterate(fn, it, ...)
	if it>1 then
		return fn(useful.iterate(fn, it-1, ...))
	else
		return fn(...)
	end
end


--[[


]]
function useful.copy(elem)
	if type(elem)=="table" then
		local copy = {}
		for k, v in pairs(elem) do
			copy[k] = useful.copy(v)
		end
	else
		return elem
	end
end

function useful.merge(to, from, clobber)
	local insert = function(tab, key, elem)
		if type(elem)=="table" then
			if not tab[key] then
				tab[key]={}
			end
			useful.merge(tab[key], elem, clobber)
		else
			tab[key]=elem
		end
	end
	for k, v in pairs(from) do
		if to[k] then
			if clobber then
				insert(to, k, v)
			end
		else
			insert(to, k, v)
		end
	end
end

return useful