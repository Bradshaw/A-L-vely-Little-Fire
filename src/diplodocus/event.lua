local event_mt = {}
local event = {}

function event.new()
	local self = setmetatable({},{__index=event_mt})

	self.events = {}

	return self
end

function event_mt:on(message, cb, id)
	if not self.events[message] then
		self.events[message] = {}
	end
	table.insert(self.events[message], {cb=cb, id=id})
end

function event_mt:off(id)
	for k,v in pairs(self.events) do
		
	end
end

function event_mt:emit(message, ...)
	if self.events[message] then
		for i,v in ipairs(self.events[message]) do
			v(...)
		end
	end
end

return event