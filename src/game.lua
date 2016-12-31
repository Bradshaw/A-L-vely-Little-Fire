local state = {}



function state:init()
	faya.map.hello()
	gifit = 0
	sidestime = 2+math.random()*10
	col = {
		r = pink and 0 or 16,
		g = pink and 16 or 24,
		b = 24
	}
	blinkin = 2
end


function segzero()
	for i = 1,400 do
		faya.new({generator="body"})
	end
	for i = 1,200 do
		faya.new({generator="bodyMask"})
	end
	for i = 1,200 do
		faya.new({generator="bodyMaskLarge"})
	end
end

function segone()
	for i = 1,400 do
		faya.new({generator="highlight"})
	end
	for i = 1,100 do
		faya.new({generator="highlightMask"})
	end
	for i = 1,100 do
		faya.new({generator="highlightMaskLarge"})
	end
end


function state:enter( pre )
	local scale = love.window.getPixelScale()
	sh = diplodocus.shade(love.graphics.newCanvas(600*scale, 600*scale))
	love.graphics.setBackgroundColor(col.r, col.g, col.b)
	for i = 1,100 do
		local c = math.random()
		c = c*c*c
		local speed = math.random(0,500)
		local a = math.random()*math.tau
		spark.new({
			fore = false,
			x = 600/2+math.sin(a)*50,
			y = 3*600/4+math.cos(a)*50-50,
			rise = 200,
			dx = math.cos(a)*speed,
			dy = -math.abs(math.sin(a)*speed),
			push = 100,
			pull = math.random(5,10),
			fric = math.random(0.01,0.5),
			fade = math.random()*0.1,
			r = 255*c,
			g = math.random(64,255)*c,
			b = 0,
			a = 0
		})
	end
	for i = 1,20 do
		local c = 255
		local speed = math.random(0,250)
		local a = math.random()*math.tau
		spark.new({
			waitTime = 40,
			fore = false,
			x = 600/2+math.sin(a)*50,
			y = 3*600/4+math.cos(a)*50-50,
			rise = 500,
			dx = math.cos(a)*speed,
			dy = -math.abs(math.sin(a)*speed),
			push = 100,
			pull = math.random(5,10),
			fric = math.random(0.01,0.5),
			fade = math.random()*0.1,
			r = 255,
			g = 255,
			b = 0,
			a = 0
		})
	end
	segzero()
	segone()
	faya.sort()
	for _=1,600 do
		local dt = 1/30
		faya.map.update(dt)
		spark.map.update(dt)
	end
end


function state:leave( next )
end


function state:update(dt)
	blinkin = blinkin-dt
	if (blinkin<0) then
		blinkin = math.random()*6
	end
	if gifit>0 then
		dt = 1/30
	else 
		dt = math.min(dt,1/30)
	end
	sidestime = sidestime - dt
	if sidestime<0.2 then
		edgelord = glitchy and true or edgelord
		pink = glitchy and true or pink
		psides()
	end
	if sidestime<0 then
		if math.random()>0.95 then
			glitchy = not glitchy
		end
		if glitchy then
			reroll()
		end
		sidestime = 2+math.random()*10
	end
	pinkness = useful.lerp(pinkness,pink and 1 or 0, 2*dt)
	slowness = useful.lerp(slowness,slowmo and 1 or 0, 2*dt)
	col = {
		r = useful.lerp(16,0,pinkness),
		g = useful.lerp(24,16,pinkness),
		b = 24
	}
	faya.map.update(dt*useful.lerp(1.75,0.5,slowness))
	spark.map.update(dt*useful.lerp(2,0.5,slowness))
	faya.bubble()
end


function state:draw()
	love.graphics.setBlendMode("alpha")
	local scale = love.window.getPixelScale()/2
	love.graphics.scale(scale)
	love.graphics.translate(300,500)

	love.graphics.setColor(col.r, col.g, col.b)
	love.graphics.rectangle("fill",-1000,-1000,2000,2000)

	sh:setTarget()


	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(255,255,255)
	spark.map.draw()
	spark.map.draw()
	spark.map.draw()


	love.graphics.setBlendMode("alpha")
	love.graphics.stencil(function()
		faya.map.stencil(true, 0)
	end, "replace", 1)
	love.graphics.setStencilTest("lequal", 0)
	faya.map.draw(false, 0)
	love.graphics.stencil(function()
		faya.map.stencil(true, 1)
	end, "replace", 1, true)
	love.graphics.setBlendMode("add")
	faya.map.draw(false, 1)
	love.graphics.setStencilTest()

	if friend then
		skulhed()
	end





	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("alpha")

	sh:pushToScreen()
	sh:prep()
	sh:blur(0.07)
	sh:release()

	love.graphics.setColor(255,255,255,64)
	love.graphics.setBlendMode("add")
	sh:pushToScreen()
	spark.map.draw()

	if gifit>0 then
		local screenshot = love.graphics.newScreenshot();
    	screenshot:encode('png', string.format( "%03d", 121-gifit )..'.png');
		gifit = gifit - 1
	end

end

function skulhed()
	local xoff = math.sin(love.timer.getTime()*3)*10
	local yoff = math.sin(love.timer.getTime()*2)*10
	love.graphics.setBlendMode("alpha")
	local intense = 127+math.sin(love.timer.getTime()*1.5)*64
	love.graphics.setColor(255,useful.lerp(intense,0,pinkness),useful.lerp(0,intense,pinkness),255)
	love.graphics.circle("fill",300+xoff,470+yoff,100+math.sin(love.timer.getTime()*2.5)*5)
	love.graphics.setColor(255,255,196,255)
	love.graphics.circle("fill",300+xoff,470+yoff,85)
	yoff = math.sin(love.timer.getTime()*2-1)*10
	if blinkin>0.07 then
		love.graphics.setColor(196,160,160)
		love.graphics.circle("fill",260+xoff,497+yoff,20)
		love.graphics.circle("fill",340+xoff,497+yoff,20)
		love.graphics.setColor(0,0,0)
		love.graphics.circle("fill",260+xoff,490+yoff,20)
		love.graphics.circle("fill",340+xoff,490+yoff,20)
	else
		love.graphics.setLineWidth(3)
		love.graphics.setColor(0,0,0)
		local eyewidth = 24
		love.graphics.line(260+xoff+eyewidth,490+yoff,260+xoff-eyewidth,490+yoff)
		love.graphics.line(340+xoff+eyewidth,490+yoff,340+xoff-eyewidth,490+yoff)
	end
	yoff = math.sin(love.timer.getTime()*2-1)*7
	love.graphics.line(300+xoff+20,525+yoff,300+xoff-20,525+yoff)
end


function state:errhand(msg)
end


function state:focus(f)
end


function state:keypressed(key, isRepeat)
	if key=='escape' then
		love.event.push('quit')
	end
	if key=="p" then
		gifit = 120
	end
end


function state:keyreleased(key, isRepeat)
end


function state:mousefocus(f)
end


function state:mousepressed(x, y, btn)
end


function state:mousereleased(x, y, btn)
end


function state:quit()
end


function state:resize(w, h)
end


function state:textinput( t )
end


function state:threaderror(thread, errorstr)
end


function state:visible(v)
end


function state:gamepadaxis(joystick, axis)
end


function state:gamepadpressed(joystick, btn)
end


function state:gamepadreleased(joystick, btn)
end


function state:joystickadded(joystick)
end


function state:joystickaxis(joystick, axis, value)
end


function state:joystickhat(joystick, hat, direction)
end


function state:joystickpressed(joystick, button)
end


function state:joystickreleased(joystick, button)
end


function state:joystickremoved(joystick)
end

return state