local faya = diplodocus.thing()
local generators = {}

function faya.compare(a, b)
	if a.fore == b.fore then
		if a.g==b.g then
			return a.y<b.y
		else
			return a.g<b.g
		end
	else
		return b.fore
	end
end

function faya:purge()
	return false
end

local pTest = function(self)
	if (self.age>5 and self.dy>20) then
		return true
	end
	if (not self.fore) and self.r<10 then
		return true
	end
	return self.y<-800 or self.radius<=0
end

function faya:onPurge()
	faya.new({generator = self.options.generator})
	faya.sort()
end

function faya.mt:init()
	self.age = 0
	useful.merge(self, generators[self.options.generator](), true)
end

function faya.mt:update(dt)
	if (pTest(self)) then
		self:init()
	end
	self.age = self.age + dt
	self.dy = self.dy-self.rise*dt
	local dx = self.x-self.ax
	local dy = self.y-self.ay
	local d = math.sqrt(dx*dx+dy*dy)
	if d < self.ar+self.radius then
		local nx = dx
		local ny = dy
		self.dx = self.dx + nx*self.push*dt*2
		if math.abs(self.dx)<150 then
			self.dx = self.dx+useful.sign(self.dx)*10*dt
		end
		self.dy = self.dy + ny*self.push*dt
	end

	local disp = self.x-self.ax
	self.dx = self.dx-self.dx*self.fric*dt-disp*self.pull*dt

	if self.dy<50 then
		self.radius = math.min(self.maxradius,math.max(0,self.radius + self.grow * dt))
	end
	--self.r = self.r-self.r*self.fade*dt
	self.g = self.g-self.g*self.fade*dt
	self.b = self.b-self.b*self.fade*dt
	self.x = self.x+self.dx*dt
	self.y = self.y+self.dy*dt
end

function faya.mt:draw(fore, seg)
	local p = (pink and (not fore) and pinkness or 0)
	local r = self.fore and (seg==0 and col.r or 0) or self.r
	local g = self.fore and (seg==0 and col.g or 0) or useful.lerp(self.g,self.b,p)
	local b = self.fore and (seg==0 and col.b or 0) or useful.lerp(self.b,self.g,p)
	if self.fore==fore and self.seg==seg then
		if self.fadeIn then
			local alpha = math.max(0,math.min(1,self.age*self.fadeIn))
			love.graphics.setColor(r,g,b, self.a*alpha)
		else
			love.graphics.setColor(r,g,b, self.a)
		end
		love.graphics.circle("fill",self.x,self.y,self.radius)
		if false and self.fore then
			love.graphics.setColor(255,255,255,32)
			love.graphics.setLineWidth(1)
			love.graphics.circle("line",self.x,self.y,self.radius)
		end
	end
end


function generators.highlight()
	local c = math.random()
	local speed = math.random(0,100)
	local a = math.random()*math.tau
	return {
		fore = false,
		seg = 1,
		x = 600/2,
		y = 3*600/4+50,
		ax = 600/2,
		ay = 3*600/4,
		ar = -10000,
		rise = 100,
		grow = 500,
		dx = math.cos(a)*speed*2,
		dy = math.sin(a)*speed,
		push = 0,
		pull = 1+math.random()*2,
		fric = math.random(0.3,0.5),
		radius = 1,
		fadeIn = 2,
		maxradius = 75,
		fade = 0.5+math.random(),
		r = 255*c,
		g = 255*c,
		b = 255*c*math.random()*0.25,
		a = 255
	}
end
function generators.highlightMask()
	local c = 0
	local speed = math.random(10,1000)
	local dx = math.random()>0.5 and speed or -speed
	return {
		fore = true,
		seg = 1,
		x = 600/2+dx/10,
		y = 3*600/4+350,
		ax = 600/2,
		ay = 3*600/4+10,
		ar = 100,
		rise = math.random(100,200),
		dx = dx,
		dy = 0,
		fade = 0,
		grow = math.random(3,10),
		push = 5,
		pull = 1+math.random(),
		fric = math.random(1,1.5),
		radius = 100,
		maxradius = 100,
		r = 0,
		g = 0,
		b = 0,
		a = 255
	}
end
function generators.highlightMaskLarge()
	local c = 0
	local speed = math.random(10,100)
	local dx = math.random()>0.5 and speed or -speed
	return {
		fore = true,
		seg = 1,
		x = 600/2+dx/10,
		y = 3*600/4+125,
		ax = 600/2,
		ay = 3*600/4+60,
		ar = 60,
		rise = math.random(100,200),
		dx = dx,
		dy = 0,
		fade = 0,
		grow = math.random(3,10),
		push = 5,
		pull = 1+math.random(),
		fric = math.random(1,1.5),
		radius = 10+math.random(20),
		maxradius = 100,
		r = 0,
		g = 0,
		b = 0,
		a = 255
	}
end

function generators.body()
	local c = math.random()*math.random()
	c=c*c*c
	local speed = math.random(0,100)
	local a = math.random()*math.tau
	return {
		fore = false,
		seg = 0,
		x = 600/2,
		y = 3*600/4+50,
		ax = 600/2,
		ay = 3*600/4,
		ar = -10000,
		rise = 100,
		grow = 500,
		dx = math.cos(a)*speed*2,
		dy = math.sin(a)*speed,
		push = 0,
		pull = 1+math.random()*2,
		fric = math.random(0.3,0.5),
		radius = 1,
		maxradius = 75,
		fade = 0,--math.random()*2,
		r = 255,
		g = 63+64*c,
		b = 0,
		a = 255
	}
end
function generators.bodyMask()
	local c = 0
	local speed = math.random(10,1000)
	local dx = math.random()>0.5 and speed or -speed
	return {
		fore = true,
		seg = 0,
		x = 600/2+dx/10,
		y = 3*600/4+400,
		ax = 600/2,
		ay = 3*600/4+10,
		ar = 150,
		rise = math.random(100,200),
		dx = dx,
		dy = 0,
		fade = 0,
		grow = math.random(3,10),
		push = 5,
		pull = 1+math.random(),
		fric = math.random(1,1.5),
		radius = 100,
		maxradius = 100,
		r = col.r,
		g = col.g,
		b = col.b,
		a = 255
	}
end
function generators.bodyMaskLarge()
	local c = 0
	local speed = math.random(10,100)
	local dx = math.random()>0.5 and speed or -speed
	return {
		fore = true,
		seg = 0,
		x = 600/2+dx/10,
		y = 3*600/4+185,
		ax = 600/2,
		ay = 3*600/4+60,
		ar = 120,
		rise = math.random(100,200),
		dx = dx,
		dy = 0,
		fade = 0,
		grow = math.random(3,10),
		push = 5,
		pull = 1+math.random(),
		fric = math.random(1,1.5),
		radius = 10+math.random(20),
		maxradius = 150,
		r = col.r,
		g = col.g,
		b = col.b,
		a = 255
	}
end


return faya