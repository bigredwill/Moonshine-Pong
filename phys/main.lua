function love.load()
	backg = love.graphics.newImage("space.png")
	love.physics.setMeter(64)
	world = love.physics.newWorld(0,0,true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	--hold all objects
	objects = {}
	objects.walls = {}
	objects.walls.bodTop = love.physics.newBody(world, 800/2, 825/2, static)
	objects.walls.bodBot = love.physics.newBody(world, 800/2, -12.5, static)
	objects.walls.bodL = love.physics.newBody(world, 812.5, 400/2, static)
	objects.walls.bodR = love.physics.newBody(world, -12.5, 400/2, static)
	objects.walls.top = love.physics.newRectangleShape(800,50)
	objects.walls.bottom = love.physics.newRectangleShape(800,50)
	objects.walls.left = love.physics.newRectangleShape(50,375)
	objects.walls.right = love.physics.newRectangleShape(50,375)
	objects.walls.fixture = love.physics.newFixture(objects.walls.bodTop, objects.walls.top, 5)
	objects.walls.fixture = love.physics.newFixture(objects.walls.bodBot, objects.walls.bottom, 5)
	objects.walls.fixture = love.physics.newFixture(objects.walls.bodL, objects.walls.left, 5)
	objects.walls.fixture = love.physics.newFixture(objects.walls.bodR, objects.walls.right, 5)
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, 400,200, "dynamic")
	objects.ball.shape = love.physics.newCircleShape( 20 )
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
	objects.ball.fixture:setRestitution(0.9)

	--initial graphics setup
	love.window.setMode(800,400)  --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
	times = 0 --initial velocity

	text = " "
	persisting = 0
end

function love.update(dt)
	world:update(dt)
	beginRound()
	--cleanup when 'text' gets too long
	if string.len(text) > 768 then
		text = ""
	end

	-- keyboard events
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(backg)
	love.graphics.setColor(20, 147, 34, 90)
	love.graphics.polygon("fill", objects.walls.bodTop:getWorldPoints(objects.walls.top:getPoints()))
	love.graphics.polygon("fill", objects.walls.bodBot:getWorldPoints(objects.walls.bottom:getPoints()))
	love.graphics.polygon("fill", objects.walls.bodL:getWorldPoints(objects.walls.left:getPoints()))
	love.graphics.polygon("fill", objects.walls.bodR:getWorldPoints(objects.walls.right:getPoints()))

	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
  	love.graphics.circle("line", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
  	love.graphics.print(text, 10, 10)
end

-- a is the first fixture object in the collision
-- b is the second fixture object in the collision
-- coll is the contact object created
function beginContact( a , b, coll)
	addVelocity()
end

function endContact(a, b, coll)
	persisting = 0 -- reset since they're no longer touching
	print "stop touching"
end
function preSolve(a, b, coll)
	if persisting == 0 then --only when first start touching
		
	elseif persisting < 20 then --just start counting
		print"what"
	end
	persisting = persisting + 1 --keep track of how many updates they've been touching for	

end

function postSolve(a, b, coll)
	--nothing yet
end





function bounce()

	
end
function beginRound()
	if(times < 1) then
		objects.ball.body:setLinearVelocity(400,100)
		times = times + 1
		print "velocity yay"
	end
end
function addVelocity()
	local x,y = objects.ball.body:getLinearVelocity()
	if x < 0 and y < 0 then
		objects.ball.body:setLinearVelocity(x-100,y - 200)
	elseif x < 0 and y > 0 then
		objects.ball.body:setLinearVelocity(x+100,y + 100)
	elseif x > 0 and y > 0 then
		objects.ball.body:setLinearVelocity(x+100,y + 200)
	else
			print "this ain't working"
			objects.ball.body:setLinearVelocity(x+100,y - 200)
	end
end