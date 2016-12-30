local faya = diplodocus.thing()

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
	if (self.age>5 and self.dy>20) then
		return true
	end
	return self.y<-800 or self.radius<=0
end

function faya:onPurge()
	faya.new(self.options)
	faya.sort()
end

function faya.mt:init()
	self.age = 0
end

function faya.mt:update(dt)
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
	if self.fore==fore and self.seg==seg then
		love.graphics.setColor(self.r,self.g,self.b, self.a)
		love.graphics.circle("fill",self.x,self.y,self.radius)
		if false and self.fore then
			love.graphics.setColor(255,255,255,32)
			love.graphics.setLineWidth(1)
			love.graphics.circle("line",self.x,self.y,self.radius)
		end
	end
end

return faya