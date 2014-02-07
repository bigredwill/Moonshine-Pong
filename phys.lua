function love.load()
	love.love.physics.setMeter(64)
	world = love.physics.newWorld(0,0,true)
	--hold all objects
	objects = {}
	objects.walls = {}
	objects.walls.body = love.physics.newBody(world, 650/2, 650/2, static)
	objects.walls.shape = love.love.physics.newRectangleShape(650,50)
	objects.ground.fixture = love.physics.newFixture(objects.walls.body, objects.walls.shape, 5)
	--initial graphics setup
	love.graphics.setBackgroundColor(104, 136, 248)
	love.window.setMode(800,400)  --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing

end

function love.update(dt)
	world:update(dt)

	-- keyboard events
end

function love.draw()
	love.graphics.setColor(20, 190, 14)
	love.graphics.polygon("fill", objects.walls.body:getWorldPoints(objecst.walls.shape:getPoints()))
end