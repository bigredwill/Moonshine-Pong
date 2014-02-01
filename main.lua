
--TODO
-- • Only bounce off paddle from the front
-- • Better paddle bounces
-- • Large numbers in each box for score
-- • Game State


function love.load()
	love.graphics.newFont( 62 )
	love.window.setTitle("A Coinye Quest")
	love.window.setMode(800,500)
	backg = love.graphics.newImage("bg1.png")
	leftscore = love.graphics.newImage("bg2.png")
	rightscore = love.graphics.newImage("bg3.png")
	coinye = love.graphics.newImage("coinye.png")
	imgx = 400
	imgy = 400
	width = coinye:getWidth()
	height = coinye:getHeight()
	rotation = 0.1
	love.graphics.setNewFont(12)
	love.keyboard.setKeyRepeat( true )
	xv = 5
	yv = 3
	poney = 250
	ptwoy = 250
	bg = backg
	gtime = love.timer.getTime()
	ptime = gtime
	scoreone = 0
	scoretwo = 0
end

function love.update(dt)
	move()
	if (ptime - gtime) > 1 then
		bg = backg
	end
	imgx = imgx + xv
	imgy = imgy + yv
	bounce()
	ptime = love.timer.getTime()
end

function love.draw()
	love.graphics.draw(bg)
	playerOne();
	playerTwo();
	love.graphics.setColor(250,250,250)
	love.graphics.draw(coinye,imgx,imgy,rotation,0.1,0.1,width/2,height/2)
	rotation = rotation + .01
	love.graphics.print(scoreone, 200, 40)
	love.graphics.print(scoretwo, 600,40)
end

function bounce()
	bouncex = love.window.getWidth()-20
	bouncey = love.window.getHeight()-45
	--score on right
	if (imgx  > bouncex) then
		xv = -1*xv
		gtime = love.timer.getTime()
		bg = rightscore
		scoretwo = scoretwo + 1
	end
	--score on left
	if (imgx < 20) then
		xv = -1*xv
		gtime = love.timer.getTime()
		bg = leftscore
		scoreone = scoreone + 1
		--Put ball in on paddle, wait till enter is pressed
	end
	--bounce off top and bottom walls
	if (imgy > bouncey) or (imgy < 45) then
		yv = -1*yv
	end
	--bounce off paddle one (left)
	if (imgx < 70) and ((poney + 50) >= imgy) and (poney <= imgy) then
		if(imgy <= poney +50) and (imgy >poney+35) then
			if yv < 0 then
				yv = 4
			else 
				yv = 8
			end
		elseif(imgy >= poney) and (imgy <poney+15) then
			if yv < 0 then
				yv = -8
			else 
				yv = 4
			end
		elseif (imgy >= poney + 15) and (imgy <=poney+35)then
			if yv < 0 then
				yv = -3
			else 
				yv = 3
			end
		end
		xv = -1 * xv
	end

	--bounce off paddle two (right)
	if (imgx > bouncex - 20) and ((poney + 50) >= imgy) and (poney <= imgy) then
		if(imgy <= poney +50) and (imgy >poney+35) then
			if yv < 0 then
				yv = 4
			else 
				yv = 8
			end
		elseif(imgy >= poney) and (imgy <poney+15) then
			if yv < 0 then
				yv = -8
			else 
				yv = 4
			end
		elseif (imgy >= poney + 15) and (imgy <=poney+35)then
			if yv < 0 then
				yv = -3
			else 
				yv = 3
			end
		end
		xv = -1 * xv
	end

	
end


function playerOne()
	love.graphics.setColor(200,200,200)
	pone = love.graphics.rectangle("fill",25,poney,20,50)
end
function playerTwo()
	love.graphics.setColor(200,200,200)
	ptwo = love.graphics.rectangle("fill",755,ptwoy,20,50)
end

function move()
	if love.keyboard.isDown("w") and poney > 30 then
		poney = poney - 8
		
	end
	if love.keyboard.isDown("s") and poney < 426 then
		poney = poney + 8
	end
	if love.keyboard.isDown("up") and ptwoy > 30 then
		ptwoy = ptwoy -8
	end
	if love.keyboard.isDown("down") and poney < 426 then
		ptwoy = ptwoy + 8
	end
end

--function score()

