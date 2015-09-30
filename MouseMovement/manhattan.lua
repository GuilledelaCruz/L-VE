player = {x = 0, y = 0, speed = 100}
positionClicked = {x = 0, y = 0}
hasClicked = false

function love.load(arg)
	player.x = love.graphics:getWidth() / 2
	player.y = love.graphics:getHeight() / 2
	positionClicked.x = love.graphics:getWidth() / 2
	positionClicked.y = love.graphics:getHeight() / 2
end

function love.update(dt)
	if player.x ~= positionClicked.x then
		if math.abs(positionClicked.x - player.x) > dt * player.speed then
			player.x = player.x + ((dt * player.speed)*((positionClicked.x - player.x) / math.abs(positionClicked.x - player.x)))
		else
			player.x = player.x + ((math.abs(positionClicked.x - player.x))*((positionClicked.x - player.x) / math.abs(positionClicked.x - player.x)))
		end
	end
	if player.y ~= positionClicked.y then
		if dt * player.speed < math.abs(positionClicked.y - player.y) then
			player.y = player.y + ((dt * player.speed)*((positionClicked.y - player.y) / math.abs(positionClicked.y - player.y)))
		else
			player.y = player.y + ((math.abs(positionClicked.y - player.y))*((positionClicked.y - player.y) / math.abs(positionClicked.y - player.y)))
		end
	end
end

function love.draw(dt)
	love.graphics.point(player.x, player.y)
	
	love.graphics.print("Player: " .. player.x .. ", " .. player.y, 0, 0)
	love.graphics.print("Clicked: " .. positionClicked.x .. ", " .. positionClicked.y, 0, 12)
end

function love.mousepressed(x, y, b)
	positionClicked.x = x
	positionClicked.y = y
end
