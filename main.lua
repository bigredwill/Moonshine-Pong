
--TODO
-- • Only bounce off paddle from the front
-- • Better paddle bounces
-- • Large numbers in each box for score
-- • Game State

	--load images

	-- backg = love.graphics.newImage("images/bg1.png")
	-- leftscore = love.graphics.newImage("images/bg2.png")
	-- rightscore = love.graphics.newImage("images/bg3.png")
	coinye = love.graphics.newImage("images/coinye.png")


function love.load()
	love.graphics.newFont( 100 )
	love.window.setTitle("A Coinye Quest")
	love.window.setMode(800,500)

	-- font
	cash = love.graphics.newFont("Cash Currency.ttf", 400)
	-- smaller font
	smallcash = love.graphics.newFont("Cash Currency.ttf", 200)
	love.graphics.setFont(cash)

	--coin initial position
	imgx = 400
	imgy = 400
	--width/coinheight coin
	-- coinWidth = coinye:getWidth()
	-- coinheight = coinye:getHeight()
	coinWidth = 20
	coinheight = 20
	rotation = 0.1

	--font
	love.graphics.setFont(cash)


	love.keyboard.setKeyRepeat(true)
	--initial coin speed
	xv = 5
	yv = 3

	--paddle initial positions
	poney = 250
	ptwoy = 250
	ponex = 25
	ptwox = 755

	--paddle dimensions
	pwidth = 20
	pheight = 50
	--set timer for socring
	gtime = love.timer.getTime()
	ptime = gtime

	--initialize score
	scoreone = 0
	scoretwo = 0

	--background image
	bg = 0

end

function love.update(dt)
	move()
	if (ptime - gtime) > 10 then
		bg = 0
	end
	imgx = imgx + xv * dt * 100
	imgy = imgy + yv * dt * 100
	bounce()
	ptime = love.timer.getTime()

end

function love.draw()


	love.graphics.setColor(10,250,10)
	if(scoreone > 9) then
		love.graphics.setFont(smallcash)
		love.graphics.print(scoreone, 60, 100)
	else
		love.graphics.setFont(cash)
		love.graphics.print(scoreone, 60, 100)
	end
    if(scoreone > 9) then

    	love.graphics.setFont(smallcash)
		love.graphics.print(scoretwo, love.window.getWidth()/2+60,100)
	else
		love.graphics.setFont(cash)
		love.graphics.print(scoretwo, love.window.getWidth()/2+60,100)
	end

	playerOne()
	playerTwo()

	drawBoard()

	love.graphics.setColor(250,250,250)
	--draw circle
	--draw coinye
	-- love.graphics.draw(coinye,imgx,imgy,rotation,0.1,0.1,-coinWidth/2*0.1,-coinheight/2*0.1)
	love.graphics.draw(coinye,imgx,imgy,0, 0.1, 0.1, 694*0.1*5, 562*0.1*5)
	-- love.graphics.circle("fill", imgx, imgy, 20, 5)
	rotation = rotation + .01
end

function drawBoard()
	love.graphics.setColor(250,250,250)
	love.graphics.line(love.window.getWidth()/2,0,love.window.getWidth()/2,love.window.getHeight())
	love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), 20)
	love.graphics.rectangle("fill", 0, love.window.getHeight()-20, love.window.getWidth(), 20)
	if(bg==1) then
		love.graphics.setColor(200,255,100)
		love.graphics.rectangle("fill", love.window.getWidth()-20, 0, 20, love.window.getHeight())
		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), 20)
	    love.graphics.rectangle("fill", 0, love.window.getHeight()-20, love.window.getWidth(), 20)
		love.graphics.setColor(250,250,250)
		love.graphics.rectangle("fill", 0, 20, 20, love.window.getHeight()-20)
	elseif(bg == 2) then
		love.graphics.setColor(250,250,250)
		love.graphics.rectangle("fill", love.window.getWidth()-20, 0, 20, love.window.getHeight())
		love.graphics.setColor(200,100,255)
		love.graphics.rectangle("fill", 0, 0, 20, love.window.getHeight())

		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), 20)
		love.graphics.rectangle("fill", 0, love.window.getHeight()-20, love.window.getWidth(), 20)
	else

		love.graphics.rectangle("fill", love.window.getWidth()-20, 0, 20, love.window.getHeight())
		love.graphics.rectangle("fill", 0, 0, 20, love.window.getHeight())
	end
end

function bounce()
	bouncex = love.window.getWidth() - 20
	bouncey = love.window.getHeight() - 45
	--score on right
	if (imgx  > bouncex) then
		xv = math.abs(xv)*-1
		gtime = love.timer.getTime()
		bg = 1
		print "rightscore"
		scoretwo = scoretwo + 1
	end
	--score on left
	if (imgx < 20) then
		xv = math.abs(xv)
		gtime = love.timer.getTime()
		bg = 2
		print "leftscore"
		scoreone = scoreone + 1
		--Put ball in on paddle, wait till enter is pressed
	end


	--bounce off top and bottom walls
	if (imgy > bouncey) or (imgy < 45) then
		yv = -1*yv
	end

	--bounce off paddle one (left)
	if((imgy  >= poney) and (imgy <=poney+pheight)) then
		if((imgx - 20<= ponex + pwidth)) then
			yv = yv + math.random(-1,1)
			xv = math.abs(xv)
		end

	end

	--bounce off paddle two (right)
	if( (imgy  >= ptwoy) and (imgy <=ptwoy+pheight)) then
		if((imgx + 20 >= ptwox)) then
			yv = yv + math.random(-1,1)
			xv = math.abs(xv) * -1
		end
	end

end


function playerOne()
	love.graphics.setColor(200,255,100)
	pone = love.graphics.rectangle("fill",ponex,poney,pwidth,pheight)
end
function playerTwo()
	love.graphics.setColor(200,100,255)
	ptwo = love.graphics.rectangle("fill",ptwox,ptwoy,pwidth,pheight)
end

function move()
	local delta = love.timer.getDelta()
	if love.keyboard.isDown("w") and poney > 30 then
		poney = poney - 800 * delta

	end
	if love.keyboard.isDown("s") and poney < 426 then
		poney = poney + 800 * delta
	end
	if love.keyboard.isDown("up") and ptwoy > 30 then
		ptwoy = ptwoy - 800 * delta
	end
	if love.keyboard.isDown("down") and ptwoy < 426 then
		ptwoy = ptwoy + 800 * delta
	end
end

--function score()

