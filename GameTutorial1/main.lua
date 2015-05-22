player = { x = 190, y = 500, speed = 320, img = nil }
bullet = nil
bullets = {}
enemy = nil
enemies = {}

isAlive = true
score = 0

shootSpeed = 600
enemySpeed = 300

createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end

function love.load(arg)
	player.img = love.graphics.newImage("assets/plane.png")
	bullet = love.graphics.newImage("assets/bullet.png")
	enemy = love.graphics.newImage("assets/enemy.png")
end

function love.update(dt)
	-- quit game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	-- time to shoot
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
		canShoot = true
	end

	-- enemy creation
	createEnemyTimer = createEnemyTimer - (1 * dt)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax

		randomNumber = math.random(50, love.graphics.getWidth() - 50)
		newEnemy = {x = randomNumber, y = -10, img = enemy}
		table.insert(enemies, newEnemy)
	end

	-- update shoots
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (shootSpeed * dt)

		if bullet.y < 0 then
			table.remove(bullets, i)
		end
	end

	-- update enemies
	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y - (enemySpeed * dt)

		if enemy.y > 650 then
			table.remove(enemies, i)
		end
	end

	-- shoot
	if love.keyboard.isDown(' ', 'ctrl') and canShoot then
		newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bullet}
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
	end

	--checkcollisions
	for i,enemy in ipairs(enemies) do
		for j,bullet in ipairs(bullets) do
			if checkCollision(enemy.x,enemy.y,enemy.img:getWidth(),enemy.img:getHeight(),
						bullet.x,bullet.y,bullet.img:getWidth(),enemy.img:getHeight()) then
				table.remove(enemies, i)
				table.remove(bullets, j)
				score = score + 10
		end
		
		if checkCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
					player.x, player.y, player.img:getWidth(), player.img:getHeight()) then
			table.remove(enemies, i)
			isAlive = false
		end
	end

	-- movement
	if love.keyboard.isDown('left','a') then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img.getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	end

	-- check alive and restart
	if not isAlive and love.keyboard.isDown('r') then
		bullets = {}
		enemies = {}

		canShootTimer = canShootTimerMax
		createEnemyTimer = createTimerEnemyMax

		player.x = 190
		player.y = 500

		score = 0
		isAlive = true
	end
end

function love.draw(dt)
	-- draw shoots
	for i,bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end

	-- draw enemies
	for i,enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	
	love.graphics.setColor(255,255,255)
	love.graphics.print("SCORE: " .. tostring(score), 400, 10)

	-- draw player
	if isAlive then
		love.graphics.draw(player.img, player.x, player.y)
	else
		love.graphics.print("Press 'R' to restart", love.graphics.getWidth()/2 - 50, love.graphics.getHeight()/2 - 10)
	end
end
