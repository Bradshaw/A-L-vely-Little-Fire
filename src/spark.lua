local spark = diplodocus.thing()

function spark.compare(a, b)
	if a.fore == b.fore then
		return a.g<b.g
	else
		return b.fore
	end
end

function spark:purge()
	return self.y<-800
end

function spark:onPurge()
	spark.new(self.options)
	spark.sort()
end

function spark.mt:init()
	
end

function spark.mt:update(dt)
	self.dy = self.dy-self.rise*dt

	local disp = self.x-600/2
	self.dx = self.dx-self.dx*self.fric*dt-disp*self.pull*dt
	self.a = useful.lerp(self.a, 255, self.fade*dt)
	self.x = self.x+self.dx*dt
	self.y = self.y+self.dy*dt
end

function spark.mt:draw()
	love.graphics.setLineWidth(3)
	love.graphics.setColor(self.r,self.g,self.b, self.a)
	love.graphics.line(self.x,self.y,self.x+self.dx*0.02,self.y+self.dy*0.02)
end

return spark