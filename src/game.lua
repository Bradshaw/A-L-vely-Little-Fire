local state = {}



function state:init()
	faya.map.hello()
	col = {
		r = 16,
		g = 24,
		b = 24
	}
	gifit = 0
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
	sh = diplodocus.shade()
	local scale = love.window.getPixelScale()
	highlight = love.graphics.newCanvas(600*scale, 600*scale)
	love.graphics.setBackgroundColor(col.r, col.g, col.b)
	for i = 1,15 do
		local c = 255
		local speed = math.random(0,500)
		local a = math.random()*math.tau
		spark.new({
			fore = false,
			x = 600/2+math.sin(a)*50,
			y = 3*600/4+math.cos(a)*50-50,
			rise = 200,
			dx = math.cos(a)*speed,
			dy = math.sin(a)*speed,
			push = 100,
			pull = math.random(5,10),
			fric = math.random(0.01,0.5),
			fade = math.random()*0.1,
			r = 255,
			g = math.random(64,255),
			b = 0,
			a = 0
		})
	end
	for i = 1,15 do
		local c = 255
		local speed = math.random(0,250)
		local a = math.random()*math.tau
		spark.new({
			fore = false,
			x = 600/2+math.sin(a)*50,
			y = 3*600/4+math.cos(a)*50-50,
			rise = 500,
			dx = math.cos(a)*speed,
			dy = math.sin(a)*speed,
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
	if gifit>0 then
		dt = 1/30
	else 
		dt = math.min(dt,1/30)
	end
	faya.map.update(dt*2)
	spark.map.update(dt*2)
	faya.bubble()
end


function state:draw()
	love.graphics.setBlendMode("alpha")
	local scale = love.window.getPixelScale()/2
	love.graphics.scale(scale)
	love.graphics.translate(300,500)


	love.graphics.setCanvas(highlight)
	


	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",-1000,-1000,2000,2000)

	faya.map.draw(false, 1)
	faya.map.draw(true, 1)

	love.graphics.setCanvas()

	sh:setTarget()


	love.graphics.setColor(col.r, col.g, col.b)
	love.graphics.rectangle("fill",-1000,-1000,2000,2000)


	faya.map.draw(false, 0)
	love.graphics.origin()
	love.graphics.setBlendMode("add")
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(highlight)
	love.graphics.setColor(255,255,255)
	love.graphics.scale(scale)
	love.graphics.translate(300,500)
	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("alpha")
	faya.map.draw(true, 0)
	spark.map.draw()


	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("alpha")

	sh:pushToScreen()

	sh:prep()
	sh:blur(0.07)
	--sh:invert()
	sh:release()

	love.graphics.setColor(255,255,255,48)
	love.graphics.setBlendMode("add")
	sh:pushToScreen()

	if gifit>0 then
		local screenshot = love.graphics.newScreenshot();
    	screenshot:encode('png', string.format( "%03d", 121-gifit )..'.png');
		gifit = gifit - 1
	end

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