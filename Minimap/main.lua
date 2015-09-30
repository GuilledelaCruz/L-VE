background = nil
map = {x = 0, y = 0, speed = 1000}
minimap = {x = 0, y = 0, width = 0, height = 0}
minmappercent = 0.25
scalemap = {x = 0, y = 0}
edgepixels = {x = 1, y = 1}
mouse = {x = 0, y = 0}

function love.load(arg)
	background = love.graphics.newImage("map.png")
	backWidth, backHeight = background:getDimensions()
	windowWidth, windowHeight = love.graphics:getDimensions()
	map.x = -1 * ((backWidth / 2) - (windowWidth / 2))
	map.y = -1 * ((backHeight / 2) - (windowHeight / 2))
	minimap.x = windowWidth - (windowWidth * minmappercent)
	minimap.y = windowHeight - (windowHeight * minmappercent)
	minimap.width = windowWidth * minmappercent
	minimap.height = windowHeight * minmappercent
	scalemap.x = windowWidth / backWidth
	scalemap.y = windowHeight / backHeight
	mouse.x, mouse.y = love.mouse.getPosition()
end

function love.update(dt)
	updateMap(dt)
	if love.mouse.isDown("l") then
		mousepressed(love.mouse.getX(), love.mouse.getY())
	end
end

function love.draw(dt)
	love.graphics.draw(background, map.x, map.y)
	love.graphics.print(map.x .. ", " .. map.y, 0, 0)

	drawMinimap()
end

function love.keypressed(k)
	-- quit game	
	if k == 'escape' then
		love.event.push('quit')
	end
end

function mousepressed(x, y)
	if x > minimap.x and y > minimap.y then
		local xi = x - minimap.x
		local yi = y - minimap.y
		local minx = windowWidth / 2 * minmappercent
		local miny = windowHeight / 2 * minmappercent
		if xi < minx then
			xi = minx
		end
		if xi > minimap.width - minx then
			xi = minimap.width - minx
		end
		if yi < miny then
			yi = miny
		end
		if yi > minimap.height - miny then
			yi = minimap.height - miny
		end
		map.x = -1 * xi * (1 / minmappercent) + windowWidth / 2
		map.y = -1 * yi * (1 / minmappercent) + windowHeight / 2
	end
end

function updateMap(dt)
	mouse.x, mouse.y = love.mouse.getPosition()
	-- left edge
	if mouse.x <= edgepixels.x and map.x < 0 then
		if map.x - (-1 * dt * map.speed) < 0 then
			map.x = map.x - (-1 * dt * map.speed)
		else
			map.x = 0
		end
	end
	-- top edge
	if mouse.y <= edgepixels.y and map.y < 0 then
		if map.y - (-1 * dt * map.speed) < 0 then
			map.y = map.y - (-1 * dt * map.speed)
		else
			map.y = 0
		end
	end
	-- right edge
	if mouse.x >= (windowWidth - edgepixels.x) and map.x > (-1 * backWidth) + windowWidth then
		if map.x + (-1 * dt * map.speed) > (-1 * backWidth) + windowWidth then
			map.x = map.x + (-1 * dt * map.speed)
		else
			map.x = (-1 * backWidth) + windowWidth
		end
	end
	-- bottom edge
	if mouse.y >= (windowHeight - edgepixels.y) and map.y > (-1 * backHeight) + windowHeight then
		if map.y + (-1 * dt * map.speed) > (-1 * backHeight) + windowHeight then
			map.y = map.y + (-1 * dt * map.speed)
		else
			map.y = (-1 * backHeight) + windowHeight
		end
	end
end
function drawMinimap()
	love.graphics.push()
  	love.graphics.scale(scalemap.x, scalemap.y)
	love.graphics.draw(background, minimap.x * (1 / scalemap.x), minimap.y * (1 / scalemap.y))
   	love.graphics.pop()

	love.graphics.rectangle("line", minimap.x, minimap.y, minimap.width, minimap.height)
	love.graphics.rectangle("line", minimap.x - map.x * scalemap.x,
					minimap.y - map.y * scalemap.y,
					windowWidth * scalemap.x, windowHeight * scalemap.y)
end
