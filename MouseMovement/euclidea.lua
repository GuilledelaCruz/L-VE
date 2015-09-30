player = {x = 0, y = 0, speed = 100}
positionClicked = {x = 0, y = 0, px = 0, py = 0, alpha = 0}

function love.load(arg)
	player.x = love.graphics:getWidth() / 2
	player.y = love.graphics:getHeight() / 2
	positionClicked.x = love.graphics:getWidth() / 2
	positionClicked.y = love.graphics:getHeight() / 2
end

function love.update(dt)
	if math.abs(player.x - positionClicked.x) > 1 and player.x < love.graphics:getWidth() and player.x > 0 then
		player.x = player.x + (dt * player.speed * (math.sin(positionClicked.alpha)))
	end

	if math.abs(player.y - positionClicked.y) > 1 and player.y < love.graphics:getHeight() and player.y > 0 then
		player.y = player.y + (dt * player.speed * (math.cos(positionClicked.alpha)))
	end
end

function love.draw(dt)
	love.graphics.point(player.x, player.y)
	
	love.graphics.print("Player: " .. player.x .. ", " .. player.y, 0, 0)
	love.graphics.print("Clicked: " .. positionClicked.x .. ", " .. positionClicked.y .. ", " .. (positionClicked.alpha * 180 / math.pi), 0, 12)
end

function love.mousepressed(x, y, b)
	positionClicked.x = x
	positionClicked.y = y
	positionClicked.px = player.x
	positionClicked.py = player.y	
	positionClicked.alpha = math.atan2(x - player.x, y - player.y)
end
